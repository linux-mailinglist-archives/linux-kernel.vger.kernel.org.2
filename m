Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB23FB587
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhH3MFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbhH3MFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:05:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D07C0617A8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z4so22066562wrr.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUNc+8qOd4ajvWM/OEIrPhkDwrj3YE9cjHuomOPXBzI=;
        b=Jl1FQY+A47xSiHaj7G3xaSJL18aYVCQ92/5uE8Q3JRT2BdzAhwdzORcJ42RBCJjwzl
         EZoN2cX7lgyhJXpS5ehXr1LjQywcApnRj9TJeb96DIyB2bcui6kjPG4BnVeM+c4PwNuh
         wH7CbkQ7S42GthuJjDYu63zmuZHEOdA2Vj8ZLFVWTVmuvz9baaO3dyhCiOKolHm37HQ3
         5ApNaT9XCrwZh92ibWawVAoykS06RdxNbaQZDiW1YCvuDd+i/zT7l5QzEw9WSYzPy4t7
         GA4MZ82uA1mJk8/Y+Z6fiaH5yGKNw0nfzPoO3JSe7nGBUmFLC1G3E72EVsmNnOaidMPS
         q18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUNc+8qOd4ajvWM/OEIrPhkDwrj3YE9cjHuomOPXBzI=;
        b=gmCqX+NX92CVOUBezwaUHCOiMHo0xLj223jM1q3Zbkxkuj4Zv8LS28ld3Qhu1OFUnk
         p1T4jFlBweaOLbHEKKD2mERnvB2lZOGfau0uYwiYcG5fSfnBwNZkm/iOs7fi73bA3BL5
         kL5VgH/jo1Nd7EDkQaDQ4C5ppAcbU+A3Nc10CbzL/tI3FTYWj7q4uuxp5XCH1pW5sO+D
         W+oKQ/pdX1sPYepyGIXO3Rt0/ieZ/tdG1b3+uS9q9+XVWNGmzMPUE3AIPxc+TlWbce72
         A9bzVqGyFJr3Ezy8evCnSD4tfddWLLU7gOhNJbQOS2gIXjyYZoucfQQp08jn8ebFqnWU
         lRWQ==
X-Gm-Message-State: AOAM531Z6cDRQRYa5YlpiByFqbg4nYQxfREGmJkX5edMhjqjNU1qGk6i
        LvGvxoiJULaEOXFu2OKkEKo=
X-Google-Smtp-Source: ABdhPJzq99F73yML1/5yQEmXeGfvjZE072k3RGbgloIiWRNhpmlypnHbC58Dtg8hSoh8IS7zGd7o1A==
X-Received: by 2002:adf:dd4f:: with SMTP id u15mr25574914wrm.237.1630325080065;
        Mon, 30 Aug 2021 05:04:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id f18sm13184195wmc.6.2021.08.30.05.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:04:39 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: r8188eu: add missing blank line after declarations
Date:   Mon, 30 Aug 2021 14:04:19 +0200
Message-Id: <20210830120420.5287-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830120420.5287-1-straube.linux@gmail.com>
References: <20210830120420.5287-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing blank line after declarations in rtw_macaddr_cfg()
to clear a checkpatch warning.

WARNING: Missing a blank line after declarations

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index c37358be631f..f76c762ccd4b 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1021,6 +1021,7 @@ u8 key_2char2num(u8 hch, u8 lch)
 void rtw_macaddr_cfg(u8 *mac_addr)
 {
 	u8 mac[ETH_ALEN];
+
 	if (!mac_addr)
 		return;
 
-- 
2.33.0

