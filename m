Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4676236B273
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhDZLpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231903AbhDZLpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619437501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=865sj3XQejk5FU8PQVUkGqm7BiqNpbV7oX+eaAy7hAk=;
        b=e3GTmi84/ADZENS8jrktTGxSrN8HexUN7bg2+NSzHnt325mbs5wvBIpGeIxGwZZy9BSYks
        Pay/bALDjlWhc2EuqTCisq5t+RguwPErgk1Bvp3cs/PGTrB7XliB6wntcXJ4BYrSvUetXE
        oR3KnK1fINuRk8JP6wVg08fm/nEvAQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-VguNjZYqM9KRR0IVKdo5iw-1; Mon, 26 Apr 2021 07:44:57 -0400
X-MC-Unique: VguNjZYqM9KRR0IVKdo5iw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7259D343A5;
        Mon, 26 Apr 2021 11:44:55 +0000 (UTC)
Received: from starship (unknown [10.40.192.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86EB660BE5;
        Mon, 26 Apr 2021 11:44:50 +0000 (UTC)
Message-ID: <ace4c4d81ef0ee461ead6d046c3b3d7308dd32ae.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] KVM: VMX: Invoke NMI handler via indirect call
 instead of INTn
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Mon, 26 Apr 2021 14:44:49 +0300
In-Reply-To: <bb2c2d93-8046-017a-5711-c61c8f1a4c09@redhat.com>
References: <20200915191505.10355-1-sean.j.christopherson@intel.com>
         <20200915191505.10355-3-sean.j.christopherson@intel.com>
         <CAJhGHyBOLUeqnwx2X=WToE2oY8Zkqj_y4KZ0hoq-goe+UWcR9g@mail.gmail.com>
         <bb2c2d93-8046-017a-5711-c61c8f1a4c09@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-26 at 12:40 +0200, Paolo Bonzini wrote:
> On 26/04/21 11:33, Lai Jiangshan wrote:
> > When handle_interrupt_nmi_irqoff() is called, we may lose the
> > CPU-hidden-NMI-masked state due to IRET of #DB, #BP or other traps
> > between VMEXIT and handle_interrupt_nmi_irqoff().
> > 
> > But the NMI handler in the Linux kernel*expects*  the CPU-hidden-NMI-masked
> > state is still set in the CPU for no nested NMI intruding into the beginning
> > of the handler.
> > 
> > The original code "int $2" can provide the needed CPU-hidden-NMI-masked
> > when entering #NMI, but I doubt it about this change.
> 
> How would "int $2" block NMIs?  The hidden effect of this change (and I 
> should have reviewed better the effect on the NMI entry code) is that 
> the call will not use the IST anymore.
> 
> However, I'm not sure which of the two situations is better: entering 
> the NMI handler on the IST without setting the hidden NMI-blocked flag 
> could be a recipe for bad things as well.

If I understand this correctly, we can't really set the NMI blocked flag
on Intel, but only keep it from beeing cleared by an iret after it 
was set by the intercepted NMI.

Thus the goal of this patchset was to make sure that we don't
call any interrupt handlers that can do iret before we call the NMI handler

Indeed I don't think that doing int $2 helps, unless I miss something.
We just need to make sure that we call the NMI handler as soon as possible.


If only Intel had the GI flag....


My 0.2 cents.

Best regards,
	Maxim Levitsky
> 
> Paolo
> 


