Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F423D9365
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhG1QoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhG1QoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:44:22 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91682C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:44:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m13so5094698lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cu87lLWCb/og9yKEYQ/1elWEpVqvoxE21CQJJHueP+0=;
        b=FHIXga3odQp+zLXPGxkus6RYPXim/grUE/TJUokmc2WyCK6a9FTBP6ANBqTc19IM4D
         qRrjKSrS7fnqS9IjugtabnFK9IBGowRnoJ1Krjt5e6+S1I+zuUkNzQkWz+UFLfHt0XdO
         Oo47DUwjG5pwEgtsL9zkctyobUhqFY3T/dKCn7pU9kxH9k7N0i4HqJ5QEQhTX1z2RgHm
         Fmu3uu2Tc9Y+bkumIVTFgivn9mzbhd4rEvIS8/6oC6V2bWT1Kjc0GrZFOsLFeRlku+dk
         tv6KX3rx449HOH8Z+CEg6hUgFFt+UWsiqLP2PbJbe/dqK1rqLURMuL9s6Cr+lhLyw9Fi
         LqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cu87lLWCb/og9yKEYQ/1elWEpVqvoxE21CQJJHueP+0=;
        b=SwV6ChfZ7PzYxOhoCYGlIlbkDcS5Cb7jg1Cyh84OBMKFmL/dyRZ+DaOCXfgz1CwYdR
         3G1qkI3JXxfNCN5xodbkMy2pwiGFVqmu/HZou+cBPYVVaGIr5x20IDZ6aFogGPyw0cz1
         ts6szswVX+SRlSZtPpKaYqOFUP4DyUB1I8BUmcN4+z3QMcooY8+cbp/MkA4mkTNmxLmA
         lyxYUEtx2Dfuj6untJ9ueMBRBhIxgjj5KUcMeqfvOpsJqsWBC3kDeV1k+5+ptQlp//WK
         53QMAQUXhxvtfzJNb/P78YgbSPyv8RioI55veP7USAwa6FtXN5iiBG8IIhX9JKFbMuyR
         WlPQ==
X-Gm-Message-State: AOAM530pNv5t+3Zij3WB5XYOqwYq/sCI5q1rf+b8UJMLJjVErXH7T4wO
        I932hrxWBZ/kjDQA1Z774iU=
X-Google-Smtp-Source: ABdhPJyp3cJutJHZtNJ5FXIQc9ydS1gkzClgYnOo36EVNDUGvvkfeNYRrQjivngr2Mtur6QiB4cJwQ==
X-Received: by 2002:a19:ac01:: with SMTP id g1mr368833lfc.301.1627490657980;
        Wed, 28 Jul 2021 09:44:17 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id r200sm45673lff.208.2021.07.28.09.44.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jul 2021 09:44:17 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Wei Chen <Wei.Chen@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [RFC PATCH 1/2] arm64: mm: Make virt_addr_valid to check for pfn_valid again
Date:   Wed, 28 Jul 2021 19:44:15 +0300
Message-Id: <1627490656-1267-1-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

The problem is that Arm's implementation of virt_addr_valid()
leads to memblock_is_map_memory() check, which will fail for
ZONE_DEVICE based addresses. But, the pfn_valid() check in turn
is able to cope with ZONE_DEVICE based memory.

You can find a good explanation of that problem at:
https://lore.kernel.org/lkml/1614921898-4099-2-git-send-email-anshuman.khandual@arm.com

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
I am not quite sure whether it is a "correct" place and
the change itself, I just partially restored a behaviour before:
https://lore.kernel.org/lkml/20210511100550.28178-4-rppt@kernel.org
So, the target of this patch is to get a feedback how to resolve
this properly if, of course, this really needs to be resolved
(I might miss important bits here).

It is worth mentioning that patch doesn't fix the current code base
(if I am not mistaken, no one calls virt_addr_valid() on Arm64 for
ZONE_DEVICE based addresses at the moment, so it seems that nothing
is broken), the fix is intended for the subsequent patch in this
series that will try to enable Xen's "unpopulated-alloc" usage
on Arm (it was enabled on x86 so far).
Please see:
[RFC PATCH 2/2] xen/unpopulated-alloc: Query hypervisor to provide
unallocated space

The subsequent patch will enable the code where virt_addr_valid()
is used in drivers/xen/unpopulated-alloc.c:fill_list() to check that
a virtual address returned by memremap_pages() is valid.
---
 arch/arm64/include/asm/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 824a365..1a35a44 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -351,7 +351,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 
 #define virt_addr_valid(addr)	({					\
 	__typeof__(addr) __addr = __tag_reset(addr);			\
-	__is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(__addr));	\
+	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
 })
 
 void dump_mem_limit(void);
-- 
2.7.4

