Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA953576C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhDGV07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhDGV05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:26:57 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0B3C061761
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 14:26:47 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id n44so4794728qvg.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rBvCDlUD9+QrMvuUFtxmfpbAHHnvTaccTwMtx3DApDw=;
        b=WVAjnkAMIwoB4WirZGCF1M7bthlOa3ydPDmNIc3WNS1wBdMGTMVfDjUXkZ4Azr6JqG
         gOieQN6tx4oV2FV00xBUPG8V0oAe0eK1IfFqnm8GCupPFgKDZDW8BYgVuLwaCYI1g4x6
         fn7Tb3+UTu0w6tS41BGZeXpNawER8oCSSQReqwMHCHUeVhyYVMBIvbFmH0ZTBWneSvG5
         ojF3cJJTUWpJs8B/cUvmx2QoxKoo3UsQYEJVpQtTuyjBunc6oyCzUtWcmDaURs66Vtwr
         nj+44Ki3fbDNF1jPVFaKmoWQLXlqs/oWoVlJhsWM9QnT8CxlgWpz1Vs4DebqfsIMA3td
         7QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rBvCDlUD9+QrMvuUFtxmfpbAHHnvTaccTwMtx3DApDw=;
        b=PbzeqFo9LiMdKtFSEhjDOmGRbNnj1WfYzOSLjQ8Vid8KLTc1lm8yfg8jESQIFgFo2Y
         XlMKCvn4bMFVeIWgxC5fgbKWMlnCTrtSIiy8QNzxr90hEtoXqHpvBa3MsNsfYBrctJ+4
         txU7r0ZLz8DMKRzwuf8983GSx2iT/CWoUsHxhAm5BmjgSDhoYykVwaanJxlGGI5Zats+
         ChiStSkbXv4r5FIv6++nRMuqMgNN+yqajkIAEJ6JzeNN6tAEu/LGZcXn8ReR6DHtD5rG
         5RVKDYjR6EZm8pUN/ZAhLVfnEr6RG3iBXEfIUsXPde+7xxsgo0t84PhQwVJ1XN/wSaUQ
         UxFA==
X-Gm-Message-State: AOAM531q9OO8WLRo0fmXEIJtC4B8BIVr/+tlKIc4WySGn+frdkKiAVIz
        R1+R9IZgymic1w83D/KJcebwAONimotWTPUr
X-Google-Smtp-Source: ABdhPJzNK0ZUqEDhtia0GmD272YxNh/iEDFHwbAH13Xh8pCP8Xu5CNPceZsnrCN4k44Y/GPuemvP7g==
X-Received: by 2002:ad4:5ec9:: with SMTP id jm9mr5468217qvb.24.1617830807202;
        Wed, 07 Apr 2021 14:26:47 -0700 (PDT)
Received: from focaruja ([2001:1284:f013:b099:91d8:678f:6a0a:466d])
        by smtp.gmail.com with ESMTPSA id r17sm17023418qtx.62.2021.04.07.14.26.46
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 07 Apr 2021 14:26:46 -0700 (PDT)
Date:   Wed, 7 Apr 2021 18:26:44 -0300
From:   Aline Santana Cordeiro <alinesantanacordeiro@gmail.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, alinesantanacordeiro@gmail.com
Subject: [PATCH 1/2] staging: media: hantro: Align line break to the open
 parenthesis
Message-ID: <1e6d73432d60dfb8bb3f7f2bd6bf3084091a2a39.1617829497.git.alinesantanacordeiro@gmail.com>
References: <cover.1617829497.git.alinesantanacordeiro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617829497.git.alinesantanacordeiro@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aligns line break with the remaining function arguments
to the open parenthesis. Issue found by checkpatch.

Signed-off-by: Aline Santana Cordeiro <alinesantanacordeiro@gmail.com>
---
 drivers/staging/media/hantro/hantro_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index 34c9e46..a650b9c 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -207,7 +207,7 @@ hantro_h264_mv_size(unsigned int width, unsigned int height)
 void hantro_g1_mpeg2_dec_run(struct hantro_ctx *ctx);
 void rk3399_vpu_mpeg2_dec_run(struct hantro_ctx *ctx);
 void hantro_mpeg2_dec_copy_qtable(u8 *qtable,
-	const struct v4l2_ctrl_mpeg2_quantization *ctrl);
+				  const struct v4l2_ctrl_mpeg2_quantization *ctrl);
 int hantro_mpeg2_dec_init(struct hantro_ctx *ctx);
 void hantro_mpeg2_dec_exit(struct hantro_ctx *ctx);
 
-- 
2.7.4

