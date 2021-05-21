Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9879238BC7C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbhEUCm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhEUCm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:42:29 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1700C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:41:06 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v8so18445005qkv.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=clTNK84qmQnT49cW6tGZ0mkoH1KVBt8rRddpIhtzd0w=;
        b=FxZ3pPNP3r7fr9GQhaPsgaA0oEfdhBPJQAw+4Hpjpz6htCWmQ0/9JhdsN49sFbCLfO
         RtKLLefmbAM4smuFkrjbLIn4dO9xkWuE6MbZ7PaEnSCucPviP2zAbmXU8FW9Ac0LTZja
         XerHR8GGYd+9fct4cNNraXHn8cUvmeiYSRSfsqk5pruB46Zz2vJmWKoPxYYaeeYx2zDB
         L82vf/+i3mYvy6+FSvu2/CgZ1zBU7E+N5/2h+uOg958QqYy5O8UCNcVnLxmpD59InOPx
         t3/eb9AQ9C9M77kHV3EK75TS/pl2KLR7K3rzgVnQsCES2JvKBmp8StAduOtXET60ZBl5
         kw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=clTNK84qmQnT49cW6tGZ0mkoH1KVBt8rRddpIhtzd0w=;
        b=i0ANfVxgifMVganck0Eh29mZVqUJvTWQD3T7v7pcDkQGqKKi/QHB4dSnYrcHDXpTfX
         HmSBUwEYcoKGbXW1a9SY2X2T3PXoCKv3mzJj2pwb6+84UYIDZwtbUBg2vLKOWrJ7zKkI
         MwSAXJwOge380OLjtFnmV0DzFodUiZ0YkB5nM7KUInsxOBMPGNuy4FR9Q953lT6Dk1FA
         Ox98V6o7/8jZKzwLh2coJetV+FEgCiY+grtgsboPguCJZQKNoYJVbufzRlq/QalcluAb
         23OEYKPXg6xx06SQjuOZN6CYTp7S6rrjtVi0p4gzdZ/KOtGmRRhIQm4Q81/GkXYIyawz
         o2uw==
X-Gm-Message-State: AOAM5301EYlcgX6a4XDXRqW5XzfDgvZEIMpxS0OcdNP5XIxNJZ1GCqnO
        MdSBA3UTsABFm7nfj54hpoqj3Q==
X-Google-Smtp-Source: ABdhPJxVvMC3v4V0bceqoWJlw1Fq60XDP/8PB6CsXBpgkq+puRi6otC/EH2aZu7PD2aAAXOjHkmGmQ==
X-Received: by 2002:a37:9d81:: with SMTP id g123mr9321375qke.280.1621564865802;
        Thu, 20 May 2021 19:41:05 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h16sm3274617qke.43.2021.05.20.19.41.04
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 20 May 2021 19:41:05 -0700 (PDT)
Date:   Thu, 20 May 2021 19:41:03 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Russell King <rmk+kernel@armlinux.org.uk>
cc:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: update __swp_entry_to_pte() to use PTE_TYPE_FAULT
In-Reply-To: <E1lh9VH-0002Lz-Pd@rmk-PC.armlinux.org.uk>
Message-ID: <alpine.LSU.2.11.2105201917270.5752@eggly.anvils>
References: <E1lh9VH-0002Lz-Pd@rmk-PC.armlinux.org.uk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021, Russell King wrote:

> Swap entries use a faulting PTE which have the least two significant
> bits as zero. Due to this, the use of PTE_TYPE_FAULT was overlooked,
> but really should have been included in __swp_entry_to_pte().
> 
> Convert this macro to use PTE_TYPE_FAULT to properly document what is
> going on here, and use __pte() to convert the swp_entry_t to a pte_t.
> 
> This results in no change to the resulting kernel text.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Hmm.  Speaking as one who occasionally has to trawl through all
the architectures considering their __swp_entry() implementations,
I would much prefer you to drop this patch: I don't think it helps
anyone to insist on ORing in (something which when one searches
further turns out to be) 0.

But if you really want to keep it, please remember it's not just
__swp_entry_to_pte() that "needs" changing: __pte_to_swp_entry()
ought to mask it off, pte_clear() ought to set it, pte_none()
ought to compare against it, page table initialization ought
to memset with it, and probably more :)

Thanks,
Hugh

> ---
>  arch/arm/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index c02f24400369..c43e07d6046d 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -303,7 +303,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  #define __swp_entry(type,offset) ((swp_entry_t) { ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
>  
>  #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
> -#define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
> +#define __swp_entry_to_pte(swp)	__pte((swp).val | PTE_TYPE_FAULT)
>  
>  /*
>   * It is an error for the kernel to have more swap files than we can
> -- 
> 2.20.1
