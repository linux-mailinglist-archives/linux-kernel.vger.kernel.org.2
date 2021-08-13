Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68F3EBD0B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhHMUFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhHMUFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:05:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F430C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 13:05:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so6958900pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 13:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LLGFAtJMn9/g+hSmBB/R1jZF7zawczzcNya/wcap1qw=;
        b=tsbCgqA+modt4I/2YcP2KWUIr4RPfsj/a17xi4tsOcqg4wa/GlfE5TSsBBNFw99QLi
         pMGX9DSZRnUrlqjyUXToXAR6sD86vRNQNlz4nMF2AKrymHZpWRZQwcKP9FDLCzYNQ1Iu
         d58Er7HLYcZQO7ECYbQ5V5QStHPe3CmEQmOK0RkAFYmAGNYejk1sQh+8G/zTwNeTIR+N
         fDujv5jrm5qVMi10Qc2I4qnlP5F3KGIUHg4l0jsZncetEFfczE0mabFWaZFVvY0UDSmI
         CPKyPM5pHZ/cQCY4UQ5/WhtfYRMRF/EfYmFkmC/ALo2H7gIz7ZmT/sVr9vg3uu30Omtq
         CBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LLGFAtJMn9/g+hSmBB/R1jZF7zawczzcNya/wcap1qw=;
        b=cY1YEjqKIvB83JHf/h/ekQX8cjvkT0Z0NzzdPo4wm/gbArVLcGAZiULU0f/oMkNh7M
         dtxJjwxg9Yf0GbtA+CHPlYQdyqepXQn7foukNon5GLVu7G4cwqZ5vL3+Er2g/nRIGgIx
         JQ+wGkPRfTTl/kOszUClwCYrhJD/GusZpOGatXHU/u32mzfrvm529DQ84lD4e3pT8PPx
         FpIJgwEBJe9A/izNz/A49GdREdJKJX9RBkdCnaRcAsWH5fQapdYFumbF4frRUL44tkRi
         E32YGQrfzqwrhTENUrpO6DqHWqYugOP+2XqEL05d1hhDGed+zznG7jQ0+9RA/gEF2T2G
         5UoA==
X-Gm-Message-State: AOAM531w2jUavmzcGubDWuVNm7hY/kzDElJq+Dla9d8AH0JAwEW5+TGa
        R7nNez3s3YNatgFTPOtw1EwI0g==
X-Google-Smtp-Source: ABdhPJzaqRUcYvq8j5jCPYy5mlscmobnM6iUY4vm+qoKCyhKIYqI6qJp5w4VVR3JpQAMXU09d24Izw==
X-Received: by 2002:a65:5686:: with SMTP id v6mr3851920pgs.174.1628885113391;
        Fri, 13 Aug 2021 13:05:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c94e:5de5:2819:8b32])
        by smtp.gmail.com with ESMTPSA id g20sm3204758pfo.20.2021.08.13.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 13:05:12 -0700 (PDT)
Date:   Fri, 13 Aug 2021 13:05:08 -0700
From:   Fangrui Song <maskray@google.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Bill Wendling <morbo@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ppc: add "-z notext" flag to disable diagnostic
Message-ID: <20210813200508.7bqehxgd6ruerds5@google.com>
References: <20210812204951.1551782-1-morbo@google.com>
 <87sfzde8lk.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87sfzde8lk.fsf@linkitivity.dja.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-14, Daniel Axtens wrote:
>Bill Wendling <morbo@google.com> writes:
>
>> The "-z notext" flag disables reporting an error if DT_TEXTREL is set on
>> PPC with CONFIG=kdump:
>>
>>   ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against
>>     local symbol in readonly segment; recompile object files with -fPIC
>>     or pass '-Wl,-z,notext' to allow text relocations in the output
>>   >>> defined in built-in.a(arch/powerpc/kernel/misc.o)
>>   >>> referenced by arch/powerpc/kernel/misc.o:(.text+0x20) in archive
>>       built-in.a
>>
>> The BFD linker disables this by default (though it's configurable in
>> current versions). LLD enables this by default. So we add the flag to
>> keep LLD from emitting the error.
>
>You didn't provide a huge amount of context but I was able to reproduce
>a similar set of errors with pseries_le_defconfig and
>
>make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- CC="ccache clang-11" LD=ld.lld-11 AR=llvm-ar-11 -j4 vmlinux
>
>I also checked the manpage, and indeed the system ld does not issue this
>warning/error by default.
>
>> ---
>>  arch/powerpc/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 6505d66f1193..17a9fbf9b789 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -122,6 +122,7 @@ endif
>>
>>  LDFLAGS_vmlinux-y := -Bstatic
>>  LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
>> +LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) += -z notext
>
>Is there any reason this should be gated on CONFIG_RELOCATABLE? (I tried
>without it and got different but possibly related linker errors...)
>
>Also, is this behaviour new?

This is a longstanding behavior.

https://maskray.me/blog/2020-12-19-lld-and-gnu-linker-incompatibilities
See "Text relocations"

.o files used to link .tmp_vmlinux.kallsyms1 have many R_PPC64_ADDR64
relocations in non-SHF_WRITE sections. There are many text relocations (e.g. in
.rela___ksymtab_gpl+* and .rela__mcount_loc sections) in a -pie link and are
disallowed by LLD:

   ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against local symbol in readonly segment; recompile object files with -fPIC or pass '-Wl,-z,notext' to allow text relocations in the output
   >>> defined in arch/powerpc/kernel/head_64.o
   >>> referenced by arch/powerpc/kernel/head_64.o:(__restart_table+0x10)

Newer GNU ld configured with --enable-textrel-check=error will report an error
as well:

   ld/ld-new: read-only segment has dynamic relocations



Text relocations are considered very awful by linker developers.
binutils 2.35 added --enable-textrel-check={no,warn,error}
https://sourceware.org/bugzilla/show_bug.cgi?id=20824

I can imagine that in the future some Linux distributions (especially those
focusing on security) will default their binutils to use
--enable-textrel-check={no,warn,error}.  CONFIG_RELOCATABLE build will break
sooner or later.


In -no-pie links, R_PPC64_ADDR64 relocations are link-time constants.
There are no text relocations, therefore no need for -z notext.

>Kind regards,
>Daniel
>
>>  LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
>>
>>  ifdef CONFIG_PPC64
>> --
>> 2.33.0.rc1.237.g0d66db33f3-goog
>
>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/87sfzde8lk.fsf%40linkitivity.dja.id.au.
