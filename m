Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5602336FCC5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhD3Oqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhD3Opr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18302C061354
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gx5so13548571ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuRDse6cwaQ2xwrTLwG7a4zXuTLnjB8VHStZClnoZTQ=;
        b=mME+Xrfui3GZIh+bM0vb/+gQZyqNAGHU1/KFcSjUW9jeHITPh7SNJYAmq+SU8zuhns
         S4FZz/u2Hue1VNp2eGLbVM8zBvyG0V/hQpXHNLsMMSN1DU4gkAmmAWHfRgBDK2zfXoOv
         PjoM7DFtRy1ri4DnDry8EKwx7/CeFzoLa10Nz36XghtnCU5oFiC/h61v+61gAgjN18JB
         iucU8hFQz3zSzPHgqkwlED6H+D812QnnNlakKF77YU+k5HRB50aDk+qSUHsmK+mUjgp1
         RWJiItUJPLZlMt1gILTccLB1wJ/ukIOtfoczVvWYMzPRtatjF5h10hn6GLUFGEK0HSz1
         EA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuRDse6cwaQ2xwrTLwG7a4zXuTLnjB8VHStZClnoZTQ=;
        b=d3XPgGrpcxKmCq7qsphRaIfxdFCGP0SjHQdq5LelRkhK5eNoDMjvKrGUATVHFIFwPf
         jDSlw2uDm8Y1NcJMEIrdZyf0uo1kY78uPpjj6nm+WG9RncdheXTcXD6kvMMsIMus0D0l
         gb8C7fKJSSyMxDyRQn1d5NCpjAHMp299j8wzN7Q+rLz0AiAw+xaFAmpQ7rLbl4vanuLe
         0sASLjpDydoacnp+BYSj7tLVTOWL9VOacZHJzg3eHrfOoNb3z/5K7IfRJPWapmXYDGLz
         3FWuRtH+gi3SGQ6L7fZCBFymmtW+7QWt2l6JxiHRdfmUxQrVaDPSUMVZHnkV/wwgVR5O
         xIOA==
X-Gm-Message-State: AOAM531n0M+loKRKzWlYhf+C31ut79Pf5JViY+/30r6Q5RKXa3TEiIRv
        PPL9kYHVbxejkG8L1ccbyNeACO4S2gk=
X-Google-Smtp-Source: ABdhPJxtRgU958n754ZFyahbXZclA/OXXAeKpvUhpXdYZvDbio/nawziJu0B8pjmgf9h/r+fnCVrSQ==
X-Received: by 2002:a17:906:14c1:: with SMTP id y1mr4877721ejc.481.1619793893594;
        Fri, 30 Apr 2021 07:44:53 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id c25sm1449679edt.43.2021.04.30.07.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/43] staging: rtl8723bs: remove BTC_PRINT_DATA definitions
Date:   Fri, 30 Apr 2021 16:43:56 +0200
Message-Id: <c1c611cc22fdc4bd1de6c8749a91ad77d125519e.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused BTC_PRINT_DATA definitions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index 00705305305b..36636ad62aac 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -114,25 +114,8 @@ extern u32 		GLBtcDbgType[];
 
 /*  The following is for dbgview print */
 #if DBG
-#define BTC_PRINT_DATA(dbgtype, dbgflag, _TitleString, _HexData, _HexDataLen)\
-{\
-	if (GLBtcDbgType[dbgtype] & dbgflag) {\
-		int __i;\
-		u8 *ptr = (u8 *)_HexData;\
-		DbgPrint(_TitleString);\
-		for (__i = 0; __i < (int)_HexDataLen; __i++) {\
-			DbgPrint("%02X%s", ptr[__i], (((__i + 1) % 4) == 0) ? "  " : " ");\
-			if (((__i + 1) % 16) == 0)\
-				DbgPrint("\n");\
-		} \
-		DbgPrint("\n");\
-	} \
-}
-
 #else
 #define BTC_PRINT_F(dbgtype, dbgflag, printstr)		 no_printk printstr
-#define BTC_PRINT_DATA(dbgtype, dbgflag, _TitleString, _HexData, _HexDataLen) \
-			no_printk("%s %p %zu", _TitleString, _HexData, _HexDataLen)
 #endif
 
 struct btc_board_info {
-- 
2.20.1

