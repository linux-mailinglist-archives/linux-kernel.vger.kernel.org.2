Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FA44239EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbhJFIrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:47:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:15157 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237543AbhJFIrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:47:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="225838574"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="225838574"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 01:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="568070709"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.56])
  by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2021 01:45:27 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Brent Lu <brent.lu@intel.com>
Subject: [PATCH] ASoC: soc-acpi: add alternative id field for machine driver matching
Date:   Wed,  6 Oct 2021 16:43:51 +0800
Message-Id: <20211006084351.438510-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current design to support second headphone driver in the same machine
driver is to duplicate the entries in snd_soc_acpi_mach array and
board configs in machine driver. We can avoid this by adding an id_alt
field in snd_soc_acpi_mach structure to specify alternative ACPI HIDs
for machine driver enumeration and leave the codec type detection to
machine driver if necessary.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 include/sound/soc-acpi.h |  2 ++
 sound/soc/soc-acpi.c     | 21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 2f3fa385c092..fcf6bae9f9d7 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -129,6 +129,7 @@ struct snd_soc_acpi_link_adr {
  * all firmware/topology related fields.
  *
  * @id: ACPI ID (usually the codec's) used to find a matching machine driver.
+ * @id_alt: array of ACPI IDs used as an alternative of id field.
  * @link_mask: describes required board layout, e.g. for SoundWire.
  * @links: array of link _ADR descriptors, null terminated.
  * @drv_name: machine driver name
@@ -146,6 +147,7 @@ struct snd_soc_acpi_link_adr {
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
 	const u8 id[ACPI_ID_LEN];
+	struct snd_soc_acpi_codecs *id_alt;
 	const u32 link_mask;
 	const struct snd_soc_acpi_link_adr *links;
 	const char *drv_name;
diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index 395229bf5c51..ab67d640c20f 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -8,6 +8,25 @@
 #include <linux/module.h>
 #include <sound/soc-acpi.h>
 
+static bool snd_soc_acpi_id_present(struct snd_soc_acpi_mach *machine)
+{
+	struct snd_soc_acpi_codecs *id_alt = machine->id_alt;
+	int i;
+
+	if (acpi_dev_present(machine->id, NULL, -1))
+		return true;
+
+	if (id_alt == NULL)
+		return false;
+
+	for (i = 0; i < id_alt->num_codecs; i++) {
+		if (acpi_dev_present(id_alt->codecs[i], NULL, -1))
+			return true;
+	}
+
+	return false;
+}
+
 struct snd_soc_acpi_mach *
 snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 {
@@ -15,7 +34,7 @@ snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 	struct snd_soc_acpi_mach *mach_alt;
 
 	for (mach = machines; mach->id[0]; mach++) {
-		if (acpi_dev_present(mach->id, NULL, -1)) {
+		if (snd_soc_acpi_id_present(mach) != false) {
 			if (mach->machine_quirk) {
 				mach_alt = mach->machine_quirk(mach);
 				if (!mach_alt)
-- 
2.25.1

