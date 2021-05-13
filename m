Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E684937F6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhEML3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhEML25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:28:57 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C283C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 04:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LlrBAsqaBHLDKkJjsDDXThJXj9LgGySYv+Ol49w0cSM=; b=FHijEhHOhx4qWJ/9jY4HsV8P9o
        ZyhpzdLdka+B6w/PYDlTaJ9zJSQiao9t3Y6+mGn2jcYNV2BJXSZwgXE52VtdKpM6Wsfcfmz/PakI7
        ph7j/M8IeH42naudrvf4yo5AgNM4ay1obnITcUQdfvGIKGJ1y+KCGSLkrfneLdO89ZNQVOIgrJZwT
        nG6P42fXsde4PMDX534+e512ilfOams13myeY2Te6YfhxDMKkDM/Jod+QX2ZEe3CQDrjAGf75evf1
        5pAMrGlGypDKXo/57FTfQvv9Oiq5MDAGBtMQIWA2uu69PFLI+uYCqAijgIivxJS7U9O5Tz3wijBQp
        8ZFgxTzA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55876 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lh9VI-000626-0N; Thu, 13 May 2021 12:27:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lh9VH-0002Lz-Pd; Thu, 13 May 2021 12:27:43 +0100
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: update __swp_entry_to_pte() to use PTE_TYPE_FAULT
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1lh9VH-0002Lz-Pd@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Thu, 13 May 2021 12:27:43 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap entries use a faulting PTE which have the least two significant
bits as zero. Due to this, the use of PTE_TYPE_FAULT was overlooked,
but really should have been included in __swp_entry_to_pte().

Convert this macro to use PTE_TYPE_FAULT to properly document what is
going on here, and use __pte() to convert the swp_entry_t to a pte_t.

This results in no change to the resulting kernel text.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index c02f24400369..c43e07d6046d 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -303,7 +303,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 #define __swp_entry(type,offset) ((swp_entry_t) { ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
+#define __swp_entry_to_pte(swp)	__pte((swp).val | PTE_TYPE_FAULT)
 
 /*
  * It is an error for the kernel to have more swap files than we can
-- 
2.20.1

