Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8920A33A963
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 02:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCOBjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 21:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCOBjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 21:39:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9356AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 18:39:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id t85so5571780pfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 18:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aGqV0l6/x/GxBVirCNeqaoHtTJlTX8f5e3u4gvZa+P8=;
        b=G980fo3Rcpn+Zr4OizAKE1jawcEafv6s6F1pLvyfUKz+uVPcdmBie9Xmy/MwTs2iwk
         kCN9Jf01I4vlDfOd9anIOp0xNfPF/fiZpaaAma6Y74vDmqj7rQ9ayBdB+lr0QNkIJbq0
         UK8hod2fdKT3arKahIX9n+kuYCiWRM3haZG5DkqbH5BUJANJQOxOdD5vV4GgNHhD1TNC
         lnQ0VXxw4OB8+Bf0Enli+xkNJegZHYQX3pHSuEUSGV6nSemgTr8QiQMW/YIGwjXe0bcR
         6Fqo2Yz9/6O7wFY4iUg+sMcrEO23kLnzf6KfqNm0T6ZGXPjEbiqbr4tLGjkFNagWhLDx
         OjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aGqV0l6/x/GxBVirCNeqaoHtTJlTX8f5e3u4gvZa+P8=;
        b=jaP9XY+gXiXAVu9I08N+k4O4ssso6yeriLEtSs2CTuuKoqNw4VK4xj6++VJdQlBlIa
         sshNRtJBMPf1LhNO3vvzU2a11+ClDY6Ne4mcvph5uyroSIMLYmVV0dt2LEqJJRHbv1E3
         E5bCc0d+iR7cLTh0S/7Rcs2cogF3kR4pxxmCmsC9/jgM7MOqbLlK2155qcGLSu9rxN2g
         ZuumVOf6jijUoFHvjuKQF0thRpVcrwY0ilKxuFi28ywh78NdKWxUiLlU6sw0O60vXyPx
         krj1kywf9RdKzbpNyM/F7bJJvmi2mAMaO8oeeErQl5R4nnc9wSo1Vj9yg9u5KFChtphx
         s/Rw==
X-Gm-Message-State: AOAM532oKNXx2nrV44HuVz94rTZyL5sxSeMpA//mG2LvYCz6fM77etsE
        YZ8f9wqeiIUWADInuKMo77k=
X-Google-Smtp-Source: ABdhPJzjjppKucqAMAWslnrDSgAkFrxGEqmGKcfESUxQj68jYI/Yif7t+SKGzyqoGGDj+lPHlrwm0g==
X-Received: by 2002:aa7:85c1:0:b029:1f4:4fcc:384d with SMTP id z1-20020aa785c10000b02901f44fcc384dmr8462224pfn.10.1615772354062;
        Sun, 14 Mar 2021 18:39:14 -0700 (PDT)
Received: from nick-Blade-Stealth.lan ([2600:1700:6d11:6f:e593:d5dc:8119:b8b2])
        by smtp.googlemail.com with ESMTPSA id 8sm8444588pjj.53.2021.03.14.18.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 18:39:13 -0700 (PDT)
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
To:     nick.desaulniers@gmail.com
Cc:     Julia.Lawall@inria.fr, alsa-devel@alsa-project.org,
        amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com, broonie@kernel.org,
        cezary.rojewski@intel.com, guennadi.liakhovetski@linux.intel.com,
        liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org,
        mateusz.gorski@linux.intel.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        yang.jie@linux.intel.com
Subject: [PATCH v3] ASoC: Intel: Skylake: skl-topology: fix -frame-larger-than
Date:   Sun, 14 Mar 2021 18:39:08 -0700
Message-Id: <20210315013908.217219-1-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHp75Vdy083+5K=4sViwg8uNJ1_6agECYbjMSFEGXX9VTO85WQ@mail.gmail.com>
References: <CAHp75Vdy083+5K=4sViwg8uNJ1_6agECYbjMSFEGXX9VTO85WQ@mail.gmail.com>
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

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
Changes V2 -> V3:
* change to kmalloc+memset to fix logic error, as per Andy.
Changes V1 -> V2:
* rebased on mainline.

 sound/soc/intel/skylake/skl-topology.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b824086203b9..c0fdab39e7c2 100644
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
 
+	val = kmalloc(sizeof(*val), GFP_KERNEL);
+	if (!val)
+		return;
+
+	mach = dev_get_platdata(component->card->dev);
 	list_for_each_entry(dobj, &component->dobj_list, list) {
 		struct snd_kcontrol *kcontrol = dobj->control.kcontrol;
 		struct soc_enum *se;
@@ -3632,14 +3637,14 @@ static void skl_tplg_complete(struct snd_soc_component *component)
 		sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
 
 		for (i = 0; i < se->items; i++) {
-			struct snd_ctl_elem_value val = {};
-
 			if (strstr(texts[i], chan_text)) {
-				val.value.enumerated.item[0] = i;
-				kcontrol->put(kcontrol, &val);
+				memset(val, 0, sizeof(*val));
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

