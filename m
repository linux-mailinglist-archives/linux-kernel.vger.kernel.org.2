Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866974044A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350515AbhIIFBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhIIFBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:01:46 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964FBC061575;
        Wed,  8 Sep 2021 22:00:37 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso951492otv.12;
        Wed, 08 Sep 2021 22:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8FqMxDgd8l7sId2kCNTKyMoE47Aco1YprUDt2DkIx8=;
        b=hlay4CXUq7sieBd59o93+7cIFWC5zal3YB2NYexwhQAUI6cSAFd0++lgc2qN01kNwR
         7vVa13kkaGNUXihmRAjmdZfmRvruBTcmFGbI/FUWX5cCN8GEBXUNDiLtdvvsZdQNDc1v
         DCE3/YhO7XjrZFy7K2ojujqVkY7yc4kYYgplQzNBbqgo4t5A4dEk1ffPEseO+O47uWkR
         bBIjputuQG2O/OczjEwNO5pnbWAEMa7IVPu+OzPn2QCtuM2iNBMzhXBO8dekF474JXiu
         5u7BslPoZVLaTowwt1Kmu+Axkdp7lxiq3on+pVZSxj693VPFb5mkQgrJQctoZ2e1MLqW
         jdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=o8FqMxDgd8l7sId2kCNTKyMoE47Aco1YprUDt2DkIx8=;
        b=Sw9QXEbyC8guVBUhuADcNS5V2RwXopDBH6Nt8tWOJHG+hOdCA6ELAt/M/2ZwRPfO6w
         HJEKTeGS+defH9hj8HIivXf2R8ehqoWDqfu1a4sPdJVFu3v7oq/+rP5uvu/xN15Y/THV
         1ZL5gWOM5/MhBqyQ6SoSLgVW8VxMH8DI0BfVcILO7wSiF77QnXiKVeYaNk9M2OEayQeH
         W+LQxv8yT23bonhCI2yF7K0qzXH7K4hHBPrrgxSxFq7QJfyaHrChMBzmEzdAMflqQyLN
         7XcfY4v68wxSFWP1jCgh3M+Rsr3KUKwsxnUDkjMHMrS+w82ljHL669Eioh/X4gAQJNGX
         RwSg==
X-Gm-Message-State: AOAM532AXOBFz+GUA14zyDDeKcTbaNCBmgHh18u7y1FvqqW2guY+KBcB
        7OMNV4uo8nom33eN6UJ7WOY=
X-Google-Smtp-Source: ABdhPJx45r3vzc12qGEeCJWZVPTNcUa4JPLfsNNVAmIdgsCJmR+YXaO4qAXWyu9uTqGtiSTk0m/8vQ==
X-Received: by 2002:a9d:38e:: with SMTP id f14mr885992otf.337.1631163636266;
        Wed, 08 Sep 2021 22:00:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f126sm163079oob.9.2021.09.08.22.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 22:00:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Richard Henderson <rth@twiddle.net>
Cc:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] alpha: Declare virt_to_phys and virt_to_bus parameter as pointer to volatile
Date:   Wed,  8 Sep 2021 22:00:33 -0700
Message-Id: <20210909050033.1564459-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers pass a pointer to volatile data to virt_to_bus() and
virt_to_phys(). One exception is alpha. This results in a number
of compile errors such as

drivers/net/wan/lmc/lmc_main.c: In function 'lmc_softreset':
drivers/net/wan/lmc/lmc_main.c:1782:50: error:
	passing argument 1 of 'virt_to_bus' discards 'volatile'
	qualifier from pointer target type

drivers/atm/ambassador.c: In function 'do_loader_command':
drivers/atm/ambassador.c:1747:58: error:
	passing argument 1 of 'virt_to_bus' discards 'volatile'
	qualifier from pointer target type

Declare the parameter of virt_to_phys and virt_to_bus as pointer to volatile
to fix the problem.

Cc: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
We could instead try to modify the affected drivers, but both drivers
use the buffer to communicate with the chip, so that would require lots
of typecasts there. Another option would be to disable affected drivers
for alpha, but that seems undesirable.
Other ideas welcome.

 arch/alpha/include/asm/io.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 0fab5ac90775..c9cb554fbe54 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -60,7 +60,7 @@ extern inline void set_hae(unsigned long new_hae)
  * Change virtual addresses to physical addresses and vv.
  */
 #ifdef USE_48_BIT_KSEG
-static inline unsigned long virt_to_phys(void *address)
+static inline unsigned long virt_to_phys(volatile void *address)
 {
 	return (unsigned long)address - IDENT_ADDR;
 }
@@ -70,7 +70,7 @@ static inline void * phys_to_virt(unsigned long address)
 	return (void *) (address + IDENT_ADDR);
 }
 #else
-static inline unsigned long virt_to_phys(void *address)
+static inline unsigned long virt_to_phys(volatile void *address)
 {
         unsigned long phys = (unsigned long)address;
 
@@ -106,7 +106,7 @@ static inline void * phys_to_virt(unsigned long address)
 extern unsigned long __direct_map_base;
 extern unsigned long __direct_map_size;
 
-static inline unsigned long __deprecated virt_to_bus(void *address)
+static inline unsigned long __deprecated virt_to_bus(volatile void *address)
 {
 	unsigned long phys = virt_to_phys(address);
 	unsigned long bus = phys + __direct_map_base;
-- 
2.33.0

