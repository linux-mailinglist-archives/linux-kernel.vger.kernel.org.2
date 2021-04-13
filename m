Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3F635DE70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbhDMMPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhDMMPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618316117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqf0RiZSoAYfI4s0e2+ZgKSiJco7N8Kba8wSDbcvYCc=;
        b=TMWLLvIIl04hagtpe6OblGypZQSvWNHooOkG3g/GA6Af1MWHl1a5j+0kzosu/DQFbwuJ1p
        GYrh8FYbdjdZpXsN+l+NKpN1gq3keBaiyM/UfHXcYmADLJZDkC1h5iqPxQ2KtqgrIlS2Yi
        9kCUuK73WUyKFOLqz2WLinu9g5OGGGE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-xEyVpG__PiiJ1dbX2iz56g-1; Tue, 13 Apr 2021 08:15:15 -0400
X-MC-Unique: xEyVpG__PiiJ1dbX2iz56g-1
Received: by mail-ed1-f72.google.com with SMTP id y10-20020a50f1ca0000b0290382d654f75eso1151326edl.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aqf0RiZSoAYfI4s0e2+ZgKSiJco7N8Kba8wSDbcvYCc=;
        b=ax4DeR6+CbIMy4SUYZrwc0wmhLXm4q7THSC46gls3+6fNEwRG20/S1UPtIa5qW/1Uz
         +vOEHhvn53arM2QbYFbM7vRSiuH8/zP55GiAoyzArmh/pkNtYC/aW8/PNbtQM6lC9G9g
         UhK3ZIsfAtA9FfeIZmVbJ23L0nEBWN+qcRJt2UFPiZwmwSpiivp2vi99PK3e5WgE1Pnl
         pEraKU8VWb9l2BWWApaTckwa3BFQfUOBZda/n2gtkkTEFgB1giIZaX2J9pPKRFYgjArh
         6+pm0SMeRVl0r51v5/okFx84sn8rRQx6X3EEmSyeTIraRnTP/BpFrIoZC6b5aFWTRb1O
         iTwA==
X-Gm-Message-State: AOAM5315sDjlbTNVWICTHj02jnoTKsi0GiBv4HFNirZFvGXXFZOt0DeQ
        2I50qPZCf3u3DrjhFyuXpH/lAK1X51hDEyb7fsSl3mbl1mQsSGgYNb/QbMm7O9RnMa7Ze2Scawl
        Y3LjMahB9F6Wa1rxv0fF+J4Km
X-Received: by 2002:a17:906:3549:: with SMTP id s9mr9309560eja.327.1618316114727;
        Tue, 13 Apr 2021 05:15:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye3ZXpM2j4/xA1ZsYOu2bEOUbV5nlWPoAJCBVywHcjFdlmDPmkeyBoZhrkjlFGbk70xZ8uSA==
X-Received: by 2002:a17:906:3549:: with SMTP id s9mr9309548eja.327.1618316114534;
        Tue, 13 Apr 2021 05:15:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j6sm9057849edw.73.2021.04.13.05.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 05:15:13 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86: Fix split-irqchip vs interrupt injection
 window request
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Filippo Sironi <sironi@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "v4.7+" <stable@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20201127112114.3219360-1-pbonzini@redhat.com>
 <20201127112114.3219360-3-pbonzini@redhat.com>
 <CAJhGHyCdqgtvK98_KieG-8MUfg1Jghd+H99q+FkgL0ZuqnvuAw@mail.gmail.com>
 <YHS/BxMiO6I1VOEY@google.com>
 <CAJhGHyAcnwkCfTcnxXcgAHnF=wPbH2EDp7H+e74ce+oNOWJ=_Q@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80b013dc-0078-76f4-1299-3cff261ef7d8@redhat.com>
Date:   Tue, 13 Apr 2021 14:15:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJhGHyAcnwkCfTcnxXcgAHnF=wPbH2EDp7H+e74ce+oNOWJ=_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/21 13:03, Lai Jiangshan wrote:
> This patch claims that it has a place to
> stash the IRQ when EFLAGS.IF=0, but inject_pending_event() seams to ignore
> EFLAGS.IF and queues the IRQ to the guest directly in the first branch
> of using "kvm_x86_ops.set_irq(vcpu)".

This is only true for pure-userspace irqchip.  For split-irqchip, in 
which case the "place to stash" the interrupt is 
vcpu->arch.pending_external_vector.

For pure-userspace irqchip, KVM_INTERRUPT only cares about being able to 
stash the interrupt in vcpu->arch.interrupt.injected.  It is indeed 
wrong for userspace to call KVM_INTERRUPT if the vCPU is not ready for 
interrupt injection, but KVM_INTERRUPT does not return an error.

Ignoring the fact that this would be incorrect use of the API, are you 
saying that the incorrect injection was not possible before this patch?

Paolo

