Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED02E3588D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhDHPrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231655AbhDHPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617896842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTgmH756AhLxTUX70sV9sEtjSkUIHcT5ErPkRW1CdPU=;
        b=AaMqvcMvBbkaa9XRhfXlIpZngR4u7eqhCtcfVz/86XvAgSAhQX6/77ViApxroSpjd2Wl5J
        Eri4pThvmbVYG1d6/+Nn/d9X6CrurgVGJuAHybRILyn9/IUFDFmEXh5pxjdAYqHLWfNu1Y
        C8mjBJ0FCiPx8GmUkvrV8/ZM3cykjNY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-XD94bC32NLq6ejZB1B9Aww-1; Thu, 08 Apr 2021 11:47:19 -0400
X-MC-Unique: XD94bC32NLq6ejZB1B9Aww-1
Received: by mail-ed1-f72.google.com with SMTP id c6so1242404edf.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 08:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YTgmH756AhLxTUX70sV9sEtjSkUIHcT5ErPkRW1CdPU=;
        b=dGp4SY0s36FYFDqVcCOI+svU2hbwhGAxyqhutoKEAIRYwDU6VAq7dWf5ero/zcjaTg
         yNbs7kh1D5tRF6dANSldi416h6rP/hefgbvZrivNY7Nr54Q+Es4ZUDzF58WPyPylkUay
         MEsWCdnovyXU7aiYiL7BeqmwLXC3TXWVROt15oi32BToyP0CljAVuKrbZ545zQTWJ97t
         PEFiKIL9no1BJEP2f7qmE/plVLAbTC5LoZ4VaqIj5DrSHxS54ZXouVF27/scHe1azvzx
         YIPaH918sjLMV4i0M2cYTVkTdM9S+aBFkk70OTsF3sZNtWSrBmzXG+c64o7l6l4Aq/pS
         7nCQ==
X-Gm-Message-State: AOAM531mrPJPI67s/I7apVYavHuCGZD8cdGexO3W25Kh5gUvETMhtVus
        cSrqP3pb7VyaBvVZdrYum7H9w3Y1E0QpMZ6/pprxfhpjDhxh3jrl36WFZVZ7Ctfs1Z8+JcSsAJY
        KjpWEDj0ngNDgcy+NtW01HazH
X-Received: by 2002:a17:906:7e53:: with SMTP id z19mr2999612ejr.422.1617896838114;
        Thu, 08 Apr 2021 08:47:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKGb2aWaaqbI0/Ib/6Q0YDqGF8YzM0XjfD52Zv6Hen9YRdCmYCPhA95jv92MLfrWIXCkYaAw==
X-Received: by 2002:a17:906:7e53:: with SMTP id z19mr2999580ejr.422.1617896837965;
        Thu, 08 Apr 2021 08:47:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id r19sm14422213ejr.55.2021.04.08.08.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:47:17 -0700 (PDT)
Subject: Re: [PATCH 6/7] KVM: SVM: hyper-v: Enlightened MSR-Bitmap support
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
 <5cf935068a9539146e033276b6d9a6c9b1e42119.1617804573.git.viremana@linux.microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58df22aa-5d2c-f99f-6dfb-9a8b4260dc21@redhat.com>
Date:   Thu, 8 Apr 2021 17:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <5cf935068a9539146e033276b6d9a6c9b1e42119.1617804573.git.viremana@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/21 16:41, Vineeth Pillai wrote:
>   
> +#if IS_ENABLED(CONFIG_HYPERV)
> +static inline void hv_vmcb_dirty_nested_enlightenments(struct kvm_vcpu *vcpu)
> +{
> +	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
> +
> +	/*
> +	 * vmcb can be NULL if called during early vcpu init.
> +	 * And its okay not to mark vmcb dirty during vcpu init
> +	 * as we mark it dirty unconditionally towards end of vcpu
> +	 * init phase.
> +	 */
> +	if (vmcb && vmcb_is_clean(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS) &&
> +	    vmcb->hv_enlightenments.hv_enlightenments_control.msr_bitmap)
> +		vmcb_mark_dirty(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS);
> +}

In addition to what Vitaly said, can svm->vmcb really be NULL?  If so it 
might be better to reorder initializations and skip the NULL check.

Paolo

