Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1354E43B6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbhJZQS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237420AbhJZQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635264960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/94dpKR31yI/R9aZdPxsjpdppLby5vZTKSOJ76Tg44s=;
        b=IGqLLT0fHHzjxd03HMEwbJxat19oAlm3bfBt3zE/LVSu3kDXld8x3WBGVz5dmm9xfyc4jJ
        4u2OAFmUTcBR+2WWcf0gCoXM0fIm34qUTMrLElfrui/yHuN8cOMW9wVAZ0xXnVzMWEzOAk
        aYfoU+lTVit6HmO2cxCQshIwxMVRtp4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-3KzT_FZSN8iYNMwGgvukvA-1; Tue, 26 Oct 2021 12:15:50 -0400
X-MC-Unique: 3KzT_FZSN8iYNMwGgvukvA-1
Received: by mail-ed1-f72.google.com with SMTP id t1-20020a056402524100b003dd9a419eb5so1802664edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/94dpKR31yI/R9aZdPxsjpdppLby5vZTKSOJ76Tg44s=;
        b=XHYy30s4A46iornRDqG04Aj/ItAL7cE8SV8+oAFDxcBCbbEaEec8MLkG95sw7uQt8Q
         p0/7FTPGaCdt7j7ckDTB+MeXPdMXi6u7DvHLn630lrCA5/3wKAuEF7pjYtF3+1K9PPPV
         53EepPRfaklfoufbbDt4KRt3gfoZJ3tnTeFChLrJr6sdme7/By3MApdMnz7ploPyjQY5
         hn75IIaKqvih8RDZsmUxtQOhx63eFiNDobgP5EgXITotdI3BCDFT3LAKeawzPdACo4lV
         +5qrZah6DHfR/TsRmPhGfZCRt87+fpNp63UbiDSuPXsjDXtEsCuGhWDp5+vAznKR5NgB
         +LLw==
X-Gm-Message-State: AOAM5315M01dqRzhcfNGSJ03etib/lDP5bMFKu2AIhzZlpC7wuYmZpAP
        6z2vH+HJr9dVE3+EozgLH9RC9Q/mSMVjbXb9nbLQNmSdc78UN8zgWRt2Scww9zWphi9tqUm7Xzc
        pQ051uAGQnrRk71GUzQ8SuF47
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr36710906edb.386.1635264949284;
        Tue, 26 Oct 2021 09:15:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/Op/IQ/h51zFonR56LdJLvwJxHOfDGEtRVYo7H+tD//73s6XTrqA/V82ysouRdIYB88JR5A==
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr36710877edb.386.1635264949031;
        Tue, 26 Oct 2021 09:15:49 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i15sm11396342edk.2.2021.10.26.09.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:15:48 -0700 (PDT)
Message-ID: <088231e9-e35c-8744-081a-546ffc39ecc2@redhat.com>
Date:   Tue, 26 Oct 2021 18:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 5.14 3/5] KVM: VMX: Remove redundant handling of
 bus lock vmexit
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Hao Xiang <hao.xiang@linux.alibaba.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20211025203828.1404503-1-sashal@kernel.org>
 <20211025203828.1404503-3-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211025203828.1404503-3-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/21 22:38, Sasha Levin wrote:
> From: Hao Xiang <hao.xiang@linux.alibaba.com>
> 
> [ Upstream commit d61863c66f9b443192997613cd6aeca3f65cc313 ]
> 
> Hardware may or may not set exit_reason.bus_lock_detected on BUS_LOCK
> VM-Exits. Dealing with KVM_RUN_X86_BUS_LOCK in handle_bus_lock_vmexit
> could be redundant when exit_reason.basic is EXIT_REASON_BUS_LOCK.
> 
> We can remove redundant handling of bus lock vmexit. Unconditionally Set
> exit_reason.bus_lock_detected in handle_bus_lock_vmexit(), and deal with
> KVM_RUN_X86_BUS_LOCK only in vmx_handle_exit().
> 
> Signed-off-by: Hao Xiang <hao.xiang@linux.alibaba.com>
> Message-Id: <1634299161-30101-1-git-send-email-hao.xiang@linux.alibaba.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/vmx/vmx.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 55de1eb135f9..87150b3c9c5f 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5551,9 +5551,13 @@ static int handle_encls(struct kvm_vcpu *vcpu)
>   
>   static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
>   {
> -	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
> -	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
> -	return 0;
> +	/*
> +	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
> +	 * VM-Exits. Unconditionally set the flag here and leave the handling to
> +	 * vmx_handle_exit().
> +	 */
> +	to_vmx(vcpu)->exit_reason.bus_lock_detected = true;
> +	return 1;
>   }
>   
>   /*
> @@ -6039,9 +6043,8 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>   	int ret = __vmx_handle_exit(vcpu, exit_fastpath);
>   
>   	/*
> -	 * Even when current exit reason is handled by KVM internally, we
> -	 * still need to exit to user space when bus lock detected to inform
> -	 * that there is a bus lock in guest.
> +	 * Exit to user space when bus lock detected to inform that there is
> +	 * a bus lock in guest.
>   	 */
>   	if (to_vmx(vcpu)->exit_reason.bus_lock_detected) {
>   		if (ret > 0)
> 

NACK

No functional change; this time the bot is not doing a good job. :)

Paolo

