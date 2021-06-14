Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8473A6DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbhFNSKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:10:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:39923 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235097AbhFNSKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:10:51 -0400
IronPort-SDR: L2ydKVCSDJLqTk2S7C1S8hTREAKCkm3GYZtTuNJvRm0xtq0+ySTA04d3uJN8rXvgr7WbvVD0Nz
 XmOpmLzoqxFg==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="227312015"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="227312015"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 11:08:48 -0700
IronPort-SDR: JxpUUiVAyyQrQSij/i+O8Y6scFMUKJkkR9iq+9yJPSvqCHeEbd61JTP9ADc21TCL0AH5ZSiezV
 eSdbNa+wmyUQ==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="484166431"
Received: from jepowell-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.114.106])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 11:08:46 -0700
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
Subject: [PATCH 3/5] ASoC: rt711-sdw: fix race condition on system suspend
Date:   Mon, 14 Jun 2021 13:08:13 -0500
Message-Id: <20210614180815.153711-4-pierre-louis.bossart@linux.intel.com>
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
executed after the link is disabled, leading to an IO error. While we
did not see this IO error on RT711-based platforms, the code pattern
is similar to the RT700 case where the IO error was noted, so the fix
is added for consistency.

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
Fixes: 501ef013390b ('ASoC: rt711: wait for the delayed work to finish when the system suspends')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt711-sdw.c | 34 ++++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt711.c     |  4 ++++
 sound/soc/codecs/rt711.h     |  2 ++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 15299084429f..bda2cc9439c9 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -423,10 +423,12 @@ static int rt711_interrupt_callback(struct sdw_slave *slave,
 	dev_dbg(&slave->dev,
 		"%s control_port_stat=%x", __func__, status->control_port);
 
-	if (status->control_port & 0x4) {
+	mutex_lock(&rt711->disable_irq_lock);
+	if (status->control_port & 0x4 && !rt711->disable_irq) {
 		mod_delayed_work(system_power_efficient_wq,
 			&rt711->jack_detect_work, msecs_to_jiffies(250));
 	}
+	mutex_unlock(&rt711->disable_irq_lock);
 
 	return 0;
 }
@@ -493,6 +495,34 @@ static int __maybe_unused rt711_dev_suspend(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused rt711_dev_system_suspend(struct device *dev)
+{
+	struct rt711_priv *rt711 = dev_get_drvdata(dev);
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	int ret;
+
+	if (!rt711->hw_init)
+		return 0;
+
+	/*
+	 * prevent new interrupts from being handled after the
+	 * deferred work completes and before the parent disables
+	 * interrupts on the link
+	 */
+	mutex_lock(&rt711->disable_irq_lock);
+	rt711->disable_irq = true;
+	ret = sdw_update_no_pm(slave, SDW_SCP_INTMASK1,
+			       SDW_SCP_INT1_IMPL_DEF, 0);
+	mutex_unlock(&rt711->disable_irq_lock);
+
+	if (ret < 0) {
+		/* log but don't prevent suspend from happening */
+		dev_dbg(&slave->dev, "%s: could not disable imp-def interrupts\n:", __func__);
+	}
+
+	return rt711_dev_suspend(dev);
+}
+
 #define RT711_PROBE_TIMEOUT 5000
 
 static int __maybe_unused rt711_dev_resume(struct device *dev)
@@ -524,7 +554,7 @@ static int __maybe_unused rt711_dev_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rt711_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(rt711_dev_suspend, rt711_dev_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(rt711_dev_system_suspend, rt711_dev_resume)
 	SET_RUNTIME_PM_OPS(rt711_dev_suspend, rt711_dev_resume, NULL)
 };
 
diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index 9f5b2dc16c54..4dbfa7b8680e 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -1166,6 +1166,8 @@ int rt711_init(struct device *dev, struct regmap *sdw_regmap,
 	rt711->sdw_regmap = sdw_regmap;
 	rt711->regmap = regmap;
 
+	mutex_init(&rt711->disable_irq_lock);
+
 	/*
 	 * Mark hw_init to false
 	 * HW init will be performed when device reports present
@@ -1190,6 +1192,8 @@ int rt711_io_init(struct device *dev, struct sdw_slave *slave)
 {
 	struct rt711_priv *rt711 = dev_get_drvdata(dev);
 
+	rt711->disable_irq = false;
+
 	if (rt711->hw_init)
 		return 0;
 
diff --git a/sound/soc/codecs/rt711.h b/sound/soc/codecs/rt711.h
index ca0f581feec7..2af467631435 100644
--- a/sound/soc/codecs/rt711.h
+++ b/sound/soc/codecs/rt711.h
@@ -25,6 +25,8 @@ struct  rt711_priv {
 	struct work_struct calibration_work;
 	struct mutex calibrate_mutex; /* for headset calibration */
 	int jack_type, jd_src;
+	struct mutex disable_irq_lock; /* imp-def irq lock protection */
+	bool disable_irq;
 };
 
 struct sdw_stream_data {
-- 
2.25.1

