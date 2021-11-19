Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18044457995
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 00:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhKSXgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 18:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhKSXgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 18:36:17 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE41C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 15:33:14 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id t34so10992373qtc.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 15:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YIQtmzLjEsgeZMQMOnkMzRwMWgRyVXZoeNdlFrk18qs=;
        b=NLLz2U5cbYEoorMYBXQrK8g/0dsQGOOIzTFzpIoM82ai9sEhm8aVRw+/BSYzFL+689
         BulZ2pbNGnI/4bphyGwK+LCcpSosFvZ+rw35XZRx6YXpkIQx8YxHYTN+q0oXMOqAVENc
         XB4JnHls4dkr5k7ZheHEl44EItXxSWqm6lSNgR62w1dbRoTG5C7zEC2oAW/D2bw78pDc
         zD/7I+T9RhLwq2MRwjtPcowgD2liuh3dxi/fvdWK1tLAharf0byCKhzAKJvZVM/E9sdk
         fVUUoRlZxW54VP8R/sKiLNvFzSEHme73UtzJ9W/Y3cYmh49+bmuoMo8qaW396gxyiZ79
         6rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YIQtmzLjEsgeZMQMOnkMzRwMWgRyVXZoeNdlFrk18qs=;
        b=si1lBc8eOz4onuZXbfEBiXLQi/5YcdgeG3j2IJjZnOfDlHF7xCrV1j2Jaj/4HP/qqJ
         oDcEdYPfl7Yv/Gy1tsRQdmfgpqIiYY38sxHti5QQ4ZdHp9mDes1bmwTN+khE9vZRHQkj
         xgD2EbgGw2NGJF7IOyfoi4b9rfg11md3NNui3r/NqXu2PqF3iJdo+ERF5/qcWZrYagf3
         37SWzFfoz11O3biwsE1aeMN0Alm4GNuJ7a11x+dpJgCo12snClcs01PvdTu826CZbLnr
         pspBqPd7qTrhQiNLleY3zBKo6bTc8FyJ08aGdYN6UQQSEtMAbK3RhL37BMhBORynKvpA
         4wJg==
X-Gm-Message-State: AOAM532DKoS9yshY22iWwXbyD5Zt/E/xTg6bBLcjQsGZQx6/iorwiPkj
        yIO74rjOfSkpBibY5hPwrlR51w==
X-Google-Smtp-Source: ABdhPJyxRDjxrzpShk1yUcPpFaeAg/9+/FV8kt7sx9ISnNgpRPG9gnZ2XXj45zOthyEGjNn5VI7NlA==
X-Received: by 2002:a05:622a:449:: with SMTP id o9mr10355315qtx.158.1637364793514;
        Fri, 19 Nov 2021 15:33:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s20sm626369qtc.75.2021.11.19.15.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:33:12 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1moDNY-00CyxZ-6v; Fri, 19 Nov 2021 19:33:12 -0400
Date:   Fri, 19 Nov 2021 19:33:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sean Christopherson <seanjc@google.com>
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
Message-ID: <20211119233312.GO876299@ziepe.ca>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
 <YZf4aAlbyeWw8wUk@google.com>
 <20211119194746.GM876299@ziepe.ca>
 <YZgjc5x6FeBxOqbD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZgjc5x6FeBxOqbD@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:21:39PM +0000, Sean Christopherson wrote:
> On Fri, Nov 19, 2021, Jason Gunthorpe wrote:
> > On Fri, Nov 19, 2021 at 07:18:00PM +0000, Sean Christopherson wrote:
> > > No ideas for the kernel API, but that's also less concerning since
> > > it's not set in stone.  I'm also not sure that dedicated APIs for
> > > each high-ish level use case would be a bad thing, as the semantics
> > > are unlikely to be different to some extent.  E.g. for the KVM use
> > > case, there can be at most one guest associated with the fd, but
> > > there can be any number of VFIO devices attached to the fd.
> > 
> > Even the kvm thing is not a hard restriction when you take away
> > confidential compute.
> > 
> > Why can't we have multiple KVMs linked to the same FD if the memory
> > isn't encrypted? Sure it isn't actually useful but it should work
> > fine.
> 
> Hmm, true, but I want the KVM semantics to be 1:1 even if memory
> isn't encrypted.

That is policy and it doesn't belong hardwired into the kernel.

Your explanation makes me think that the F_SEAL_XX isn't defined
properly. It should be a userspace trap door to prevent any new
external accesses, including establishing new kvms, iommu's, rdmas,
mmaps, read/write, etc.

> It's not just avoiding the linked list, there's a trust element as
> well.  E.g. in the scenario where a device can access a confidential
> VM's encrypted private memory, the guest is still the "owner" of the
> memory and needs to explicitly grant access to a third party,
> e.g. the device or perhaps another VM.

Authorization is some other issue - the internal kAPI should be able
to indicate it is secured memory and the API user should do whatever
dance to gain access to it. Eg for VFIO ask the realm manager to
associate the pci_device with the owner realm.

Jason
