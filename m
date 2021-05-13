Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60F37F5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 12:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhEMKx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 06:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhEMKxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 06:53:51 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0784C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 03:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/r7vsNkaaaLlEs2V4TIC3qkCSYecc0pj6ZL4FrnVKYU=; b=LPWt3jqo24QEG/KRjmzrkD/Tt
        ROLKh8lYDpweTeDIzcOQCqksjx3F7KAVfu8k5qJ3SRc9JxFWF5edVNwYMSyw7tNT5N81X6rpajSIK
        oFpGN8O5j9e+16kzxTjP6joY9m3nVOMaR/Hfnn6lx/RxpEAlobl8QvnRNz+d4BOvy0e9+tfSoCkGx
        sWuC+6dvbK/vqVTaldYRn2N5RkA7mV10/EG1I18WqZKm9TeYQkh+CT1VaqRfvWW2rr85CbnnBMFWF
        ow733p0Pv77Foi340p6xU3wnhcuYz41wq26bIuJ3qitKDiR6a7ssftZWwkgIDK4UtmrzgeyQzGggQ
        3ZtVRhwYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43924)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lh8xI-0005zJ-0Z; Thu, 13 May 2021 11:52:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lh8xG-0002wb-QB; Thu, 13 May 2021 11:52:34 +0100
Date:   Thu, 13 May 2021 11:52:34 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/mm: Drop [PTE|PMD]_TYPE_FAULT
Message-ID: <20210513105234.GW1336@shell.armlinux.org.uk>
References: <1620885113-5938-1-git-send-email-anshuman.khandual@arm.com>
 <20210513080353.GR1336@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513080353.GR1336@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 09:03:53AM +0100, Russell King - ARM Linux admin wrote:
> On Thu, May 13, 2021 at 11:21:53AM +0530, Anshuman Khandual wrote:
> > Drop these unused symbols i.e PTE_TYPE_FAULT and PMD_TYPE_FAULT.
> 
> They're documentation, although PTE_TYPE_FAULT ought to be used by
> __swp_entry() to show that better.

So really, we should be doing something like this:

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

Since that is really what is going on here. It is by design that the
swp_entry_t is layed out to be correct, and of course because
PTE_TYPE_FAULT has the value of zero, the above merely adds to the
"documentation" rather than having any functional effect.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
