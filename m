Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7303334C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCJFO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:14:27 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:57347 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhCJFN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:13:57 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DwKxD3YWwz9sVt;
        Wed, 10 Mar 2021 16:13:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1615353236;
        bh=PTvR9yy+hFS1JwrAkv1oOXKRmXp2wT57fM05CuMq9n4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gAAezJ3g1I+qwK2XJLKpN8fLHuQhJUtk5xtwGLQCWS+YNib0C/xLeB/2wRr127ta0
         2KyjMDPt2zX6vAv7dKlir7kRhUjjlfgU83c16TkZmOqGc9UDK2E6rzXCkh+9zhBCZs
         RPBhBchbTPSnu1iqRA5vaJ+m/kcB/AfwfNdvArtrudzO9yvhgbI0TQRdDpffhn6hdU
         EMdj1VITVWjR6sFBNDHAqI6ZIyPjlK7ewcXMa9n55DV4HWNGjD/btkMREYD/6eUW4/
         pgcvzG0nEtt+IHOHN57E8cT2wXq+bynGya0XurUDnx9BuBKaQHaG18JU+6+g0s9lb6
         tkTfVAt/9KW1g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     oleg@redhat.com, rostedt@goodmis.org, paulus@samba.org,
        jniethe5@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v4] powerpc/uprobes: Validation for prefixed instruction
In-Reply-To: <1a080cb5-af98-6b6e-352d-772a90cfa902@linux.ibm.com>
References: <20210305115433.140769-1-ravi.bangoria@linux.ibm.com>
 <87ft14r6sa.fsf@mpe.ellerman.id.au>
 <20210309112115.GG145@DESKTOP-TDPLP67.localdomain>
 <1a080cb5-af98-6b6e-352d-772a90cfa902@linux.ibm.com>
Date:   Wed, 10 Mar 2021 16:13:51 +1100
Message-ID: <877dmfr3ow.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
> On 3/9/21 4:51 PM, Naveen N. Rao wrote:
>> On 2021/03/09 08:54PM, Michael Ellerman wrote:
>>> Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
>>>> As per ISA 3.1, prefixed instruction should not cross 64-byte
>>>> boundary. So don't allow Uprobe on such prefixed instruction.
>>>>
>>>> There are two ways probed instruction is changed in mapped pages.
>>>> First, when Uprobe is activated, it searches for all the relevant
>>>> pages and replace instruction in them. In this case, if that probe
>>>> is on the 64-byte unaligned prefixed instruction, error out
>>>> directly. Second, when Uprobe is already active and user maps a
>>>> relevant page via mmap(), instruction is replaced via mmap() code
>>>> path. But because Uprobe is invalid, entire mmap() operation can
>>>> not be stopped. In this case just print an error and continue.
>>>>
>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>>> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>>
>>> Do we have a Fixes: tag for this?
>> 
>> Since this is an additional check we are adding, I don't think we should
>> add a Fixes: tag. Nothing is broken per-se -- we're just adding more
>> checks to catch simple mistakes. Also, like Oleg pointed out, there are
>> still many other ways for users to shoot themselves in the foot with
>> uprobes and prefixed instructions, if they so desire.
>> 
>> However, if you still think we should add a Fixes: tag, we can perhaps
>> use the below commit since I didn't see any specific commit adding
>> support for prefixed instructions for uprobes:
>> 
>> Fixes: 650b55b707fdfa ("powerpc: Add prefixed instructions to
>> instruction data type")
>
> True. IMO, It doesn't really need any Fixes tag.

Yep OK, I'm happy without a Fixes tag based on that explanation.

>>>> diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
>>>> index e8a63713e655..4cbfff6e94a3 100644
>>>> --- a/arch/powerpc/kernel/uprobes.c
>>>> +++ b/arch/powerpc/kernel/uprobes.c
>>>> @@ -41,6 +41,13 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
>>>>   	if (addr & 0x03)
>>>>   		return -EINVAL;
>>>>   
>>>> +	if (cpu_has_feature(CPU_FTR_ARCH_31) &&
>>>> +	    ppc_inst_prefixed(auprobe->insn) &&
>>>> +	    (addr & (SZ_64 - 4)) == SZ_64 - 4) {
>>>> +		pr_info_ratelimited("Cannot register a uprobe on 64 byte unaligned prefixed instruction\n");
>>>> +		return -EINVAL;
>>>
>>> I realise we already did the 0x03 check above, but I still think this
>>> would be clearer simply as:
>>>
>>> 	    (addr & 0x3f == 60)
>> 
>> Indeed, I like the use of `60' there -- hex is overrated ;)
>
> Sure. Will resend.

Thanks.

cheers
