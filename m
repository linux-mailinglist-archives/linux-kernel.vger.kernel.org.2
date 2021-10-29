Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546D144010F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhJ2RTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:19:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:39487 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhJ2RS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:18:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="211479852"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="211479852"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 10:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="598276597"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.1])
  by orsmga004.jf.intel.com with ESMTP; 29 Oct 2021 10:16:22 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Gongjun Song <gongjun.song@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v5 6/6] ASoC: Intel: soc-acpi: use const for all uses of snd_soc_acpi_codecs
Date:   Sat, 30 Oct 2021 01:14:09 +0800
Message-Id: <20211029171409.611600-7-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029171409.611600-1-brent.lu@intel.com>
References: <20211029171409.611600-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

'const' qualifiers are missing on some platforms, add as needed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c |  2 +-
 sound/soc/intel/common/soc-acpi-intel-cml-match.c |  8 ++++----
 sound/soc/intel/common/soc-acpi-intel-glk-match.c |  2 +-
 sound/soc/intel/common/soc-acpi-intel-jsl-match.c |  8 ++++----
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c | 12 ++++++------
 sound/soc/intel/common/soc-acpi-intel-skl-match.c |  2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 78cfdc48ad45..342d34052204 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -41,7 +41,7 @@ static struct snd_soc_acpi_mach *apl_quirk(void *arg)
 	return mach;
 }
 
-static struct snd_soc_acpi_codecs bxt_codecs = {
+static const struct snd_soc_acpi_codecs bxt_codecs = {
 	.num_codecs = 1,
 	.codecs = {"MX98357A"}
 };
diff --git a/sound/soc/intel/common/soc-acpi-intel-cml-match.c b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
index b591c6fd13fd..b4eb0c97edf1 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cml-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
@@ -9,22 +9,22 @@
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 
-static struct snd_soc_acpi_codecs rt1011_spk_codecs = {
+static const struct snd_soc_acpi_codecs rt1011_spk_codecs = {
 	.num_codecs = 1,
 	.codecs = {"10EC1011"}
 };
 
-static struct snd_soc_acpi_codecs rt1015_spk_codecs = {
+static const struct snd_soc_acpi_codecs rt1015_spk_codecs = {
 	.num_codecs = 1,
 	.codecs = {"10EC1015"}
 };
 
-static struct snd_soc_acpi_codecs max98357a_spk_codecs = {
+static const struct snd_soc_acpi_codecs max98357a_spk_codecs = {
 	.num_codecs = 1,
 	.codecs = {"MX98357A"}
 };
 
-static struct snd_soc_acpi_codecs max98390_spk_codecs = {
+static const struct snd_soc_acpi_codecs max98390_spk_codecs = {
 	.num_codecs = 1,
 	.codecs = {"MX98390"}
 };
diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 3900e3dbae30..8492b7e2a945 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -9,7 +9,7 @@
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 
-static struct snd_soc_acpi_codecs glk_codecs = {
+static const struct snd_soc_acpi_codecs glk_codecs = {
 	.num_codecs = 1,
 	.codecs = {"MX98357A"}
 };
diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
index ee703701bff2..278ec196da7b 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -9,22 +9,22 @@
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 
-static struct snd_soc_acpi_codecs jsl_7219_98373_codecs = {
+static const struct snd_soc_acpi_codecs jsl_7219_98373_codecs = {
 	.num_codecs = 1,
 	.codecs = {"MX98373"}
 };
 
-static struct snd_soc_acpi_codecs rt1015_spk = {
+static const struct snd_soc_acpi_codecs rt1015_spk = {
 	.num_codecs = 1,
 	.codecs = {"10EC1015"}
 };
 
-static struct snd_soc_acpi_codecs rt1015p_spk = {
+static const struct snd_soc_acpi_codecs rt1015p_spk = {
 	.num_codecs = 1,
 	.codecs = {"RTL1015"}
 };
 
-static struct snd_soc_acpi_codecs mx98360a_spk = {
+static const struct snd_soc_acpi_codecs mx98360a_spk = {
 	.num_codecs = 1,
 	.codecs = {"MX98360A"}
 };
diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
index 741bf2f9e081..4e817f559d38 100644
--- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
@@ -12,32 +12,32 @@
 
 static struct skl_machine_pdata skl_dmic_data;
 
-static struct snd_soc_acpi_codecs kbl_codecs = {
+static const struct snd_soc_acpi_codecs kbl_codecs = {
 	.num_codecs = 1,
 	.codecs = {"10508825"}
 };
 
-static struct snd_soc_acpi_codecs kbl_poppy_codecs = {
+static const struct snd_soc_acpi_codecs kbl_poppy_codecs = {
 	.num_codecs = 1,
 	.codecs = {"10EC5663"}
 };
 
-static struct snd_soc_acpi_codecs kbl_5663_5514_codecs = {
+static const struct snd_soc_acpi_codecs kbl_5663_5514_codecs = {
 	.num_codecs = 2,
 	.codecs = {"10EC5663", "10EC5514"}
 };
 
-static struct snd_soc_acpi_codecs kbl_7219_98357_codecs = {
+static const struct snd_soc_acpi_codecs kbl_7219_98357_codecs = {
 	.num_codecs = 1,
 	.codecs = {"MX98357A"}
 };
 
-static struct snd_soc_acpi_codecs kbl_7219_98927_codecs = {
+static const struct snd_soc_acpi_codecs kbl_7219_98927_codecs = {
 	.num_codecs = 1,
 	.codecs = {"MX98927"}
 };
 
-static struct snd_soc_acpi_codecs kbl_7219_98373_codecs = {
+static const struct snd_soc_acpi_codecs kbl_7219_98373_codecs = {
 	.num_codecs = 1,
 	.codecs = {"MX98373"}
 };
diff --git a/sound/soc/intel/common/soc-acpi-intel-skl-match.c b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
index 961df8d6b5e4..75302e956742 100644
--- a/sound/soc/intel/common/soc-acpi-intel-skl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
@@ -12,7 +12,7 @@
 
 static struct skl_machine_pdata skl_dmic_data;
 
-static struct snd_soc_acpi_codecs skl_codecs = {
+static const struct snd_soc_acpi_codecs skl_codecs = {
 	.num_codecs = 1,
 	.codecs = {"10508825"}
 };
-- 
2.25.1

