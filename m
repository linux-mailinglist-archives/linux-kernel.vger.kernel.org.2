Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A87B348445
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbhCXV7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238686AbhCXV7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616623175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFzpylW/Ivr5aQk5H1g6AKbksqO6a0byFVS5ZXBUDgI=;
        b=EeDseClgFOLiBsFO884sYYDYpVsVrftSLPfI6g98me5YgAF2TFDXpjgv7H8OfCt1JOlpEd
        zy5xiik7trHmiJkLQOZvauUAt17E0KGBsgxWP7Xdsd8jA0QK23USjUetiHB6W2UXI1ZQQV
        gZX3WQcItrNBt3lcNhQGdV1aqB0Hcf4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-rqz7zSOHP0a0JiAXKM03XA-1; Wed, 24 Mar 2021 17:59:33 -0400
X-MC-Unique: rqz7zSOHP0a0JiAXKM03XA-1
Received: by mail-wr1-f69.google.com with SMTP id o11so1653277wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sFzpylW/Ivr5aQk5H1g6AKbksqO6a0byFVS5ZXBUDgI=;
        b=kMW8L1YNWbh7nIqHM2WEOuzKG3ATGFMd+jGibe2XrJznGUdwpfopcRZOvGYUMdtFeP
         ROogBURF0gEKT3CC9rOyOEJMAltPY0n2Nrx/axQl4V2bTdtQ6c49b3qFdHpxIlF5IUvp
         6twOb57S+YTumc+kwqG165o9h7JpOJUlTylek7rOhzdmpeK0HAozAd/5v0xlhOFyyUPc
         wjMYxuHh3in7xdjAprWO6I2wUfWNFchr8buH21nrf/XUMlw25Se1E9bP+5S+UoOekVRR
         l8mQUA+zgdvaNpJ0miUWSJq/Y+HneLUzQrW9LrieVNQ8Wm0VTuTGVStIU+8PD0Qpg57X
         aV0g==
X-Gm-Message-State: AOAM532Bpc1Sm0N6N9x7UeC0uDOB0cEe9S7gqE5V0JqmweB9cDukymD9
        i4w4LoH7k3gJIqTZNEW9SZSfr6O0MrI8lbb9GB/seDOBnQcKRS5VjgSzowVTG7jQ8BAaoeV+y3p
        pP5Id5njoiJ2SOh/qQcYFRSSp
X-Received: by 2002:a5d:554b:: with SMTP id g11mr5433801wrw.411.1616623172165;
        Wed, 24 Mar 2021 14:59:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDhLDhqcEk8qPr6PRDCmGSFYoDEToCC8z/2B0+32YuAGUBVFwbT+VHVtEM+Wwt5nFZgpHW4A==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr5433774wrw.411.1616623172001;
        Wed, 24 Mar 2021 14:59:32 -0700 (PDT)
Received: from [192.168.1.124] ([93.56.169.140])
        by smtp.gmail.com with ESMTPSA id c2sm3649441wme.15.2021.03.24.14.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 14:59:31 -0700 (PDT)
Subject: Re: [PATCH v6 00/12] SVM cleanup and INVPCID feature support
To:     Borislav Petkov <bp@alien8.de>, Babu Moger <babu.moger@amd.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Makarand Sonare <makarandsonare@google.com>,
        Sean Christopherson <seanjc@google.com>
References: <78cc2dc7-a2ee-35ac-dd47-8f3f8b62f261@redhat.com>
 <d7c6211b-05d3-ec3f-111a-f69f09201681@amd.com>
 <20210311200755.GE5829@zn.tnic> <20210311203206.GF5829@zn.tnic>
 <2ca37e61-08db-3e47-f2b9-8a7de60757e6@amd.com>
 <20210311214013.GH5829@zn.tnic>
 <d3e9e091-0fc8-1e11-ab99-9c8be086f1dc@amd.com>
 <4a72f780-3797-229e-a938-6dc5b14bec8d@amd.com>
 <20210311235215.GI5829@zn.tnic>
 <ed590709-65c8-ca2f-013f-d2c63d5ee0b7@amd.com>
 <20210324212139.GN5010@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <feabccbb-8e0f-83b0-64a7-b5e1988c4559@redhat.com>
Date:   Wed, 24 Mar 2021 22:59:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210324212139.GN5010@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/21 22:21, Borislav Petkov wrote:
>  	if (kaiser_enabled)
>   		invpcid_flush_one(X86_CR3_PCID_ASID_USER, addr);
> +	else
> +		asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
> +
>   	invpcid_flush_one(X86_CR3_PCID_ASID_KERN, addr);
>   }

I think the kernel ASID flush can also be moved under the "if"?

> and the reason why it does, IMHO, is because on AMD, kaiser_enabled is
> false because AMD is not affected by Meltdown, which means, there's no
> user/kernel pagetables split.
> 
> And that also means, you have global TLB entries which means that if you
> look at that __native_flush_tlb_single() function, it needs to flush
> global TLB entries on CPUs with X86_FEATURE_INVPCID_SINGLE by doing an
> INVLPG in the kaiser_enabled=0 case. Errgo, the above hunk.

Makes sense.

Paolo

