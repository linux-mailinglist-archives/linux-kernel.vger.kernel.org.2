Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF77244675F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhKEQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhKEQ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:56:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080E5C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:54:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q126so4921839pgq.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ALMmQlZo8+KWhNKSuIRIbhgj4mQ52Qs0A0EZkuhtla0=;
        b=L7NRUL9Wt8voFjQzLH9tlmbo7jzZgl82GnKlPgD/C8uP543v8mkPcLXjhtld2jKNAs
         8e1KUVs+SDRixGZoPV+S1Bx8FK06oBBviOAv/JlmMiVcG2uzScAXtGBHpBonj+HzZ9CY
         kstdKd3QyG6HzZ5R4PzWJwTrDLciM4PvHKeoI6xXesomwE4dthZ63sIQFYFRy3ErvDaK
         l9sk6Vr4XM7mJrssO9Ip0rInOqDNKhgw/cE1WHHDWW9dG/LC7KK9i+gtvDuU+rwxE9lJ
         64YYXrD7SqXCi1vjrkWfvpkakYYsnWCy2YM7XLbwQruMEO7AfvQl3392xjRrnpnyppMl
         mMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALMmQlZo8+KWhNKSuIRIbhgj4mQ52Qs0A0EZkuhtla0=;
        b=rph08Kslf2LJGiTN+nXsItX4EtnhbE5gjMPb5iVhSE5w70HZGkA3tHYHfHXlE84AlJ
         eHBhsrEAibnASJpdcKWTUOZTePrWj2xWSI/5QjB1UGnSwg6zM4QAX2nrzpQwZXxPP/uf
         YUiKIfe5umqKUvJr97HxbUY/6n6PLdfudLBAdK5EZPcQGbFkQih5jzOYmKb6RhAzRXh+
         yTeIH6AtEDAtd/O/eCPNi2HrjZAD+eJ2f9LTr+JwSwJfUYi371S6pSzcSDalHDsPe64C
         mZOqUFwmb4X9L2vIfP2EBtzMm0E8mmRgALmNWKXcZdoT3cvDXEplf84IGTqDEGVbCgyM
         Lcyw==
X-Gm-Message-State: AOAM532O2UTveHETe8IfAegd7hPv90Ah/A0n+Nhw8v2phtwTpkeFIwIo
        +NUyiZrlDCLhxAqXFNxxff4knHBcAso=
X-Google-Smtp-Source: ABdhPJx3xbEG22VrZb+VCW2Mu+XGX6Iwdvy7Ak+su3+8QezkaV/1tT1ZT609I4QTO6lvbOPkEj7V4w==
X-Received: by 2002:a63:3d4c:: with SMTP id k73mr45028603pga.44.1636131241496;
        Fri, 05 Nov 2021 09:54:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:4490:4409:3406:a18f:7c45:2f81:cea2])
        by smtp.gmail.com with ESMTPSA id s30sm8524425pfg.17.2021.11.05.09.53.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Nov 2021 09:54:01 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        saurav.girepunje@gmail.com, dan.carpenter@oracle.com,
        shreyaskumar1035@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8723bs: core: remove unused local variable padapter
Date:   Fri,  5 Nov 2021 22:23:30 +0530
Message-Id: <20211105165330.78524-3-saurav.girepunje@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105165330.78524-1-saurav.girepunje@gmail.com>
References: <saurav.girepunje@gmail.com>
 <20211105165330.78524-1-saurav.girepunje@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused variable padapter from Efuse_Write1ByteToFakeContent
This variable is not used in the function.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index bd057e041a08..3d3c77273026 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -43,10 +43,7 @@ Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
 }
 
 static bool
-Efuse_Write1ByteToFakeContent(
-	struct adapter *padapter,
-	u16 	Offset,
-	u8 Value)
+Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)
 {
 	if (Offset >= EFUSE_MAX_HW_SIZE)
 		return false;
@@ -288,7 +285,7 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 	u32 efuseValue = 0;
 
 	if (bPseudoTest)
-		return Efuse_Write1ByteToFakeContent(padapter, addr, data);
+		return Efuse_Write1ByteToFakeContent(addr, data);
 
 
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
-- 
2.33.0

