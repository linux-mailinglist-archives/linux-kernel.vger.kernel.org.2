Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39E1354EE8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244509AbhDFIps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244477AbhDFIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:45:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0EC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 01:45:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b4so21462282lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eG9N6vd8YdDNhKc5wiTz2FLA+NZ0laeofe06nyKfMT4=;
        b=P1ZUq+7rme2Dwp/A+Ir77qzfzAFu6XaEThogNqcuRwmo4v29fGtj2qeWUd77BSSncO
         6QMLaOcuw71L2VmIpzIG7JM9TcNQYHNZ6wdvR7KYWpOs4LEBsSyRDnr+4dqsUdc3FVpH
         9sSZsBUzRl0y3HVvpZFaWei/ubPo2d6Y4R8+CmeAYBXu8ZPY6Jdk4UbrbvgpAgIXByZ4
         exFDLwHaTsQhNT8fFcyE7ZZ5FFrmA+Z7Pdak+6BOX7PCAs0boKFFUGeQP7RUYvZLXCy8
         TCrqV/zaobEwEAbuGBRIjfGAYiwuWhafb8zu10mr+kDiT8hPxejTy+BlhETQvCXDyW3R
         pszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eG9N6vd8YdDNhKc5wiTz2FLA+NZ0laeofe06nyKfMT4=;
        b=bnsCsObvXnWXb+21UpCKRlRxOGXU5vwuhO5PF0Kd+Dt8KDmLVTxTOhuZQWFWhlAM3G
         5UWomm5fqPjiRp80cf05NLcZT2OYA2piGVvMCbWGW8Haedtq9YdgqYL7qlo1t7oS/l08
         c6M0TnwUwJ8ShMu6WQQFsQODjt2evJFPl6OKLlGIpAN0ve2TgC7PQDbiMULcZZS3O4SO
         ZlT0GZqpKS5By0mEYKdRetl7JRLl2q3o31AgXs+AgRkQF4pEoz3S0BnB15v4Duy/HTKE
         AOgJKtlRcMlX/s+Kt2bL/PoYPP5u4zilx7wumLIiXClznm08pZep6DyEqufltVXd7b3F
         YBQA==
X-Gm-Message-State: AOAM533N/GPy3aCRXFJhNJdKZnckIuOgqfysTFwGJ4tvlnjbNJWBe3n4
        8GjH4yzjRtf9zpL+PXQSIyQ=
X-Google-Smtp-Source: ABdhPJz7zUiBmLNg1xgUhC/FHiwLXiSQ0OE/giPOx6cvPbNqWnCDWFJzgSae+oG//39CIvwiOKyIeQ==
X-Received: by 2002:a19:ae07:: with SMTP id f7mr20754373lfc.551.1617698728861;
        Tue, 06 Apr 2021 01:45:28 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id p25sm2081605ljn.61.2021.04.06.01.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 01:45:28 -0700 (PDT)
Date:   Tue, 6 Apr 2021 14:45:27 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 4/4] staging: rtl8712: Remove spaces after a cast
Message-ID: <f8932bfa35eb7480b69a9c8296bb10fac5a28540.1617697237.git.zhansayabagdaulet@gmail.com>
References: <cover.1617697237.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617697237.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra spaces after a cast to conform with Linux kernel coding
style. 
Reported by checkpatch.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_security.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
index 5000c87752d3..b0cc3c922842 100644
--- a/drivers/staging/rtl8712/rtl871x_security.c
+++ b/drivers/staging/rtl8712/rtl871x_security.c
@@ -259,7 +259,7 @@ static void secmicputuint32(u8 *p, u32 val)
 	long i;
 
 	for (i = 0; i < 4; i++) {
-		*p++ = (u8) (val & 0xff);
+		*p++ = (u8)(val & 0xff);
 		val >>= 8;
 	}
 }
@@ -907,8 +907,8 @@ static void construct_mic_iv(u8 *mic_iv, sint qc_exists, sint a4_exists,
 		mic_iv[i] = mpdu[i + 8];
 	for (i = 8; i < 14; i++)
 		mic_iv[i] = pn_vector[13 - i]; /* mic_iv[8:13] = PN[5:0] */
-	mic_iv[14] = (unsigned char) (payload_length / 256);
-	mic_iv[15] = (unsigned char) (payload_length % 256);
+	mic_iv[14] = (unsigned char)(payload_length / 256);
+	mic_iv[15] = (unsigned char)(payload_length % 256);
 }
 
 /************************************************/
@@ -995,8 +995,8 @@ static void construct_ctr_preload(u8 *ctr_preload,
 		ctr_preload[i] = mpdu[i + 8];
 	for (i = 8; i < 14; i++)
 		ctr_preload[i] = pn_vector[13 - i];
-	ctr_preload[14] = (unsigned char) (c / 256); /* Ctr */
-	ctr_preload[15] = (unsigned char) (c % 256);
+	ctr_preload[14] = (unsigned char)(c / 256); /* Ctr */
+	ctr_preload[15] = (unsigned char)(c % 256);
 }
 
 /************************************/
-- 
2.25.1

