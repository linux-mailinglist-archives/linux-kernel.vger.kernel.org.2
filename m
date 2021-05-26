Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A67E39230C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhEZXMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhEZXMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:12:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702A6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r5so5055965lfr.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6cqfoBUBIBZBnXHCZDwrElhf2ir+Bt3tbcHnECyy/1M=;
        b=E+voA5DP9ip8MLWp4XLYG2OuwruYbMDCfDQ7oqaYWWtBxhM1nVixvjfaZarsFImE8L
         jZSs9N5GHZAcZgPk02QqXnPp+DbpQYO6La58ZSvPQLgef3kUGJRZbg7tPAzdq85zandR
         TpLI073zWBA1AMn8+au6kN2xpDK9d5IjhoHaC4W0cFuJbuRTY1bqBLPYcdXxDEbX90Gl
         bJUFosbC9IZcA2z0sRIpbTOzgElAlwHIeIEPhcxVOql1FpnGoRwler0SuQXSUo2gdvF+
         kEODqbiFdu3NtYNw7222pT73eCeBif2xgzuFr5kLnHyI5IHShJ4la9kgECaWQD+4JRsp
         hRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6cqfoBUBIBZBnXHCZDwrElhf2ir+Bt3tbcHnECyy/1M=;
        b=U2hbnh5TNeaTrhg/FtzMc09ETaoalZbY3Vb5B9JXLQAhK+bWzSpFRdmf88MI08lQ1G
         Oz+buYKoepwKMC+D1s5mqshc/QvPhT9/cUEhcsTn2bDQD4rwTyBEBkJHQi4l47D7Acbn
         BWDhgA+kSajJ5uMd0rKJxOGc1OPIt0oebbTqD8H4Itjyw44xi6Z1DOQm3TUhNdXXWqoK
         AYueKpeHixNbzLHn+Yki7zwgjIIeIxxD/gtNmNwkvS4tD78ZfMAKGzYNOmgT6MGKTTqs
         P48u3tTEwMUnk0yjP0EZ1ts9kBlTkuapqg2WqchlMJVii8IxP7zW3yAgXAD7XhfDY60V
         YWZg==
X-Gm-Message-State: AOAM5335qVnDwS+u999lsoY1GXmBLSIMWmQb1+By0mpm4tN/TckHwmse
        qO5OknnVLmCCfZJbxu1OpwpKJ+B4ujtSYQ==
X-Google-Smtp-Source: ABdhPJx80KNIisL1p6ZVTMU6a/aB8NzELevSRe5WFSORcB66wyOizl7X18sXKzNGPD0naO6eoIuKQg==
X-Received: by 2002:a19:4085:: with SMTP id n127mr308460lfa.415.1622070626866;
        Wed, 26 May 2021 16:10:26 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id d5sm35802lfi.144.2021.05.26.16.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:10:26 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org
Subject: [PATCH 5/5] ASoC: SOF: Intel: Constify sof_probe_compressed_ops
Date:   Thu, 27 May 2021 01:10:13 +0200
Message-Id: <20210526231013.46530-6-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
References: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of sof_probe_compressed_ops is to assign its address to
the compress_ops field in the snd_soc_component_driver struct, which is
a pointer to const. The assignment is done in sound/soc/sof/pcm.c. Make
it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/sof/compress.c | 2 +-
 sound/soc/sof/compress.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 2d4969c705a4..57d5bf0a171e 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -13,7 +13,7 @@
 #include "ops.h"
 #include "probe.h"
 
-struct snd_compress_ops sof_probe_compressed_ops = {
+const struct snd_compress_ops sof_probe_compressed_ops = {
 	.copy		= sof_probe_compr_copy,
 };
 EXPORT_SYMBOL(sof_probe_compressed_ops);
diff --git a/sound/soc/sof/compress.h b/sound/soc/sof/compress.h
index ca8790bd4b13..4448c799e14b 100644
--- a/sound/soc/sof/compress.h
+++ b/sound/soc/sof/compress.h
@@ -13,7 +13,7 @@
 
 #include <sound/compress_driver.h>
 
-extern struct snd_compress_ops sof_probe_compressed_ops;
+extern const struct snd_compress_ops sof_probe_compressed_ops;
 
 int sof_probe_compr_open(struct snd_compr_stream *cstream,
 		struct snd_soc_dai *dai);
-- 
2.31.1

