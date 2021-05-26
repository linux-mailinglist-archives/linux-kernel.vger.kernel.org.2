Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EAF39230B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhEZXML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhEZXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:12:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75341C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j10so5007807lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rafWoYI/41oLLgH0zc0m9Aor5D1w1XH8dZGtN18a1Oo=;
        b=Owjd8HWLgAG1uF9eUcz4l+ojxm0RUTnNZxefGCvnrtLD7VD2G/cJfHxt8j2MsdgeCw
         lIIMx+FS5QWxozDGhHh+kLRt2PRo8HA9dXQ2kDt0kO2et3Cwe3RVCNd2wVSYvsrF98O1
         6YJ7PZQKyz6T9CsiTBsVhiQuBJGrrRb4DVIqBqOZ95324yQzPH/o9WKMUHp0wOv7w/gI
         dDMcsJSBcGG0IWxRybhx9DRlB9ZTSX/m70Hqv0SLchNUMrIIOPoGuXMPLa4TvYqRbPVv
         j8WsvmXygkf0u40PjKoRGFZe+PxGi37msbolBb0W+h1QNk9GvO+2XCbdkgfDg+8XialD
         6RNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rafWoYI/41oLLgH0zc0m9Aor5D1w1XH8dZGtN18a1Oo=;
        b=ITDAJ893ak5UfHh2APny5F4ODZZYt7ZMz649V/EfNxVsEvMIVlO4/sdbvQDj82XLnJ
         Lft5FFWZaLuLk67l4OZWy+ynOMi04cQg8O044VF2vCXpRB0ms+wLZjX5fCv/rPMjFe6h
         PFMHhj45+Vtp2XpsiBJDhadcVIKMrdND/zPnbfR4GcsKOSpyjz/0TuJJpAh5XqBZz7rm
         mKd10rir/SlXiY/FTOpAHcH3ONWobxl1Lr7zlUBVt4LgDVvmjnymgTNwmJiD7zQDF1bp
         gL11Yn76Ozm8QrWHyBXuveirPwfJab+1YpyZIoyQjM7EcsMJf2EJisccA0zf434jWHtW
         po9Q==
X-Gm-Message-State: AOAM531kSUiESE1Wy3POhSEXXH/yg0bPgNBHdeq0RSqGJLjdg/zEohw5
        hQn7XHMVh7a7DKK6NxKuqoA=
X-Google-Smtp-Source: ABdhPJyitHNPPsdsydEW2Ko0uLs6O40Fb+AnkAS84YPdbkTVGgy3LG8qxDVCn86Lx9O0HZfndd8IrQ==
X-Received: by 2002:a05:6512:21a:: with SMTP id a26mr321020lfo.468.1622070625906;
        Wed, 26 May 2021 16:10:25 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id d5sm35802lfi.144.2021.05.26.16.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:10:25 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>
Subject: [PATCH 4/5] ASoC: qcom: q6asm-dai: Constify static struct snd_compress_ops
Date:   Thu, 27 May 2021 01:10:12 +0200
Message-Id: <20210526231013.46530-5-rikard.falkeborn@gmail.com>
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
 sound/soc/qcom/qdsp6/q6asm-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 9766725c2916..5ff56a735419 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -1169,7 +1169,7 @@ static int q6asm_dai_compr_get_codec_caps(struct snd_soc_component *component,
 	return 0;
 }
 
-static struct snd_compress_ops q6asm_dai_compress_ops = {
+static const struct snd_compress_ops q6asm_dai_compress_ops = {
 	.open		= q6asm_dai_compr_open,
 	.free		= q6asm_dai_compr_free,
 	.set_params	= q6asm_dai_compr_set_params,
-- 
2.31.1

