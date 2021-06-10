Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202583A2B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFJMOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhFJMOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623327133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1co3NguiIYX83PrIHoTzkJXW8j6qclf/uPcmCgOsD0=;
        b=J2rtTprjnifxYpKfdunR6cluSsh9yEtolRmqF6uM5vHL1uKhZj0toZeRhGj7V5KtbnAE5D
        PTAO1TXjZf+UAJjaUxhgIoRaaqba00TqvfrlJhReL7AStDvdl/HsvK5yoA17H/YNAyyaXF
        5+8EWGrpM4jiPVUPd+tKYHVPg7Z+dM8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-oyD7SPxYPNafzZe1LsMDiQ-1; Thu, 10 Jun 2021 08:12:12 -0400
X-MC-Unique: oyD7SPxYPNafzZe1LsMDiQ-1
Received: by mail-wm1-f70.google.com with SMTP id 128-20020a1c04860000b0290196f3c0a927so3783844wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 05:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h1co3NguiIYX83PrIHoTzkJXW8j6qclf/uPcmCgOsD0=;
        b=sv25CqPJr0s2e+dfQAAQZCkEIaz1AW7QJDs2e7eclh6DHicLBwdRxCL+kPM2nvEERg
         FQOszPOTdyTFLEq+Vplhns6xFJAMh/q/fqV7+8rxwkVVuUp9O62tEgzwUTAjnOTtNPxV
         XlscP/Ln3tIdStbERjKv2o3ME3IGp7Rz58L2UQkuM9UhQhn3CBy3j6Ghs/EBD8ODaD+s
         bACJ3odUagy2OJD1NogkRR+cwBgISOse4qt7Y4dD59hl25lPe/8/2LKsnHTfbiSZjclU
         LIJ0Q1zhS/L7z4M09Q32/aoSd3YKvC4HC7phUQpZ1AfhqjpByHvGu30KbQGPPbnFlz/j
         o3Kg==
X-Gm-Message-State: AOAM533cX/Qx9aUwQ1CB7C7QINuiMe1cg7zW8s+DqJl6TMl381n+HnoA
        1Q1MmNbOUgoQBAsQj6ogFP3rylQgAlIaSLTy+ss++Qok2F5fYEg9YJGPwrf5ULyzU85OvyXupDu
        S+MkpYcQcqBlUPOT3tS0Tjm+Y
X-Received: by 2002:a5d:444e:: with SMTP id x14mr5298001wrr.200.1623327131496;
        Thu, 10 Jun 2021 05:12:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaaeKCRriP/oAUJg6Qb3M8kqKGIm1NxWDyKoB63F2JMQbWW716m9AQLUXeosAEckC7yzOSuA==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr5297978wrr.200.1623327131324;
        Thu, 10 Jun 2021 05:12:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id j12sm3080674wrt.69.2021.06.10.05.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 05:12:10 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Ensure liveliness of nested VM-Enter fail
 tracepoint message
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <20210607175748.674002-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1e8fda75-4c34-b13f-b193-4def6869b0f2@redhat.com>
Date:   Thu, 10 Jun 2021 14:12:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607175748.674002-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/21 19:57, Sean Christopherson wrote:
> Use the __string() machinery provided by the tracing subystem to make a
> copy of the string literals consumed by the "nested VM-Enter failed"
> tracepoint.  A complete copy is necessary to ensure that the tracepoint
> can't outlive the data/memory it consumes and deference stale memory.
> 
> Because the tracepoint itself is defined by kvm, if kvm-intel and/or
> kvm-amd are built as modules, the memory holding the string literals
> defined by the vendor modules will be freed when the module is unloaded,
> whereas the tracepoint and its data in the ring buffer will live until
> kvm is unloaded (or "indefinitely" if kvm is built-in).
> 
> This bug has existed since the tracepoint was added, but was recently
> exposed by a new check in tracing to detect exactly this type of bug.
> 
>    fmt: '%s%s
>    ' current_buffer: ' vmx_dirty_log_t-140127  [003] ....  kvm_nested_vmenter_failed: '
>    WARNING: CPU: 3 PID: 140134 at kernel/trace/trace.c:3759 trace_check_vprintf+0x3be/0x3e0
>    CPU: 3 PID: 140134 Comm: less Not tainted 5.13.0-rc1-ce2e73ce600a-req #184
>    Hardware name: ASUS Q87M-E/Q87M-E, BIOS 1102 03/03/2014
>    RIP: 0010:trace_check_vprintf+0x3be/0x3e0
>    Code: <0f> 0b 44 8b 4c 24 1c e9 a9 fe ff ff c6 44 02 ff 00 49 8b 97 b0 20
>    RSP: 0018:ffffa895cc37bcb0 EFLAGS: 00010282
>    RAX: 0000000000000000 RBX: ffffa895cc37bd08 RCX: 0000000000000027
>    RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff9766cfad74f8
>    RBP: ffffffffc0a041d4 R08: ffff9766cfad74f0 R09: ffffa895cc37bad8
>    R10: 0000000000000001 R11: 0000000000000001 R12: ffffffffc0a041d4
>    R13: ffffffffc0f4dba8 R14: 0000000000000000 R15: ffff976409f2c000
>    FS:  00007f92fa200740(0000) GS:ffff9766cfac0000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000559bd11b0000 CR3: 000000019fbaa002 CR4: 00000000001726e0
>    Call Trace:
>     trace_event_printf+0x5e/0x80
>     trace_raw_output_kvm_nested_vmenter_failed+0x3a/0x60 [kvm]
>     print_trace_line+0x1dd/0x4e0
>     s_show+0x45/0x150
>     seq_read_iter+0x2d5/0x4c0
>     seq_read+0x106/0x150
>     vfs_read+0x98/0x180
>     ksys_read+0x5f/0xe0
>     do_syscall_64+0x40/0xb0
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 380e0055bc7e ("KVM: nVMX: trace nested VM-Enter failures detected by H/W")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/trace.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index a61c015870e3..4f839148948b 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -1550,16 +1550,16 @@ TRACE_EVENT(kvm_nested_vmenter_failed,
>   	TP_ARGS(msg, err),
>   
>   	TP_STRUCT__entry(
> -		__field(const char *, msg)
> +		__string(msg, msg)
>   		__field(u32, err)
>   	),
>   
>   	TP_fast_assign(
> -		__entry->msg = msg;
> +		__assign_str(msg, msg);
>   		__entry->err = err;
>   	),
>   
> -	TP_printk("%s%s", __entry->msg, !__entry->err ? "" :
> +	TP_printk("%s%s", __get_str(msg), !__entry->err ? "" :
>   		__print_symbolic(__entry->err, VMX_VMENTER_INSTRUCTION_ERRORS))
>   );
>   
> 

Queued, thanks.

Paolo

