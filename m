Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92303B241B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhFWXvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhFWXvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:51:39 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE48EC0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c138so9816832qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0AfTz6lhFALWAF95V8eX3JJFOOKj3+2vlJS3pE/R1ls=;
        b=cXHblTphWSG5QRPX4XbTDuvZM6SEBRTZK9kCHiqJAmNU7S2LU7EGON9S9SCkpySPV0
         gh2Hi14OyLl9PH2g9VMEM/RqGk7npgj42A4Y/sDWfw9wlyDvT31Del0zkCDdB6sBJmRO
         t11FmF5YdOMghIvgVjACB/7expbenjTYKtcCcSEOarx9vYWC88cClN4wFvBg3urqoSuA
         C8iTy+kW19OMcZK9264DTbBtDqd9A6snzG0tXxFJPMC7ckTZep+SLEkNKkf0rtpQL1lk
         fg/++qQcDtyevaDTBtPeMx/zytIbo8qGxsnvvuOV4Btv+E6QvHcqMtXLiCg3/SQ7Cm8l
         94zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AfTz6lhFALWAF95V8eX3JJFOOKj3+2vlJS3pE/R1ls=;
        b=iGyAvBS80X3/XJ8SGJW+xtNgkKJJwXQUB12YfOZrwttLlVVPCOR8WIFRQlm+e0iHKV
         GdNjT8j9/m0kfEFkJ4juF35o7z/rtpmHsboqLbHjS5BsUFHcdpsoKPa4dTeot86/kNza
         RQOtCuc+px9+E8mo95DF5BCM7dyMA884MOtgwFSxKoBzen6lX/c3TZ9IMpHk6lynkP+g
         8Ucx8n0Guc4amScVPRDAoHCIQNLz28seR4cjuCtW+Pyvfhm/KMK3y2f5r6OW3hJljaPu
         3jdrcQhvmLmh6y5eWcJPwSX9MzJ4ktpn/0hbXBn6wSqEI58JuUtCZ6tHiOecI7E9wECK
         wK2g==
X-Gm-Message-State: AOAM533ESL1yzdxwo/0RBHM335Jx/mADQGMBQrKZvU9EY8gk6IGmPvDn
        hSr1EfG8VhR6Zu74fsDLYUBlmQ==
X-Google-Smtp-Source: ABdhPJx9sKTslX/FV37xwlqSeS+PBabwSpntZu67Z4BX91AtQS5DZ61IeWIAowYM58VL1ZyKGM6CxA==
X-Received: by 2002:a05:620a:134e:: with SMTP id c14mr2733366qkl.301.1624492160049;
        Wed, 23 Jun 2021 16:49:20 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id w2sm992387qto.50.2021.06.23.16.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:49:19 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 9/9] staging: rtl8188eu: remove MSG_88E macro from include/rtw_debug.h
Date:   Thu, 24 Jun 2021 00:49:02 +0100
Message-Id: <20210623234902.7411-10-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623234902.7411-1-phil@philpotter.co.uk>
References: <20210623234902.7411-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove definition of MSG_88E macro from include/rtw_debug.h, as it
no longer has any callers and does not follow kernel coding conventions.
Removing this macro leaves only RT_TRACE and associated definitions.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/include/rtw_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_debug.h b/drivers/staging/rtl8188eu/include/rtw_debug.h
index ac123ddb8acb..72a18ec3ee32 100644
--- a/drivers/staging/rtl8188eu/include/rtw_debug.h
+++ b/drivers/staging/rtl8188eu/include/rtw_debug.h
@@ -58,12 +58,6 @@
 
 extern u32 GlobalDebugLevel;
 
-#define MSG_88E(...)							\
-	do {								\
-		if (_drv_err_ <= GlobalDebugLevel)			\
-			pr_info(DRIVER_PREFIX __VA_ARGS__);			\
-	} while (0)
-
 #define RT_TRACE(_comp, _level, fmt)					\
 	do {								\
 		if (_level <= GlobalDebugLevel) {			\
-- 
2.31.1

