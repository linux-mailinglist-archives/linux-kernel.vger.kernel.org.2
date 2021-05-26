Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3895839230A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhEZXMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbhEZXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:11:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA68C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b26so5039179lfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wxumGjjKmyhy9AtNX/EtM7gYeJBe+fSFWDY+3BCIpJU=;
        b=YR9BmeUR/SYPMeg44xeLZIrjLsDpNsbNs1BHLe9YOZCku+u9FMj/5Q/EtP+jIcxg61
         7UbRVsnNsynH//WdoJ2KPnTSHRBhVZGYltbLHewlvJCP23PfWwY2g/HE56gq5jT3sH/Y
         mnbCcCokGDs8mLyVgNjkQZHu0fahoJPD+fzGn5YNnz8zM51jusobKXgx+FA0EMhGvbi/
         jbxYeQKw/eTyDPBRab0KtPq6wuXmO/UnYfYDUWt8APYN0MvCXPj4Qn7V1tcA3KYrZU1I
         jSjJMMZqZJxJXy2qeeRpbLrSxqXR0RalN4rtyWnjRH6eV235rlSL7toVVLb3pOs7jsMu
         9rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxumGjjKmyhy9AtNX/EtM7gYeJBe+fSFWDY+3BCIpJU=;
        b=Zo7GTVEI2qePDxjXGWVXiG/BG7ENNXO6q/JbxsaUv+17Q+qHClpUhIsP2i7CIANOW9
         7NKzPO/U1v2U5ctNzCLLbQIGKEeVB4BX/Ik0i7nnEZPkHp0YDNLwBPaaqc8+EDlg56/A
         XeSBxOtrk2jTz9L+sgr48I+dOCa4YA0sO/7hnCTYBMj9ReTS2yAvoNmwENJ7JxPFQvdu
         xQOmVKaIoGmtRTSZj5zPer01eDdR8Rfb6v04AtJuZEnq9KVrzirT0XR1NaX/9E7YcvYp
         dpl9ClmHcdlre2y5xA1V6Y4CQIx27Emg8Q4IvXR62AdnBmKXknuzg/Qm60laWudhHVRg
         Tx0Q==
X-Gm-Message-State: AOAM530De0wR3fH0hThYDgdc+1RDP4Y3OviN3xFBOaFyH9Mlhb2m2Ahs
        hjfezdCIYQFbLlYMqEYGEdw=
X-Google-Smtp-Source: ABdhPJzU0//HLO1M/s3OeXk8PSoCR7XVVz3EuRNaT6s/U8dFBo9RZn0KG+0JF/za48r6ATihAp0Dlg==
X-Received: by 2002:ac2:5304:: with SMTP id c4mr313085lfh.634.1622070624981;
        Wed, 26 May 2021 16:10:24 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id d5sm35802lfi.144.2021.05.26.16.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:10:24 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        patches@opensource.cirrus.com
Subject: [PATCH 3/5] ASoC: wm5110: Constify static struct snd_compress_ops
Date:   Thu, 27 May 2021 01:10:11 +0200
Message-Id: <20210526231013.46530-4-rikard.falkeborn@gmail.com>
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
 sound/soc/codecs/wm5110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 76efca0fe515..5c2d45d05c97 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2355,7 +2355,7 @@ static unsigned int wm5110_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_6R,
 };
 
-static struct snd_compress_ops wm5110_compress_ops = {
+static const struct snd_compress_ops wm5110_compress_ops = {
 	.open		= wm5110_open,
 	.free		= wm_adsp_compr_free,
 	.set_params	= wm_adsp_compr_set_params,
-- 
2.31.1

