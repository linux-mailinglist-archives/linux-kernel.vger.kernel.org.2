Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0739033A375
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 09:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCNIG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 04:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNIG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 04:06:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C107AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 00:06:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso13150338pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 00:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bXA6USXXf109kPN2SOHKYnrZwby0HZ2THc1y1K25TU=;
        b=G3Y6yivPa58rOuro/9lEATBfZExqHF5rvchwObszi6o6PK0CqQcKh3FdsUSTkEtz1J
         Oy1SEcZlt/HaDp+8yp0yedHl7aZ+90p++ZcXWJpUHclikcd3nFHYL7Zl49stvuLRfKHv
         8nRfWTxPY5M0stzPVNK1Pb6SLYUpjEZhpifUV4vtnKJgTesZZ2iofHip4WXjXWFPG3PY
         x/Qj5RMwvGKeWFJR3/uVOVBUwmpuiGhtVYm1FiJTLz0wUyk6h2LM9YYqPtgu/gbXCBPU
         Z1+CvUMklE8XXjRXqd7Fa4MlKrO6yFxnkBXKV3ikJxAD2kPfCC5X8NwdM1fApvZy+yLW
         6qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bXA6USXXf109kPN2SOHKYnrZwby0HZ2THc1y1K25TU=;
        b=lZAmZMQqwUqdGOxfr/zeifTdD99d4MslZQq2a9+MWJPTDDAwmPrOdBPefPDUBp2qa3
         10SRwtbVkm4GAjkBY8Zqf00tGkArN5OeknnRdh6ffwwXlrV5IKcjnLionE/xjfl2g5Xl
         r3TeQfVxW548BGZJD6sMHdwC6wyq1fIBS1VNX8zB/bpQjIUIYhfS75JpqI2f/NbGlIIR
         cOXkUTXHC7a9PQ0UpL1xF4IJHM/6W3guLQyfBL9Or+es15gT+ikMBgPKw/b2bFntMpWk
         M+LNtgwjOQcWLHo2C5pp7g1lA6ra8ncA9OQMrYw94o9dPc+HbsDWKgFDrR2SRt1tf+Qp
         hU9w==
X-Gm-Message-State: AOAM532YP/fPM9WMezFTD/mfY1zVsk2MHTU/1hWot4XYLJeISDqLmKCJ
        fBFwMWbQ6mfbAHpylPZvZr8=
X-Google-Smtp-Source: ABdhPJxXFqS4n3T/tv2hr/Rrm5Gohn8JYplE+kLI06g3oq9mAPxz0mAia30K8wHD4C+Yq/+4LBXcnw==
X-Received: by 2002:a17:902:bf92:b029:e6:bc0:25ac with SMTP id v18-20020a170902bf92b02900e60bc025acmr6662299pls.49.1615709179641;
        Sun, 14 Mar 2021 00:06:19 -0800 (PST)
Received: from nick-Blade-Stealth.lan ([2600:1700:6d11:6f:aa3:33d6:bd6f:3286])
        by smtp.googlemail.com with ESMTPSA id r186sm10177565pfr.124.2021.03.14.00.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 00:06:19 -0800 (PST)
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
To:     nick.desaulniers@gmail.com
Cc:     Julia.Lawall@inria.fr, alsa-devel@alsa-project.org,
        amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com, broonie@kernel.org,
        cezary.rojewski@intel.com, guennadi.liakhovetski@linux.intel.com,
        liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org,
        mateusz.gorski@linux.intel.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        yang.jie@linux.intel.com
Subject: [PATCH v2] ASoC: Intel: Skylake: skl-topology: fix -frame-larger-than
Date:   Sun, 14 Mar 2021 00:06:13 -0800
Message-Id: <20210314080613.190663-1-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210314074434.164868-1-nick.desaulniers@gmail.com>
References: <20210314074434.164868-1-nick.desaulniers@gmail.com>
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
Changes V1 -> V2: rebased on mainline.

 sound/soc/intel/skylake/skl-topology.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b824086203b9..566d07b4b523 100644
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
 		struct soc_enum *se;
@@ -3632,14 +3637,13 @@ static void skl_tplg_complete(struct snd_soc_component *component)
 		sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
 
 		for (i = 0; i < se->items; i++) {
-			struct snd_ctl_elem_value val = {};
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

base-commit: 88fe49249c99de14e543c632a46248d85411ab9e
-- 
2.25.1

