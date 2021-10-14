Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1196C42D943
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhJNM2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230339AbhJNM2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634214395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nw9W7HyIzCeo5RrN6lM9UA8wdwwigGUEHJS6J9krvP0=;
        b=HvnSl+15guxjH+8liuUDVkR6kl6RAcxGlUHj+iiHvlUJrcT9WxrViZcWU3cmqSckEN+zPi
        WU2r8WHdUFvSprk5UCcUewH7K8/lW7QZV8z/geV5NundF9BxPb3BJBVqnIkTdIFMpQabVw
        RQaIY3LrN/EdN9oRQh43byz+bSrMIfA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-xLjMFVVyOCOOmHn-UiICOQ-1; Thu, 14 Oct 2021 08:26:34 -0400
X-MC-Unique: xLjMFVVyOCOOmHn-UiICOQ-1
Received: by mail-ed1-f69.google.com with SMTP id l10-20020a056402230a00b003db6977b694so4961873eda.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Nw9W7HyIzCeo5RrN6lM9UA8wdwwigGUEHJS6J9krvP0=;
        b=hNZHJS+aTi/TuvCvz1WQrvJo/esB12inChdFbtgHyw/DQkmoKH39OrNq6YxpJ792kI
         w8dGO4wnvklUy0fJnw3MTO1GUEF4KWTq1y7UT184qLVNP8sfaAO1fKcUeftEWlCVNtj8
         aAVyu9c3udF6PVzYJ2CEotjqdbb6kTOBIwBOAdIxWIZRn4a3rRFX6pnP+M8KBUrSOrno
         Wtd5FIIP/ot5Xr5JKutqlas8+kIu/tkgVi7TsJlGGKH8P28J7/8OH+Oq8Fd71t+uTgqB
         +S6XEYPe5o17yHv18PCoq+V8G9r370+VDBBw/01QBgwa31IK6jSS2L8cdUY+M6T46YZj
         ckVw==
X-Gm-Message-State: AOAM5327TM8XJabjVGeNiK1i/r7DNEB6BGgb++dQqKRYJ80SS50s+PIV
        zrYE7xva6T6h+5g8B6faC+y9EbCqyJ2xnzEPrgWtRHGJzsUtvW+jZQ1b5SSCF+Zs6Mu2fJgNF3n
        /+Ltx0723fxzsvE6yh8tInzlf
X-Received: by 2002:a17:906:c041:: with SMTP id bm1mr3477320ejb.280.1634214393532;
        Thu, 14 Oct 2021 05:26:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTB0hQgUCoVigLcm7gDa+Nn2NZNaSf2eIC82HTFKDicUQIlwso41JQ/erZLteLVzwc2ywzrg==
X-Received: by 2002:a17:906:c041:: with SMTP id bm1mr3477290ejb.280.1634214393348;
        Thu, 14 Oct 2021 05:26:33 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o12sm2087672edw.84.2021.10.14.05.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 05:26:32 -0700 (PDT)
Message-ID: <0a5aa9d3-e0d4-266e-5e25-021a5ea9c611@redhat.com>
Date:   Thu, 14 Oct 2021 14:26:31 +0200
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
 <ec9c761d-4b5c-71e2-c1fc-d256b6b78c04@redhat.com> <875ytz7q2u.ffs@tglx>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <875ytz7q2u.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/21 14:23, Thomas Gleixner wrote:
>> In principle I don't like it very much; it would be nicer to say "you
>> enable it for QEMU itself via arch_prctl(ARCH_SET_STATE_ENABLE), and for
>> the guests via ioctl(KVM_SET_CPUID2)".  But I can see why you want to
>> keep things simple, so it's not a strong objection at all.
> Errm.
> 
>     qemu()
>       read_config()
>       if (dynamic_features_passthrough())
> 	request_permission(feature)             <- prctl(ARCH_SET_STATE_ENABLE)
> 
>       create_vcpu_threads()
>         ....
> 
>         vcpu_thread()
> 	 kvm_ioctl(ENABLE_DYN_FEATURE, feature) <- KVM ioctl
> 
> That's what I lined out, right?
> 

I meant prctl for QEMU-in-user-mode vs. ioctl QEMU-in-guest-mode (i.e. 
no prctl if only the guest uses it).  But anyway it's just abstract 
"beauty", let's stick to simple. :)

Paolo

