Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18333A9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 03:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCOCtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 22:49:06 -0400
Received: from ozlabs.org ([203.11.71.1]:58383 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhCOCs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 22:48:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DzLT65XnBz9sVb;
        Mon, 15 Mar 2021 13:48:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1615776507;
        bh=2a8puDRnJdmt99D4SSF44flRITbs7zaSkUZNQ2VTCp8=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=IdQMPHQwM59Ri7P80RhRw4Zayj0FB5q5co0sV+gfV4xQlCfaaUT7f1V0BEOkcHOL9
         T49xv028jzVSKLqYia3oX7BddaZcaPmibtGQ4Sqo5i2H4o/21rPIW/y07dD6j0LvxP
         zbl0XDQR6O/RFaM3y9jnrGaqJQN/C4ywl+8H7uyLJ3kaXnlDRIMdftSwdCtbkPpSQ6
         ov7oaaIHVipgznzOO6rquTVYoJQzbAC0LF+AG5ryjVsHWgQCi+SQutZVr3rMgCgvAF
         gI4j5fmHRisGXspk8rUe9rIxhOlfi9wFfv3NYoVR+Pz0E4cs8jBtfF0HLqtRf+5Q7n
         m2sCnYeP7Fmuw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, rppt@kernel.org, oss@buserror.net,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: kernel: Trivial spelling fixes throughout the
 file head_fsl_booke.S
In-Reply-To: <f8dc3cbe-54f4-1da1-b14f-4735d28aad13@infradead.org>
References: <20210314220436.3417083-1-unixbhaskar@gmail.com>
 <f8dc3cbe-54f4-1da1-b14f-4735d28aad13@infradead.org>
Date:   Mon, 15 Mar 2021 13:48:25 +1100
Message-ID: <87r1kh3zeu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> On 3/14/21 3:04 PM, Bhaskar Chowdhury wrote:
>> 
>> Trivial spelling fixes throughout the file.
>> 
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  arch/powerpc/kernel/head_fsl_booke.S | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
>> index fdd4d274c245..c6fcfca0b0d7 100644
>> --- a/arch/powerpc/kernel/head_fsl_booke.S
>> +++ b/arch/powerpc/kernel/head_fsl_booke.S
>> @@ -403,7 +403,7 @@ interrupt_base:
>>  	EXCEPTION(0x2900, AP_UNAVAIL, AuxillaryProcessorUnavailable, \
>>  		  unknown_exception, EXC_XFER_STD)
>> 
>> -	/* Decrementer Interrupt */
>> +	/* Decremented Interrupt */
>
> No, the comment matches the macro (or whatever that is).

Right. I dropped this hunk. Please update your script or whatever to not
"correct" that spelling.

cheers
