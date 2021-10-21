Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C86C436456
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhJUOfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhJUOff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:35:35 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9C2C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:33:19 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso635591ota.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4HGMYEBVt5lztNuzur8LH0H/Wgn1pjymQTOhN0cejJ4=;
        b=HzokV+VMGqZXSf0caNnHUCBfMbUHKlUw4SKRQLtH8yfzQ+0Dl/mZSFcYVSS/Vj7324
         OUDEFsarByBZ7I44Fiy530ycgW0PXOMc/stTwovZZeGeyYYbmKOSSgPl5tQO2PQL+c5p
         GpZZ9wt60Bs8aUtF08GVUU0Fi/4H0tl5fA5UG07OpgT9IuuqqUuXET1eSEoOhnASqbpa
         ywzgPxC9vvm+2O1FM5eonGI9R9kgvEgjQr4bU5jNu3CdpsYHdKHI0B+QEt+7ohpR3Mrb
         jjSrXVVLXaJZfvg2yJzYglhZZ0iLdvC/YA6SBH2/JRRM0FuSCWtPbzMAYcNmVFiKgokn
         Si+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4HGMYEBVt5lztNuzur8LH0H/Wgn1pjymQTOhN0cejJ4=;
        b=vzFf8k01jO8OZsSlO38T1Pz1Wq3b0oaJspJbPacZUsHCiQ8gO+mJZ2deoy2pYtDb0i
         0RgAS1Wp2q4olWcE6K/6EX9OnJyPvFLqjyEOEhTUiOmRjbTEDlC62FtDpiXVGHt1uNDc
         RQmDGNs9ckIapjVnDcrGPpTdRlwTrOhyhPaKI3JxcmWslDQQjt+9PwMMAyn5niYJNavt
         /bJChz8rdafZhXBMwIJ4C1g1GZzoPi6teZS7PHFNVIuLhvJ77YxwIr7tdVY2u36bBh89
         /37OjKCa6AzZpfQXRNeH0rT1y6MKQF/uwmesOAt3THFUBV2t2JjasqS3X8klbelq4Qkg
         ECtA==
X-Gm-Message-State: AOAM532d6yTda9eCJo0y1P2Nl7uGw3fugJTM2M3d33I6kUqhKnQbDwT6
        Sj46Jy9t1VdGS7bQLRjSe1I=
X-Google-Smtp-Source: ABdhPJx1Gj4SPgCyl8/lpZgE22ZS6ii5No+YEsb3xZmA1BhJztM4vnQHOq0hl98ABBaUWvJAdwBUfw==
X-Received: by 2002:a05:6830:410e:: with SMTP id w14mr5172367ott.256.1634826799011;
        Thu, 21 Oct 2021 07:33:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e22sm1102595otp.0.2021.10.21.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:33:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3] nios2: Make NIOS2_DTB_SOURCE_BOOL depend on !COMPILE_TEST
Date:   Thu, 21 Oct 2021 07:33:15 -0700
Message-Id: <20211021143315.3139952-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nios2:allmodconfig builds fail with

make[1]: *** No rule to make target 'arch/nios2/boot/dts/""',
	needed by 'arch/nios2/boot/dts/built-in.a'.  Stop.
make: [Makefile:1868: arch/nios2/boot/dts] Error 2 (ignored)

This is seen with compile tests since those enable NIOS2_DTB_SOURCE_BOOL,
which in turn enables NIOS2_DTB_SOURCE. This causes the build error
because the default value for NIOS2_DTB_SOURCE is an empty string.
Disable NIOS2_DTB_SOURCE_BOOL for compile tests to avoid the error.

Fixes: 2fc8483fdcde ("nios2: Build infrastructure")
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Added Fixes: and Reviewed-by: tags
v2: Add build error message to commit description

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

