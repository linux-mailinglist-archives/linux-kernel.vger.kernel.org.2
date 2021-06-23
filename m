Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850843B1915
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFWLmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 07:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230061AbhFWLl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624448382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJel3gfJEP2aIFpIS4J7bMYGEGndk6SG2vHn3PnMyD0=;
        b=LySqkMzqabvT5ruZesmkivk+3ppJt0htWFgd0bQZJCNpyug90ktDTfMEP2qXL6eis+0DRP
        jJW5+zF7jiChhhA+LHccsMexN3Zkwe37VxU/Eu/Jm7O3+KRcrO58cAeykLoWT4CjpOKWM7
        OR6Xn8yyyntgvmAdTnnXINaZKCo6JMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-oSvjkb10NouFD1FeQIIa6Q-1; Wed, 23 Jun 2021 07:39:41 -0400
X-MC-Unique: oSvjkb10NouFD1FeQIIa6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F09F91084F4B;
        Wed, 23 Jun 2021 11:39:39 +0000 (UTC)
Received: from starship (unknown [10.40.192.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 583C25C1CF;
        Wed, 23 Jun 2021 11:39:35 +0000 (UTC)
Message-ID: <2eaa94bcc697fec92d994146f7c69625b6a84cd0.camel@redhat.com>
Subject: Re: [PATCH RFC] KVM: nSVM: Fix L1 state corruption upon return from
 SMM
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Cathy Avery <cavery@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 23 Jun 2021 14:39:34 +0300
In-Reply-To: <a3918bfa-7b4f-c31a-448a-aa22a44d4dfd@redhat.com>
References: <20210623074427.152266-1-vkuznets@redhat.com>
         <a3918bfa-7b4f-c31a-448a-aa22a44d4dfd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-23 at 11:39 +0200, Paolo Bonzini wrote:
> On 23/06/21 09:44, Vitaly Kuznetsov wrote:
> > - RFC: I'm not 100% sure my 'smart' idea to use currently-unused HSAVE area
> > is that smart. Also, we don't even seem to check that L1 set it up upon
> > nested VMRUN so hypervisors which don't do that may remain broken. A very
> > much needed selftest is also missing.
> 
> It's certainly a bit weird, but I guess it counts as smart too.  It 
> needs a few more comments, but I think it's a good solution.
> 
> One could delay the backwards memcpy until vmexit time, but that would 
> require a new flag so it's not worth it for what is a pretty rare and 
> already expensive case.
> 
> Paolo
> 

I wonder what would happen if SMM entry is triggered by L1 (say with ICR),
on a VCPU which is in L2. Such exit should go straight to L1 SMM mode.

I will very very soon, maybe even today start testing SMM with my migration
tests and such. I hope I will find more bugs in this area.

Thanks for fixing this issue!

Best regards,
	Maxim Levitsky

