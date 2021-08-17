Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB7C3EF1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhHQS3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhHQS31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:29:27 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33218C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:28:54 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Gq00g6PG0zQkBZ;
        Tue, 17 Aug 2021 20:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received; s=mail20150812; t=
        1629224925; bh=FVpvGo+sqKVExbwos8/nqa74dWMduIk6BUG+vaxHwKI=; b=C
        hd0fA7j2sexsHbuD2QUi/r1hTiNkJ7dabADycxSb+5PjPCnVJmyjZqBNS7IRbNZj
        iNsNguCpVquNngoOBKvEbYKh6N22DnJEmVZxUmvdhAxpSLB18bcBThftc1MUk4I0
        SU9pNnDAOzqWsZacmAVN9nzwU871KB+aFn42Je5bmqRLX6VaRiudQJktMtfjbnmX
        DLlan7Wmw6Wmw3mC/T5z2cX3BMO/LFyMg2bIdb1JyYkau2i2WZuzTGbLaeAtQs9H
        9+hyx2enJvQ1RRdn0UqEfI7Zw3l+gnO5ydMzeODHdZ1Iqa86ZovjkFTSSb4VBCN5
        cA74+bqQG15Q0kTugj2eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1629224929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41lZRdMf7DYVcwWiruJSCA+FLjLI0/wb06kdjBmxolE=;
        b=flS0bCNw4fAGjPXmI7YdBuPexz+7vrCpdISKBHBmSByhLN1HrEJYWSl5bB4Wu5QtlnauwZ
        hbCVQeaEIDflrM9tJp8ViB1pr+jWBhQ4ac5gZ8GMPIKWf71enoHltikd0NzZYfSt8F6JXh
        z6haWp+m0tjjFqN7kbGaZwbdSV2qeDiEjvCTRrVwSORSxGzRdZ3ueaHccU/YllXM9pmFKu
        PFEUQskz72AUwxJu45OY64GJxmLxyT+MWuLlyktrRdC502Bz7+qE81GjCetkliVSRW6r68
        ATpXdUa4QZ4ky1zSkt7iuelNUHt/lE9CP6NH3nnJYIqXXXZAnE+xbx1O2ZE5CA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id bEbpRvqyAJm2; Tue, 17 Aug 2021 20:28:45 +0200 (CEST)
Subject: Re: [PATCH 1/2] x86, Makefile: Move the CPU-specific 64-bit tuning
 settings to arch/x86/Makefile.cpu
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <CAKwvOdkpJc66DWTJV1qTZ6ch-qLxf+g-mJnLmP0ea396P1oYmA@mail.gmail.com>
From:   Tor Vic <torvic9@mailbox.org>
Message-ID: <35f9422c-4cde-af6a-d56c-500b66d6f1f0@mailbox.org>
Date:   Tue, 17 Aug 2021 18:28:35 +0000
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkpJc66DWTJV1qTZ6ch-qLxf+g-mJnLmP0ea396P1oYmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 64F00182B
X-Rspamd-UID: e33ff5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.08.21 17:58, Nick Desaulniers wrote:
> Tor,
> Thanks for the patches. One thing I always try to do is use
> ./scripts/get_maintainer.pl to get the appropriate maintainers and
> reviewers cc'ed. I prefer to explicitly put the maintainers that I
> expect to pick up a patch in the To: line.
> 

I did use the script, but I wasn't sure whether to include groups,
individuals, or both.
Noted for next submission.

> $ ./scripts/get_maintainer.pl arch/x86/Makefile -norolestats
> Thomas Gleixner <tglx@linutronix.de>
> Ingo Molnar <mingo@redhat.com>
> Borislav Petkov <bp@alien8.de>
> x86@kernel.org
> "H. Peter Anvin" <hpa@zytor.com>
> Nathan Chancellor <nathan@kernel.org>
> Nick Desaulniers <ndesaulniers@google.com>
> linux-kernel@vger.kernel.org
> clang-built-linux@googlegroups.com
> 
> added them to CC.  Probably needs a refresh at this point, but
> https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/
> is still mostly relevant.
> 

Noted as well.
Thanks!

> On Tue, Aug 17, 2021 at 7:23 AM torvic9 via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
>>
>> In accordance with the FIXME comment in arch/x86/Makefile, move the
>> CPU-specific 64-bit tuning settings to arch/x86/Makefile.cpu.
>>
>> Signed-off-by: Tor Vic <torvic9@mailbox.org>
>> ---
>>  arch/x86/Makefile     | 11 ++---------
>>  arch/x86/Makefile.cpu | 12 ++++++++++++
>>  2 files changed, 14 insertions(+), 9 deletions(-)
>>  create mode 100644 arch/x86/Makefile.cpu
>>
>> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
>> index 307fd0000a83..94105d7ad22c 100644
>> --- a/arch/x86/Makefile
>> +++ b/arch/x86/Makefile
>> @@ -119,15 +119,8 @@ else
>>         # Use -mskip-rax-setup if supported.
>>         KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
>>
>> -        # FIXME - should be integrated in Makefile.cpu (Makefile_32.cpu)
>> -        cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
>> -        cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
>> -
>> -        cflags-$(CONFIG_MCORE2) += \
>> -                $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
>> -       cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
>> -               $(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
>> -        cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
>> +        # CPU-specific tuning (64-bit).
>> +        include arch/x86/Makefile.cpu
> 
> So we have arch/x86/Makefile_32.cpu, would it be more symmetrical to
> have a new arch/x86/Makefile_64.cpu (rather than Makefile.cpu)?
> 
>>          KBUILD_CFLAGS += $(cflags-y)
>>
>>          KBUILD_CFLAGS += -mno-red-zone
>> diff --git a/arch/x86/Makefile.cpu b/arch/x86/Makefile.cpu
>> new file mode 100644
>> index 000000000000..fb407ae94d90
>> --- /dev/null
>> +++ b/arch/x86/Makefile.cpu
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# CPU tuning section (64-bit) - shared with UML.
>> +# Must change only cflags-y (or [yn]), not CFLAGS! That makes a difference for UML.
>> +
>> +cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
>> +cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
>> +
>> +cflags-$(CONFIG_MCORE2) += \
>> +       $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
>> +cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
>> +       $(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
>> +cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
> 
> I was going to say we probably don't want to limit -mtune=genric to
> 64b only, but it seems that arch/x86/Makefile_32.cpu has some
> duplication here.
> 
>  47 cflags-$(CONFIG_X86_GENERIC)  += $(call tune,generic,$(call
> tune,i686))
> 
> That probably could be hoisted back into arch/x86/Makefile before the
> CONFIG_X86_32 check, but I'm not sure about the differences between
> CONFIG_GENERIC_CPU vs CONFIG_X86_GENERIC?
> 
