Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B80435382
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhJTTNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhJTTNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:13:34 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA800C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:11:19 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u69so10868928oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3TD/VaGDQqhVY3cS1lVEqz1lY9E/iuwPnp6B8lTAVtk=;
        b=kMI0U8RvMMo3WO6ikECfHif6WhwwGal456vqrdkefzvbjzkwchxx6lrVdhWW3gCkdg
         eumuhH6kzYLKuuwpJJA80Pd8FOMGoWNGvhweoYbrUcS4hUBwPdK6/ml9OLFqWS2QlArW
         iEeiBdWXTx/ZXFSjuaOvIXHkKZlFF+O0BAhfFb+tTzu0dG7IJKOIvyPUTic9Zr5qkhD7
         s5cgP4wyHA29z+Qz/NKYxT5iaJ4gZVkq7alhzKCEGZ0u+dgn/RaLQm1rec/Lk2m3u2Nq
         CutQTSD1HZaBebTYrQ9dSo5SSEcqLob0cx4l/h2RiEoWJjag951wPsuhb81n67iBCbWU
         0MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=3TD/VaGDQqhVY3cS1lVEqz1lY9E/iuwPnp6B8lTAVtk=;
        b=wwFlaBM2OWPUy3ahb8Ixp8NsFO0Ccxy5FTvnvjEnxNMSBAt6d5Nf03LFIZw7ouRC4z
         2mCWycZia20o6LFciEuVmEfhG1EuXymmYMeCjZOvA/f9B0zwaBf7/s1/MfSRIxYjD0ug
         WIJD7HNYDC79C+oncAdk3qVxYW1VsLJ17pZF6g8X2jYxOnu9Ig1U1BUUgRv18eb336gX
         o8iDS+DYR7+9e0SqEhd9shihrq6ag0HSWUF+4xF33LEp0f/JbLXOC1FhkyxROBuMOebw
         Oki7CSSbIG5AissiTkb9YeazyR3PYAjncGQXlTaL1CJRU/QwiXmmGmIxGY+bYeIy1wj3
         Httg==
X-Gm-Message-State: AOAM531Q/1e99umuJMzZyj4ZHChp2OIaV8ntXSyz1yTCXr+Yqskmaaze
        QbOzU4larlU6qF/h7TA+Puw/C/HJl9k=
X-Google-Smtp-Source: ABdhPJzFQRJaPYjLCn44DvxC+O4p/J3WCRICe9oHu84DOmrQ1r8uF8HKAZJTFThkAE3IbiILeikQ6Q==
X-Received: by 2002:aca:5c5:: with SMTP id 188mr662465oif.154.1634757079169;
        Wed, 20 Oct 2021 12:11:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u21sm581371oiv.25.2021.10.20.12.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:11:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] nios2: Make NIOS2_DTB_SOURCE_BOOL depend on !COMPILE_TEST
Date:   Wed, 20 Oct 2021 12:11:16 -0700
Message-Id: <20211020191116.2510450-1-linux@roeck-us.net>
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Include error message

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

