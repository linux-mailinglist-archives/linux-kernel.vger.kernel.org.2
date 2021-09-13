Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4FC409D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242085AbhIMTjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbhIMTjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:39:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA87DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:38:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631561911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SNljKPD0Xskmz5pElU9tRhA+/eVrlrzmSfYWjyc0pwQ=;
        b=Lz1rdiVRdsnnIyZTt9O+PdsZkBcUkriRCVvIxzoSwUtP9AB2zCB7wQXlSkaVmzyDa+efCP
        97t3aMTfIUSBC7VBmRsp4QJTwzZVlb0mCyhPmsoW9b/WQUdg1PafWop8XM0W5RbaHPm59a
        cy6vFLF1A3DOpN3OXWY0MEwA0oJVy4cqR7mD11os6qQzwVoqdCjvr4aemI+WH2lcUEY3+N
        tHFOoPn1z5s/aiN8Kho5XLlhNETZu5DQsR/V2EnkkoXBNcgN/SLkHgD5WhFCg44Kk9Vku1
        3DDT6heVg1SqMuCAHsAARCZHzaVObvXVGn1Kob2PNC5diFkuXd7PTA9L+O3Nyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631561911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SNljKPD0Xskmz5pElU9tRhA+/eVrlrzmSfYWjyc0pwQ=;
        b=SufMvqF2KSz3fVI4AXwUx2qxp8cvjJJKuP2MMttHEgnS9lz4/mi1ozW/1Ac0UnCZ0bFSGS
        oDsaHyPxIjRIFLBw==
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
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
In-Reply-To: <CACGkMEu+HPBTV81EHOc6zWP7tTgTf4nDaXViUeejmT-Bhp0PEA@mail.gmail.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org>
 <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
 <20210913022257-mutt-send-email-mst@kernel.org>
 <CACGkMEsWJq0SMMfTBdoOxVa1_=k9nZkrRu2wYZo7WO-01p_sgQ@mail.gmail.com>
 <20210913023626-mutt-send-email-mst@kernel.org>
 <20210913024153-mutt-send-email-mst@kernel.org>
 <CACGkMEu+HPBTV81EHOc6zWP7tTgTf4nDaXViUeejmT-Bhp0PEA@mail.gmail.com>
Date:   Mon, 13 Sep 2021 21:38:30 +0200
Message-ID: <87bl4wfeq1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13 2021 at 15:07, Jason Wang wrote:
> On Mon, Sep 13, 2021 at 2:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> > But doen't "irq is disabled" basically mean "we told the hypervisor
>> > to disable the irq"?  What extractly prevents hypervisor from
>> > sending the irq even if guest thinks it disabled it?
>>
>> More generally, can't we for example blow away the
>> indir_desc array that we use to keep the ctx pointers?
>> Won't that be enough?
>
> I'm not sure how it is related to the indirect descriptor but an
> example is that all the current driver will assume:
>
> 1) the interrupt won't be raised before virtio_device_ready()
> 2) the interrupt won't be raised after reset()

If that assumption exists, then you better keep the interrupt line
disabled until virtio_device_ready() has completed and disable it again
before reset() is invoked. That's a question of general robustness and
not really a question of trusted hypervisors and encrypted guests.

>> > > > > > > +void vp_disable_vectors(struct virtio_device *vdev)
>> > > > > > >  {
>> > > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> > > > > > >       int i;
>> > > > > > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>> > > > > > >               synchronize_irq(vp_dev->pci_dev->irq);

Don't you want the same change for non-MSI interrupts?

Thanks,

        tglx
