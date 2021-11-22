Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3EE459605
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 21:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbhKVUXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 15:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhKVUXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:23:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4956C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:19:56 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so189374pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mRxIeU9HPgzOY3clEU+77o23b2EAQbNCRiTPpgLxklA=;
        b=CKa8JazZ41nRBv/+ULd1g5vvoetmCxEd7/52ZApQmKaWjCkKzv4wX0aZcynTwBG44V
         dp/yPAisfCYmXCGEtl96K9Dvesy2q4l76JsT5rxcVJ3epWACmiFg4Y8YRJ7LDZwlx/Ic
         u3BtM8hd9e6keFl2lJWiRpXc5BGJn+kdyr0DJdBYkWuZXPogLKvJD4IRHVqHWo9IrGL4
         XsgNrdtYF8TrbjEOgbpuWGcnsOYJUAjwz5z5qtv7l6WS04Ik89Ksmbg6auAPVWTPxVm5
         uY1LjtFCsW/4IN1RbSbExW3o2r2XKCw/7R4tRrmrNqAra2UQjds5J0CuGupE1lPTaEQH
         YZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mRxIeU9HPgzOY3clEU+77o23b2EAQbNCRiTPpgLxklA=;
        b=3jgq1gY/37T+9g/MwqQnpMuzDtCfM6rTuVCXiO/iH87EW5vbWKlfefvOOl8LpX6wPy
         qBjnVClt+zP96lBGn8hf6IJz+9DKUKNBsTNkUPEGC8FZJHtymQi+Is8N1ln5niAAFm/4
         c/jRVuZSSQUgS+ETTJFYMCxBNMNam/nKk5gCfQ/NBsP11MMAS9oAzjlznv+R3kBIAxWT
         VZBa3MxdyI0w3ZJNayDdNwG8ivbYiu5y1jgFCR/kblC8xrM8A/PYeXp5C1FJwisClE4S
         FiTaqKJvYeIwgzsGwtfVRZBDi5KzwjFVKYQXx/yzlct14Rg7G7kVI0k7qCi6w6P0RxGT
         2haQ==
X-Gm-Message-State: AOAM532DD3UxJIOikCIw8oCE5IZJinMQCjup+RFqBsAlMt+/0Mv46pr0
        CSwtexpVqYwj6+TQrZ+Isr//AA==
X-Google-Smtp-Source: ABdhPJzQAX5rio7DTTwz9eNYQ6QSDxHgCK5fgM6VOwMLfwtHzlnXhLRnQp6cNfcC09xIgx8XvJICDQ==
X-Received: by 2002:a17:902:d4d0:b0:141:c13d:6c20 with SMTP id o16-20020a170902d4d000b00141c13d6c20mr112062554plg.44.1637612396182;
        Mon, 22 Nov 2021 12:19:56 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v38sm6717082pgl.38.2021.11.22.12.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 12:19:55 -0800 (PST)
Date:   Mon, 22 Nov 2021 20:19:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hou Wenlong <houwenlong93@linux.alibaba.com>
Subject: Re: [PATCH 09/28] KVM: x86/mmu: Require mmu_lock be held for write
 in unyielding root iter
Message-ID: <YZv7aIL8+7ESCfFc@google.com>
References: <20211120045046.3940942-1-seanjc@google.com>
 <20211120045046.3940942-10-seanjc@google.com>
 <CANgfPd9=ce+JT3xEJy=p5MEfvkMGovEaBEu8KmxiZAJ1AA958g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd9=ce+JT3xEJy=p5MEfvkMGovEaBEu8KmxiZAJ1AA958g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021, Ben Gardon wrote:
> > + * Holding mmu_lock for write obviates the need for RCU protection as the list
> > + * is guaranteed to be stable.
> > + */
> > +#define for_each_tdp_mmu_root(_kvm, _root, _as_id)                     \
> > +       list_for_each_entry(_root, &_kvm->arch.tdp_mmu_roots, link)     \
> >                 if (kvm_mmu_page_as_id(_root) != _as_id) {              \
> > +                       lockdep_assert_held_write(&(_kvm)->mmu_lock);   \
> 
> Did you mean for this lockdep to only be hit in this uncommon
> non-matching ASID case?

Yes and no.  Yes, I intended what I wrote.  No, this isn't intended to be limited
to a memslot address space mismatch, but at the time I wrote this I was apparently
lazy or inept :-)

In hindsight, this would be better:

/* blah blah blah */
static inline struct list_head *kvm_get_tdp_mmu_roots_exclusive(struct kvm *kvm)
{
	lockdep_assert_held_write(&kvm->mmu_lock);

	return &kvm->arch.tdp_mmu_roots;
}

#define for_each_tdp_mmu_root(_kvm, _root, _as_id)			       \
	list_for_each_entry(_root, kvm_get_tdp_mmu_roots_exclusive(kvm), link) \
		if (kvm_mmu_page_as_id(_root) != _as_id) {		       \
		} else
