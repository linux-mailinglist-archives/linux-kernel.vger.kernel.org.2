Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB23834B7A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhC0OZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhC0OZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:25:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136ADC0613B2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j9so6653931wrx.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CHdWroy7tRGJ6z2hFf3CkopkW65s4qPmFApR2G2IO2Y=;
        b=LLL3Hbo2zjnWmH49k8/AER8msWRJP98NPintOVkGdJEECJEj4VhI54ZjgZTz9QyV4m
         kD2054V8zGkFB3sUiywySXOvPCsd1xbKSdaxay8ll9pacgSO0cAMNh6zC2XIDjT43v7p
         WwBMNm+Cm3hMVsj5o6AGzCiDYoEI1tArBVovGLaY8HVOTicBfczLq6UYTPXcOCB6ZVNC
         /pOgvPB66s8kalk72yC+R+qtMOba6B0kotX6d7ix14foroLExlUsw/0ZKp52YhSJErau
         0WnnqvChHJmWoUhf9cim9kXvDQuiIdYDILQtbfxVpRpYS674T/AAHtzihtREb0o4VRTM
         2FwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHdWroy7tRGJ6z2hFf3CkopkW65s4qPmFApR2G2IO2Y=;
        b=hK2tsEjmOsRQ6hEP37zUshtneq0v3Az/xNHma963e/+oGgq1FXh55LKNcKNvmwP4Gd
         ouGVjSgbSYoCZb57N+g+qhcFYmjcD8kolOdvmWczhOB2sbjKu1ONoI62Cx/g9BrUmpo+
         uGpcFkYy+pz+W8cDhAaEsOWPVT94rwJifGgP3IQRgaECx4KkSxkFHWKlQVzll+sgs/l/
         8ebkVXY3k27qtb7sT16dNeHpjORD+DBcBH1TFMG0CBzGkDB5sF8XAA8BG4tADeCHj1Se
         8yuZdEDMSXxYolkO+zpFpC87AemWT5UNy9Fk2bLlCxMm7c2x4j8rB86GICe/HQ5yGCiP
         B55w==
X-Gm-Message-State: AOAM532LpeyIyFt/wTAAPv8PRHTx8ImdxLX/nQNdFhvTbvzk3OoR4WvE
        AhXlBTeDDOR3Hup53R+TWDs=
X-Google-Smtp-Source: ABdhPJxSKRsekNxzCtBSWPzOCPqDzij5Dc+Z7Y9AG0dk3N/etZRq/vrmmIyq3BEaZJaV1CU4Bg5Llg==
X-Received: by 2002:a5d:5487:: with SMTP id h7mr20022211wrv.348.1616855122875;
        Sat, 27 Mar 2021 07:25:22 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id c9sm17634028wml.42.2021.03.27.07.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:25:22 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 19/20] staging: rtl8723bs: include macro in a do - while loop in core/rtw_security.c
Date:   Sat, 27 Mar 2021 15:24:18 +0100
Message-Id: <0f176b08b7a49d6649ff9d5468bd912e58c1db06.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: Macros with multiple statements should be enclosed
in a do - while loop
2014: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:2014:
+#define ROUND(i, d, s) \

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 0ddd7667a986..8a447e149438 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -2012,10 +2012,12 @@ static void rijndaelEncrypt(u32 rk[/*44*/], u8 pt[16], u8 ct[16])
 	s3 = GETU32(pt + 12) ^ rk[3];
 
 #define ROUND(i, d, s) \
-d##0 = TE0(s##0) ^ TE1(s##1) ^ TE2(s##2) ^ TE3(s##3) ^ rk[4 * i]; \
-d##1 = TE0(s##1) ^ TE1(s##2) ^ TE2(s##3) ^ TE3(s##0) ^ rk[4 * i + 1]; \
-d##2 = TE0(s##2) ^ TE1(s##3) ^ TE2(s##0) ^ TE3(s##1) ^ rk[4 * i + 2]; \
-d##3 = TE0(s##3) ^ TE1(s##0) ^ TE2(s##1) ^ TE3(s##2) ^ rk[4 * i + 3]
+	do { \
+		d##0 = TE0(s##0) ^ TE1(s##1) ^ TE2(s##2) ^ TE3(s##3) ^ rk[4 * i]; \
+		d##1 = TE0(s##1) ^ TE1(s##2) ^ TE2(s##3) ^ TE3(s##0) ^ rk[4 * i + 1]; \
+		d##2 = TE0(s##2) ^ TE1(s##3) ^ TE2(s##0) ^ TE3(s##1) ^ rk[4 * i + 2]; \
+		d##3 = TE0(s##3) ^ TE1(s##0) ^ TE2(s##1) ^ TE3(s##2) ^ rk[4 * i + 3]; \
+	} while (0)
 
 	/* Nr - 1 full rounds: */
 	r = Nr >> 1;
-- 
2.20.1

