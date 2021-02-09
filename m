Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFF93152EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhBIPiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbhBIPiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:38:07 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F5FC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:37:22 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k22so5572766pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 07:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QKpVLQm7ZgzFHub3c/NcdvxoQclO6JlmQvaCgvZwUso=;
        b=i2a1iFtyMtyF821MfTRZUkwrMjKRzRHxgbbddSQbrmgdl0umOE4/AZwIPLHQvVhIAP
         XZhwtbpaFbwChOo+FtSRRVDFQAMWn13PuGTpHiIjtSE9L9nH6pG8eJVDaBCkcybMcLlY
         4lao8MGkuJltTGb2BDzcKoVEf7OjOE3jEUOcACDQ5G6C2P6EP9VNCrK3zPboJ7oEyAmu
         Ih8dn/+Htd6g6WOwB/QJh3Tt0b6RydywOB4J1KD9UHyldXTsR12upcwdznl5gglK5I2f
         eBAYMT+7PT6VVAMxjaSy165fGAJZqRzd2YyMSZNCnho6mwuvZ36SMHn3bcOodJwJEpJG
         9euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QKpVLQm7ZgzFHub3c/NcdvxoQclO6JlmQvaCgvZwUso=;
        b=LznN71VtiArdoMiuAFLOqCo7td4SCjCeO39oxnYZjaUtj5SqnPkAsPruX1ay7L0Gh6
         QS8N1/jZghY+yuJInfsEBNTyCi9JN9pwSSEblanTb/w+xJFSiykv7TdpTh448b2UhEc5
         z2Yos6qaZmd9KgOxsRjtDnrtfE/VAybKQI9eDXLe3CfGN88AIYQJ4buWQrBu44PGwzbj
         TvrZ8ZDQHY1oQQa/eLu+E+Dwcicm/CXIdu34FUi0+Ai6Drj2EZxUJmfFTGcl+4RfrPAF
         VhyXiadKnpiB9JszFGVYgZSDD7yUybRZRqrdkQu9088m9arhUEwBTbtgMW1pH5m/TJLs
         Es9A==
X-Gm-Message-State: AOAM531DPVqRtsX8W94D39siEsPwoUzGdlZFf0B2L6c//uSsWUw8vI7L
        Dt+HEfHPzgcN/GX6ASgcOEM=
X-Google-Smtp-Source: ABdhPJyWxZWW4E9OVCxZns9sUsIjtc7KinBlV1hYdh+UexUhafMldAYJM/gcSdiQffMjCMRhrBgkdg==
X-Received: by 2002:a17:902:b189:b029:dc:4102:4edf with SMTP id s9-20020a170902b189b02900dc41024edfmr21137768plr.80.1612885041976;
        Tue, 09 Feb 2021 07:37:21 -0800 (PST)
Received: from xps.yggdrail ([49.205.78.218])
        by smtp.gmail.com with ESMTPSA id g9sm23369759pfr.94.2021.02.09.07.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 07:37:21 -0800 (PST)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Remove multiple blank lines
Date:   Tue,  9 Feb 2021 21:07:09 +0530
Message-Id: <20210209153709.128676-1-aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl CHECK:
CHECK: Please don't use multiple blank lines

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
This is my first patch.
Done as a part of the linux-kernel-mentees program and as the 10th task
on eudyptula to fix style checks.

 drivers/staging/rtl8712/rtl871x_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_debug.h b/drivers/staging/rtl8712/rtl871x_debug.h
index a427547c02ba..57f2a38cb71c 100644
--- a/drivers/staging/rtl8712/rtl871x_debug.h
+++ b/drivers/staging/rtl8712/rtl871x_debug.h
@@ -17,7 +17,6 @@
 #include "osdep_service.h"
 #include "drv_types.h"

-
 #define _drv_emerg_			1
 #define _drv_alert_			2
 #define _drv_crit_			3
@@ -28,7 +27,6 @@
 #define _drv_dump_			8
 #define	_drv_debug_			9

-
 #define _module_rtl871x_xmit_c_		BIT(0)
 #define _module_xmit_osdep_c_		BIT(1)
 #define _module_rtl871x_recv_c_		BIT(2)
--
2.30.0

