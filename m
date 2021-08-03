Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA973DE873
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhHCIaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhHCIay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:30:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3B9C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 01:30:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so3669464pji.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXIeFsSEfhQ5FLZhNOuYsB7Hwka5h7OEPdEDsi9EjiU=;
        b=ou+bUOJ1a874U6V6Q/sECs+AAJyfg9fnmQsFZeUi3ag+l+QE1OHkLXftPJ8OT5MWw6
         BeJ0g3Z0wDHYcKHJQLIh9XzRwx5UT1Vz3Y2psnRfrPw0cGSRxUnRBYTNT8LW4+kb2sFw
         KouTYiCNY1qcQab+acnB6ze17EKXS6x2mEjYslulgjJ7tZKgLKRsDEgIiY06/eodRzDx
         /JMDK90HtAq5Gdn+QIe6ftipGMG7vYuUnReiDNaLXBOAVIBe08wpWyPgq303GmolKwps
         KStBBL/uVX3IJx8YXsQ+43oJOp1lwI9n3/OK8FaxTAPRsR4B9F/y3evkmaCTONo/iwxQ
         u6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXIeFsSEfhQ5FLZhNOuYsB7Hwka5h7OEPdEDsi9EjiU=;
        b=k4wvSKiprjN1NP8VTxZisv5781/tcIoga8Vtkz1UmnCijuAW+IsITPAuSm94g1l9LE
         /4LJQ0RZxx/iFzf3WkJkL2ydVJIU4QmhlPp4HkJx75QFh8S3Eojv8BBnnODkG4xeqRyd
         EDTsx9hgJ/Tj9hHkfioQbXc5hZG3fubrcdHSh5mazzBp/C1hLIsIluIPV08AxtJfP7Gg
         o83GmBx7Gy2cPGUbqGgeylwY1bqBChxeGQzbzUTFzgyvndw5cMvzw9877vpWComo1f6P
         o7moWr3esMpXKkiaL7Jk0zrps9iDxDkVl5blGzYoPO5fU80W7svGR2AP9vPZUnAnA8o/
         06ZA==
X-Gm-Message-State: AOAM53358BaIJ5oTgoPd6eXYCFBpRF79rCN8bQ93oI5C+kQQpfiGJT0w
        zs/Rrb8bfk+1Rm5q9hQ0mjc1Cw==
X-Google-Smtp-Source: ABdhPJy43I4BdGiXktXCXBUaClgUvRVLCc6+QVrYuP7RCXyg2ygLAWuJrmmTYKGXjWVadXrezTr3YA==
X-Received: by 2002:a17:90a:be16:: with SMTP id a22mr21586331pjs.169.1627979443313;
        Tue, 03 Aug 2021 01:30:43 -0700 (PDT)
Received: from localhost.localdomain ([1.200.254.247])
        by smtp.gmail.com with ESMTPSA id n1sm10828409pgt.63.2021.08.03.01.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 01:30:42 -0700 (PDT)
From:   Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>
To:     alsa-devel@alsa-project.org
Cc:     kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        mac.chiang@intel.com, broonie@kernel.org, brent.lu@intel.com,
        bard.liao@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, perex@perex.cz,
        linux-kernel@vger.kernel.org,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>
Subject: [PATCH] ASoC: Intel: sof_rt5682: Add support for max98360a speaker amp
Date:   Tue,  3 Aug 2021 16:30:35 +0800
Message-Id: <20210803083035.342889-1-malik_hsu@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>
---
 sound/soc/intel/boards/sof_rt5682.c               |  9 +++++++++
 sound/soc/intel/common/soc-acpi-intel-adl-match.c | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 39217223d50c..8d727dd37f12 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -1043,6 +1043,15 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_AMP(2) |
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
+	{
+		.name = "adl_max98360a_rt5682",
+		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(2) |
+					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_NUM_HDMIDEV(4)),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index a0f6a69c7038..6855c9e65236 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -280,6 +280,11 @@ static const struct snd_soc_acpi_codecs adl_max98357a_amp = {
 	.codecs = {"MX98357A"}
 };
 
+static const struct snd_soc_acpi_codecs adl_max98360a_amp = {
+	.num_codecs = 1,
+	.codecs = {"MX98360A"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	{
 		.id = "10EC5682",
@@ -297,6 +302,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.sof_fw_filename = "sof-adl.ri",
 		.sof_tplg_filename = "sof-adl-max98357a-rt5682.tplg",
 	},
+	{
+		.id = "10EC5682",
+		.drv_name = "adl_max98360a_rt5682",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &adl_max98360a_amp,
+		.sof_fw_filename = "sof-adl.ri",
+		.sof_tplg_filename = "sof-adl-max98357a-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_adl_machines);
-- 
2.25.1

