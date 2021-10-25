Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD6E438D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 04:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhJYCxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 22:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhJYCxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 22:53:53 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8DC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 19:51:31 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso12946561otl.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 19:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jt5WrNdniPvfss1O9KmjVnHEXTSiv214codr4unP+oA=;
        b=WMkyov0sKx1llAMTw0bwlzUEFSW5ErsFzaD3Yxui73zcnsB1ccYWeIvDJv/6AzlbFL
         O4S3Mlnps7jXJ95GPWq/uUMmz5NRWwQvTwub5QgrFBlJfSfMA9hx8dKuA7t67OWuX4Nb
         rF/nfasKsQc06WAj3lWILM8J4tfaiyTwQwmKHiEA9Fp/wHjQMa8ClhSuGSsmdHsWLxc1
         RfGCNXLwOpzF5N5HV6RmRZ7ZPqB5tD8Tt1qs4FWkFWIpYf9WqPZEUVwUqFCNEIc+f+2N
         10A8LgfDn1ZlUF4nUCsRCfzsOEEuuYfpHLecn26gJDaAFttTUYJXM3k7CL+QtFWKqscq
         zmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jt5WrNdniPvfss1O9KmjVnHEXTSiv214codr4unP+oA=;
        b=zFNe/ajnFY0/LQw7TvsxBM6Xoyd8k0TzV50Bnt7KaFJy8ad1sgBtzu1vcZnWBauCp3
         pKe2MHefd7fvN/DVuh7fAQDAKahnHDbcV/hKYnKgiGGf5XB5o7x1goVPNn36+nqCBruv
         w5xFxVhSIoJRKecDiHjJrp33N/S36sMT4qs14OrD6lDO56JLGTgNoW+v//O3EPS0JQ2z
         C5L02j0OFU3yNaVEdLe+6grt+8fOAubqu8zLjd2+QhJg4mp8rQwVmRZqRUs9kCzBp6We
         cqwIRggFL2cypM/6xz5WCVI1B2S8MhCtWpsgWsFTzCiEihp5wCnyD9zgPTUJo3fgUEPY
         /3Ow==
X-Gm-Message-State: AOAM532VOAH243wn5p7u7uxk9FsvdFmEKXCTOzsNEi0jqTiIxkSJAUt+
        jN77UU4T3af74d+pAjVtjqwJN9ZPJidkOg==
X-Google-Smtp-Source: ABdhPJzFCHULQj/Xm6Tkm/+dSsO1fXLz+YyziGZ3bM2JZ27RHGAUz7Gj7HFwXPJdUqrqcL/Gbpp5KA==
X-Received: by 2002:a05:6830:2492:: with SMTP id u18mr11989729ots.29.1635130290866;
        Sun, 24 Oct 2021 19:51:30 -0700 (PDT)
Received: from [192.168.39.11] ([172.58.97.48])
        by smtp.gmail.com with ESMTPSA id j5sm3427497oii.39.2021.10.24.19.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 19:51:30 -0700 (PDT)
Subject: Re: Commit 0d989ac2c90b broke my x86-64 build.
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <53f767cd-9160-1015-d1b8-0230b5566574@landley.net>
 <CAK7LNAQFEi=4nky4nxRA8s+ODaf89Wa5kwDhe9dppKWX0UiFJA@mail.gmail.com>
 <20211024192742.uo62mbqb6hmhafjs@treble>
From:   Rob Landley <rob@landley.net>
Message-ID: <66ed460c-ac48-2b5a-e8e4-07613cf69ab0@landley.net>
Date:   Sun, 24 Oct 2021 21:51:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211024192742.uo62mbqb6hmhafjs@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/21 2:27 PM, Josh Poimboeuf wrote:
> On Mon, Oct 25, 2021 at 03:13:40AM +0900, Masahiro Yamada wrote:
>> On Sun, Oct 24, 2021 at 3:36 PM Rob Landley <rob@landley.net> wrote:
>> >
>> > The attached config built fine before the above commit, doesn't build after. The
>> > commit in question did nothing except remove support for building x86-64 without
>> > libelf.
>> 
>> You enable CONFIG_STACK_VALIDATION in your .config file.

When I first noticed this dependency in 2018 it was because the ORC unwinder
selected it, which is why I selected UNWINDER_FRAME_POINTER to avoid that
dependency.

>> At least, you observed
>> "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install
>> libelf-dev, libelf-devel or elfutils-libelf-devel"
>> in the previous builds.

I turned off CONFIG_STACK_VALIDATION=y because I didn't want the dependency. It
appears to have crept back in since.

> Unfortunately I think CONFIG_STACK_VALIDATION is no longer optional on
> x86-64 these days, because of static calls and retpolines.

Does it need stack validation, or just a frame unwinder?

> But it
> should be possible to extricate them if that's a problem.

Yes please. How would I go about that? (Is there something to grep for?)

This is to build a small kernel that runs dedicated code. It hasn't got selinux
or containers, and part of the goal is to have a minimal self-contained build
system which can be binary audited against Ken Thompson's "trusting trust" attack:

  http://lists.landley.net/pipermail/toybox-landley.net/2020-July/011898.html

...and then bootstrap up to arbitrarily complexity using nothing but the audited
binaries built from known source with no external dependencies.

Last go-round I got the minimal system down to 7 packages (busybox, uclibc,
linux, make, bash, gcc, binutils), under natively rebuilt itself under itself,
and under which I built Linux From Scratch (and large chunks of BLFS).

I'm now working to get it down to 4 (toybox, musl, tinycc, linux) and this time
targeting an AOSP build under the result.

>> > It took me a while to notice because the commit ONLY broke x86-64. I can still
>> > build arm (32 and 64 bit), i686, m68k, mips/mipsel, powerpc, s390x, and sh4
>> > without libelf in my cross compiler. Heck, I can still build i686. The change
>> > seems to have added a unique build dependency to just x86-64.

FYI:

  git clone https://github.com/landley/toybox
  git clone https://github.com/richfelker/musl-cross-make
  git clone https://github.com/torvalds/linux
  cd musl-cross-make
  ../toybox/scripts/mcm-buildall.sh
  cd ../toybox
  ln -s ../musl-cross-make/ccc ccc
  LINUX="$PWD"/../linux CROSS=allnonstop scripts/mkroot.sh

Assuming I haven't typoed anything and live repo tips don't have bug du jour,
that should build 21 cross toolchains (and 20 native: todo make armv7r work),
then attempt to build tiny bootable qemu systems for each target (I think 14
currently boot to a shell prompt, ala (cd root/sh4 && ./qemu-*.sh)

The mkroot.sh script that builds the systems is currently 254 lines of bash,
hopefully readable...

>> The other architectures are not affected because you cannot enable
>> CONFIG_STACK_VALIDATION.
>> 
>> Please note only x86_64 selects HAVE_STACK_VALIDATION.

Indeed. I'd like to tweak the config so I can disable stack validation and thus
this dependency. It worked fine for me before the above commit, and a kernel
with the following quick hack just built and booted for me:

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
-       select HAVE_STACK_VALIDATION            if X86_64
+       select HAVE_STACK_VALIDATION            if X86_64 && !UNWINDER_FRAME_POINTER

The question is the right way to go about it. (New config symbol?)

Rob
