Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC8A33A370
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 08:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhCNHpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNHor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 03:44:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA06C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 23:44:47 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so12764459pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 23:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/UsNynLrn3gfHIh2wsBU8ZzW+u+h32Tr3P8Iq5YLDLQ=;
        b=t+9mz/ajPiRLOk68DvwWtoI0cpnltyJYBWLf/QmINFLPoXMOQU2qkVCWNt37oL0Did
         keytkbI3KwDcuJ7H+VzlvGf9i9yFTqVmdXCjLYiRiL290Urd7IB6jRQtGrOHUH1ZwUus
         ySG5+sttGNE4skfMVOoJ4hXJu//4oBWlDInDf0HX5GBXDlGuOT9uTVZZ4WV9efKvLnuW
         x12lKZ1mXUN6BVzAgq6mEwVKaULHbyiPkiWZXMNGJIWr+ecedJbzP7hlcUlLgKynbzh2
         jSfYZEOn9GwWuxtKZDqnALN3qH/LRbJdfgGcV8iXIHr8dPLe8mZAsm1ttg72bh1dM1aP
         CZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/UsNynLrn3gfHIh2wsBU8ZzW+u+h32Tr3P8Iq5YLDLQ=;
        b=IwFf3S04vsbjSg57X126wNHMD2Nx+kf9xEh12W/QLXGrhxe+SmFVUe66qIvxfCla5Y
         0PjPQOZMHQERbaMiwqpaXePrVXu0DC1sv5MNPkkZsizoN4RzXtDLQKsMir3LSRTU8lqf
         3cY/18/rA9NVJkIk+fQ4tcaKO2uNvkoEbQAqvxCp5Cu4TJgxtwhiH5BjS9/QQ4D/lUvI
         NDjxClndiV9IEQHICFVho2hnw688eAPWFdhjJIBLE9m/HiX5PzAY5f8rd3Sxe8w++0Nj
         5jI43JA6ZJwF7IVlvCrpjQ4q8QS8SytY54MPWI8INSAZVLVWoLkOhfmh4DopDCb/iPRr
         6YPg==
X-Gm-Message-State: AOAM532wBk9LXNGBihFjZ0abXcY8LL/hA5A8QCTwtKlH0zqgiaJA8dqU
        QefRVa1h5koAkiZNxOo0Ni4=
X-Google-Smtp-Source: ABdhPJwuxcTvmVu5hn0qpomzXOQp/3fisYEWSPaQUb/FM2qn9IF+ZEri4CF9gE72gRiuno7IidPpNg==
X-Received: by 2002:a17:90a:1502:: with SMTP id l2mr6749122pja.149.1615707886392;
        Sat, 13 Mar 2021 23:44:46 -0800 (PST)
Received: from nick-Blade-Stealth.lan ([2600:1700:6d11:6f:aa3:33d6:bd6f:3286])
        by smtp.googlemail.com with ESMTPSA id z2sm9830560pfa.121.2021.03.13.23.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 23:44:45 -0800 (PST)
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Cc:     Nick Desaulniers <nick.desaulniers@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: Skylake: skl-topology: fix -frame-larger-than
Date:   Sat, 13 Mar 2021 23:44:33 -0800
Message-Id: <20210314074434.164868-1-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
sound/soc/intel/skylake/skl-topology.c:3613:13: warning: stack frame
size of 1304 bytes in function 'skl_tplg_complete'
[-Wframe-larger-than=]

struct snd_ctl_elem_value is 1224 bytes in my configuration.

Heap allocate it, then free it within the current frame.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 sound/soc/intel/skylake/skl-topology.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ae466cd59292..cdc916c91301 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3613,10 +3613,15 @@ static int skl_manifest_load(struct snd_soc_component *cmpnt, int index,
 static void skl_tplg_complete(struct snd_soc_component *component)
 {
 	struct snd_soc_dobj *dobj;
-	struct snd_soc_acpi_mach *mach =
-		dev_get_platdata(component->card->dev);
+	struct snd_soc_acpi_mach *mach;
+	struct snd_ctl_elem_value *val;
 	int i;
 
+	val = kzalloc(sizeof(*val), GFP_KERNEL);
+	if (!val)
+		return;
+
+	mach = dev_get_platdata(component->card->dev);
 	list_for_each_entry(dobj, &component->dobj_list, list) {
 		struct snd_kcontrol *kcontrol = dobj->control.kcontrol;
 		struct soc_enum *se =
@@ -3631,14 +3636,13 @@ static void skl_tplg_complete(struct snd_soc_component *component)
 		sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
 
 		for (i = 0; i < se->items; i++) {
-			struct snd_ctl_elem_value val;
-
 			if (strstr(texts[i], chan_text)) {
-				val.value.enumerated.item[0] = i;
-				kcontrol->put(kcontrol, &val);
+				val->value.enumerated.item[0] = i;
+				kcontrol->put(kcontrol, val);
 			}
 		}
 	}
+	kfree(val);
 }
 
 static struct snd_soc_tplg_ops skl_tplg_ops  = {

base-commit: 65f0d2414b7079556fbbcc070b3d1c9f9587606d
prerequisite-patch-id: 4d05aad8c2b50c0c3b4447dd842abe8b1b840927
-- 
2.25.1

