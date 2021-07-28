Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547763D992E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhG1XAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhG1XAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:00:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA3BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 16:00:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso6380723pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4OhRfzRCDIVRSF0qVIZu/V8Dymx9+bTbUwgg3FW5xYI=;
        b=i3wBDh/ZYvNEANhL1wdz0gtZjpl3LYCuhITrNFVCLnsgss01MorTj5VfRElsRx7EM1
         IGoqUwF2w2c33+fFueEKRP632JerVwGOVg9pFc+/XuHuOADDb54r6T7uwlQIyN9UUSJk
         DuO89Qg3nS1TWWzNxBiPwMD8HwzPIrHML9F+dDfGd1JGfWOpAKzbqlwVRZRl5+6wJIrh
         rEwxarv5WUUmv2VmGsO9H9RYUA4YpDy6dFODz1iA8fafrAGz+2/kkm3Qm4zo8LCKlyxz
         lMeAocEih1R8EZrX5KRsx8QemdlwWHCAHbQcEziaj64g/6kxwOMi0Xymi2dj3KM7UYKy
         lSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4OhRfzRCDIVRSF0qVIZu/V8Dymx9+bTbUwgg3FW5xYI=;
        b=UVtQzFAbKCpOHC2B2vK7TE3ws5TcO0N6kgN3FrhP0EV5ZlWzX9sMvAlZL7wyv6HnYV
         hmal7ONouzdsua6ie7p5hnN3a/hssVwMxKFQew6Aq9beZYDKufVeJmSnw/x8NEDX0DWS
         +jxrViDeEwSgHCvCU7aEvECjvP4mXXQyJpc49LZNkjmsxVOHl3ef2Ig2JITm0OenNoic
         fK98+7DLSF4mAaJ6iJeUck8yFS5+uT3sxL0wMxA/GI2iftn6LNNMKmIsz/umQ4fzYbR/
         yf9NoVYQ/pPaNdD8wFmYK/GcRTQX2rz/Bcp1KbPlEg3SmX7fxqF6SK45R7h9iKRTny8k
         NawA==
X-Gm-Message-State: AOAM532otb0cswG7W7CkpRgEPMkyLAryy54C3rd3ECNCEr8XPYY5qVOc
        I7jKhFLRxnB6Qt0rCnb3i0VWFaquRN7gAA==
X-Google-Smtp-Source: ABdhPJxVnHMQkelgiFmuK2lyeu8jOnVruAgThfvOtuFuxAPLRXu5RAWQEkUOXPQapxVvd8BV+Sh4FQ==
X-Received: by 2002:a62:7cc7:0:b029:32a:5351:8bf4 with SMTP id x190-20020a627cc70000b029032a53518bf4mr1853884pfc.69.1627513211414;
        Wed, 28 Jul 2021 16:00:11 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b22sm7068638pjq.37.2021.07.28.16.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:00:10 -0700 (PDT)
Date:   Wed, 28 Jul 2021 23:00:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] x86/sgx: Add SGX infrastructure to recover from
 poison
Message-ID: <YQHhd0qKZqMCWqks@google.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-5-tony.luck@intel.com>
 <3534daf5-fae5-a85c-e198-c0b73e44ece4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3534daf5-fae5-a85c-e198-c0b73e44ece4@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021, Dave Hansen wrote:
> On 7/28/21 1:46 PM, Tony Luck wrote:
> > +int sgx_memory_failure(unsigned long pfn, int flags)
> > +{
> ...
> > +	page->flags |= SGX_EPC_PAGE_POISON;
> 
> Is this safe outside of any locks?

It's safe outside of sgx_reclaimer_lock iff this can guarantee nothing else can
reach the page.  I'm pretty sure that doesn't hold true here.

> I see the reclaimer doing things like:
> 
>                 epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> 
> I'd worry that this code and other non-atomic epc_page->flags
> manipulation could trample on each other.
> 
> This might need to some some atomic bit manipulation *and* convert all
> the other epc_page->flags users.

I don't think atomics would be sufficient as that would open all sorts of possible
races.  E.g. this new code in __sgx_sanitize_pages()

                page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);

+               if (page->flags & SGX_EPC_PAGE_POISON) {
+                       list_del(&page->list);
+                       continue;
+               }
+
		***HERE***
                ret = __eremove(sgx_get_epc_virt_addr(page));

could attempt EREMOVE on a freshly POISONed page.  That appears to be "benign"
since ENCLS is wrapped with_ASM_EXTABLE_FAULT, but it feels wrong to add a check
that we know can race.

And similar races for allocation/free could hand out a poisoned page or add one
to the free list.

@@ -585,6 +600,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)

        for ( ; ; ) {
                page = __sgx_alloc_epc_page();
+
+               if (page->flags & SGX_EPC_PAGE_POISON)
+                       continue;
		*** HERE ***
+


@@ -630,7 +651,8 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
        spin_lock(&node->lock);

        page->owner = NULL;
-       list_add_tail(&page->list, &node->free_page_list);
+       if (!(page->flags & SGX_EPC_PAGE_POISON))
		*** HERE ***
+               list_add_tail(&page->list, &node->free_page_list);


Setting POISON and hoping we eventually notice doesn't sound robust.  Maybe some
of these races are unavoidable due to the nature of #MC delivery, but I would hope
the kernel can at least avoid handing out a poisoned page to a different enclave.
