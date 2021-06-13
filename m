Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4543A584C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 14:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhFMMbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 08:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhFMMbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 08:31:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 05:29:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k22-20020a17090aef16b0290163512accedso9192932pjz.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 05:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVyb5GJd1/eOOTzVnEFYfGEHURKljx+p9YMnSFodCUw=;
        b=OXW0VIQrWkWFSxR1BBI+69VwFZ3jzmEoUd4MBJ2+0cGcsznqOhekZfbDPVKUcO8pm5
         F3wMyfCHDQkY62k3vmHGDB23xeo0epPsaUwPs6FkhZq/r/6ELe5R5uTonKVjXFoWeBsH
         Oq+p9q1dRGv+TMXTX4yV6o5uzDHPTKsK8OdPDqGHZYr9V9u7wXL7kSN3tuiWxI9bFwgY
         nQPuYp+ylGg0Da/J7u0xDKlg3dsHKLFBWDJGycbVA/RTQ1/aWcrari3dv7ifFnzsRkKB
         Gtlyn7aK4tWSTkF6uMAlYhesBtnHuxKyYVBynuLOn0bPLU95R4hwPLnCrWzLZzC+Z/3n
         cSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVyb5GJd1/eOOTzVnEFYfGEHURKljx+p9YMnSFodCUw=;
        b=SKXwAJtB8f2BqHth/wlFLbFZjBFSY2EGG60YVsND0PGQa2JCZLdsapTtmtvrOJH4xj
         O25x8YTs1R1QHHWo8VVzoLH0OlB2msEwj5hmv9G5U3hrpuZMBumKnibMUUf17xryPGrJ
         oR2s02lYRsSOPpJdftZi+uZpbL1VfAO1jFi+3OTGAlRna0Vad94jbmGJpGQwkHzvDOLE
         nvpUE/UJ09NwLKN50gT2lmU80coFppPt60o+PL713QEc73BXFrNqeovTKe+qZUxqBNbn
         nVnWDnKa0CC0fBmTZ1dZU/QhVo/mGjMOnhBt6SBRJnSeN9SXFiQ+6LqGWihwusXHiOrG
         ETTA==
X-Gm-Message-State: AOAM530JVd0MUh2QZNwul9YS20OlY3zLPBShbWm20UjpdjQS1sXnWTic
        OKHuypmFl4XS58MNUJysWGlzAsvRc+Vgzo68
X-Google-Smtp-Source: ABdhPJwZ8craB1C/0/Er1m4RiA5TSl2CczVZdHmrN6wig7NEtvx/QMk5Cg2c+52kVvpUdVHhiXd82g==
X-Received: by 2002:a17:902:a70f:b029:ea:d4a8:6a84 with SMTP id w15-20020a170902a70fb02900ead4a86a84mr12431881plq.42.1623587345706;
        Sun, 13 Jun 2021 05:29:05 -0700 (PDT)
Received: from jm.lan (1-171-209-173.dynamic-ip.hinet.net. [1.171.209.173])
        by smtp.gmail.com with ESMTPSA id l12sm555022pff.105.2021.06.13.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 05:29:05 -0700 (PDT)
From:   Jhih-Ming Huang <fbihjmeric@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Jhih-Ming Huang <fbihjmeric@gmail.com>
Subject: [PATCH v2] rtw_security: fix cast to restricted __le32
Date:   Sun, 13 Jun 2021 20:28:58 +0800
Message-Id: <20210613122858.1433252-1-fbihjmeric@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the sparse warning of fix cast to restricted __le32.

Last month, there was a change for replacing private CRC-32 routines with
in-kernel ones.
In that patch, we replaced getcrc32 with crc32_le in calling le32_to_cpu.
le32_to_cpu accepts __le32 type as arg, but crc32_le returns unsigned int.
That how it introduced the sparse warning.

This patch uses __force to fix the warning.

Signed-off-by: Jhih-Ming Huang <fbihjmeric@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a99f439328f1..2f4da67e31c6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -121,7 +121,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		arc4_crypt(ctx, payload, payload,  length);
 
 		/* calculate icv and compare the icv */
-		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+		*((u32 *)crc) = le32_to_cpu((__force __le32)~crc32_le(~0, payload, length - 4));
 
 	}
 }
@@ -618,7 +618,8 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			arc4_setkey(ctx, rc4key, 16);
 			arc4_crypt(ctx, payload, payload, length);
 
-			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+			*((u32 *)crc) = le32_to_cpu((__force __le32)~crc32_le(~0, payload,
+						length - 4));
 
 			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
 			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
-- 
2.25.1

