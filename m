Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F053357A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 04:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhDHCZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 22:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhDHCZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 22:25:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00166C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 19:25:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i4so325098pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 19:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=B3nkOxLt37ikjNh1dmCrH27OA3QKrjj/aIwluo8z8/M=;
        b=uRmM/eDkM6Mu88gsKVMeW6KK3rf9K4CU2TQnuBwcItC5Cp9qQ7+equPDnXIxXiLxc5
         x/b/9hGqVXVUxZ3WDd6MVWKgbvUn+9iX/Fb9pbu2zNDjz+wDQ71M8kJ2rphL6JPc6/HV
         9bdwrX1rDLw37WrJ+oDcqo2h8V1M3czpXQAqFumMf0GmVHXbANoN5KK6bDFm4NGj2huu
         31RYoSfoCjIV2TSUxRBx5o4PDNGV2i0Oq1DSfZ5mtL/dApxMJRP0KlsiqZdsquxzI5vW
         LD8GQovQWF88mo2lwUP3UUTYlOTFbBq+8gdRA6n0kmb1wMxQS7bdX0+m4zOEvXyuCdC4
         AIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=B3nkOxLt37ikjNh1dmCrH27OA3QKrjj/aIwluo8z8/M=;
        b=h3EAyPGmiwmhxqBuvXnoLihXX0MK56GEseXn9nfFCvVAz69V+M6v7KBcp0XJECdo4B
         3R3KRZFOcrxCJRSunUV/zWPGaMGppz6YqilmESu327J8oL7GkJ5pS3klQZ3u+U4bzPvf
         uU7gBOzJWdokfZpC+WR0olewJmGn/V098AJSuSEF7kHPpJsZj9RxccXiiM9uPG5DGRLP
         YcYgxcFVX0GxL0onjiYXSdHiTZ9if3E6bGoI0sKlw1mmwTMclcfLWhstaNRbYw3UhyrM
         VHBueBj2rr7EvNr1wODdMtpqv5Ux/sQRCR3YliKGLwvJMP21hgZQaZsM2MrAfB9hN6Lc
         f7zw==
X-Gm-Message-State: AOAM531TrpkLpDN7yEir4J5sM4WV60f3Noj575mM82ybOyyq/uzZ/X5C
        9/ZW2WMYLHWNxlZCl3EOnMffsWTd14gJI2AI
X-Google-Smtp-Source: ABdhPJxnf6JAZajUJLzftpFtX64NfI54a4Qom6zNJLrZ7QUbsxdUyEZ6oNDsHMeDcBkUZnz9ppjYQw==
X-Received: by 2002:a17:90a:1b05:: with SMTP id q5mr4951105pjq.104.1617848745303;
        Wed, 07 Apr 2021 19:25:45 -0700 (PDT)
Received: from kali ([152.57.40.190])
        by smtp.gmail.com with ESMTPSA id i7sm21876193pgq.16.2021.04.07.19.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 19:25:44 -0700 (PDT)
Date:   Thu, 8 Apr 2021 07:55:41 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: removed extra blank line
Message-ID: <YG5ppTlGhRp5WVgS@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed an extra blank line so that only one blank line is present in
between two functions which separates them out.
Reported by checkpatch

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_wmac_regdef.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_wmac_regdef.h b/drivers/staging/rtl8712/rtl8712_wmac_regdef.h
index 662383fe7a8d..dfe3e9fbed43 100644
--- a/drivers/staging/rtl8712/rtl8712_wmac_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_wmac_regdef.h
@@ -32,6 +32,5 @@
 #define AMPDU_MIN_SPACE			(RTL8712_WMAC_ + 0x37)
 #define	TXOP_STALL_CTRL			(RTL8712_WMAC_ + 0x38)
 
-
 #endif /*__RTL8712_WMAC_REGDEF_H__*/
 
-- 
2.30.2

