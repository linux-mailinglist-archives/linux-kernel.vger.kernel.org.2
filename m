Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294B443B60C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbhJZPvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbhJZPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:51:25 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1611C061220
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:49:00 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i9so36002627ybi.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bVpuD1Y0J9AqmF+3g16iWc8OCZsFp8I5PNhkQ+ZVF8=;
        b=ETLLMFRoQJtWWgBJT0RT3eQfsBfYysOXlgNe2DEvEZ1QazSwauaMIoM44pYme32Cmf
         5wDxSE86ikalKtUTF8YaP1Vkcs/bOKBzt0fci7rR3EbizNznCCEx/0w0v70ni5jpJVBn
         Sh62U8y41huL0JAATtLmBuahL1Xvkh1iSGtriC0Ko45kmdHgePn3PtuEZZHBjRrSzBBJ
         dGjnlJj7MYVxr1qqvL87tedwzYyPKh3xKjvudUVGo7CSSjA3VfLQ9uqL4RjTuNMod5w7
         zMBED7gaNA16iIjHd5Hnj6vSRP7OvuF+zHyueWTRLv5g9HUUT/3huLUFxWp7eKQl28lK
         6V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bVpuD1Y0J9AqmF+3g16iWc8OCZsFp8I5PNhkQ+ZVF8=;
        b=BoVWOkbEoi+8xzUul/YFQMBuwIIFpghfJdz5mbfjs04w2l3W81x5q8VSyofv4BxSK4
         5Zgo5GB9+I16cyf6C/OElwI6NItruPO3AapdlURvSyuCy3NFRgh1R2Du1eSiQvNeo7kw
         1x7eW7r0flWur5NVAsFSf/L1JhHjnKlDbCQmcsi/NC7tY4qS/1VY8FJ6EjUO5E2/rBpD
         C0ECXhOjbpiznzCJxyxMQD15sO1qabypWp2ZKsOt2nKb5XOEz64Hv/71mwkLLztYIEUt
         06L+IIKAmk/NrEtel/c2azdwJHJNux6lUF4Q1Qjf1rao2j0s/roMtFned9n20bd4EiJD
         dKHw==
X-Gm-Message-State: AOAM532rPl3wN94oDO+GKg1JiErH32/NAKnydbg250pFTZuQDHtoXA8V
        paLaYAVJlmezSkBmmyyIyLmk/28VUBpz/0w195gApA==
X-Google-Smtp-Source: ABdhPJxkAfBCqV5ai6x0PYyirty5FemxittcYFhZ6c9nyXWtlQOHD/jYuUO4dkRqgU2YSYIgmFfT9YLe/rbjhyI0rAo=
X-Received: by 2002:a25:2514:: with SMTP id l20mr26110968ybl.30.1635263339751;
 Tue, 26 Oct 2021 08:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211005234459.430873-1-michael.roth@amd.com> <20211005234459.430873-3-michael.roth@amd.com>
 <CAL715W+-H7ZSQZeZmAbbJNGKaZCNqf4VdLismivxux=gerFuDw@mail.gmail.com> <20211021033723.tfnhazbnlz4z5czl@amd.com>
In-Reply-To: <20211021033723.tfnhazbnlz4z5czl@amd.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 26 Oct 2021 08:48:48 -0700
Message-ID: <CAL715W+kJpnx5Jax2-vtFRDNrQFsc6+YT+q5ZkWbBM7gFVKjkg@mail.gmail.com>
Subject: Re: [RFC 02/16] KVM: selftests: add hooks for managing encrypted
 guest memory
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 8:46 PM Michael Roth <michael.roth@amd.com> wrote:
>
> On Mon, Oct 18, 2021 at 08:00:00AM -0700, Mingwei Zhang wrote:
> > > +void vm_set_memory_encryption(struct kvm_vm *vm, bool enc_by_default, bool has_enc_bit,
> > > +                             uint8_t enc_bit)
> > > +{
> > > +       vm->memcrypt.enabled = true;
> > > +       vm->memcrypt.enc_by_default = enc_by_default;
> > > +       vm->memcrypt.has_enc_bit = has_enc_bit;
> > > +       vm->memcrypt.enc_bit = enc_bit;
> > > +}
> > > +
> > > +struct sparsebit *
> > > +vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot, vm_paddr_t *gpa_start,
> > > +                          uint64_t *size)
> > > +{
> > > +       struct userspace_mem_region *region;
> > > +       struct sparsebit *encrypted_phy_pages;
> > > +
> > > +       if (!vm->memcrypt.enabled)
> > > +               return NULL;
> > > +
> > > +       region = memslot2region(vm, slot);
> > > +       if (!region)
> > > +               return NULL;
> > > +
> > > +       encrypted_phy_pages = sparsebit_alloc();
> > > +       sparsebit_copy(encrypted_phy_pages, region->encrypted_phy_pages);
> >
> > Do we have to make a copy for the sparsebit? Why not just return the
> > pointer? By looking at your subsequent patches, I find that this data
> > structure seems to be just read-only?
>
> Yes, it's only intended to be used for read access. But I'll if I can
> enforce that without the need to use a copy.
>

Understood. Thanks for the clarification. Yeah, I think both making a
copy and returning a const pointer should work. I will leave that to
you then.

Thanks.
-Mingwei
