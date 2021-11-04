Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579CD445A0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhKDS4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232213AbhKDS4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636052045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=22J3dROcP4pdoIo55IV+Bohwv+Qqq74wXg4G/xH4xsM=;
        b=PAd2S4nmRnF5A95GtyDlJC5NHDH0tirFpgPMYfHwRVs0ocY/p97O0nCPC8BtzCA7DbgO8V
        1KZ9gQxSvzxTQzcmFXeALDgv3KyFiWvh+iKmbf+FwfWWi9vz34qlRKyPygY30ltTpPsqiJ
        5U+sYp0/hoelxGaDhBaj/cY0AqcVdBs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-BG3gz3lqMyq5CbqhEPU3Xg-1; Thu, 04 Nov 2021 14:54:04 -0400
X-MC-Unique: BG3gz3lqMyq5CbqhEPU3Xg-1
Received: by mail-ed1-f72.google.com with SMTP id q6-20020a056402518600b003e28d92bb85so6614795edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 11:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=22J3dROcP4pdoIo55IV+Bohwv+Qqq74wXg4G/xH4xsM=;
        b=S6R3Vik0pFX9oSfYvhM5ZK91nt+cBRT8NaY95XeVqGcuD5MYetA3ZKr/VsyGWLgbSq
         TvR2ZZPrq2O8WP5JPFSgJySPV59UMLEWvtFqK57SvKNzZ8csLqDr85MYvy+gYbtqzg/r
         GjulcZAn122HPINB0KUSyWcZMYCKcREY7qcKVtwsSbaMw1I3Y3mKz/eY8Tf7jye3yhjZ
         xrr6v7OxyzHTNAwman3e2gOkZzgzwepf8QhkERRWCQVfAWusTDyxjpRXlpvPQ2DRMkfD
         nwapv5X2/2pqGaG19g53Gg6KfkeflckuAHrKkbWG6Fc/BGKESCMgMY5aftPtUXHeHVFZ
         pu7A==
X-Gm-Message-State: AOAM5331NBzwauQymCRJC7Ru7ibSs+hSSfehTkWklG3MbXuUec9MLosR
        h7dWDZ5xsbnHree1u86cKtvudKBHw29wfm/KSMsvl74jJCwFDToWVpzemCHHJ8cD94KBO4Lsl0e
        Lxs51WExitOBITwN8iy0w00gh
X-Received: by 2002:a17:907:3fa3:: with SMTP id hr35mr6520208ejc.397.1636052042828;
        Thu, 04 Nov 2021 11:54:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX9KjtknYtlGRxikeEHUxc2ZJyoYXGJtVCvrmWLPvlXeioeLNT9HVxebE6Be6WkneAjHUSuQ==
X-Received: by 2002:a17:907:3fa3:: with SMTP id hr35mr6520185ejc.397.1636052042622;
        Thu, 04 Nov 2021 11:54:02 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id m14sm3342408edv.9.2021.11.04.11.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 11:54:02 -0700 (PDT)
Message-ID: <651be744-3d47-2486-0ada-099bd43e536e@redhat.com>
Date:   Thu, 4 Nov 2021 19:50:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC][PATCH 15/22] x86,vmx: Remove .fixup usage
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        mbenes@suse.cz
References: <20211104164729.226550532@infradead.org>
 <20211104165525.408049586@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211104165525.408049586@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/21 17:47, Peter Zijlstra wrote:
> In the vmread exceptin path, use the, thus far, unused output register
> to push the @fault argument onto the stack. This, in turn, enables the
> exception handler to not do pushes and only modify that register when
> an exception does occur.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/kvm/vmx/vmx_ops.h |   14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> --- a/arch/x86/kvm/vmx/vmx_ops.h
> +++ b/arch/x86/kvm/vmx/vmx_ops.h
> @@ -80,9 +80,11 @@ static __always_inline unsigned long __v
>   		      * @field, and bounce through the trampoline to preserve
>   		      * volatile registers.
>   		      */
> -		     "push $0\n\t"
> +		     "xorl %k1, %k1\n\t"
> +		     "2:\n\t"
> +		     "push %1\n\t"
>   		     "push %2\n\t"
> -		     "2:call vmread_error_trampoline\n\t"
> +		     "call vmread_error_trampoline\n\t"
>   
>   		     /*
>   		      * Unwind the stack.  Note, the trampoline zeros out the
> @@ -93,12 +95,8 @@ static __always_inline unsigned long __v
>   		     "3:\n\t"
>   
>   		     /* VMREAD faulted.  As above, except push '1' for @fault. */
> -		     ".pushsection .fixup, \"ax\"\n\t"
> -		     "4: push $1\n\t"
> -		     "push %2\n\t"
> -		     "jmp 2b\n\t"
> -		     ".popsection\n\t"
> -		     _ASM_EXTABLE(1b, 4b)
> +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %1)
> +
>   		     : ASM_CALL_CONSTRAINT, "=r"(value) : "r"(field) : "cc");
>   	return value;
>   }
> 
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

