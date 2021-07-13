Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB693C7140
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhGMNfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbhGMNfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:35:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83DEC0613EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:32:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o5so41527919ejy.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AtdBxpTbfHI9zbIVsZ9n9GdLQqULdtTSE9Dda28OKGs=;
        b=arzhzSexletdezrIX00iuWr6PXJClFcKap26bWzVnlSQOe40YBLQ+Ssz06kLN81keY
         SzBy6GrM9I484ZCUT/RaDs/JKgEjCjqVddj2WSlUR6bAgNPMQIxA/ijqm05+wAyCskr2
         oDnNb2WqeTPBMEUJGHMkAukjp8LnJB2v+FK6FkLoVPY1NbvJ3UmNzJiW9w0Sn4DZ4BwW
         s40mMKANdb1ifp+jqTKko1fHxb3/O84blBxJRC06alA7IBVyHr1NQ03PFUCtegIBpE7T
         ntKeAxPAHTWiUOnm532AIFrbSQYkCla5mwQlLqAps0Cb13KmQ7LhibDVYMDkQvPDpFcD
         K/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AtdBxpTbfHI9zbIVsZ9n9GdLQqULdtTSE9Dda28OKGs=;
        b=r8lovhgtGOmq5cvF+qpcap86P9Dnz6OHZcd28rXP3Q0WJETf/bnqrVOU0d32hFOmoa
         RIqwyPmYja324R4C3QDuB/6LHVgkd14e2dLy9qebzSSeUj/UJGjLI9Gh9N5mEv4T9LTX
         8g9sZWkJd9/wKICpOfBOZfWXDd61CC8e/6w6PMzfHuR9en9T77XPZSlgmLg+Q+e0Nko1
         BNPooL2pomiRufXkQTPJnc5rUdNYvkbc3QDplJpHbe94v3GYt6oyRXI456wdw9fPUMjB
         RIplz0z3ecvW+G9IFNEsclgvu/5+zWW53aCsQTl2FmFPR1EFgeBhejIVjH7BdrQ3brrL
         FueA==
X-Gm-Message-State: AOAM532e7XQKdR86zSfD3ohsqbNmMdHBGiHerKzd2VKlYkReCFyif0K5
        AiGHYsp5ZsznG4TuArmgwi8=
X-Google-Smtp-Source: ABdhPJyQoK9u/72BsU0I0QMdIqlx68r8g6oAyZCK2X65NMlI3FjZ3gohRyrOA83oHhj6A11h+OJfuw==
X-Received: by 2002:a17:907:7608:: with SMTP id jx8mr5613677ejc.233.1626183175273;
        Tue, 13 Jul 2021 06:32:55 -0700 (PDT)
Received: from pc ([196.235.212.194])
        by smtp.gmail.com with ESMTPSA id gg26sm7500555ejb.103.2021.07.13.06.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 06:32:54 -0700 (PDT)
Date:   Tue, 13 Jul 2021 14:32:52 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     p.zabel@pengutronix.de, alexdeucher@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: ipu-v3: use swap()
Message-ID: <20210713133230.GA1872993@pc>
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

