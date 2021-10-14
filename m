Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DBD42D2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhJNGwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhJNGwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634194244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQ3c2nRaHzol1pqD1n/jXxR8f1O3T1lWBUtq6eTvBtQ=;
        b=O0e9Nqu2oxOQvHQJd3StaGD8zGg0RIkuibI1sqcU+wPsEmWzZ+V8R2NKwPJZGnb7UEkuh9
        lV59FaG3wnfAQb61qvg8et1UGsOvEHbvZcEH0+Vrcd/5Vm/I3/5U9UEXZeOAjFxTHLnnUx
        KuKGm/XJTbbkNJcvNJE13YDbKSkAefw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-cEK2M5K0PhKYXOaoR0GK6w-1; Thu, 14 Oct 2021 02:50:43 -0400
X-MC-Unique: cEK2M5K0PhKYXOaoR0GK6w-1
Received: by mail-wr1-f69.google.com with SMTP id h99-20020adf906c000000b001644add8925so601814wrh.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AQ3c2nRaHzol1pqD1n/jXxR8f1O3T1lWBUtq6eTvBtQ=;
        b=0SctEZ2ERK/p0JsSpNY3cXujMuWI5zWgEO/PP/mJfY86eXi7Wj6f7FFUMV13LxWPTc
         ZBVGZzSdU4QCuqnYLSo2gdczm5/1eVV4bI3lLd+ODywos3DDPIaUTVP7xF0z/9/oiWKD
         63x08IOPb13PeuZx75KtTbUVAPJTXntCbj4Rm7xDLh1LMm/L29scECFdrGniQQu8auoH
         mv/YE9+Rr0kEAj2zbVJE+q/Coojtb4u06ht59jZRk3LPw01iJAxr4DyVlLhUn4W+Mkhz
         UD6YK5yWAKqpZcQ9u5ALCWygR5mGhAqXECi5sPeTzI0sF+JYwsM+ktPcXuglhZ85dusG
         nKKg==
X-Gm-Message-State: AOAM530IxPGHHosw0Y9BIawg7ikDs6p6F6JbqeDAQ7WzL3ci69egI99D
        vQAuFCCSkeOt33fMPXWzfvzsAYSPdX0WQgiGXvlSvj6jEQCgQjRx/XBzOV+/+3Ept3gMMriO00i
        XiSjX9yY60wPuZfUiOro21zyG
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr3927827wmh.86.1634194241848;
        Wed, 13 Oct 2021 23:50:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX0mzzxZHETZ2P3FudpW7b4TG21nRN851KzYr/eDS3Qk/lSy8yyDArVf+qhucx2Tf49XkxKg==
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr3927797wmh.86.1634194241503;
        Wed, 13 Oct 2021 23:50:41 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id t21sm1298234wmi.19.2021.10.13.23.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 23:50:40 -0700 (PDT)
Message-ID: <ec9c761d-4b5c-71e2-c1fc-d256b6b78c04@redhat.com>
Date:   Thu, 14 Oct 2021 08:50:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [patch 13/31] x86/fpu: Move KVMs FPU swapping to FPU core
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Jing Liu <jing2.liu@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <871r4p9fyh.ffs@tglx>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <871r4p9fyh.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/21 16:06, Thomas Gleixner wrote:
>> - the guest value stored in vcpu->arch.
>>
>> - the "QEMU" value attached to host_fpu.  This one only becomes zero if
>> QEMU requires AMX (which shouldn't happen).
> 
> I don't think that makes sense.
> 
> First of all, if QEMU wants to expose AMX to guests, then it has to ask
> for permission to do so as any other user space process. We're not going
> to make that special just because.

Hmm, I would have preferred if there was no need to enable AMX for the 
QEMU FPU.  But you're saying that guest_fpu needs to swap out to 
current->thread.fpu if the guest is preempted, which would require 
XFD=0; and affect QEMU operation as well.

In principle I don't like it very much; it would be nicer to say "you 
enable it for QEMU itself via arch_prctl(ARCH_SET_STATE_ENABLE), and for 
the guests via ioctl(KVM_SET_CPUID2)".  But I can see why you want to 
keep things simple, so it's not a strong objection at all.

> Anything else will just create more problems than it solves. Especially
> #NM handling (think nested guest) and the XFD_ERR additive behaviour
> will be a nasty playground and easy to get wrong.
> 
> Not having that at all makes life way simpler, right?

It is simpler indeed, and it makes sense to start simple.  I am not sure 
if it will hold, but I agree it's better for the first implementation.

Paolo

