Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AFC42543D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbhJGNjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:39:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:43073 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241631AbhJGNjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:39:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="206369568"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="206369568"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 06:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="484523130"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.56])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2021 06:36:58 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        linux-kernel@vger.kernel.org, Rander Wang <rander.wang@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>
Subject: [PATCH v2 1/3] ASoC: soc-acpi: add comp_ids field for machine driver matching
Date:   Thu,  7 Oct 2021 21:35:14 +0800
Message-Id: <20211007133516.1464655-2-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007133516.1464655-1-brent.lu@intel.com>
References: <20211007133516.1464655-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A machine driver needs to be enumerated by more than one ACPI HID if
it supports second headphone driver (i.e. rt5682 and rt5682s).
However, the id field in snd_soc_acpi_mach structure could contain
only one HID. By adding a 'comp_ids' field which can contain several
HIDs, we can enumerate a machine driver by multiple ACPI HIDs.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 include/sound/soc-acpi.h |  2 ++
 sound/soc/soc-acpi.c     | 24 ++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 2f3fa385c092..43cf520f145e 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -129,6 +129,7 @@ struct snd_soc_acpi_link_adr {
  * all firmware/topology related fields.
  *
  * @id: ACPI ID (usually the codec's) used to find a matching machine driver.
+ * @comp_ids: a list of audio codecs also used to find a matching machine driver.
  * @link_mask: describes required board layout, e.g. for SoundWire.
  * @links: array of link _ADR descriptors, null terminated.
  * @drv_name: machine driver name
@@ -146,6 +147,7 @@ struct snd_soc_acpi_link_adr {
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
 	const u8 id[ACPI_ID_LEN];
+	struct snd_soc_acpi_codecs *comp_ids;
 	const u32 link_mask;
 	const struct snd_soc_acpi_link_adr *links;
 	const char *drv_name;
diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index 395229bf5c51..aca7c2020567 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -8,14 +8,34 @@
 #include <linux/module.h>
 #include <sound/soc-acpi.h>
 
+static bool snd_soc_acpi_id_present(struct snd_soc_acpi_mach *machine)
+{
+	struct snd_soc_acpi_codecs *comp_ids = machine->comp_ids;
+	int i;
+
+	if (machine->id[0]) {
+		if (acpi_dev_present(machine->id, NULL, -1))
+			return true;
+	}
+
+	if (comp_ids) {
+		for (i = 0; i < comp_ids->num_codecs; i++) {
+			if (acpi_dev_present(comp_ids->codecs[i], NULL, -1))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 struct snd_soc_acpi_mach *
 snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 {
 	struct snd_soc_acpi_mach *mach;
 	struct snd_soc_acpi_mach *mach_alt;
 
-	for (mach = machines; mach->id[0]; mach++) {
-		if (acpi_dev_present(mach->id, NULL, -1)) {
+	for (mach = machines; mach->id[0] || mach->comp_ids; mach++) {
+		if (snd_soc_acpi_id_present(mach)) {
 			if (mach->machine_quirk) {
 				mach_alt = mach->machine_quirk(mach);
 				if (!mach_alt)
-- 
2.25.1

