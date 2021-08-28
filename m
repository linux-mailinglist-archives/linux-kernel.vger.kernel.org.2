Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C993FA722
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 20:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhH1SSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 14:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhH1SSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 14:18:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DF2C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 11:17:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j2so6111290pll.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QK06svqw7DyH5jd4WQQegPSwOLABf8o6RovqCiYy1aI=;
        b=GdDcYUUFcu40LOvVrFSUSjOdct8TJvYCny7rpi0ZRkFSVfR/5k0QoFQ4ka2tosX2mD
         /LvxPxJFXR/6FBmbVowLEe3MoVk8rOA1LQwvPCZpBIUbfJwYBhBkDKdfNfuHMqrHwqv0
         zBjOfRpyG4pyyBLu8mukkVE2CPpPe6castqRRG9OXFo2srraiomilfK74Cb5C6+Njpvb
         ZtnBOWZz0eGTHk6NhfRRCPwE2zoGCkXdUYX50rOi3G7x+LMi9WPAUqmDZiCvrID3/iTS
         e2HhcO6A4dJiEdT1aIa7Qvdf/orpoBMCmS1iINujGR2p2pAK48gN5GVZfZgHX/dxxL65
         PpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QK06svqw7DyH5jd4WQQegPSwOLABf8o6RovqCiYy1aI=;
        b=jSEDegtCXXi4YI+3tbKZfKidNWBJOG3tgRY0yFCZ6cxb6/tsD9kC9KL/lhQrNKtexe
         vka9RFLJ7Qsw0+eivFfGOG53fr/KR5algMI9KR7DMRnDdSJFxHys8D/Jnra5IJ1wXYex
         P7gmlRI5Cak47CuhiLw8U/iS9pTxRO2FCLpEr0vp/jAQ9mvwUFV4Us6FJR2Q3AAKzyLd
         pYwGuLMPFn0N8fwP+b6WNsL6NyeAMLo7MjRw/j9kx4je2QyiYW3d/iwK+xgglf0M0Z3S
         EVrlgkMISxfYQRZgs+t9DSF4lLkNQOUyDGw4Bp0D/634zPqnX0/EZOP0uBFz1aZXYjUe
         z62w==
X-Gm-Message-State: AOAM532bQt+SW26f8HJLYON7azns5JXuGkvFzrsdadw+J6oxxgYPNgn5
        Ttn639HfU+29oodwfWF1MxvqoRjKijw=
X-Google-Smtp-Source: ABdhPJxHJ5qdD6EpLAmrE4/35glO1pjDTLOTtmU/bxNMDeSr70Q8AwlhYP5UzNNPEl/HCqOJQr959w==
X-Received: by 2002:a17:902:ed82:b029:ef:48c8:128e with SMTP id e2-20020a170902ed82b02900ef48c8128emr14366631plj.72.1630174677122;
        Sat, 28 Aug 2021 11:17:57 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id c16sm10196931pfb.196.2021.08.28.11.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 11:17:56 -0700 (PDT)
Date:   Sat, 28 Aug 2021 23:47:51 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: os_dep: use kmemdup instead of kzalloc and
 memcpy
Message-ID: <YSp9z2/JmvHGhW5m@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:WARNING opportunity for kmemdup in ioctl_linux.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 81d4255d1785..495fadd2b8c8 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -585,14 +585,12 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 	}

 	if (ielen) {
-		buf = kzalloc(ielen, GFP_KERNEL);
+		buf = kmemdup(pie, ielen, GFP_KERNEL);
 		if (!buf) {
 			ret =  -ENOMEM;
 			goto exit;
 		}

-		memcpy(buf, pie, ielen);
-
 		/* dump */
 		{
 			int i;
--
2.32.0

