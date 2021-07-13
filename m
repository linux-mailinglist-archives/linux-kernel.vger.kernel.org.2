Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492CE3C71D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 16:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbhGMOIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 10:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbhGMOIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 10:08:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7478C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 07:05:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id c17so41610439ejk.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XnJI6qXOw6HsabQFNSqtivtJDCKOD2fPbI9xhSpPX+g=;
        b=H6h7/rvaV6hTrQ+ZDaJd4fsM8GWCyrjOeUONSUYBl8ICPUJmsqsFhIHcRTDSycZxd6
         6xHrnZQAMWfMZ5zg0rd6GgAUSrW1qwWkULN4dqPh3VmbZxZP/OR+E8JEv1oe10uvJOJv
         caE9Lecyf8lvnyakapQYffih19U427ROUz5EgjO8m7mxtCbv83PXZPngCN0ZTCp25Sco
         OwHhWXyRcBMV+VKEqpVb4F4IaSCSO8dQKGw45pbvYfbMrQrzU9zjr1CXsRetHto3mneR
         Mc7m6fqc9TGeOfFK/5l6XVqXTl3OoH1gftZdZmVNfy/cdIiGIpx1+Zj3IuRnsuamPqhU
         n1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XnJI6qXOw6HsabQFNSqtivtJDCKOD2fPbI9xhSpPX+g=;
        b=gCAdmvFnJn+DBOPf6uufA0VkIzEb8wH7eC+cCGeUnibTtyPuZM9iI0XijL7dvoTM2e
         TSitQplOTwU82LD3JmoViSTm3J7mZlxq/uhfvR7rF9PAGR8zu8XbKMJlARBV8vIvX6WH
         fkTSqT9XOags49hUFX9ocDfpdEXjSTK1zy74wPrGiAMIM+vpU4i87owZ7BJsVrA2Xf8l
         XPm82s7M3HtRtKZ9KEDFxy+3uNRT6Xb7MrxLvQ8rFRu8AR7F3q8pMSZKP7IZWBWo49p+
         BJHInhkOLUivol4yYJJAqmmiEzV0119olK1AuEBR9IiaCwljgul+wISFsXX3v/mrMHHP
         OTAw==
X-Gm-Message-State: AOAM533/2LcOLJL0qIHQweZ3Ry7+mufz2d4zoTwEr+KziRHBgjov9tp3
        5qMdQbj31RyPcVNHZ1bF9kc=
X-Google-Smtp-Source: ABdhPJwrN7Uce6XZnD8SlIaRWhSyTHA/CD+x4umpJkAzbx3TT4cd6AiXIMtXKWWFzsKER+YalNa9Lg==
X-Received: by 2002:a17:906:4fce:: with SMTP id i14mr5964587ejw.231.1626185124024;
        Tue, 13 Jul 2021 07:05:24 -0700 (PDT)
Received: from pc ([196.235.212.194])
        by smtp.gmail.com with ESMTPSA id co21sm9866084edb.24.2021.07.13.07.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 07:05:23 -0700 (PDT)
Date:   Tue, 13 Jul 2021 15:05:21 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     p.zabel@pengutronix.de, festevam@gmail.com, alexdeucher@gmail.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] gpu: ipu-v3: use swap()
Message-ID: <20210713140521.GA1873885@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use swap() instead of implementing it since it makes code cleaner.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---

Changes since v1:
	- Remove the declaration of tmp
	- Fix typo in the description

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

