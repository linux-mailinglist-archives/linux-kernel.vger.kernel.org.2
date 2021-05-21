Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CC938CFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhEUVi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:38:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45213 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhEUVi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:38:27 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14LLagD2290060
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 21 May 2021 14:36:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14LLagD2290060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621633003;
        bh=FE5Ro4/Df02Yj2Nr/OVNSwT2t3v7nd7g7yirN11+GkI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SEujZ2h6Qg34/Roxk6uljZzzeWP6YXqdswfVkOb1vlNlRUaAvYj5vbQGUYSEu1PlM
         ePPGcLv5KfcUgo2MI8cHLDlcHr9KpupXvwsNzKLQI3Exi9POPiSICFqVvcafOoctfK
         o27ClV7lS+v8F3uEiHMZftm74NSdEn0LDgI6YqqHk+9MQFuuLMxqYlSWmPjA7l46/h
         sbOT36G+tVe5vfp1ZWxjGlRXcUxB+fLLmQzpCqnGTAPmfAfnS4Cg0GVDQu1YHWt3Lq
         4OwAbhoYGUNZpR6g49vCxm6UW2NXF6t1u5NJubVDd6GGRsVI3dGnRpkNNoInhcpwLu
         VSqzWMWOMC0eQ==
Subject: Re: [PATCH v4 6/6] x86/syscall: use int everywhere for system call
 numbers
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210518191303.4135296-1-hpa@zytor.com>
 <20210518191303.4135296-7-hpa@zytor.com>
 <87zgwpbxby.ffs@nanos.tec.linutronix.de>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e43577cf-ab35-1de2-818a-ccc2e2fb99b8@zytor.com>
Date:   Fri, 21 May 2021 14:36:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87zgwpbxby.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/21 1:53 AM, Thomas Gleixner wrote:
> On Tue, May 18 2021 at 12:13, H. Peter Anvin wrote:
>> +static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
>> +{
>> +	/*
>> +	 * Convert negative numbers to very high and thus out of range
>> +	 * numbers for comparisons. Use unsigned long to slightly
>> +	 * improve the array_index_nospec() generated code.
> 
> How is that actually improving the generated code?
> 
> unsigned long:
> 
>   104:	48 81 fa bf 01 00 00 	cmp    $0x1bf,%rdx
>   10b:	48 19 c0             	sbb    %rax,%rax
>   10e:	48 21 c2             	and    %rax,%rdx
>   111:	48 89 df             	mov    %rbx,%rdi
>   114:	48 8b 04 d5 00 00 00 	mov    0x0(,%rdx,8),%rax
>   11b:	00
>   11c:	e8 00 00 00 00       	callq  121 <do_syscall_64+0x41>
> 
> unsigned int:
> 
>    f1:	48 81 fa bf 01 00 00 	cmp    $0x1bf,%rdx
>    f8:	48 19 d2             	sbb    %rdx,%rdx
>    fb:	21 d0                	and    %edx,%eax
>    fd:	48 89 df             	mov    %rbx,%rdi
>   100:	48 8b 04 c5 00 00 00 	mov    0x0(,%rax,8),%rax
>   107:	00
>   108:	e8 00 00 00 00       	callq  10d <do_syscall_64+0x3d>
> 
> Text size increases with that unsigned long cast.
> 
> I must be missing something.
> 

"unsigned long" gave slightly better code than "int", but as you 
correctly point out here, "unsigned int" is even better.

Thanks for catching that.

	-hpa

