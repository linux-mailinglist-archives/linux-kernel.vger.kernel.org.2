Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30363373D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhCKN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:27:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:8288 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233141AbhCKN1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:27:40 -0500
IronPort-SDR: 0ByynVjjNMvyBFVc6SLKOO3iLQwEAcC96oYn3aJg3aij2q0wJdQeF/o5DT9fDTICtGIi8yB/Lb
 xc5SU60gjIMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="185308980"
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="185308980"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 05:27:39 -0800
IronPort-SDR: 1naYdwb6TYKPitpDxqKbwF2YDvxGN9z6QMAgjdE0diAESfqPoGdM/zMGEiPRKfHm9az1jOxr6d
 +opmAkjnee0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="404073379"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2021 05:27:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB9A92BD; Thu, 11 Mar 2021 15:27:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ALSA: hda/realtek: Sort alphanumerically the HDA_CODEC_ENTRY() entries.
Date:   Thu, 11 Mar 2021 15:27:48 +0200
Message-Id: <20210311132748.81071-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort alphanumerically the HDA_CODEC_ENTRY() entries for better maintenance.
No functional change implied.

Note, that HDA_CODEC_REV_ENTRY() goes after HDA_CODEC_ENTRY() as per
default value in the latter macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/hda/patch_realtek.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d23c8c2e6833..c9e62693db6d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10341,10 +10341,7 @@ static const struct hda_device_id snd_hda_id_realtek[] = {
 	HDA_CODEC_ENTRY(0x10ec0299, "ALC299", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0300, "ALC300", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0623, "ALC623", patch_alc269),
-	HDA_CODEC_REV_ENTRY(0x10ec0861, 0x100340, "ALC660", patch_alc861),
 	HDA_CODEC_ENTRY(0x10ec0660, "ALC660-VD", patch_alc861vd),
-	HDA_CODEC_ENTRY(0x10ec0861, "ALC861", patch_alc861),
-	HDA_CODEC_ENTRY(0x10ec0862, "ALC861-VD", patch_alc861vd),
 	HDA_CODEC_REV_ENTRY(0x10ec0662, 0x100002, "ALC662 rev2", patch_alc882),
 	HDA_CODEC_REV_ENTRY(0x10ec0662, 0x100101, "ALC662 rev1", patch_alc662),
 	HDA_CODEC_REV_ENTRY(0x10ec0662, 0x100300, "ALC662 rev3", patch_alc662),
@@ -10359,16 +10356,19 @@ static const struct hda_device_id snd_hda_id_realtek[] = {
 	HDA_CODEC_ENTRY(0x10ec0701, "ALC701", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0703, "ALC703", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0711, "ALC711", patch_alc269),
+	HDA_CODEC_ENTRY(0x10ec0861, "ALC861", patch_alc861),
+	HDA_CODEC_REV_ENTRY(0x10ec0861, 0x100340, "ALC660", patch_alc861),
+	HDA_CODEC_ENTRY(0x10ec0862, "ALC861-VD", patch_alc861vd),
 	HDA_CODEC_ENTRY(0x10ec0867, "ALC891", patch_alc662),
 	HDA_CODEC_ENTRY(0x10ec0880, "ALC880", patch_alc880),
 	HDA_CODEC_ENTRY(0x10ec0882, "ALC882", patch_alc882),
 	HDA_CODEC_ENTRY(0x10ec0883, "ALC883", patch_alc882),
+	HDA_CODEC_ENTRY(0x10ec0885, "ALC885", patch_alc882),
 	HDA_CODEC_REV_ENTRY(0x10ec0885, 0x100101, "ALC889A", patch_alc882),
 	HDA_CODEC_REV_ENTRY(0x10ec0885, 0x100103, "ALC889A", patch_alc882),
-	HDA_CODEC_ENTRY(0x10ec0885, "ALC885", patch_alc882),
 	HDA_CODEC_ENTRY(0x10ec0887, "ALC887", patch_alc882),
-	HDA_CODEC_REV_ENTRY(0x10ec0888, 0x100101, "ALC1200", patch_alc882),
 	HDA_CODEC_ENTRY(0x10ec0888, "ALC888", patch_alc882),
+	HDA_CODEC_REV_ENTRY(0x10ec0888, 0x100101, "ALC1200", patch_alc882),
 	HDA_CODEC_ENTRY(0x10ec0889, "ALC889", patch_alc882),
 	HDA_CODEC_ENTRY(0x10ec0892, "ALC892", patch_alc662),
 	HDA_CODEC_ENTRY(0x10ec0897, "ALC897", patch_alc662),
-- 
2.30.1

