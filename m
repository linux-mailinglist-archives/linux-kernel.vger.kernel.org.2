Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160B83588CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhDHPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232278AbhDHPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617896706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxZSSFkRc5d+FXT95sETdVHEHpcJTGOg4Cy64wSdBCg=;
        b=O+0pEuybGmy7MntB8RLmyOGFnuOHqTrUC6oGxP2OLlyyiYpl4aCPDBnZFLJF/rDnEjhvib
        pOgpTHPVdH6XOXtrc5/qKa8HFpzyYlE3Odis2Z8yhRFgReg59fs8OYLQYRsaaT9jMJuuNl
        ZDbMRIvLbgUQeiekaYtDoNpEgflj6Jc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-8GFb3RjGMy2a5p4jg5vqiw-1; Thu, 08 Apr 2021 11:45:04 -0400
X-MC-Unique: 8GFb3RjGMy2a5p4jg5vqiw-1
Received: by mail-ed1-f71.google.com with SMTP id l22so1245158edt.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 08:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gxZSSFkRc5d+FXT95sETdVHEHpcJTGOg4Cy64wSdBCg=;
        b=sn80mh+ybvEg4IEbA+saKTM51tVPi0SgcKyFhsIxvv2bcbfg3vIjQRn6yugocnDkPD
         W8BOjSonIz2VQweNxTmLtcQncJ6nGP3s/qyZcWvvAbz7IVDs1n4PvFqs9eVi7oMgnb/Z
         CbXZHZ3e1JjNC2uCmRhQ4NdqUIqIspAnDV4xSBf4ikXASrqaCN2ya8IqlaQh2BQCT00Q
         WLb5zJ/xtPyhG40gAABpa+RcNVav8I58+rooGpW4az0ALMwHDYTnC8Z1/DEmvVS+kt57
         UbHTxBuo5NJiwHhXBh1NviEAsH0LvkMGtSLxPA38suZBVOYas3NMT7ZK6S/kwJFBULNg
         LG9w==
X-Gm-Message-State: AOAM531qW5PgVnCyDBMcUGDXn+y4S8lUdo3EqlITpoFoblcvEwwKMs6C
        B0tGrX1yZoK97za+2As/F2yH0YhXl5mKudF8ld66jFaTeqAFS+Ixs7qb9LF0hLpMk7N3FSXm87d
        KkKDITo/GGUp2ExOv/WS5P1SO
X-Received: by 2002:a17:906:b202:: with SMTP id p2mr11220304ejz.244.1617896702837;
        Thu, 08 Apr 2021 08:45:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc+D6gf0p56QNNNE6U9VVSdrPcb2MRDwMka/llMjsBrOIZnv6LrnroLFwuX/teEEzTlf2qgg==
X-Received: by 2002:a17:906:b202:: with SMTP id p2mr11220273ejz.244.1617896702636;
        Thu, 08 Apr 2021 08:45:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id d1sm14461941eje.26.2021.04.08.08.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:45:02 -0700 (PDT)
Subject: Re: [PATCH 4/7] KVM: SVM: hyper-v: Nested enlightenments in VMCB
To:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
References: <cover.1617804573.git.viremana@linux.microsoft.com>
 <e9de12a81ab31613fb55d5c1308ca0ca050ced4c.1617804573.git.viremana@linux.microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5927967d-c5a2-6df9-9aff-4b92c207df09@redhat.com>
Date:   Thu, 8 Apr 2021 17:44:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <e9de12a81ab31613fb55d5c1308ca0ca050ced4c.1617804573.git.viremana@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/21 16:41, Vineeth Pillai wrote:
> +#define VMCB_ALL_CLEAN_MASK (__CLEAN_MASK | (1U << VMCB_HV_NESTED_ENLIGHTENMENTS))
> +#else
> +#define VMCB_ALL_CLEAN_MASK __CLEAN_MASK
> +#endif

I think this should depend on whether KVM is running on top of Hyper-V; 
not on whether KVM is *compiled* with Hyper-V support.

So you should turn VMCB_ALL_CLEAN_MASK into a __read_mostly variable.

Paolo

>   /* TPR and CR2 are always written before VMRUN */
>   #define VMCB_ALWAYS_DIRTY_MASK	((1U << VMCB_INTR) | (1U << VMCB_CR2))
>   
> @@ -230,7 +251,7 @@ static inline void vmcb_mark_all_dirty(struct vmcb *vmcb)
>   
>   static inline void vmcb_mark_all_clean(struct vmcb *vmcb)
>   {
> -	vmcb->control.clean = ((1 << VMCB_DIRTY_MAX) - 1)
> +	vmcb->control.clean = VMCB_ALL_CLEAN_MASK
>   			       & ~VMCB_ALWAYS_DIRTY_MASK;
>   }

