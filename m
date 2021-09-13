Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A14409EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbhIMUzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244428AbhIMUzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631566456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hlpZvCk21PRwAK2AssPWCacRS5dlgslqLeUme/k+iMw=;
        b=H5JxGe5OArwC+am0XfDj6N1MhPEX3j5vgkyObmX35eK1dUvEVqpLzvPAWlpdrk/X7hin3p
        jp7VNtX386HgdB69vd+m8W00VGTrSOdBKPlP024iDHkP6/1HNq6hckNr8oef0GxojdiCBj
        OVPaXgnWmKI8sXb4VveITz5uLK/jZPw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-PLhFaAltNGiBiegZEPOs1w-1; Mon, 13 Sep 2021 16:54:15 -0400
X-MC-Unique: PLhFaAltNGiBiegZEPOs1w-1
Received: by mail-wr1-f69.google.com with SMTP id r15-20020adfce8f000000b0015df1098ccbso1855296wrn.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hlpZvCk21PRwAK2AssPWCacRS5dlgslqLeUme/k+iMw=;
        b=xn/we5xcHuDKHlwMPTG4JsI0YuuDgoYL7lSzJnwPPzIsLNUxXXA28KpxOh6j/v1/nN
         67tBoFxlsDmKqLclAcFX4cqSbqxWRMk2nEbbIZ99PUMBcHdfnIgxnciD9VYsazRP11Th
         83kUZu+aoh0fMWafGoP8l5IN0A1WH9u/daU9t9vPe9OkNUShZK1rc9ibP0uW8Y3Ib5vo
         8I1mb9byu9aAv87PWettr3uNlUF7D5clHf8CiTDU+/+OtdQng7nj9UcrMJYPnYnZO1/q
         qA4bjveQNKgInQs3k/FXwdNjMtf+PiTW0y8IlJg0V43yB8dx4W6eUznghyx4Re5hjre9
         ZnKw==
X-Gm-Message-State: AOAM532qwN9WXDrhAs6UfPSXXDfzFfyl91sGJ0HNtfgimU+JzZJTBMie
        rAagc5b1sZa9AxClVFXsSX3blk6kPkse1iJMYDtL3p1rKU01Zk0nnMI8gx7XCGm5Lc6tb/y3XfJ
        Kn6PAdCMcH8VNujEvZ+/p+2CJ
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr14416343wrw.311.1631566453986;
        Mon, 13 Sep 2021 13:54:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMajhI/hXKe/GPHfRteHnAZwNKo0kHbqRkuPGx3w3DgULJMMHKTbVpiprC8l4Y+VQZSXapTQ==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr14416326wrw.311.1631566453828;
        Mon, 13 Sep 2021 13:54:13 -0700 (PDT)
Received: from redhat.com ([2.55.151.134])
        by smtp.gmail.com with ESMTPSA id w1sm7747752wmc.19.2021.09.13.13.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 13:54:13 -0700 (PDT)
Date:   Mon, 13 Sep 2021 16:54:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        pbonzini <pbonzini@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
Message-ID: <20210913164934-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org>
 <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
 <20210913022257-mutt-send-email-mst@kernel.org>
 <CACGkMEsWJq0SMMfTBdoOxVa1_=k9nZkrRu2wYZo7WO-01p_sgQ@mail.gmail.com>
 <20210913023626-mutt-send-email-mst@kernel.org>
 <20210913024153-mutt-send-email-mst@kernel.org>
 <CACGkMEu+HPBTV81EHOc6zWP7tTgTf4nDaXViUeejmT-Bhp0PEA@mail.gmail.com>
 <87bl4wfeq1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl4wfeq1.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 09:38:30PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 15:07, Jason Wang wrote:
> > On Mon, Sep 13, 2021 at 2:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > But doen't "irq is disabled" basically mean "we told the hypervisor
> >> > to disable the irq"?  What extractly prevents hypervisor from
> >> > sending the irq even if guest thinks it disabled it?
> >>
> >> More generally, can't we for example blow away the
> >> indir_desc array that we use to keep the ctx pointers?
> >> Won't that be enough?
> >
> > I'm not sure how it is related to the indirect descriptor but an
> > example is that all the current driver will assume:
> >
> > 1) the interrupt won't be raised before virtio_device_ready()
> > 2) the interrupt won't be raised after reset()
> 
> If that assumption exists, then you better keep the interrupt line
> disabled until virtio_device_ready() has completed

started not completed. device is allowed to send
config interrupts right after DRIVER_OK status is set by
virtio_device_ready.

> and disable it again
> before reset() is invoked. That's a question of general robustness and
> not really a question of trusted hypervisors and encrypted guests.

We can do this for some MSIX interrupts, sure. Not for shared interrupts though.

> >> > > > > > > +void vp_disable_vectors(struct virtio_device *vdev)
> >> > > > > > >  {
> >> > > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >> > > > > > >       int i;
> >> > > > > > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> >> > > > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> 
> Don't you want the same change for non-MSI interrupts?


We can't disable them - these are shared.

> Thanks,
> 
>         tglx

