Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC0332896
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhCIO17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:27:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230465AbhCIO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615300052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uefc69ZAVo40Lyi9qS15enKlYyR1TmA5w4KWE/8N6f0=;
        b=PuyDInNYr5ULLqQ8bw0cWs7NjWDziWL8swKrhPvEWDCxvH1NIwKZ2j5lP/V5n+xBZW3bnm
        bQ7U1xG2jM6BG0B5g9IeXhUZWY/XrRKVfj50VNPfevrJ5GR/NFiH1IFfTWv8o6D9zC5h9a
        sXA/YJX2gZsoZ3YY0P8B2rsaCEW9E0Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-y0Tq0pG4P5qY0v_aOucPkg-1; Tue, 09 Mar 2021 09:27:29 -0500
X-MC-Unique: y0Tq0pG4P5qY0v_aOucPkg-1
Received: by mail-wr1-f72.google.com with SMTP id g2so6503776wrx.20
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uefc69ZAVo40Lyi9qS15enKlYyR1TmA5w4KWE/8N6f0=;
        b=qEa+8DFBLoFTRpFqt1PD2rg5eR5SHHgqACAqppm+qfqmRNoOa8SzZWNTjUxIONI0PC
         v954Cs8TLtVe4uePkqLfbku0zfmrpQdj6V091DZKEEELryV3iVL54J99mAWUV0nlogQc
         CCmXbVbcYdN8w45izrIESQBkZUgeKEBnL7XCLZCRDMrsSLlQWMxpx9EKlHkPKxbxJLGQ
         Q8smD7lo1d87vrDBFuTtnAbfFPVQEjuDkRFhcvZHQrLS4p5Z51GolKdixCBBROlqHWPr
         KUMjGVtoDG0D6zj5tT3CskI3hazD/DKLgVBXCZgMeJ6OAiFL6gHA4gVNk+rLSBSr6YxF
         fLPg==
X-Gm-Message-State: AOAM530oiNf/JmP6CIpF212rogZBnkhVG11WXplISix+mUNqYa3NNLvz
        kU+Ywuh4Tq1Hw58QPiny4Wkfe9rtbQrgVN9GGrfRrzdinLxM0SF7LL5A9526kjkRpsNZwK2MeFg
        Dwrqgsh232zcYY8++GrLWQC9H
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr4437928wme.172.1615300048123;
        Tue, 09 Mar 2021 06:27:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziYLcxKgKhST0pV5HkhnHk/u+COVI1jyY3xXYJj71+XW5C6Uppli/1zbPdoQUMgPjx5kTHHw==
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr4437912wme.172.1615300047976;
        Tue, 09 Mar 2021 06:27:27 -0800 (PST)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id o7sm23869752wrs.16.2021.03.09.06.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 06:27:27 -0800 (PST)
Subject: Re: [RFC PATCH v2 00/13] objtool: add base support for arm64
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, ycote@redhat.com,
        Fangrui Song <maskray@google.com>,
        Bill Wendling <morbo@google.com>,
        Pete Swain <swine@google.com>,
        Yonghyun Hwang <yonghyun@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
 <20210305235102.384950-1-ndesaulniers@google.com>
 <CAKwvOdmgRAJXVdaHAnZoYm-Y4Dt01CYxvsnJC6zaSwr5amRWBg@mail.gmail.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <47cb7299-a361-6036-fc6e-860bbcfc2476@redhat.com>
Date:   Tue, 9 Mar 2021 15:27:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmgRAJXVdaHAnZoYm-Y4Dt01CYxvsnJC6zaSwr5amRWBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/21 1:04 AM, Nick Desaulniers wrote:
> On Fri, Mar 5, 2021 at 3:51 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> (in response to
>> https://lore.kernel.org/linux-arm-kernel/20210303170932.1838634-1-jthierry@redhat.com/
>> from the command line)
>>
>>> Changes since v1[2]:
>>> - Drop gcc plugin in favor of -fno-jump-tables
>>
>> Thank you for this!  I built+booted(under emulation) arm64 defconfig and built
>> arm64 allmodconfig with LLVM=1 with this series applied.
>>
>> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>>
>> One thing I noticed was a spew of warnings for allmodconfig, like:
>> init/main.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
>> init/main.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
>>
>> I assume those are from the KASAN constructors. See also:
>> https://github.com/ClangBuiltLinux/linux/issues/1238
>>
>> Can we disable HAVE_STACK_PROTECTOR if CC_IS_CLANG and CONFIG_KASAN is set,
>> until we can resolve the above issue?

So that concerns objtool for all arches, right?

> 
> Ah, filtering the logs more, it looks like GCOV is has the same issue
> KASAN does (known issue).  Here's a filtered log:
> https://gist.github.com/nickdesaulniers/01358015b33bd16ccd7d951c4a8c44e7
> 
> I'm curious about the failure to decode certain instructions?
> 

This is probably related to data constants present in code sections. To 
fix this, objtool needs to handle SYM_DATA_* annotations [1] and then 
the relevant bytes need to be annotated in the kernel sources (e.g. [2], 
but there are multiple parts in arm64 assembler needing this). I have 
not submitted those yet because I didn't want the amount of patches to 
become overwhelming and mixing objtool + kernel sources.

[1] 
https://github.com/julien-thierry/linux/commit/9005e9f3bb10aac663c42bb87d337b7a1aae5a67

[2] 
https://github.com/julien-thierry/linux/commit/ad132b032b4141c7ffce95d784b5254120e5bf65

> The stack state mismatches are what are valuable to me; we'll need
> some help digging into those at some point.  The logs from defconfig
> are clean.
> 

I think at the moment this is mostly a limitation of objtool to track 
code flow. aarch64 code tends to do a lot more register load/store 
inside a function than x86, and objtool doesn't track multiple register 
states (e.g. a registered stored at some offset on the stack at the 
beginning of the function, and later at some other stack offset). 
Although, when looking at the disassembled code, I'm not 100% I 
understand why there are so many intermediary store/load for these 
registers since it doesn't look like those values are actually used (I 
don't know whether this is caused by kasan/probes instrumentation).

But I'd need to investigate a bit more.

-- 
Julien Thierry

