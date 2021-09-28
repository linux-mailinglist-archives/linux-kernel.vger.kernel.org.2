Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10D941B3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbhI1QWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241759AbhI1QWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632846027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9uMJK26P60RAhxwk6AHTnSttWiM8SyG1M4QvAkMsAA=;
        b=Qi+m8VFWk/Ifxf2o+9G/U2ode0QSkmpzlsQ5YCoKzKrFf5PiTayJSPrMRB8S0temgX2BAv
        5mCDVaeSxC8T2Jc5JlShXJOi6WWzuecZzyRpw13eyedgShEVw85X/09bx0Pz3FaTR22u+S
        HltV5+cqYeslp+ewiKhvv9Sq5M6tbf8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-oJECCGQ9P3mo4qnmWvkQFQ-1; Tue, 28 Sep 2021 12:20:26 -0400
X-MC-Unique: oJECCGQ9P3mo4qnmWvkQFQ-1
Received: by mail-ed1-f70.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso22449573edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z9uMJK26P60RAhxwk6AHTnSttWiM8SyG1M4QvAkMsAA=;
        b=ReuUJGfrrnZnm9O1k/sWMF2id3SVu2Uyt3XgUxnClS3A4/+X3M1tPgB7rCjKvPhB1d
         BBtha2xHeKPGej4J6gJ3jalukFllZ5qTfQfL+AVQ6APKzy2u8pndYcvBHAARFMjc9veV
         2GbWt3p54BXYCCq4iWbOAsdJpiDSSKdm55v8CtY64kgaNjRckTSKBa7VYrQQ4khN4ang
         oAtJWLa3ZrPMVWAmyzAywvgKYool0WKHgMTSBq/kUpFzUAq9rpLKNeu8FXlA50djY3D4
         +8dKFVIXMFtrgd30Jba4JjxMi3GyOSXNnK+XS4CrXZS1TJO32+1uOC0ZBKJ2s5T8rzug
         L/4Q==
X-Gm-Message-State: AOAM530eye+518tp+v8+WEXoh/kszNkBTe9najPuzkrhYdRC4+JbHQPP
        q3K/Ew3AN5qXUTUe27QY32xDY2WETdzuuGfz8p2A25q8JHjOf+ltPriL7WzQjY/IZNoF3tZjX1E
        7PW8cJPYW/JJAw+syZBAcySJX
X-Received: by 2002:a17:906:5d6:: with SMTP id t22mr7639881ejt.98.1632846024792;
        Tue, 28 Sep 2021 09:20:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyio9n7XU3Vkcgm5WLJWy0FSGCW2mQFmeonM9ZvIwP7eL35roJUNMyb5wbTQhpjehr95KRmfA==
X-Received: by 2002:a17:906:5d6:: with SMTP id t22mr7639858ejt.98.1632846024607;
        Tue, 28 Sep 2021 09:20:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 21sm10523657ejv.54.2021.09.28.09.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 09:20:24 -0700 (PDT)
Message-ID: <82acae8f-6b27-928f-0c00-1df8fc9d26b8@redhat.com>
Date:   Tue, 28 Sep 2021 18:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH 2/3] nSVM: introduce smv->nested.save to cache save
 area fields
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20210903102039.55422-1-eesposit@redhat.com>
 <20210903102039.55422-3-eesposit@redhat.com>
 <fbb40bb8c12715c0aa9d6a113784f8a21603e2b3.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <fbb40bb8c12715c0aa9d6a113784f8a21603e2b3.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/21 12:39, Maxim Levitsky wrote:
> On Fri, 2021-09-03 at 12:20 +0200, Emanuele Giuseppe Esposito wrote:
>> This is useful in next patch, to avoid having temporary
>> copies of vmcb12 registers and passing them manually.
> 
> This is NOT what I had in mind, but I do like that idea very much,
> IMHO this is much better than what I had in mind!
> 
> The only thing that I would change is that I woudn't reuse 'struct vmcb_save_area'
> for the copy, as this both wastes space (minor issue),
> and introduces a chance of someone later using non copied
> fields from it (can cause a bug later on).
> 
> I would just define a new struct for that (but keep same names
> for readability)
> 
> Maybe something like 'struct vmcb_save_area_cached'?

I agree, I like this too.  However, it needs a comment that this new 
struct is not kept up-to-date, and is only valid until enter_svm_guest_mode.

I might even propose a

#ifdef CONFIG_DEBUG_KERNEL
	memset(&svm->nested.save, 0xaf, sizeof(svm->nested.save));
#endif

but there are no uses of CONFIG_DEBUG_KERNEL in all of Linux so it's 
probably not the way one should use that symbol.  Can anybody think of a 
similar alternative?  Or should the memset simply be unconditional?

Paolo

