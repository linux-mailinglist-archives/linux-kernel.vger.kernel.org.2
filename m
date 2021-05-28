Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676A8393FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhE1JZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbhE1JZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:25:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70927C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:23:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so4150931wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Oae5cR8MpOvf+7v137WImmltYKo9bkSfnBXxwDp6WY=;
        b=cGPZK+1qh3qGl5Tkc1sggfO4JBDvIkZA9FXLdvpxqd6TMyWeEEk7/MgeRX+FaYavf8
         ikTE2FJW+xnrGlsca9t/2JXtFJ5qvE9yqitfWNXYkMoTax3kRVmSx120KZYyTkmi9/Lt
         SMcVnSR0A4r0zFL3gX2crr4NtAYD6VI/aVN8wSIWqsxrdx8dv6KgpZWQZkSdx8EKMKJi
         iq1v7D9z+XJJK8lxImZf/Lq4q4uWE8JdGG57gT+ag2q0EgevZW0YlwfoZX1d5w1BAwzi
         +7uDRlTTwnD5YE49iL0Z5Us96psl75tcxHvXvo7P10DpYLuqy7aiJM3Tp976xJ8cVJd6
         yEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Oae5cR8MpOvf+7v137WImmltYKo9bkSfnBXxwDp6WY=;
        b=oZf/koATzAX45/h+Tjda/HzGSjQYLx4F8dq54bO7Y/ZWNGJqoke9Y9vAxOIFsusjdv
         IueqdnKJepkp8r5KLAXJXZGq8/B+r14NOHLWcqVBy1x1R3A3LSDNgoPUuCq/TWEyl5Aa
         C1I5VbBz9Lj4LhDfptcPda2lUl+XQMqFeVDTodMx7ZS4Bw4xHgcUjb/pGyI89XveRHTZ
         aA0emU28KJteB3T7+RJP4EJcVAMQF1cxaiAEo602c4ibMcTFjHpZP1uV/Ju4PW9Ntxfq
         liiIMhjS+O008911mJ9boVPy3GzWEaTd6kfmmlVj/7vCdkN7pfSKJTHAoS+e8huNhXtu
         wXyQ==
X-Gm-Message-State: AOAM532cDTPHRdlAKFC3WfS9HykAgDWWDSa56En27XPlISB/YEUImBBc
        8zfw7NcYdll1f9IgtSEzUDs=
X-Google-Smtp-Source: ABdhPJxzUfuATGCrxC3eGJEucDonBzwEvQVjqq9btPqHB+xwn7yMVwTA25ceEa+muVw/jWKTVpZ7OA==
X-Received: by 2002:a1c:7f84:: with SMTP id a126mr7028123wmd.96.1622193821059;
        Fri, 28 May 2021 02:23:41 -0700 (PDT)
Received: from ruhe.localdomain (89-139-227-208.bb.netvision.net.il. [89.139.227.208])
        by smtp.gmail.com with ESMTPSA id x13sm6301854wro.31.2021.05.28.02.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:23:40 -0700 (PDT)
From:   eli.billauer@gmail.com
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH 2/2] char: xillybus: Remove unneeded MODULE_VERSION() usage
Date:   Fri, 28 May 2021 12:22:42 +0300
Message-Id: <20210528092242.51104-2-eli.billauer@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528092242.51104-1-eli.billauer@gmail.com>
References: <20210528092242.51104-1-eli.billauer@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eli Billauer <eli.billauer@gmail.com>

MODULE_VERSION is useless for in-kernel drivers, so these are removed from
files in drivers/char/xillybus/

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
---
 drivers/char/xillybus/xillybus_class.c | 1 -
 drivers/char/xillybus/xillybus_core.c  | 1 -
 drivers/char/xillybus/xillybus_of.c    | 1 -
 drivers/char/xillybus/xillybus_pcie.c  | 1 -
 drivers/char/xillybus/xillyusb.c       | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index ea74da84bf19..5046486011c8 100644
--- a/drivers/char/xillybus/xillybus_class.c
+++ b/drivers/char/xillybus/xillybus_class.c
@@ -18,7 +18,6 @@
 
 MODULE_DESCRIPTION("Driver for Xillybus class");
 MODULE_AUTHOR("Eli Billauer, Xillybus Ltd.");
-MODULE_VERSION("1.0");
 MODULE_ALIAS("xillybus_class");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/char/xillybus/xillybus_core.c b/drivers/char/xillybus/xillybus_core.c
index 0efc4fddaa94..931d0bf4cec6 100644
--- a/drivers/char/xillybus/xillybus_core.c
+++ b/drivers/char/xillybus/xillybus_core.c
@@ -33,7 +33,6 @@
 
 MODULE_DESCRIPTION("Xillybus core functions");
 MODULE_AUTHOR("Eli Billauer, Xillybus Ltd.");
-MODULE_VERSION("1.10");
 MODULE_ALIAS("xillybus_core");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/char/xillybus/xillybus_of.c b/drivers/char/xillybus/xillybus_of.c
index 96b6de8a30e5..1a20b286fd1d 100644
--- a/drivers/char/xillybus/xillybus_of.c
+++ b/drivers/char/xillybus/xillybus_of.c
@@ -17,7 +17,6 @@
 
 MODULE_DESCRIPTION("Xillybus driver for Open Firmware");
 MODULE_AUTHOR("Eli Billauer, Xillybus Ltd.");
-MODULE_VERSION("1.06");
 MODULE_ALIAS("xillybus_of");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index 18b0c392bc93..bdf1c366b4fc 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -14,7 +14,6 @@
 
 MODULE_DESCRIPTION("Xillybus driver for PCIe");
 MODULE_AUTHOR("Eli Billauer, Xillybus Ltd.");
-MODULE_VERSION("1.06");
 MODULE_ALIAS("xillybus_pcie");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 1e15706af749..1210a4ef97fa 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -33,7 +33,6 @@
 
 MODULE_DESCRIPTION("Driver for XillyUSB FPGA IP Core");
 MODULE_AUTHOR("Eli Billauer, Xillybus Ltd.");
-MODULE_VERSION("1.1");
 MODULE_ALIAS("xillyusb");
 MODULE_LICENSE("GPL v2");
 
-- 
2.17.1

