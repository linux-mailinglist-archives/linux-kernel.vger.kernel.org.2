Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D43D2B06
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhGVQkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhGVQkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:40:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A91C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:21:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a80-20020a1c98530000b0290245467f26a4so102743wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XiPHw5u5dlUXQvtcPtPmrVrUeEK7JBvZbFg3RjLxVe0=;
        b=k8adYkRqg+0Yq3FALuAPTAWEbM9vSz4+e7CarbPmwL1yyhJGq51cZ3TDvE/KeJv625
         vRdiuTvNUz1z0V63eKFM6GvXaKbqgxJu50/ENoSrI0PPmgb9hSGZqsAaqshJJWt9sNDq
         gpx8Czg+hBn0oM1+9G9C8mnZDKfnKsmyiKvVVF5GUESeyq4OPxNHjTr3YiFHfPAffWsN
         DSEJmdWJNUJn5AS8TGlcdRQzcJujc8dTTfIVMl7knMYsCKklTBffMKe8BJ3uLE4rWvdH
         64eB4mzs5ZJ+hMz2ipFiomIZcfRYlsEoiCDaHFlgQAfWUSF09xrMiypGWorc4mj/aMfK
         gBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XiPHw5u5dlUXQvtcPtPmrVrUeEK7JBvZbFg3RjLxVe0=;
        b=PTv8V32SMDKIvgInU0gUlqDjWsdbVGy6zTAEpI3nWBiuV4/TvvswNd2kT5HOCFqjGB
         IoAzEVKgsHHRiK1xppVMPt8Te8ATzSPofgDTn9Ga7uoKSBzM40WRS3DPFRCzo4JZXlOE
         BburEc91S+pn8zP2INOBilBVQjY/GZ5dNhhmVlc6KQ5dLEcfIokRyhsM6Zr+m0uAs9Pw
         mCgVrZik7uaCljuVnSTZuAt18ZHSkJ287wZ7YWw/gkGkkt7NlT22KdgyZY4IVlbi3+kt
         DzZati/TN72HI157IxhUAWg+R9UUayLI+LaflqOxRWJ8QiTqXQ/3SDesYaIaqNoaV+yY
         Ilfw==
X-Gm-Message-State: AOAM531kjFJ8y0NufVehX6JkQMOHlA2fElRLBI06oEhLkJLUhagWWYb8
        Dc42MZeDZ1sPkqd9VAR4FoOirpWW7Shgcw==
X-Google-Smtp-Source: ABdhPJxGDjTtVBS4MxpPGbs38jJgXZud7Y5wLWAUhuFTV9hppvYsbdtWn2t8FCI0kezAPH/6+Yhk9g==
X-Received: by 2002:a1c:2282:: with SMTP id i124mr632948wmi.166.1626974465657;
        Thu, 22 Jul 2021 10:21:05 -0700 (PDT)
Received: from pc ([196.235.233.206])
        by smtp.gmail.com with ESMTPSA id d29sm37221986wrb.63.2021.07.22.10.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 10:21:05 -0700 (PDT)
Date:   Thu, 22 Jul 2021 18:21:02 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     p.zabel@pengutronix.de, gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RESEND] gpu: ipu-v3: use swap()
Message-ID: <20210722172102.GA5144@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use swap() instead of implementing it since it makes code cleaner.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index aa1d4b6d278f..af1612044eef 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -990,7 +990,7 @@ static int calc_tile_offsets_planar(struct ipu_image_convert_ctx *ctx,
 	const struct ipu_image_pixfmt *fmt = image->fmt;
 	unsigned int row, col, tile = 0;
 	u32 H, top, y_stride, uv_stride;
-	u32 uv_row_off, uv_col_off, uv_off, u_off, v_off, tmp;
+	u32 uv_row_off, uv_col_off, uv_off, u_off, v_off;
 	u32 y_row_off, y_col_off, y_off;
 	u32 y_size, uv_size;
 
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

