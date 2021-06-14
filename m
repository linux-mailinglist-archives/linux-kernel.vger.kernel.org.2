Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010903A6DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhFNSKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:10:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:39923 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235086AbhFNSKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:10:49 -0400
IronPort-SDR: KG/ciK6AasS+Xmx4mpJ0JmRFj/o0h6HOK5EHvr+voNfIWHW69Nntmd+5PL786pMN9+O/nbMxis
 LqX7FnrM239g==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="227312010"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="227312010"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 11:08:45 -0700
IronPort-SDR: lhAyVb42Y4tFIWQd17H9o9r/4UwWb+jlKm45saZS4Yc4VKAeIesxvfM2d9LCK+n4h6z4CwcFxu
 uefeOaX+rBbQ==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="484166421"
Received: from jepowell-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.114.106])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 11:08:44 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Shuming Fan <shumingf@realtek.com>,
        Jack Yu <jack.yu@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] ASoC: rt700-sdw: fix race condition on system suspend
Date:   Mon, 14 Jun 2021 13:08:12 -0500
Message-Id: <20210614180815.153711-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614180815.153711-1-pierre-louis.bossart@linux.intel.com>
References: <20210614180815.153711-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous commits we cancelled deferred work, but there is still a
window of time where a new interrupt could result in new deferred work
executed after the link is disabled, leading to an IO error.

This patch uses an 'disable_irq_lock' mutex to prevent new interrupts
from happening after the start of the system suspend. The choice of a
mutex v. a spinlock is mainly due to the time required to clear
interrupts, which requires a command to be transmitted by the
SoundWire host IP and acknowledged with an interrupt. The
'interrupt_callback' routine is also not meant to be called from an
interrupt context.

An additional 'disable_irq' flag prevents race conditions where the
status changes before the interrupts are disabled, but the workqueue
handling status changes is scheduled after the completion of the
system suspend. On resume the interrupts are re-enabled already by the
io_init routine so we only clear the flag.

BugLink: https://github.com/thesofproject/linux/issues/2943
Fixes: 5f2df2a4583b ('ASoC: rt700: wait for the delayed work to finish when the system suspends')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt700-sdw.c | 34 ++++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt700.c     |  4 ++++
 sound/soc/codecs/rt700.h     |  2 ++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
index d1d9c0f455b4..bda594899664 100644
--- a/sound/soc/codecs/rt700-sdw.c
+++ b/sound/soc/codecs/rt700-sdw.c
@@ -418,10 +418,12 @@ static int rt700_interrupt_callback(struct sdw_slave *slave,
 	dev_dbg(&slave->dev,
 		"%s control_port_stat=%x", __func__, status->control_port);
 
-	if (status->control_port & 0x4) {
+	mutex_lock(&rt700->disable_irq_lock);
+	if (status->control_port & 0x4 && !rt700->disable_irq) {
 		mod_delayed_work(system_power_efficient_wq,
 			&rt700->jack_detect_work, msecs_to_jiffies(250));
 	}
+	mutex_unlock(&rt700->disable_irq_lock);
 
 	return 0;
 }
@@ -490,6 +492,34 @@ static int __maybe_unused rt700_dev_suspend(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused rt700_dev_system_suspend(struct device *dev)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct rt700_priv *rt700 = dev_get_drvdata(dev);
+	int ret;
+
+	if (!rt700->hw_init)
+		return 0;
+
+	/*
+	 * prevent new interrupts from being handled after the
+	 * deferred work completes and before the parent disables
+	 * interrupts on the link
+	 */
+	mutex_lock(&rt700->disable_irq_lock);
+	rt700->disable_irq = true;
+	ret = sdw_update_no_pm(slave, SDW_SCP_INTMASK1,
+			       SDW_SCP_INT1_IMPL_DEF, 0);
+	mutex_unlock(&rt700->disable_irq_lock);
+
+	if (ret < 0) {
+		/* log but don't prevent suspend from happening */
+		dev_dbg(&slave->dev, "%s: could not disable imp-def interrupts\n:", __func__);
+	}
+
+	return rt700_dev_suspend(dev);
+}
+
 #define RT700_PROBE_TIMEOUT 5000
 
 static int __maybe_unused rt700_dev_resume(struct device *dev)
@@ -521,7 +551,7 @@ static int __maybe_unused rt700_dev_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rt700_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(rt700_dev_suspend, rt700_dev_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(rt700_dev_system_suspend, rt700_dev_resume)
 	SET_RUNTIME_PM_OPS(rt700_dev_suspend, rt700_dev_resume, NULL)
 };
 
diff --git a/sound/soc/codecs/rt700.c b/sound/soc/codecs/rt700.c
index 01af9d9dd3ca..921382724f9c 100644
--- a/sound/soc/codecs/rt700.c
+++ b/sound/soc/codecs/rt700.c
@@ -1112,6 +1112,8 @@ int rt700_init(struct device *dev, struct regmap *sdw_regmap,
 	rt700->sdw_regmap = sdw_regmap;
 	rt700->regmap = regmap;
 
+	mutex_init(&rt700->disable_irq_lock);
+
 	/*
 	 * Mark hw_init to false
 	 * HW init will be performed when device reports present
@@ -1133,6 +1135,8 @@ int rt700_io_init(struct device *dev, struct sdw_slave *slave)
 {
 	struct rt700_priv *rt700 = dev_get_drvdata(dev);
 
+	rt700->disable_irq = false;
+
 	if (rt700->hw_init)
 		return 0;
 
diff --git a/sound/soc/codecs/rt700.h b/sound/soc/codecs/rt700.h
index 794ee2e29051..bed9d1de6d5b 100644
--- a/sound/soc/codecs/rt700.h
+++ b/sound/soc/codecs/rt700.h
@@ -23,6 +23,8 @@ struct  rt700_priv {
 	struct delayed_work jack_detect_work;
 	struct delayed_work jack_btn_check_work;
 	int jack_type;
+	struct mutex disable_irq_lock; /* imp-def irq lock protection */
+	bool disable_irq;
 };
 
 struct sdw_stream_data {
-- 
2.25.1

