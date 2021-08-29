Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9A13FACAE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhH2Pfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235587AbhH2Pfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630251292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k7bK8mjMEr9/+vI3Cmf28n6PO028nMAxW7f7pwBVdA0=;
        b=WQELnnID40NCvm8TdmbstgN9brw48EWtswvkZcYkN6DuUcQSoJ8rLc7vbH+P3TKIW3KUbD
        aPhWl6wmZqM+d5Kq1npMLrMgmVvypdymlsKp2iraOCmx0R+s8pMSB2ZakuBpgYgr+pmeI7
        LgWUoeVgUBZl9r2A1l1caN3GY3tMErg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-Z_xoIPRFNd2aMGbDt7bC3w-1; Sun, 29 Aug 2021 11:34:51 -0400
X-MC-Unique: Z_xoIPRFNd2aMGbDt7bC3w-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so3884650wmj.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k7bK8mjMEr9/+vI3Cmf28n6PO028nMAxW7f7pwBVdA0=;
        b=olj105UCgH513VRYVnActecqOSuyhUQxEjz9w43QIQcbeusg7y8Wy43E5GNna4OcCp
         /9VY84uOaGFnJ1xwKH54lRIdkBLadluVOcU3sTzWbnQadie4t0+Ai9K0cGzfz/JGvzQC
         mGFfyvnUtR1493XtlTYzOXnC+W9rNNZjCFW6xuA8EX08T9qEPL2uMWUvrWIxIRsk2vXK
         P/MedSKIUXw2Cht1F5b7IZOThudTSWGRCDP3on3WPTXKFedJuYhy29aBAkkFz8jolQDM
         y76bfgepx0Ef38OHWxbb7M1dnebCn1AXIw3zXRCWyWN+giqJeMAYEgaIB3DYD1Lap/5w
         xnyg==
X-Gm-Message-State: AOAM531HV6BlTqkqK5EK3UC0iCBVgZ8EyIQlU039eIHmh6sc3eLrYxFh
        vgic5EqmNvjeynFHr2uOIOQuZylRzbaiomgeZZ+buBcSkU70SPiATd1/zFCAUqlADwpFEsU3bBk
        ufHtKrrMXHbOSyXd8MekQGlI0
X-Received: by 2002:a05:600c:3554:: with SMTP id i20mr7228683wmq.164.1630251290268;
        Sun, 29 Aug 2021 08:34:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsfKVvJX2xTr0v/Oh8xaTCTod6wJJZwve+Ck9U4y7wUSNHEINC5PgKnfcQc4zsMGO0I7qvbA==
X-Received: by 2002:a05:600c:3554:: with SMTP id i20mr7228668wmq.164.1630251290087;
        Sun, 29 Aug 2021 08:34:50 -0700 (PDT)
Received: from redhat.com ([2.55.137.4])
        by smtp.gmail.com with ESMTPSA id h15sm11626735wrb.22.2021.08.29.08.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 08:34:49 -0700 (PDT)
Date:   Sun, 29 Aug 2021 11:34:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210829113023-mutt-send-email-mst@kernel.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <YSSay4zGjLaNMOh1@infradead.org>
 <2747d96f-5063-7c63-5a47-16ea299fa195@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2747d96f-5063-7c63-5a47-16ea299fa195@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:04:26AM -0700, Andi Kleen wrote:
> 
> On 8/24/2021 12:07 AM, Christoph Hellwig wrote:
> > On Mon, Aug 23, 2021 at 05:30:54PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > > 
> > > On 8/23/21 4:56 PM, Michael S. Tsirkin wrote:
> > > > > Add a new variant of pci_iomap for mapping all PCI resources
> > > > > of a devices as shared memory with a hypervisor in a confidential
> > > > > guest.
> > > > > 
> > > > > Signed-off-by: Andi Kleen<ak@linux.intel.com>
> > > > > Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > I'm a bit puzzled by this part. So why should the guest*not*  map
> > > > pci memory as shared? And if the answer is never (as it seems to be)
> > > > then why not just make regular pci_iomap DTRT?
> > > It is in the context of confidential guest (where VMM is un-trusted). So
> > > we don't want to make all PCI resource as shared. It should be allowed
> > > only for hardened drivers/devices.
> > Well, assuming the host can do any damage when mapped shared that also
> > means not mapping it shared will completely break the drivers.
> 
> There are several cases:
> 
> - We have driver filtering active to protect you against attacks from the
> host against unhardened drivers.
> 
> In this case the drivers not working is the intended behavior.
> 
> - There is an command allow list override for some new driver, but the
> driver is hardened and shared
> 
> The other drivers will still not work, but that's also the intended behavior
> 
> - Driver filtering is disabled or the allow list override is used to enable
> some non hardened/enabled driver
> 
> There is a command line option to override the ioremap sharing default, it
> will allow all drivers to do ioremap. We would really prefer to make it more
> finegrained, but it's not possible in this case. Other drivers are likely
> attackable.
> 
> - Driver filtering is disabled (allowing attacks on the drivers) and the
> command line option for forced sharing is set.
> 
> All drivers initialize and can talk to the host through MMIO. Lots of
> unhardened drivers are likely attackable.
> 
> -Andi

All this makes sense but ioremap is such a random place to declare
driver has been audited, and it's baked into the binary with no way for
userspace to set policy.

Again all we will end up with is gradual replacement of all ioremap
calls with ioremap_shared as people discover a given driver does not
work in a VM. How are you going to know driver has actually been
audited? what the quality of the audit was? did the people doing the
auditing understand what they are auditing for?  No way, right?
So IMHO, let it be for now.

-- 
MST

