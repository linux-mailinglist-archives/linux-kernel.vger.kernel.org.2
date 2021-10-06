Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0101F4241CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbhJFPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbhJFPuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:50:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B21C061767
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:48:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k7so10088007wrd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1i5uYXrPwvlq2iDKx2OUISeGIECPHitsBDyfw/S8/JI=;
        b=SSGob+l6swbzfHrN8j3ZipLM0OprZMaCt+pA8lyXMOCJK+cs7A711Jm98xKFjCiuAX
         SXVykAFpstlQbBsikx0Pm8An/5FbbfZsZ8hKivmKNDaiLaXOr24j9ee2eePKjfvon4xh
         1Fs0PzS7zwuxbnjtuwOHrWtXDgOm/H2A0SF7lcMbqGv71TG64qeeehuP8UOztwKSRkg3
         NYpKHQeIRERQCkgVJntV8FNNwsxF0PMbClAia0ziWggo/ZKNve2P2k5e7R3X+FGIAo5o
         YujwNFyihakQ+mNog8eHdg6G0M7MpuloWVrvSFZaD02ri/8EMXsN3d+hNEKr3UA6NcUh
         N6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1i5uYXrPwvlq2iDKx2OUISeGIECPHitsBDyfw/S8/JI=;
        b=tTVf3IYPOr0XB0g0Sobz43Z4Jp/f+ciARJsk0D8YMe8Gfq9WIPANdPgnGatPQiyNyp
         /6bbcwJUmnH6K7zE6fkJMxY5gCLEU02tWCe6VP+BwAJ1aOk6lGmAgUiBhzLES5ow31EM
         r6bVGkn0Hnfiv+saVNf4cA5EFogSWqTwp0DTyvkfdWsRq4nAQZpt5yJ38UeP7lPaTvtH
         aFc9tSgjJDF/phxtG4Bx3OJinnNUfyUOxeiAgwAzzEGy7nqLbdCHPU2CdjbWh8hlWOWv
         0BTVwOEzbm+ekdVsutHjlWcf3aC/9z83ko4Ku+X1n5x/yp+qOtS/9mQXPt6SMrSGZfmq
         sZhg==
X-Gm-Message-State: AOAM531C0uhPmxNvesdicLsUBej4IVUOMVaBv2aifHerznmvXeX/yvjD
        vWmkFWaNKNBBTfQCiNBIYHc=
X-Google-Smtp-Source: ABdhPJzyEuJb+m+INaE94TsIhCobkhPWKiWVjpeOAHtYUYltv6xObWwcCfXKd6UsI1Lypqg83tGL2Q==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr27009423wrs.204.1633535304640;
        Wed, 06 Oct 2021 08:48:24 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id m6sm11127386wru.53.2021.10.06.08.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 08:48:24 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ilya Dryomov <idryomov@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in sysfs-firmware-acpi
Date:   Wed,  6 Oct 2021 17:48:21 +0200
Message-Id: <20211006154822.135292-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated word: "send send a Notify"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-firmware-acpi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index 819939d858c9..39173375c53a 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -112,7 +112,7 @@ Description:
 		OS context.  GPE 0x12, for example, would vector
 		to a level or edge handler called _L12 or _E12.
 		The handler may do its business and return.
-		Or the handler may send send a Notify event
+		Or the handler may send a Notify event
 		to a Linux device driver registered on an ACPI device,
 		such as a battery, or a processor.

--
2.25.1

