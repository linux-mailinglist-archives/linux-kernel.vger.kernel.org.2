Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB3A435379
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhJTTMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhJTTMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:12:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C499C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:09:58 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z126so10801259oiz.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPjaPEuX5A746s8v75X8g/60kgyy7clKTF8vv6uh878=;
        b=nEW+1kTLBe+WKJ8vb62FpFIx30/UgCdlD9PmeJflDrYNJdal6VOp2hjIQTFb+mZdiE
         kqKkRXyfWqqFfynwtwQeLLml3yGZi7DcIZnit4oOwgPsZ1yn+YocZDkdIFIFp/PuErsi
         HZYUCoupIfRjtHKK/qb1c5FcFXW4f6kWJ7QeaT+PCMsImc9bfwrnooBTeflJ02fETpzf
         x+oV6mktGsFqXfhPUZPI00Ouq60IqcsVHEjDEUDi8yVK7FUJTLmoIUiSNNy3Lqw0cEY2
         NjKAqLKFtnbWh6uu5GzgmM0D0JZL4HTxnWGFTOqpFnflKWMyBPqabnz9PK2p6hVWp4hs
         QMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SPjaPEuX5A746s8v75X8g/60kgyy7clKTF8vv6uh878=;
        b=LEExDB3wn7jT3TBxWe2cmccNAkT5NzITGs8Vdni/lgPLfjL3YbI1EPDeqNvA0TRCyk
         IIAP1+jA2rmhnVjMD51Yop5EzXj+HTpkoyeEVr/f4qugde4T+NyPpGsdoqBa7gIulAZi
         g6kj1r7fOZg20pLGxqqh5s948BBqSoPKJ6TQXKeznuQg0rS6vT88vF79PP8fwAQarUrk
         k4OaTMAzGCEuxXZ6WbvKpYt+rTzsesq4U14nUK9/JIoF+B94FerIeKsGNZe9vq94oKWo
         gULz1Ylw1R0d8wmIm1ukVSSJPdog0OLKnuVjKm5wlBGBWcgM/pH9c+7fOM3CiQMQ4+uY
         22zQ==
X-Gm-Message-State: AOAM532Cr6E1Pea4nrMO2SsK3zMr6pu9FTitguFSkL2pKKw/q9+WyazT
        5NPSzzMAAldS8g5paR8pRuNmWYVIxsU=
X-Google-Smtp-Source: ABdhPJxTKb0fYbXRUxoS7eJF1UEyvr+8v8PxjLSIOUBDoZaU43J7TVaN67HXqjkwsPSp/7ZaDYfzTA==
X-Received: by 2002:aca:5c5:: with SMTP id 188mr656599oif.154.1634756997460;
        Wed, 20 Oct 2021 12:09:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3sm639182otr.42.2021.10.20.12.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:09:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] nios2: Make NIOS2_DTB_SOURCE_BOOL depend on !COMPILE_TEST
Date:   Wed, 20 Oct 2021 12:09:52 -0700
Message-Id: <20211020190952.2473153-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nios2:allmodconfig builds fail with

This is seen with compile tests since those enable NIOS2_DTB_SOURCE_BOOL,
which in turn enables NIOS2_DTB_SOURCE. This causes the build error
because the default value for NIOS2_DTB_SOURCE is an empty string.
Disable NIOS2_DTB_SOURCE_BOOL for compile tests to avoid the error.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/nios2/platform/Kconfig.platform | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nios2/platform/Kconfig.platform b/arch/nios2/platform/Kconfig.platform
index 9e32fb7f3d4c..e849daff6fd1 100644
--- a/arch/nios2/platform/Kconfig.platform
+++ b/arch/nios2/platform/Kconfig.platform
@@ -37,6 +37,7 @@ config NIOS2_DTB_PHYS_ADDR
 
 config NIOS2_DTB_SOURCE_BOOL
 	bool "Compile and link device tree into kernel image"
+	depends on !COMPILE_TEST
 	help
 	  This allows you to specify a dts (device tree source) file
 	  which will be compiled and linked into the kernel image.
-- 
2.33.0

