Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444BC343D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhCVJjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:39:55 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:22532 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230042AbhCVJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:39:25 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12M9GovL026273;
        Mon, 22 Mar 2021 05:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=IZZmDWoeYpA894/jnGZIgYX0koHQOXtvBq29Zoe+Fio=;
 b=jO28DpZLHs1SNvwVeoF+SX8V4aKUFd6FW+xNz5kEzgDXwHM5q4lt48SBqm1HUleYVFrZ
 JTQKuWAiTm1dKNfZ3lQTNe99tcbknaFLi1nW6EJdebDvxUZQI/nSHjuUVOKVHs1q2Qdr
 OC3yG3hkdYmkzq0cbWlPebmPN3c4K4kEQk2Nul7XVfzpJtoPX3P1OYr+SSBe1SD3Yisi
 Qu0JXFQAhCNp96ZeGjQI9oYW2BvKRMzeEbDhLWTHYp5rJ8z1G9u/tbuZusQO8fxsq7tg
 xjLsii9UdsbAT08X5fHsKgGGqMC5foGhYPjP5oO9SvqTtR9O76LHC+3Jl2aWv+Ulyhis EQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 37dggkbk7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 05:39:24 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12M9Etbq020335;
        Mon, 22 Mar 2021 05:39:24 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 37dx1gm2kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 05:39:24 -0400
X-LoopCount0: from 10.69.132.19
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,268,1610431200"; 
   d="scan'208";a="613815038"
From:   Perry Yuan <Perry.Yuan@dell.com>
To:     pobrn@protonmail.com, pierre-louis.bossart@linux.intel.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        Mario.Limonciello@dell.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Perry.Yuan@dell.com
Subject: [PATCH v5 2/2] ASoC: rt715:add micmute led state control supports
Date:   Mon, 22 Mar 2021 17:39:14 +0800
Message-Id: <20210322093914.4228-1-Perry_Yuan@Dell.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_03:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220072
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <perry_yuan@dell.com>

Some new Dell system is going to support audio internal micphone
privacy setting from hardware level with micmute led state changing
When micmute hotkey pressed by user, soft mute will need to be enabled
firstly in case of pop noise, and codec driver need to react to mic
mute event to EC(embedded controller) notifying that SW mute is completed
Then EC will do the hardware mute physically within the timeout reached

This patch allow codec rt715 and rt715 sdca driver to change the local micmute
led state. Dell privacy led trigger driver will ack EC when micmute key pressed
through this micphone led control interface like hda_generic provided
ACPI method defined in dell-privacy micmute led trigger will be called
for notifying the EC that software mute has been completed, then hardware
audio circuit solution controlled by EC will switch the audio input source off/on

Signed-off-by: Perry Yuan <perry_yuan@dell.com>

--------
v4 -> v5:
* rebase to latest 5.12 rc4 upstream kernel
v3 -> v4:
* remove unused debug log
* remove compile flag of DELL privacy
* move the micmute_led to local from rt715_priv
* when Jaroslav upstream his gerneric LED trigger driver,I will rebase
  this patch,please consider merge this at first
  https://lore.kernel.org/alsa-devel/20210211111400.1131020-1-perex@perex.cz/
v2 -> v3:
* simplify the patch to reuse some val value
* add more detail to the commit info
v1 -> v2:
* fix some format issue
--------
---
 sound/soc/codecs/rt715-sdca.c | 11 +++++++++++
 sound/soc/codecs/rt715.c      | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index 20528afbdc57..70e1181f1dee 100644
--- a/sound/soc/codecs/rt715-sdca.c
+++ b/sound/soc/codecs/rt715-sdca.c
@@ -11,6 +11,7 @@
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/leds.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 #include <linux/soundwire/sdw.h>
@@ -358,6 +359,7 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = p->invert;
 	int err;
+	bool micmute_led;
 
 	for (i = 0; i < 4; i++) {
 		if (ucontrol->value.integer.value[i] != rt715->kctl_switch_orig[i]) {
@@ -393,6 +395,15 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
 		if (err < 0)
 			return err;
 	}
+	/* Micmute LED state changed by muted/unmute switch */
+	if (invert) {
+		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) {
+			micmute_led = LED_OFF;
+		} else {
+			micmute_led = LED_ON;
+		}
+		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
+	}
 
 	return k_changed;
 }
diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index 34c3357e943b..13686c5239b3 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/leds.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 #include <linux/soundwire/sdw.h>
@@ -88,6 +89,7 @@ static int rt715_set_amp_gain_put(struct snd_kcontrol *kcontrol,
 		RT715_SET_GAIN_MIX_ADC2_L};
 	unsigned int addr_h, addr_l, val_h, val_ll, val_lr;
 	unsigned int read_ll, read_rl, i, j, loop_cnt;
+	bool micmute_led;
 
 	if (strstr(ucontrol->id.name, "Main Capture Switch") ||
 		strstr(ucontrol->id.name, "Main Capture Volume"))
@@ -95,6 +97,16 @@ static int rt715_set_amp_gain_put(struct snd_kcontrol *kcontrol,
 	else
 		loop_cnt = 1;
 
+	/* Micmute LED state changed by muted/unmute switch */
+	if (mc->invert) {
+		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) {
+			micmute_led = LED_OFF;
+		} else {
+			micmute_led = LED_ON;
+		}
+		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
+	}
+
 	for (j = 0; j < loop_cnt; j++) {
 		/* Can't use update bit function, so read the original value first */
 		if (loop_cnt == 1) {
-- 
2.25.1

