Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9063AEAE8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFUOPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhFUOPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:15:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF360C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:13:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h16so10064924pjv.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uYXsev2NikLvniwUbGy7LLHqgqCmmM6+EMtNEtpgAt0=;
        b=A3E/kkKI7oDrgwcYmlIm7TxoWXPEMeBFJgw/BEl3Wi45bV6g18XiUpXkJCTvnYNnYa
         v9cL6izMATY3rsTGfQBgQhesZGDhpyf+0cWXOv0MGFTAYqz+46+mWIWKyhJKCOCZx2Av
         pT6rNqAbmIt9zP6MTs1NwRGNXj/jRXx/ofzYzHDSy9aD+Q8AHhJwOPCS0oA0TO+W1mzN
         JQdst+2QBrU/kw4WVLoA0XVWtRvnNlwLCVHmtrcyLjGqLA4yT1uH2oGLsvLGh9tggtMS
         QZLc6cOLqtCb7Nmd+EnnIAevvfhHi0DsV5YzbN+GnILNbmCFJ33Kwsbq5aiGrT+GFWbQ
         XBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uYXsev2NikLvniwUbGy7LLHqgqCmmM6+EMtNEtpgAt0=;
        b=LnOFXUBo54xGk5vSEyqb2SBIjvdJimwbewwLwy3CwCDiGDo96b0PfCdj3WRi0mZdYO
         2TyYZt4gq4wGvQlujFNtyooNHVBP+yu3d6/wexe/Wn9I5pyF5K9TBXyrq6GykaU2quyO
         RWkh6KB278F5bhjKAfKuAXRG1J+FlOAnCpwxuhsE/l8Du0XNZRSUSwIyAN5YsgeTVPgx
         C/2o1K3aGzMCQK+WKPBq+IqZe7lTu6t6vre/9VBoYiZR1VIlN3KbZxMLFfm7C3LdmlL+
         tltFp9iUm1kIB/lVeh93a2Otrba2grqaQvM5HMT9nN8FRfr+kuVVQEjRIPRq7Y9rao06
         aOwQ==
X-Gm-Message-State: AOAM530F0irTu0daJk1USsoblgNA5AiUgQpceWhKdMeQabkD7Vl1W3fI
        0Fi5UhEg0UlFNWokykgvJv0=
X-Google-Smtp-Source: ABdhPJyg8hcybMXuKce2vGFsGlAouy8e9etcrrkQ6y6X7cXx5IaygdCtBCUIFnRuNPE7Va6f7684qw==
X-Received: by 2002:a17:90a:4101:: with SMTP id u1mr37335458pjf.59.1624284814088;
        Mon, 21 Jun 2021 07:13:34 -0700 (PDT)
Received: from [192.168.1.123] (163.128.178.217.shared.user.transix.jp. [217.178.128.163])
        by smtp.gmail.com with ESMTPSA id d131sm15982113pfd.176.2021.06.21.07.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 07:13:33 -0700 (PDT)
Cc:     akira.tsukamoto@gmail.com
Subject: Re: [PATCH 5/5] riscv: __asm_to/copy_from_user: Bulk copy when both
 src, dst are aligned
To:     David Laight <David.Laight@ACULAB.COM>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
 <4637f0f2-2da9-1056-37bf-17c0861b6bff@gmail.com>
 <4a847070ad494e839de1d3fc5b39ba57@AcuMS.aculab.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <061be1e7-9941-58fb-c2b5-feb2163883af@gmail.com>
Date:   Mon, 21 Jun 2021 23:13:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4a847070ad494e839de1d3fc5b39ba57@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/2021 8:55 PM, David Laight wrote:
> From: Akira Tsukamoto
>> Sent: 19 June 2021 12:43
>>
>> In the lucky situation that the both source and destination address are on
>> the aligned boundary, perform load and store with register size to copy the
>> data.
>>
>> Without the unrolling, it will reduce the speed since the next store
>> instruction for the same register using from the load will stall the
>> pipeline.
> ...
>> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
>> index e2e57551fc76..bceb0629e440 100644
>> --- a/arch/riscv/lib/uaccess.S
>> +++ b/arch/riscv/lib/uaccess.S
>> @@ -67,6 +67,39 @@ ENTRY(__asm_copy_from_user)
>>  	bnez	a3, .Lshift_copy
>>
>>  .Lword_copy:
>> +        /*
>> +	 * Both src and dst are aligned, unrolled word copy
>> +	 *
>> +	 * a0 - start of aligned dst
>> +	 * a1 - start of aligned src
>> +	 * a3 - a1 & mask:(SZREG-1)
>> +	 * t0 - end of aligned dst
>> +	 */
>> +	addi	t0, t0, -(8*SZREG-1) /* not to over run */
>> +2:
>> +	fixup REG_L   a4,        0(a1), 10f
>> +	fixup REG_L   a5,    SZREG(a1), 10f
>> +	fixup REG_L   a6,  2*SZREG(a1), 10f
>> +	fixup REG_L   a7,  3*SZREG(a1), 10f
>> +	fixup REG_L   t1,  4*SZREG(a1), 10f
>> +	fixup REG_L   t2,  5*SZREG(a1), 10f
>> +	fixup REG_L   t3,  6*SZREG(a1), 10f
>> +	fixup REG_L   t4,  7*SZREG(a1), 10f
>> +	fixup REG_S   a4,        0(a0), 10f
>> +	fixup REG_S   a5,    SZREG(a0), 10f
>> +	fixup REG_S   a6,  2*SZREG(a0), 10f
>> +	fixup REG_S   a7,  3*SZREG(a0), 10f
>> +	fixup REG_S   t1,  4*SZREG(a0), 10f
>> +	fixup REG_S   t2,  5*SZREG(a0), 10f
>> +	fixup REG_S   t3,  6*SZREG(a0), 10f
>> +	fixup REG_S   t4,  7*SZREG(a0), 10f
>> +	addi	a0, a0, 8*SZREG
>> +	addi	a1, a1, 8*SZREG
>> +	bltu	a0, t0, 2b
>> +
>> +	addi	t0, t0, 8*SZREG-1 /* revert to original value */
>> +	j	.Lbyte_copy_tail
>> +
> 
> Are there any riscv chips than can do a memory read and a
> memory write int the same cycle but don't have significant
> 'out of order' execution?
> 
> Such chips will execute that code very badly.
> Or, rather, there are loops that allow concurrent read+write
> that will be a lot faster.

For the above two paragraphs, the boom will be probably one of
them and perhaps U8, but I do not have a chance to try it.

I have run the benchmarks both the unrolled load store
and not unrolled load store and always unrolled version
was faster on current cores. We could discuss and optimizing
way when the Out of Order core comes out in the market
with comparing bench results on real hardware.

I really understand of your comments of concurrent read+write
that you have mentioned in the other thread too.

I just would like to make the current risc-v better
as soon as possible, since the difference is significant.

> 
> Also on a cpu that can execute a memory read/write
> at the same time as an add (probably anything supercaler)
> you want to move the two 'addi' further up so they get
> executed 'for free'.

The original assembler version of memcpy does have the `addi`
moving up the few lines up.
You really know the internals, I am in the between of making
the code easy to understand to make the patches in the upstream
and optimizing further more.

If you really like to, I will move the `addi` up at the time of 
when merging the patches to one which do not break bisecting.

Akira
