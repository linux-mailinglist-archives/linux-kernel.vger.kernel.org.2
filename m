Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F29354BFC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 07:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhDFE7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhDFE7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:59:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6714361222;
        Tue,  6 Apr 2021 04:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617685174;
        bh=tIomgEeIuH8P7ze0EpjBfN/KC3eWyiZsxls9MV18GGA=;
        h=From:To:Cc:Subject:Date:From;
        b=QzWorqWMOHmMsSEBLrfFvgLArOfX2Ekm1OfbI7eT+hQDLXp+/NUlfq9OOrqg5arG7
         CsqsYBpT5RT0YER+DPmVgJOtjhFlOcGrAAQxrJhEoGHutyjzkTyOXNQEWV+hqM6xvP
         1MlTLEb/SM3VcUSvY5NmPb1ZNbRZBvutSi1eJZzWSzYORgyXInl0B2F9/CJq0ZrhhO
         Oewu+cSikyq4TH1ccc9oSRnlrMDh7yA+DC5gKkUY7j28zojOL7UivehwjX+hI6ielV
         VQ/p977dqnGomY7HvP2LlWMEhvNllTQfD9UKZFLyrwE7T1uWM2MpKV8bcpq40RA3q3
         mL4Piw5bH9A6A==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>
Cc:     Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH] parisc: avoid a warning on u8 cast for cmpxchg on u8 pointers
Date:   Tue,  6 Apr 2021 12:59:29 +0800
Message-Id: <20210406045929.30331-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

commit b344d6a83d01 ("parisc: add support for cmpxchg on u8 pointers")
can generate a sparse warningi ("cast truncates bits from constant
value"), which has been reported several times [1] [2] [3].

The original code worked as expected, but anyway, let silence such
sparse warning as what others did [4].

[1] https://lore.kernel.org/r/202104061220.nRMBwCXw-lkp@intel.com
[2] https://lore.kernel.org/r/202012291914.T5Agcn99-lkp@intel.com
[3] https://lore.kernel.org/r/202008210829.KVwn7Xeh%25lkp@intel.com
[4] https://lore.kernel.org/r/20210315131512.133720-2-jacopo+renesas@jmondi.org
Cc: Liam Beguin <liambeguin@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 arch/parisc/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index cf5ee9b0b393..84ee232278a6 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -72,7 +72,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 #endif
 	case 4: return __cmpxchg_u32((unsigned int *)ptr,
 				     (unsigned int)old, (unsigned int)new_);
-	case 1: return __cmpxchg_u8((u8 *)ptr, (u8)old, (u8)new_);
+	case 1: return __cmpxchg_u8((u8 *)ptr, old & 0xff, new_ & 0xff);
 	}
 	__cmpxchg_called_with_bad_pointer();
 	return old;
-- 
2.20.1

