Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC7136EF02
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbhD2Rhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240969AbhD2Rhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619717809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K4rNwoUrsBxVZzoadAn6uvb1lrOSv00d53aEi1UZj3U=;
        b=R84VLNkFqpM7GHnpj9QO9duzXPPB00Q7eRbdhyt8voO2oq4QT1/k1dv1Tg/t680aBOzIgV
        ApbXeCHCOW8LUCUmRJ7ur/HOCfkUM3yIoF8zE52+sCeo0msf60pWxMEvCxT6JgtQ7TaezK
        /tYs0bwJ6Drz2DpWofiLfMhcM+4bLAs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-WQIzpuYHPtKcsVomKskp-w-1; Thu, 29 Apr 2021 13:36:47 -0400
X-MC-Unique: WQIzpuYHPtKcsVomKskp-w-1
Received: by mail-qk1-f198.google.com with SMTP id c4-20020a3781040000b02902e46e29acf5so11539031qkd.22
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4rNwoUrsBxVZzoadAn6uvb1lrOSv00d53aEi1UZj3U=;
        b=oEtjvcvcRwEmsip6n7yxGHZ5abHf5BNZx9WWy3wHjDIY6n57hW19YsLy0+B8+o76XK
         N7bzBEblQ/jlkneXrPXlNDkVL6+EQoe+QxpFCFrMhN4v8k0TWTC+cdDU5sYIiQJBOQQA
         wor5mbFa/+2+BdByQWBh/f3J/3DiwHSJxc+2v9jlG7+eRDMTnSPuMZl845M7nIVY8Aat
         /aryCXYX7hluhrP/N2dodeVpN9nnbuwuBTAjxHPcXdUInibPQVStmZh7+Uif3c1MNUV1
         4n/XCtzgmpqUSQh4Sk2ALaOGs9MBdZ2GVLVixZRCM5pU3bIMYqv1YbzZn46Nw5iMVUJD
         k5sA==
X-Gm-Message-State: AOAM532dGCOw9blnitB7W5ikrC09WqrqhDaUqb9GEUBXAcXs3kPE9xKY
        fbMNaZ2ISRyz06IZo0QKLjJOlxmTvptbfJMlEAPz46BX5pYjXc7OzvoDZDnsgcBs3cDSaN/FwJa
        vK2GOu4Fc3e0b78DHPiibF9In
X-Received: by 2002:ad4:55ab:: with SMTP id f11mr621354qvx.49.1619717806933;
        Thu, 29 Apr 2021 10:36:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxm+KAbmVoVRhpdIdwacN/+bTi3+qtiMBy4JkP5iV66UBMlTFgUYy5K73549+vcQxt8ZOEYFg==
X-Received: by 2002:ad4:55ab:: with SMTP id f11mr621331qvx.49.1619717806749;
        Thu, 29 Apr 2021 10:36:46 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 144sm2725453qkn.108.2021.04.29.10.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 10:36:46 -0700 (PDT)
From:   trix@redhat.com
To:     srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: codecs: lpass-wsa-macro: make sure array index is set
Date:   Thu, 29 Apr 2021 10:36:42 -0700
Message-Id: <20210429173642.3230615-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem

lpass-wsa-macro.c:1732:6: warning: Array subscript is undefined
        if (wsa->ec_hq[ec_tx]) {
            ^~~~~~~~~~~~~~~~~

The happens because 'ec_tx' is never initialized and there is
no default in the switch statement that sets ec_tx.  Because there
are only two cases for the switch, convert it to an if-else.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/lpass-wsa-macro.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 1a7fa5492f28..c11ae72f2148 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1718,15 +1718,13 @@ static int wsa_macro_enable_echo(struct snd_soc_dapm_widget *w,
 
 	val = snd_soc_component_read(component, CDC_WSA_RX_INP_MUX_RX_MIX_CFG0);
 
-	switch (w->shift) {
-	case WSA_MACRO_EC0_MUX:
+	if (w->shift == WSA_MACRO_EC0_MUX) {
 		val = val & CDC_WSA_RX_MIX_TX0_SEL_MASK;
 		ec_tx = val - 1;
-		break;
-	case WSA_MACRO_EC1_MUX:
+	} else {
+		/* WSA_MACRO_EC1_MUX */
 		val = val & CDC_WSA_RX_MIX_TX1_SEL_MASK;
 		ec_tx = (val >> CDC_WSA_RX_MIX_TX1_SEL_SHFT) - 1;
-		break;
 	}
 
 	if (wsa->ec_hq[ec_tx]) {
-- 
2.26.3

