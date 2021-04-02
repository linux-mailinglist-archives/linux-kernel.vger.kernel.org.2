Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD91D352E62
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhDBRb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbhDBRaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205A6C06178C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so2675112wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ySfXnIkKD8gvPDA0SbkHqU7mZfNhHmlaXFfQGBVJ8E=;
        b=QK0Slj3XAn445fWELayZRlHLvJqu5hVgK1SAhWwG/VNzS0ZL+TegJS9g2EZp4iH6Go
         BWVpluj4Qf85amBhTOaYId4JqKqkR66wO+z/8C30U31wdseFp8y7HAEPwZ78NzIM6lWd
         S9xFUS9CuAR5rpkFNYtOtJCThUGn9yyqzJDK6cvbCDP9Bl5nXFqXOExKYbtK/jyQCsXH
         oHjfLTKxHuEjwkz7yQMHHKxXbH6kL2McXac/EU302Zjm61ILW3oeN6KWdkZ4L7uwHpVz
         h8yX43CIRRzaG/zWR/24L1p6l4P2APrZBsRelDiCWbSOWWHrOxMpxC3/HK1Q6YIMWKqf
         PyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ySfXnIkKD8gvPDA0SbkHqU7mZfNhHmlaXFfQGBVJ8E=;
        b=OAZhNcC6leppw8P2JWrYpJNrdxW2W4PxqrbEwJCmV+jOrthuzN5szu2+Bm8cUHOOVR
         kiX0zXCs/QhYGasdio3XASeREB8tdnxStggqNtYgKbwqKzU3YS10oNZQbjRwhE6tAxya
         +Yf39hRxRMBESGHrNTHP3ifZ3YHSN3badKYg839LmG3sMNrnfLl9dE02LcXX7KmO0Uzm
         Ml7HJZQ1gTkyZ3yh0+LCz0R3YYZEjVH3O15Sh8jxtBg8MBQFvuvAKvSagLmHRrxlXrKM
         7iXaVZ/2feQm/gh37F9px+hPXM+1em1cWhiFSUzEEhrJ7ct7s6BXwh9hbwuf1G5kucHZ
         0iwA==
X-Gm-Message-State: AOAM53191HVmX8JKD8xuloM+bb3j5YitMuEPWKYeMoosDem7nuxTSbBW
        7PWmX7d590YlGTbb0xpeXp0=
X-Google-Smtp-Source: ABdhPJz8DYYs4ecjV8Qt8/lxolNA5DoEmsOolEMORDuzAUxIkvO93E0LOXHuxPJ9J7MBdgZFtzYNVA==
X-Received: by 2002:a05:600c:201:: with SMTP id 1mr13455631wmi.167.1617384649861;
        Fri, 02 Apr 2021 10:30:49 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id u2sm17002674wmm.5.2021.04.02.10.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:49 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 20/30] staging: rtl8723bs: added spaces around operator
Date:   Fri,  2 Apr 2021 19:30:02 +0200
Message-Id: <c472f6ab91c06b5b2a7b65e54ca0a5640ccd7676.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook issue:

CHECK: spaces preferred around that '+' (ctx:VxV)
60: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:359:
+				if (miccode[i] != *(pframemic+i))
 				                             ^

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 2d749341d47b..953351f896c3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -356,7 +356,7 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 			bmic_err = false;
 
 			for (i = 0; i < 8; i++) {
-				if (miccode[i] != *(pframemic+i))
+				if (miccode[i] != *(pframemic + i))
 					bmic_err = true;
 			}
 
-- 
2.20.1

