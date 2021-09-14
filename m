Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00C340A933
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhINIaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:30:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhINIax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:30:53 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631608175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uHkQ2f03H/PuJHXm8XPlJhTMFmQaWQv3oameKd/9pIM=;
        b=Fj0aHeO69qk/iu1WeOScRO/audTzEodFbNV1WK85R/QJT0mRZdUMh1SxUU7ps0Pg+pBQyr
        E4BJ5vTRFeo5EUPSd5htXSrL8QFHGlpaXZ3U3XICyes1/cp0K90pfF6JckbCE9FUCWTwl5
        AlA/ZfKlDHQ7OKmFUQ8bIC0Cc7jNKc7WlUr1+2KrvTkV4Mk0sh+LQD3ayuQmgSJXOl9w6s
        psPsp59bFHrP+rE2736xe38iF9kL+EpFtGDOaxrqhjC5t71n8bZvrw9hNd/xlwJdoCPq3P
        p5a6CGsUBrceiJRgK7yAWu9ivH76OxFbaOIZkvVjZlLjOuNnQW7tpKnT7esEoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631608175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uHkQ2f03H/PuJHXm8XPlJhTMFmQaWQv3oameKd/9pIM=;
        b=cNiMAtDbpBa10XpUJgI4NVAbvk88gwVvjrYB/S9/ooE1FdRTbPykAQS5QAHOo/8KAhxh1s
        XJcVOXKp4ZcLuHBQ==
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
Date:   Tue, 14 Sep 2021 10:29:35 +0200
Message-ID: <878rzzef0w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13 2021 at 16:54, Michael S. Tsirkin wrote:
> On Mon, Sep 13, 2021 at 09:38:30PM +0200, Thomas Gleixner wrote:
>> and disable it again
>> before reset() is invoked. That's a question of general robustness and
>> not really a question of trusted hypervisors and encrypted guests.
>
> We can do this for some MSIX interrupts, sure. Not for shared interrupts though.

But you have to make sure that the handler does not run before and after
the defined points. And that's even more important for shared because
with shared interrupts the interrupt can be raised at any point in time
via the other devices which share the line.

Thanks,

        tglx
