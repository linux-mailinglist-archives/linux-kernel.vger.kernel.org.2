Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF1E3C667F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 00:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhGLWre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 18:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGLWrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 18:47:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB675C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 15:44:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nd37so37708181ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AtdBxpTbfHI9zbIVsZ9n9GdLQqULdtTSE9Dda28OKGs=;
        b=S4e8xxvOeTsjJRWXeBOxg06Wptzfr/wUdvjfW7pBsIq5xVyAFR5M8UaWP88yJmYZO8
         6P6gjBJWSZqwh3ihQex5EFtiA7cvxakjMnlDcZ/fwD+5J0K1M3PbPd1Vs88IJ4aD0csF
         N1ofgEVv1h5kX2IILYCou7nuDQydxOxrlir97gvAUgVQ4PIQotmZHXFVpQryJ/KomHT2
         8+4GRk9UAZUZ1xNMqw5hVtoh83wBvU+WywzFN+s3eytUgnWbnvugjdj9256PdFw36MiA
         tk+eXQ/jPEVRKxRturtW228mSUXB0Shs4JWHtic/di9hHhKkS59yMUvFYrpJYXKwiAme
         /jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AtdBxpTbfHI9zbIVsZ9n9GdLQqULdtTSE9Dda28OKGs=;
        b=DuvmWBacm6ujOqhPumC8Wld6SOfyh+MWbJqfTGiwgt5bSThuAozsmjAamWfndPOkvv
         9Rss9CSH6UF+TF+O48xjywJ7vxFv15Rk01wan4P8aUW48yXNMroFbWSB7ypYC9HeR7cp
         pWOT0F7dqB6WvTwgd4vjpCT1Q08UE6arkZgs+28f6SDbZzCv3Sg6pDOQr4cyIHiqZ0ym
         qaNNoigMXYvGmk4+9EIhe/P2RL8Z1dzevY99HePiIiv2g/SeI7ZhCWUvWLUU9ufXN62L
         NZBWhPnTKWu6M1s1F+5TzEfCASXwzrkoYk9/vsxl5ePNFijfXvEY4WxZudHj6DdUwNPB
         CcsQ==
X-Gm-Message-State: AOAM533KNbHLPrsWnlZnq//sQp2LoWbaNyTY5ijihqrpzxyV19D/0NBa
        te7aDI1NL5bgQb328zW0tpA=
X-Google-Smtp-Source: ABdhPJzBjtupWYnBUEQgMeebH91Cg8fNa6fr/gkwR+g/XTsWEAOareUL1IS8eW+AxsSrrbCh0yrxVA==
X-Received: by 2002:a17:907:7d9f:: with SMTP id oz31mr300950ejc.366.1626129883434;
        Mon, 12 Jul 2021 15:44:43 -0700 (PDT)
Received: from pc ([196.235.212.194])
        by smtp.gmail.com with ESMTPSA id z6sm2181591ejo.77.2021.07.12.15.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 15:44:43 -0700 (PDT)
Date:   Mon, 12 Jul 2021 23:44:40 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     p.zabel@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] use swap()
Message-ID: <20210712224440.GA1830070@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use swap() instead of implementing it since it makes code more clean.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index aa1d4b6d278f..5f730cd6009d 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -1021,11 +1021,8 @@ static int calc_tile_offsets_planar(struct ipu_image_convert_ctx *ctx,
 
 			u_off = y_size - y_off + uv_off;
 			v_off = (fmt->uv_packed) ? 0 : u_off + uv_size;
-			if (fmt->uv_swapped) {
-				tmp = u_off;
-				u_off = v_off;
-				v_off = tmp;
-			}
+			if (fmt->uv_swapped)
+				swap(u_off, v_off);
 
 			image->tile[tile].offset = y_off;
 			image->tile[tile].u_off = u_off;
-- 
2.25.1

