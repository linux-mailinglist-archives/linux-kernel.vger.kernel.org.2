Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23EC392309
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhEZXMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbhEZXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:11:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B050EC061760
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:25 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b26so5039151lfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J91A2ezJDwmmBjDbHzFnYK1SauhUWhSDtbv+ex6BQOE=;
        b=MIcepU1970vDHoUb96UFwfdYyRxbLToMCwifD7g/JcbLZv+mJFPdH5/BH15slSU09p
         OUpIpHClX62/SKVvDxMGfInkkAhYT57wIeHj5qgu8Kzf4PafVDYW4VcPDswnu6ZpC3VX
         nDNZfXNJCTJrsSM/Du2AjquLHl2Tz4oInZmK4VXmh9Kx1rG6Trfgtrzvs03+HHtUO6G5
         3Cq+k68/P/+yaxiTL1RS0tBci5pODFWxJzZaD2IegVe9TLbXk9rJi/Al29CsYF/mDCdO
         rEVYaPA1UwPo2z7OAZvxrIZgzys/RnpNV8C+PGdfG+Io+McJ7QNw92JsnFneNCyZJM1n
         bEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J91A2ezJDwmmBjDbHzFnYK1SauhUWhSDtbv+ex6BQOE=;
        b=bPxNpVFkJ+Wz6SbHCz9lHuiEw97VOdsxyfTJ794gJd8Qrj7klApar/a/9GEIOhbf5i
         M9Gp2n6I5s8uaDnAcj2Q5k0IvcCVbCOpeQipAW+2qAWNay9Gg/sIayTwnTOyEyGaXY8s
         C2HulB5MgYNYtYEvRQuUL/uii8Hr5L2OR/vJVs+n/hY/gMwJGGIDS1JnavIu04CL4pHU
         /QD2WGDh7TMT5BnV1z2sbelerut/OCQ8gDE803g2KMUwysM0D8UXd9Qs4JqikNlHPO/E
         aK9tNPiMgIPZBQ+n+1ucK5vHlfuNi9Jubbuh0OdbLXXPKJg2HJZfm6tlatDE73vaxqmy
         P3vQ==
X-Gm-Message-State: AOAM530G9mWjCWiFi90xsjX16ka1T8wjPurpoLPF4kR9Vgj18J6gXsts
        80OIGyiiMs9lfE5tnAQv7Yk=
X-Google-Smtp-Source: ABdhPJxT4uY6M8RKPTvy2BvhyVq4g0Cd0qirCeVYzU5lkL6YtQEwOkpw5HntEv08KNRZ9HTvwRgSnw==
X-Received: by 2002:a19:f012:: with SMTP id p18mr293953lfc.493.1622070624086;
        Wed, 26 May 2021 16:10:24 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id d5sm35802lfi.144.2021.05.26.16.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:10:23 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        patches@opensource.cirrus.com
Subject: [PATCH 2/5] ASoC: wm5102: Constify static struct snd_compress_ops
Date:   Thu, 27 May 2021 01:10:10 +0200
Message-Id: <20210526231013.46530-3-rikard.falkeborn@gmail.com>
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
 sound/soc/codecs/wm5102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 34b665895bdf..621598608bf0 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1989,7 +1989,7 @@ static unsigned int wm5102_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_5R,
 };
 
-static struct snd_compress_ops wm5102_compress_ops = {
+static const struct snd_compress_ops wm5102_compress_ops = {
 	.open		= wm5102_open,
 	.free		= wm_adsp_compr_free,
 	.set_params	= wm_adsp_compr_set_params,
-- 
2.31.1

