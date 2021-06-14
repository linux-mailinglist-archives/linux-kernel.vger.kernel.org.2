Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B343A6DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhFNSKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:10:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:39923 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234429AbhFNSKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:10:53 -0400
IronPort-SDR: lve8VMUkmZyjBLY4Cag6on5+ha9AtzhUIFvI7POoqEAZLwGRcTboZavCyb+THQQNEujGn/qYBE
 RjT6G2F0UtLg==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="227312018"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="227312018"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 11:08:50 -0700
IronPort-SDR: QMz9h5D4R+M5rWNcbW4LAYtZHDOgB1PVLVWdGUQw1RLWI5jzomHB4u9seA9GkvgLsLDvLqTfmQ
 DB095xgsO89A==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="484166440"
Received: from jepowell-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.114.106])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 11:08:48 -0700
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
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] ASoC: rt5682-sdw: fix race condition on system suspend
Date:   Mon, 14 Jun 2021 13:08:14 -0500
Message-Id: <20210614180815.153711-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614180815.153711-1-pierre-louis.bossart@linux.intel.com>
References: <20210614180815.153711-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the initial driver we cancelled deferred work, but there is still a
window of time where a new interrupt could result in new deferred work
executed after the link is disabled, leading to an IO error. While we
did not see this IO error on RT5682-based platforms, the code pattern
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

The Fixes tag points to a 5.10 commit, there's no need to propagate
this change to earlier upstream versions.

BugLink: https://github.com/thesofproject/linux/issues/2943
Fixes: 4a55000722d7 ('ASoC: codecs: rt*.c: remove useless pointer cast')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt5682-sdw.c | 38 +++++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt5682.h     |  2 ++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 54873730bec5..31a4f286043e 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -344,6 +344,8 @@ static int rt5682_sdw_init(struct device *dev, struct regmap *regmap,
 	rt5682->sdw_regmap = regmap;
 	rt5682->is_sdw = true;
 
+	mutex_init(&rt5682->disable_irq_lock);
+
 	rt5682->regmap = devm_regmap_init(dev, NULL, dev,
 					  &rt5682_sdw_indirect_regmap);
 	if (IS_ERR(rt5682->regmap)) {
@@ -378,6 +380,8 @@ static int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 	int ret = 0, loop = 10;
 	unsigned int val;
 
+	rt5682->disable_irq = false;
+
 	if (rt5682->hw_init)
 		return 0;
 
@@ -679,10 +683,12 @@ static int rt5682_interrupt_callback(struct sdw_slave *slave,
 	dev_dbg(&slave->dev,
 		"%s control_port_stat=%x", __func__, status->control_port);
 
-	if (status->control_port & 0x4) {
+	mutex_lock(&rt5682->disable_irq_lock);
+	if (status->control_port & 0x4 && !rt5682->disable_irq) {
 		mod_delayed_work(system_power_efficient_wq,
 			&rt5682->jack_detect_work, msecs_to_jiffies(rt5682->irq_work_delay_time));
 	}
+	mutex_unlock(&rt5682->disable_irq_lock);
 
 	return 0;
 }
@@ -740,6 +746,34 @@ static int __maybe_unused rt5682_dev_suspend(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused rt5682_dev_system_suspend(struct device *dev)
+{
+	struct rt5682_priv *rt5682 = dev_get_drvdata(dev);
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	int ret;
+
+	if (!rt5682->hw_init)
+		return 0;
+
+	/*
+	 * prevent new interrupts from being handled after the
+	 * deferred work completes and before the parent disables
+	 * interrupts on the link
+	 */
+	mutex_lock(&rt5682->disable_irq_lock);
+	rt5682->disable_irq = true;
+	ret = sdw_update_no_pm(slave, SDW_SCP_INTMASK1,
+			       SDW_SCP_INT1_IMPL_DEF, 0);
+	mutex_unlock(&rt5682->disable_irq_lock);
+
+	if (ret < 0) {
+		/* log but don't prevent suspend from happening */
+		dev_dbg(&slave->dev, "%s: could not disable imp-def interrupts\n:", __func__);
+	}
+
+	return rt5682_dev_suspend(dev);
+}
+
 static int __maybe_unused rt5682_dev_resume(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
@@ -768,7 +802,7 @@ static int __maybe_unused rt5682_dev_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rt5682_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(rt5682_dev_suspend, rt5682_dev_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(rt5682_dev_system_suspend, rt5682_dev_resume)
 	SET_RUNTIME_PM_OPS(rt5682_dev_suspend, rt5682_dev_resume, NULL)
 };
 
diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index 74ff66767016..b59221048ebf 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -1415,6 +1415,8 @@ struct rt5682_priv {
 	struct regulator_bulk_data supplies[RT5682_NUM_SUPPLIES];
 	struct delayed_work jack_detect_work;
 	struct delayed_work jd_check_work;
+	struct mutex disable_irq_lock; /* imp-def irq lock protection */
+	bool disable_irq;
 	struct mutex calibrate_mutex;
 	struct sdw_slave *slave;
 	enum sdw_slave_status status;
-- 
2.25.1

