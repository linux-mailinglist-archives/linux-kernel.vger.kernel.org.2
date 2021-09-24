Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8283E416D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244529AbhIXIPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234880AbhIXIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632471226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XdA4VPBfW58lxxwN3+MJcHR/jkRy1EQ63OMWAHFug08=;
        b=T7cuAU4hlO4ryOw1ZPx4oFjla2O8RKCMRQfGia1EilIS0GraPK/lZYU6t5/5tj4TqDGyKd
        u8174YVTQ+cwsy0CoPZFdbOYqbAOCPEFNQvbd8WoA9tAMnp5C+oHeWPaYqRwpekN1xxeqA
        nTAfTNF3X7FDBiqqcax25B7fDbPtbNI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-nxYYgYwkPp2qp1MYkb4Z_w-1; Fri, 24 Sep 2021 04:13:45 -0400
X-MC-Unique: nxYYgYwkPp2qp1MYkb4Z_w-1
Received: by mail-ed1-f71.google.com with SMTP id s12-20020a05640217cc00b003cde58450f1so9492441edy.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XdA4VPBfW58lxxwN3+MJcHR/jkRy1EQ63OMWAHFug08=;
        b=RcKw6vkv2Tk0N68Sjn7O8Eyj0DzhiQzr7h1ZIi0i6n3s5EWKg66YFQkKhK1LeQO9+f
         /zKGOW5Mb6xkghokZvXWbQRCaY7gp53TqOFw5BCGrEoCR0Ssaf4OkYutP4+YPnXvmJPk
         QByqJHjNkhwgniWJe4PC8PTMVjVyMdT0+mO1MltDXAco8F6PmFH3VfZ84x1roXeKafne
         X6FrL6pscKznR5veDppKip3aomnc08R5qhFANIw1tSucgvJH5Jwx6ArPGbgvKANdK3Vn
         +K3hdK58C8z/otZLoJU8VsYrm300Jf7fUxpotmxD+S/IcWUt8S5I8GKOl4+kOlsYa98n
         6/eA==
X-Gm-Message-State: AOAM530e7GetCgzaQyW4eY2SLQgZ+4fQPNTvH3I33TiI67H7Eyok7lly
        CJYhauZQGz+ugaA1uuvBWlmb8o3p0O6+NvlTxC4hLJ+jia/5MSxuQXUbSu5pru4iYx6NXn+6RWf
        EnQLTRls4R3K3bT74EteOp6EL
X-Received: by 2002:aa7:ca45:: with SMTP id j5mr3694132edt.6.1632471224410;
        Fri, 24 Sep 2021 01:13:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9FnvhU56K8X4WQjS4suIQp16LYGQI22BlIEKnZzGb0Y6IpWys38jsZ0skzmpU0R5jsfbmBA==
X-Received: by 2002:aa7:ca45:: with SMTP id j5mr3694110edt.6.1632471224179;
        Fri, 24 Sep 2021 01:13:44 -0700 (PDT)
Received: from [192.168.1.173] ([78.157.137.28])
        by smtp.gmail.com with ESMTPSA id b14sm5280694edy.56.2021.09.24.01.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 01:13:43 -0700 (PDT)
Subject: Re: [RFC PATCH] x86, vmlinux.lds: Add debug option to force all data
 sections aligned
To:     Feng Tang <feng.tang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
References: <1627456900-42743-1-git-send-email-feng.tang@intel.com>
 <20210922185137.ivdp4yoalv4qdbe2@treble>
 <20210923145720.GA28463@shbuild999.sh.intel.com>
From:   Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <5ac33795-9402-43e6-9595-d6c07f3250bc@redhat.com>
Date:   Fri, 24 Sep 2021 10:13:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210923145720.GA28463@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/21 4:57 PM, Feng Tang wrote:
> On Wed, Sep 22, 2021 at 11:51:37AM -0700, Josh Poimboeuf wrote:
>> Hi Feng,
>>
>> Thanks for the interesting LPC presentation about alignment-related
>> performance issues (which mentioned this patch).
>>   
>>    https://linuxplumbersconf.org/event/11/contributions/895/
>>
>> I wonder if we can look at enabling some kind of data section alignment
>> unconditionally instead of just making it a debug option.  Have you done
>> any performance and binary size comparisons?
>   
> Thanks for reviewing this!
> 
> For binary size, I just tested 5.14 kernel with a default desktop
> config from Ubuntu (I didn't use the normal rhel-8.3 config used
> by 0Day, which is more for server):
> 
> v5.14
> ------------------------
> text		data		bss	    dec		hex	filename
> 16010221	14971391	6098944	37080556	235cdec	vmlinux
> 
> v5.14 + 64B-function-align
> --------------------------
> text		data		bss	    dec		hex	filename
> 18107373	14971391	6098944	39177708	255cdec	vmlinux
> 
> v5.14 + data-align(THREAD_SIZE 16KB)
> --------------------------
> text		data		bss	    dec		hex	filename
> 16010221	57001791	6008832	79020844	4b5c32c	vmlinux
> 
> So for the text-align, we see 13.1% increase for text. And for data-align,
> there is 280.8% increase for data.

Page-size alignment of all data is WAY too much. At most, alignment
to cache line size should work to make timings stable.
(In your case with "adjacent cache line prefetcher",
it may need to be 128 bytes. But definitely not 4096 bytes).


> Performance wise, I have done some test with the force-32bytes-text-align
> option before (v5.8 time), for benchmark will-it-scale, fsmark, hackbench,
> netperf and kbuild:
> * no obvious change for will-it-scale/fsmark/kbuild
> * see both regression/improvement for different hackbench case
> * see both regression/improvement for netperf, from -20% to +98%

What usually happens here is that testcases are crafted to measure
how well some workloads scale, and to measure that efficiently,
testcases were intentionally written to cause congestion -
this way, benefits of better algorithms are easily seen.

However, this also means that in the congested scenario (e.g.
cache bouncing), small changes in CPU architecture are also
easily visible - including cases where optimizations are going awry.

In your presentation, you stumbled upon one such case:
the "adjacent cache line prefetcher" is counter-productive here,
it pulls unrelated cache into the CPU, not knowing that
this is in fact harmful - other CPUs will need this cache line,
not this one!

Since this particular case was a change in structure layout,
increasing alignment of .data sections won't help here.

My opinion is that we shouldn't worry about this too much.
Diagnose the observed slow downs, if they are "real"
(there is a way to improve), fix that, else if they are spurious,
just let them be.

Even when some CPU optimizations are unintentionally hurting some
benchmarks, on the average they are usually a win:
CPU makers have hundreds of people looking at that as their
full-time jobs. With your example of "adjacent cache line prefetcher",
CPU people might be looking at ways to detect when these
speculatively pulled-in cache lines are bouncing.


> For data-alignment, it has huge impact for the size, and occupies more
> cache/TLB, plus it hurts some normal function like dynamic-debug. So
> I'm afraid it can only be used as a debug option.
> 
>> On a similar vein I think we should re-explore permanently enabling
>> cacheline-sized function alignment i.e. making something like
>> CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B the default.  Ingo did some
>> research on that a while back:
>>
>>     https://lkml.kernel.org/r/20150519213820.GA31688@gmail.com
> 
> Thanks for sharing this, from which I learned a lot, and I hope I
> knew this thread when we first check strange regressions in 2019 :)
> 
>> At the time, the main reported drawback of -falign-functions=64 was that
>> even small functions got aligned.  But now I think that can be mitigated
>> with some new options like -flimit-function-alignment and/or
>> -falign-functions=64,X (for some carefully-chosen value of X).

-falign-functions=64,7 should be about right, I guess.

http://lkml.iu.edu/hypermail/linux/kernel/1505.2/03292.html

"""
defconfig vmlinux (w/o FRAME_POINTER) has 42141 functions.
6923 of them have 1st insn 5 or more bytes long,
5841 of them have 1st insn 6 or more bytes long,
5095 of them have 1st insn 7 or more bytes long,
786 of them have 1st insn 8 or more bytes long,
548 of them have 1st insn 9 or more bytes long,
375 of them have 1st insn 10 or more bytes long,
73 of them have 1st insn 11 or more bytes long,
one of them has 1st insn 12 bytes long:
this "heroic" instruction is in local_touch_nmi()
   65 48 c7 05 44 3c 00 7f 00 00 00 00
   movq $0x0,%gs:0x7f003c44(%rip)

Thus ensuring that at least seven first bytes do not cross
64-byte boundary would cover >98% of all functions.
"""

