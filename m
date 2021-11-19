Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41445789C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 23:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhKSWYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 17:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbhKSWYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 17:24:46 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2891C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 14:21:43 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y8so9197456plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 14:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BWddyG3YL6k7bG+TnBK28e//6M0bIbW4TSIkWYmJ/v8=;
        b=EuwLBJL7d8Z1+TfWgCR5KtCvEV67f5PIxvqG3aTGsd/eshhsU8erJhoGf0qFXRBYNK
         ojHHmODuu2mFpfgcCH9Mh7DUEoaZ86X30XwStlGJZNYWsNn9NL94sEru/vUg5Nbj4Ygk
         rg0O9yS0UoSLKIy+BYbkKCS7p6NG7AJKpFjEP2DFQyX8BBbyhzRWp+wRYVub/WiG1a4H
         EGDfKcdqN4CON4UFuLc4/wDhL1EAWBW4K279192TaFlRQ297QMSEKJ5/s8gtUr82qbLh
         G3wDAbAF+/UYwO1h3h+UwsxOj6qLscYU/yF0iX9FS4zA7l58NfcA9DyBK+/NK/quciN+
         kONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BWddyG3YL6k7bG+TnBK28e//6M0bIbW4TSIkWYmJ/v8=;
        b=4IJT5ww3w1UDtuFu5srMeAwLK/bRYbnUUTUWJyxc7YoKLi1Tesv/PZ9wULITPqA0Ky
         FB5D2b1fGIVLlmZunYdccw4Z59fMVRiwckrv1w+E2drmMfW1JktUljA1iHMS40pd143D
         ed46zsn9yLWYccjHLVVKUGWiGHmoTwKK1x2lO605pHtu+jhSz5Tgq+scJUmc4vfLus5a
         C3rSkSncPPgGLEoP9/qmXAnKjxshdKzcYSay5aPx7eoZuk/lJtY1P4/AAZhyeavc58Yz
         an5kLXx7XF5Lah01fA4iiXdvpMkrgY5avjR2G9BvqM3Y+QSknv21HFaZEBUfc2XqPfJ2
         jNRA==
X-Gm-Message-State: AOAM5326aeqpHS6sioWT/OTAKC0RuV7rheT1J3Exgg4iVgpWMtohEGsp
        h/raqwb901kWDYodbsQWGSLqCgJ8Sdw6yA==
X-Google-Smtp-Source: ABdhPJw5pCQ1lvi4R7CtbDaQGcOJnt0PSBvoK0mJGOtw9m+Psi5Ckwf4h+0YLOW3oeLbqYaNToVYnQ==
X-Received: by 2002:a17:90b:1c81:: with SMTP id oo1mr3963147pjb.171.1637360503250;
        Fri, 19 Nov 2021 14:21:43 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w17sm601647pfu.58.2021.11.19.14.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:21:42 -0800 (PST)
Date:   Fri, 19 Nov 2021 22:21:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Message-ID: <YZgjc5x6FeBxOqbD@google.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
 <YZf4aAlbyeWw8wUk@google.com>
 <20211119194746.GM876299@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119194746.GM876299@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021, Jason Gunthorpe wrote:
> On Fri, Nov 19, 2021 at 07:18:00PM +0000, Sean Christopherson wrote:
> > No ideas for the kernel API, but that's also less concerning since
> > it's not set in stone.  I'm also not sure that dedicated APIs for
> > each high-ish level use case would be a bad thing, as the semantics
> > are unlikely to be different to some extent.  E.g. for the KVM use
> > case, there can be at most one guest associated with the fd, but
> > there can be any number of VFIO devices attached to the fd.
> 
> Even the kvm thing is not a hard restriction when you take away
> confidential compute.
> 
> Why can't we have multiple KVMs linked to the same FD if the memory
> isn't encrypted? Sure it isn't actually useful but it should work
> fine.

Hmm, true, but I want the KVM semantics to be 1:1 even if memory isn't encrypted.
Encrypting memory with a key that isn't available to the host is necessary to
(mostly) remove the host kernel from the guest's TCB, but it's not necessary to
remove host userspace from the TCB.  KVM absolutely can and should be able to do
that without relying on additional hardware/firmware.  Ignoring attestation and
whether or not the guest fully trusts the host kernel, there's value in preventing
a buggy or compromised userspace from attacking/corrupting the guest by remapping
guest memory or by mapping the same memory into multiple guests.

> Supporting only one thing is just a way to avoid having a linked list
> of clients to broadcast invalidations too - for instance by using a
> standard notifier block...

It's not just avoiding the linked list, there's a trust element as well.  E.g. in
the scenario where a device can access a confidential VM's encrypted private memory,
the guest is still the "owner" of the memory and needs to explicitly grant access to
a third party, e.g. the device or perhaps another VM.

That said, I'm certainly not dead set on having "guest" in the name, nor am I
opposed to implementing multi-consumer support from the get-go so we don't end
up with a mess later on.

> Also, how does dirty tracking work on this memory?

For KVM usage, KVM would provide the dirty bit info.  No idea how VFIO or other
use cases would work.
