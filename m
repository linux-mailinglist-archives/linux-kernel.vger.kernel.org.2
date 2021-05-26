Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72173392308
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhEZXME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbhEZXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:11:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B829BC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e17so4481206lfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0DwJ6464lblgiJlofD5GM02fvqVVflTlv4Zsog+he+Q=;
        b=NpYz1s8S7yxF1eqtPR6VkJLmv68CCWaRwk2PECxnZO+Y3ztcKaXwkGfGYNqIXLCAe6
         6yANl5CG9Il18wP4WNoNQVEzUFSgDLxavq1D6IxmL+Z6xoXrg2Z0cpXnJwns8J0b4G8y
         8TUnzI6jTQSmmlWgkEpNB8knZ/JRoxyHS3/QGZYuMErowraWvgmNh4E+PDSc/6YZayzC
         OnviQkz0Pd7xqh64cftvKK9MpwYwG4c/vXhkMJcs6e5fKJBmX0zhRpS8znhKlsehhwza
         2pLmZL+dMf5PW/nBxnIutbve9bRnxX9WKRDjHCx+jpEjYy2qtkb6Dt/1HCm6sZO6X0WD
         Zz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0DwJ6464lblgiJlofD5GM02fvqVVflTlv4Zsog+he+Q=;
        b=SsygB13gcIrPA3E/izRxoWAoAen0+Osb2Hl1s51+WIIl84HhXMcB902yvrfTTsnbq7
         WCBlXgi8HgzetzzuEOoDQ16N0xGupVZ46Z4Lxt+Rq27okWR+jpfz627mYXhWRE9ZgOq3
         z2OedeG3SxBBv8lbLTtLItVcwp8vyKEN1PQjJS+ztOn+IKC7lrJW0ReKYJPlEMjukoBU
         q68MCf6dHE7QjfEKVAM57Zj765wTWzrrArU8V69yWNebywIhWV3TmEAh6z8q3KgbqKrP
         php0m8H4DVv1gPuhSWrSEd489Gg8ugji/XtHfZLGOlmlpwSImmlJEyMuEEOulH9x7PW+
         oygQ==
X-Gm-Message-State: AOAM530wDgUntSPwYWdyys2KgCzBS+84YT3r2CQ/zdigGwPcmO6fF13m
        zbmVlx8M/6lwjoZsLTbR2ZM=
X-Google-Smtp-Source: ABdhPJx3wJMUqA3I0HnKdDRalpJxqKd7JaTCDIbE0v4w2KBZxtwFsGjC3mcsc82mGmi2onNu031V5Q==
X-Received: by 2002:a19:dc4e:: with SMTP id f14mr314076lfj.176.1622070623116;
        Wed, 26 May 2021 16:10:23 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id d5sm35802lfi.144.2021.05.26.16.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:10:22 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        patches@opensource.cirrus.com
Subject: [PATCH 1/5] ASoC: cs47125: Constify static struct snd_compress_ops
Date:   Thu, 27 May 2021 01:10:09 +0200
Message-Id: <20210526231013.46530-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
References: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The snd_compress_ops structs are only stored in the compress_ops field
of a snd_soc_component_driver struct, so make it const to allow the
compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/codecs/cs47l24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index eaabbb56a173..6b6d08816024 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1178,7 +1178,7 @@ static unsigned int cs47l24_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_4L,
 };
 
-static struct snd_compress_ops cs47l24_compress_ops = {
+static const struct snd_compress_ops cs47l24_compress_ops = {
 	.open		= cs47l24_open,
 	.free		= wm_adsp_compr_free,
 	.set_params	= wm_adsp_compr_set_params,
-- 
2.31.1

