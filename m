Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F28C339641
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhCLSXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:36942 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233158AbhCLSXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:21 -0500
IronPort-SDR: OfFEKX2uAEz0BCscmJOiirjVLJehZoltjYMimZ2gJ9QzvvaLqT0+RUCWXoXgsoz7zmfSvRCffR
 ItfMXtFjn9nQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999111"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999111"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:21 -0800
IronPort-SDR: EdXX+UIhDx5zqRs0FzvertwIfPOSL2SomPczBK0WLMNUuULzv6RwGrxv3BIJP8+pmSV4hitjBm
 iYKmBUUbR/Rw==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791944"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:19 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 08/23] ASoC: hdac_hdmi: remove useless initializations
Date:   Fri, 12 Mar 2021 12:22:31 -0600
Message-Id: <20210312182246.5153-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cppcheck complains a lot about possible null pointer dereferences but
it's again a case of useless initializations to NULL.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 2c1305bf0572..66408a98298b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -523,7 +523,7 @@ static struct hdac_hdmi_port *hdac_hdmi_get_port_from_cvt(
 			struct hdac_hdmi_cvt *cvt)
 {
 	struct hdac_hdmi_pcm *pcm;
-	struct hdac_hdmi_port *port = NULL;
+	struct hdac_hdmi_port *port;
 	int ret, i;
 
 	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
@@ -713,7 +713,7 @@ static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm(struct hdac_device *hdev,
 					struct hdac_hdmi_port *port)
 {
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
-	struct hdac_hdmi_pcm *pcm = NULL;
+	struct hdac_hdmi_pcm *pcm;
 	struct hdac_hdmi_port *p;
 
 	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
@@ -900,7 +900,7 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 	struct hdac_hdmi_port *port = w->priv;
 	struct hdac_device *hdev = dev_to_hdac_dev(dapm->dev);
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
-	struct hdac_hdmi_pcm *pcm = NULL;
+	struct hdac_hdmi_pcm *pcm;
 	const char *cvt_name =  e->texts[ucontrol->value.enumerated.item[0]];
 
 	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
@@ -1693,7 +1693,7 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
 {
 	struct hdac_device *hdev = aptr;
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
-	struct hdac_hdmi_pin *pin = NULL;
+	struct hdac_hdmi_pin *pin;
 	struct hdac_hdmi_port *hport = NULL;
 	struct snd_soc_component *component = hdmi->component;
 	int i;
@@ -1958,7 +1958,7 @@ static int hdmi_codec_probe(struct snd_soc_component *component)
 	struct hdac_device *hdev = hdmi->hdev;
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_component_get_dapm(component);
-	struct hdac_ext_link *hlink = NULL;
+	struct hdac_ext_link *hlink;
 	int ret;
 
 	hdmi->component = component;
@@ -2227,7 +2227,7 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 {
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
 	struct hdac_bus *bus = hdev->bus;
-	struct hdac_ext_link *hlink = NULL;
+	struct hdac_ext_link *hlink;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
 
@@ -2263,7 +2263,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 {
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
 	struct hdac_bus *bus = hdev->bus;
-	struct hdac_ext_link *hlink = NULL;
+	struct hdac_ext_link *hlink;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
 
-- 
2.25.1

