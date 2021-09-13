Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68675409FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 00:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244035AbhIMWc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 18:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbhIMWcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 18:32:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6862C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:31:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631572296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1Gt1t46cZyolnAF2U9fuqPB0Ne6SIX1s2ezNwbfHgs=;
        b=wKie1t1eD3ila7O0i8AUxj36N5RSBI6WglFMsuzNN/1rBn4kT9BjLIPCHa4cnYCZzyDTzc
        bA/xegx7oDxXBbpM+k/p9a/760NfwhdlaPq14FM3R5AJ4/7dq8D4E3qpg5NOGt0YRBMDZD
        eC8P1sdNbYnIC1QISKdrsHl0SLFyVo5eFDYQCVz3NsZEGlmyPMjZeh+0k+1MwW7JZij+uN
        hcutTWWVbfQvVwyNgYMtJ8tMfCAlKIYgcgWA2o6gLtHRyhX2lbepjXu5VJKQqjH+NPVdKI
        kzFKr1KCKk51+sEwczRUgJxI1AGltx8F1JWlYU46VHZqk/HQcACHgB96RfD9gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631572296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1Gt1t46cZyolnAF2U9fuqPB0Ne6SIX1s2ezNwbfHgs=;
        b=0obimbJa7vbavMCTYbEOPY1I/1sUAJ075567RRz5J7y2xj3pNhae/5S//pPfzjdbcjapom
        qQcUvAbVK0VSdJDA==
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
In-Reply-To: <20210913164934-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org>
 <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
 <20210913022257-mutt-send-email-mst@kernel.org>
 <CACGkMEsWJq0SMMfTBdoOxVa1_=k9nZkrRu2wYZo7WO-01p_sgQ@mail.gmail.com>
 <20210913023626-mutt-send-email-mst@kernel.org>
 <20210913024153-mutt-send-email-mst@kernel.org>
 <CACGkMEu+HPBTV81EHOc6zWP7tTgTf4nDaXViUeejmT-Bhp0PEA@mail.gmail.com>
 <87bl4wfeq1.ffs@tglx> <20210913164934-mutt-send-email-mst@kernel.org>
Date:   Tue, 14 Sep 2021 00:31:36 +0200
Message-ID: <87sfy8ds53.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13 2021 at 16:54, Michael S. Tsirkin wrote:

> On Mon, Sep 13, 2021 at 09:38:30PM +0200, Thomas Gleixner wrote:
>> On Mon, Sep 13 2021 at 15:07, Jason Wang wrote:
>> > On Mon, Sep 13, 2021 at 2:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > But doen't "irq is disabled" basically mean "we told the hypervisor
>> >> > to disable the irq"?  What extractly prevents hypervisor from
>> >> > sending the irq even if guest thinks it disabled it?
>> >>
>> >> More generally, can't we for example blow away the
>> >> indir_desc array that we use to keep the ctx pointers?
>> >> Won't that be enough?
>> >
>> > I'm not sure how it is related to the indirect descriptor but an
>> > example is that all the current driver will assume:
>> >
>> > 1) the interrupt won't be raised before virtio_device_ready()
>> > 2) the interrupt won't be raised after reset()
>> 
>> If that assumption exists, then you better keep the interrupt line
>> disabled until virtio_device_ready() has completed
>
> started not completed. device is allowed to send
> config interrupts right after DRIVER_OK status is set by
> virtio_device_ready.

Whatever:

 * Define the exact point from which on the driver is able to handle the
   interrupt and put the enable after that point

 * Define the exact point from which on the driver is unable to handle
   the interrupt and put the disable before that point

The above is blury.

>> and disable it again
>> before reset() is invoked. That's a question of general robustness and
>> not really a question of trusted hypervisors and encrypted guests.
>
> We can do this for some MSIX interrupts, sure. Not for shared interrupts though.

See my reply to the next patch. The problem is the same:

 * Define the exact point from which on the driver is able to handle the
   interrupt and allow the handler to proceed after that point

 * Define the exact point from which on the driver is unable to handle
   the interrupt and ensure that the handler denies to proceed before
   that point

Same story just a different mechanism.

Thanks,

        tglx
