Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26A3A4C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 06:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhFLEIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 00:08:40 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:35526 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhFLEIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 00:08:36 -0400
Received: by mail-pf1-f175.google.com with SMTP id h12so6054771pfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 21:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=auy0WVYl8Y45pHRqjvZyfXRrSFjA4yBO/RFaVXZLz/g=;
        b=sHMUbaOXb1CsM8eE4QdQCh1OapkMPGVKzu9b30RpoqXznGZfYxAiw+I2qUMxx76pv4
         lUfx+YQAuPkrf4cvZwIge0hYERKN138i0aNRdGRhHWnBoC4EADFUmla4Mr/wHgoemzPo
         g7w2f2nM97s+rdcSBRooWpxEslR3U7oOA1JWCotzkFOypygmCJhNSiVUrT9aXnDP/ICE
         pwmwthrsgE28WVrnc9ObGNuzLvtyELn9WYQB6um8W9X/mb9IUi/2JjH+4LCxmsV1DTU3
         arDtGPHdJXHaQ+MYCSwSINcGPZQQiyw1NtmCXR8/o5N/9pg1RVAldp6V038hJ7ptmmi9
         FrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=auy0WVYl8Y45pHRqjvZyfXRrSFjA4yBO/RFaVXZLz/g=;
        b=OCVrgXVOUwbdplbsg7alcrsgfyjMPOkHkOvulV4gN+iwy1SbF1xBVkXeIgRjIjUkzQ
         7KSRfoYwcEM6pFFi/typIzKVBuB+suz4Z+108jUAHYSrcDx9IgrCkPBUFIbqMojiYakp
         0YCE69e+tokvbmJFdU2HDCbKchSQ+ERcKGlCgww+hl9bDWSCJkB9AkTDqE+aCH5XAdnr
         CfMG4Tc2pYB/XK2dOavWPSOQYk6TnAMoF+6rq6ik4As+jca8+8oadWDyOy0cLkGcwJ0k
         XdzFNcPZwZ7HZ/c8WA/x3xyeIfACCWrKv8sEdfY2tlSx2rnLIlrqC+1ta6bgpUkaidCd
         LFJg==
X-Gm-Message-State: AOAM532pWvCvyA3pI8ubwl9flTotE9LuD//KgyDf11QSqclQqWZFx6jg
        3bf6SceWrirn5ykInLpUi3+Xtg==
X-Google-Smtp-Source: ABdhPJwAIG7egTmxzBnoxI6V1ssds0EvLk83JhYrJor3EOEUtwQp3aaBDpd0Ttsb8onwfJ9Tzgoj2Q==
X-Received: by 2002:a62:76d1:0:b029:2e9:e128:2f89 with SMTP id r200-20020a6276d10000b02902e9e1282f89mr11181550pfc.59.1623470722189;
        Fri, 11 Jun 2021 21:05:22 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v14sm6697211pgl.86.2021.06.11.21.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 21:05:21 -0700 (PDT)
Date:   Fri, 11 Jun 2021 21:05:21 -0700 (PDT)
X-Google-Original-Date: Fri, 11 Jun 2021 21:05:19 PDT (-0700)
Subject:     RE: [PATCH 1/1] riscv: prevent pipeline stall in __asm_to/copy_from_user
In-Reply-To: <67dab8dc517f4add8b0c29074a6b3f06@AcuMS.aculab.com>
CC:     akira.tsukamoto@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, gary@garyguo.net, nickhu@andestech.com,
        nylon7@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     akira.tsukamoto@gmail.com, David.Laight@ACULAB.COM
Message-ID: <mhng-e4f1484c-052f-4981-83f9-3884ee4d5ea0@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jun 2021 04:31:40 PDT (-0700), David.Laight@ACULAB.COM wrote:
> From: Akira Tsukamoto
>> Sent: 04 June 2021 10:57
>> 
>> Reducing pipeline stall of read after write (RAW).
>> 
>> These are the results from combination of the speedup with
>> Gary's misalign fix. Speeds up from 680Mbps to 900Mbps.
>> 
>> Before applying these two patches.
> 
> I think the changes should be in separate patches.
> Otherwise it is difficult to see what is relevant.
> It also looks as if there is a register rename.
> Maybe that should be a precursor patch?

Yes, and I'd also prefer the original patches.  This also doesn't apply.

> ...
> 
> I think this is the old main copy loop:
>>  1:
>> -    fixup REG_L, t2, (a1), 10f
>> -    fixup REG_S, t2, (a0), 10f
>> -    addi a1, a1, SZREG
>> -    addi a0, a0, SZREG
>> -    bltu a1, t1, 1b
> and this is the new one:
>>  3:
>> +    fixup REG_L a4,       0(a1), 10f
>> +    fixup REG_L a5,   SZREG(a1), 10f
>> +    fixup REG_L a6, 2*SZREG(a1), 10f
>> +    fixup REG_L a7, 3*SZREG(a1), 10f
>> +    fixup REG_L t0, 4*SZREG(a1), 10f
>> +    fixup REG_L t1, 5*SZREG(a1), 10f
>> +    fixup REG_L t2, 6*SZREG(a1), 10f
>> +    fixup REG_L t3, 7*SZREG(a1), 10f
>> +    fixup REG_S a4,       0(t5), 10f
>> +    fixup REG_S a5,   SZREG(t5), 10f
>> +    fixup REG_S a6, 2*SZREG(t5), 10f
>> +    fixup REG_S a7, 3*SZREG(t5), 10f
>> +    fixup REG_S t0, 4*SZREG(t5), 10f
>> +    fixup REG_S t1, 5*SZREG(t5), 10f
>> +    fixup REG_S t2, 6*SZREG(t5), 10f
>> +    fixup REG_S t3, 7*SZREG(t5), 10f
>> +    addi a1, a1, 8*SZREG
>> +    addi t5, t5, 8*SZREG
>> +    bltu a1, a3, 3b
> 
> I don't know the architecture, but unless there is a stunning
> pipeline delay for memory reads a simple interleaved copy
> may be fast enough.
> So something like:
> 	a = src[0];
> 	do {
> 		b = src[1];
> 		src += 2;
> 		dst[0] = a;
> 		dst += 2;
> 		a = src[0];
> 		dst[-1] = b;
> 	} while (src != src_end);
> 	dst[0] = a;
> 
> It is probably worth doing benchmarks of the copy loop
> in userspace.

I also don't know this microarchitecture, but this seems like a pretty 
wacky load-use delay.

Can we split out the misaligned handling fix to get that in sooner, 
that's likely the more urgent issue.

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
