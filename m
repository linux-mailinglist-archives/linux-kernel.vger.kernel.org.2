Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717313808D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhENLrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhENLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:47:10 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFECC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:45:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d16so3720473pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1uWTWCx3rVwoQXwRDyxvyCjfIhD9sJFj93Bkz/f21Dw=;
        b=JKDZ0bRpneLYwkSc6Fiyokl7fb5cC0bO9WZr2Jugz7Z+pnmbUolUExa+1jqCWQXjXj
         JChvACbi4LZpevUW9fjUiK1AXPS3I3G8+6KQfFlKWSnJnSv1ylDqf8Jcped2pQqZGbTJ
         1GBF+2n6kSkPY32vVMGQOsZBlhrTItDwh1xXxMcN9lB5g5jkaiiLGfnGQnev1pbtTA5X
         ekNTTJikf7wiIhB0IgbQnrZ153zL/IwmPxypcvJpdUB+Sz3ZJ+KKgnlfiXeRBwvjVntJ
         0T8pzXkZA/9Sll/ISdfzt56+nf/xV3KMY+8f+cX/ORXrTnm7ISUzYgbXr2wYQsfqKS6i
         P2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1uWTWCx3rVwoQXwRDyxvyCjfIhD9sJFj93Bkz/f21Dw=;
        b=CXMcio2zT8s1Jlnu9winYaqYq0kZ4M6KOIsnLLEjRM+JEsT5uRmlq5e8pQ6ENsWs7S
         GeAI2/r5RXrKmFOoz9DuR1SgNdN7IcT9bBJpTbOR84Y6Pp4pfumyqB7UhyKgJSSPm02X
         qT1FRdaUNmdcKeqvRMR2raFiNKxJ1mLI6rd0jUSAIVG05U+1MauUOlWSHRGPT8eUnqPI
         /19OZuH4qyYoIUx1SG8sYtYPhAtR8LI+di0KqWd7rCKcDRTzzYNyLyqzmQfNXIlHTIYf
         Vaj8KbHzpaYV24T3goyY9PpcLrsCPCnq6+qMcB0OwcTefxYn+dA8LqyGomC+Fr9X4rP5
         iQtQ==
X-Gm-Message-State: AOAM531U/n5se8cZH1CHopIc8tQ1CjC+I0h+EoOvK0l5kgdIniqllFZq
        gKhlXZ8PLyvaGMqvRUCSsao=
X-Google-Smtp-Source: ABdhPJy+epfnc9I0vvLkTjCFaROADi0jPBOk8wlwnO5H3VVdxq6pwUPmH0xEPtPTRkWUAHaHxC16Lg==
X-Received: by 2002:a63:9d48:: with SMTP id i69mr46354396pgd.297.1620992758992;
        Fri, 14 May 2021 04:45:58 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id e27sm4260168pfm.144.2021.05.14.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:45:58 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Morris Ku <saumah@gmail.com>
Subject: [PATCH] 8250:Add SUNIX SDC series uart driver
Date:   Fri, 14 May 2021 19:45:46 +0800
Message-Id: <20210514114546.5330-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add SUNIX SDC series uart driver

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git driver/tty/serila/8250/Makefile driver/tty/serila/8250/Makefile
index 4186e8c..45da230 100644
--- driver/tty/serila/8250/Makefile
+++ driver/tty/serila/8250/Makefile
@@ -39,4 +39,4 @@ obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 obj-$(CONFIG_SERIAL_8250_SDC)		+= 8250_sdc.o
 
-
+CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.20.1

