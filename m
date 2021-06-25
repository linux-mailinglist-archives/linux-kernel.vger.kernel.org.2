Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C733B419D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhFYK2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230461AbhFYK2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624616750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fG0be8Kc2dwTF6j8KtChCzsOlmu137hmqe59tyGCHkE=;
        b=P0tELQllzabz6XY2FG0nPf8smHAEZ5pJVdARUVkFYKNZwUsPKFmJjwnGTwr/Jl29c6iv04
        pfGSlig1ANmLNTYI7IrqhMWF/UDXIhhf0nbZehqCwLPlEDpt+KTKfj0IJAZHTNA9tlT949
        3nlJXP51b9aPvfn+NF1fw44VYMvBeF4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-OPRCZ2o2OgGn2Sul4g4odw-1; Fri, 25 Jun 2021 06:25:48 -0400
X-MC-Unique: OPRCZ2o2OgGn2Sul4g4odw-1
Received: by mail-ej1-f70.google.com with SMTP id mh17-20020a170906eb91b0290477da799023so2960123ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fG0be8Kc2dwTF6j8KtChCzsOlmu137hmqe59tyGCHkE=;
        b=StFQQkC//UAqkN8ev1QRrACdUkEVph8WkDts8DEQkilgxfU9DxljQ52q3/rmRadrPy
         T2uswYmRe7Jzq3YMp3GAbcYjCmh2HNhS3GhH/NZbELZgp5j1gQSruaUvry9LaW80+NDA
         Dq4Gp1yQrQGGGKhNWM6ksyKg0K298swzpi5FfxlrQSOer0nzHkzH1EAyLo+1u9d+XxIx
         JxnSS8rOw8zo5Bgg3EJA0sqgRHvvPOYqWVdMzGE++4jiPBXx8EXYSyhbAl4wOHyD0t9i
         tlO1env6OR3ffXcsC+b1TsuOaQH0RC84ENN3iKvz15OQnmHVS9+5y+ATMGTDjYsE57hm
         Kx9w==
X-Gm-Message-State: AOAM532R8ueCYQevmPpUFMlM+l/3yCqL+m8RayZFHh8ov7Igu6fRHI8w
        udlmzT2afVqrQpklakbot4iesbDsDnxjihcK2KjlDR/SO3MhJkDADm9Oe8WQqUjxHEXipxqgxw9
        RzFVI2EqUbmI92i/cdpr70Zf6
X-Received: by 2002:a17:906:60d3:: with SMTP id f19mr10301203ejk.413.1624616747784;
        Fri, 25 Jun 2021 03:25:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWbFg9dFBgEY7PpCIE0Ayv1y0K1VX63+CfNjzZnkmZBL77UmQqvCJ5vh1nGchYaKorPdoArg==
X-Received: by 2002:a17:906:60d3:: with SMTP id f19mr10301190ejk.413.1624616747644;
        Fri, 25 Jun 2021 03:25:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j19sm3631248edw.43.2021.06.25.03.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 03:25:47 -0700 (PDT)
Subject: Re: [PATCH 05/54] Revert "KVM: x86/mmu: Drop
 kvm_mmu_extended_role.cr4_la57 hack"
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-6-seanjc@google.com>
 <20210625084644.ort4oojvd27oy4ca@linux.intel.com>
 <09a49caf-6ff5-295b-d1ab-023549f6a23b@redhat.com>
 <20210625092902.o4kqx67zvvbudggh@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <885018ab-206b-35c7-a75a-e4fccb663fc3@redhat.com>
Date:   Fri, 25 Jun 2021 12:25:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210625092902.o4kqx67zvvbudggh@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/21 11:29, Yu Zhang wrote:
> Thanks, Paolo.
> 
> Do you mean the L1 can modify its paging mode by setting HOST_CR3 as root of
> a PML5 table in VMCS12 and HOST_CR4 with LA57 flipped in VMCS12, causing the
> GUEST_CR3/4 being changed in VMCS01, and eventually updating the CR3/4 when
> L0 is injecting a VM Exit from L2?

Yes, you can even do that without a "full" vmentry by setting invalid 
guest state in vmcs12. :)

Paolo

