Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224C03BB6EB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGEFgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhGEFgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:36:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4CC061762
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 22:34:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a2so17255586pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Wsby3LClrEo2/xvJaYmxPCAce43LH7aBkEp9Egxfy4=;
        b=ciOeWZgPMFrOVTP7nqd3vh4BK2H/kDoECH0M4NTEkvLjqklwcEvMZ6pOyuiZv+QQ6h
         lDrBMGCeKRXaGAWDSu0UEiP0bU0dHHUbj1LyFXD8974EHU34QZf923FQPLIIHzmY+Flg
         kSfePNmu2lWtckpm/B5Wfe4iQykGWcWzyPyRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Wsby3LClrEo2/xvJaYmxPCAce43LH7aBkEp9Egxfy4=;
        b=szw4YksbYgALuV35mrJL4exVj63sSrCQ7N481S5uVjib84x7tH7s/GfPU7PYzleisz
         26QlAavKQIB8ZCopAifWX6Q3zPrvPW0a59Z8CYSq2PB2aJog52ksVqL8sA6U0lxw+NaE
         dSVNmZDFpMoj3qfJSdkqAHLJCPB1QwDP2QW1TNUhOzp5xWtTQIh/YHFJ86Urwfm+ysCy
         gIzIgpMh1eLKdAObAFGJduX+JgziuobxY/bMZllcAe7qASt03t7dodcVHOmZf155su70
         W+wCRJIQowpvPYATDmysGkQrdbmId/Tjs1Z4liez/nVMG9E5K80BurwSpRrWzJ85m7DE
         mbRw==
X-Gm-Message-State: AOAM532x8kuag7gl8V4aNmw8BwG68V/YO056fAg61fTUac8z2f9+mpX/
        YawA5FQXXgXwK3pQ0ZNSBXYIhg==
X-Google-Smtp-Source: ABdhPJzP2yjoBz66yyuwQKfBYNR+vQPbMTqUfKLq82KBIzHKMAhnU++++X2fY97oynm7v9ff5u19nQ==
X-Received: by 2002:a63:fb11:: with SMTP id o17mr13787214pgh.177.1625463240848;
        Sun, 04 Jul 2021 22:34:00 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:3fed:7130:60f:265a])
        by smtp.gmail.com with ESMTPSA id x19sm6805245pfp.115.2021.07.04.22.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 22:34:00 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH v6 14/14] media: mtk-vcodec: enable MT8183 decoder
Date:   Mon,  5 Jul 2021 14:32:58 +0900
Message-Id: <20210705053258.1614177-15-acourbot@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210705053258.1614177-1-acourbot@chromium.org>
References: <20210705053258.1614177-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Dong <yunfei.dong@mediatek.com>

Now that all the supporting blocks are present, enable decoder for
MT8183.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
[acourbot: refactor, cleanup and split]
Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index c8a84fa11e4a..55ae198dbcf9 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -374,12 +374,17 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 }
 
 extern const struct mtk_vcodec_dec_pdata mtk_vdec_8173_pdata;
+extern const struct mtk_vcodec_dec_pdata mtk_vdec_8183_pdata;
 
 static const struct of_device_id mtk_vcodec_match[] = {
 	{
 		.compatible = "mediatek,mt8173-vcodec-dec",
 		.data = &mtk_vdec_8173_pdata,
 	},
+	{
+		.compatible = "mediatek,mt8183-vcodec-dec",
+		.data = &mtk_vdec_8183_pdata,
+	},
 	{},
 };
 
-- 
2.32.0.93.g670b81a890-goog

