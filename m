Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6CB41B3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbhI1QXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241803AbhI1QXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632846093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CT7cAxoA6vRZ+WDbcsi5kAoHImq+sp7O0xi0KzKIjyE=;
        b=GtXh4GIv9FjXQQ/NEOUNAN4chnMbXUgn4x2hVGX5R5A0mIZPvwujqrsFsEYufKZ4FYFICK
        5raF2QzHuBsyWuhiFpXGJw/Bt2RLBcz6P3SiK9ZD8eSyCCTzXGuGnEKWXJZauZ1NVawMOd
        a3TAynQkr6L3QYTf2b8q5XDN9qoD1e0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-aIc8y5iPNyyQx1Mad9y3yg-1; Tue, 28 Sep 2021 12:21:32 -0400
X-MC-Unique: aIc8y5iPNyyQx1Mad9y3yg-1
Received: by mail-ed1-f69.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso10519477edj.20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CT7cAxoA6vRZ+WDbcsi5kAoHImq+sp7O0xi0KzKIjyE=;
        b=SKpUr1IvxMARNQGaUqbBulx/b+ntKpOlkq+OK/HiiD1fp/i8DxvxbA29UAEG9DU7yH
         spCFgl/RpVMcN/mBuSE6bhOrAHsxtbjrA3vDhCKJIvSKzc/AfE8nGvloBPmwhnF7jmwC
         DgUw5Vrtb13D5fkYjn4OYRE46v73PsOb9zicOdHd0CLni6sAJ/qd2aajvewJr1ByFAgL
         qV+1YCgdh2HLf57kP+Z8vQEro6n69BJY/Q4cLLr5ZX2jt9T7Za4CHVmHyKBSnjBOX+gh
         QK0ii9jrcWOlsKcVRQ7I2IffoJKnJu6Ug5EwpRR12Td2UYekIwTjBTB4fGPXK5yncOeD
         KK9g==
X-Gm-Message-State: AOAM532Xj7av56LCGtDA+F0/Va15Sy8qXhUfURCt9K0qZQtLqQtF6dth
        g+HUHVLlabCdsph3z8M3X4+uf5QfZqtk43i3xWMEdS9FskdOdascVTaJFKYZVGDd2/UJiSGjCjp
        FJrbjsPo6SdMhJaU7lRgMSUZ2
X-Received: by 2002:a17:906:3f95:: with SMTP id b21mr7341799ejj.368.1632846091160;
        Tue, 28 Sep 2021 09:21:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdsM8oDQGic/i7UI1yJ7VIt9ZM8uL+wSxSmJI2BNADnHEmEIXpgxSTkVXx5xBKZjFqGh+hwA==
X-Received: by 2002:a17:906:3f95:: with SMTP id b21mr7341764ejj.368.1632846090938;
        Tue, 28 Sep 2021 09:21:30 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id la1sm10861450ejc.48.2021.09.28.09.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 09:21:30 -0700 (PDT)
Message-ID: <4a4c7e3d-5823-6b19-3fd8-e4accf53f28f@redhat.com>
Date:   Tue, 28 Sep 2021 18:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH 3/3] nSVM: use svm->nested.save to load vmcb12
 registers and avoid TOC/TOU races
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
 <20210903102039.55422-4-eesposit@redhat.com>
 <21d2bf8c4e3eb3fc5d297fd13300557ec686b625.camel@redhat.com>
 <73b5a5bb-48f2-3a08-c76b-a82b5b69c406@redhat.com>
 <9585f1387b2581d30b74cd163a9aac2adbd37a93.camel@redhat.com>
 <2b1e17416cef1e37f42e9bc8b2283b03d2651cb2.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <2b1e17416cef1e37f42e9bc8b2283b03d2651cb2.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/21 11:12, Maxim Levitsky wrote:
> But actually that you mention it, I'll say why not to create vmcb_control_area_cached
> as well indeed and change the type of svm->nested.save to it. (in a separate patch)

I think you should have two structs, struct vmcb12_control_area_cache 
and struct vmcb12_save_area_cache.  Otherwise the two series that 
Emanuele posted are nice and can be combined into just one.

Paolo

