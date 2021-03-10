Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9B334B26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhCJWJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:09:06 -0500
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:64675 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbhCJWIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:08:42 -0500
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id EB027364A1;
        Wed, 10 Mar 2021 17:08:37 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=Ug9o/CNDr8Sdv0PtCWP+/W5LLys=; b=YzueOr
        RXeO+d0hkA3aB22fLKuAuVW+6xCxMKgJ36LaUGfu6wKS0QHG6mCTTuj4xSarEzy/
        tcfTLGRsN8Mcv4mSu3s0fscIHpBIc8kCxhWzR7JfocZuVEqCfbfHGeBjNadig8Cf
        LyjreeRbxSxNu4idNAFfChoMccFtTOQgUzDpg=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id CD0C53649E;
        Wed, 10 Mar 2021 17:08:37 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=x4HMzILFvvyEh61HaVAZo3iq7tjd/ZgNnUzJbrp7ba4=; b=R4OnUqYuF8FypRdz9+ryCiO5dK8WcX4T1DnDxapiRHsEgc36uxSzCbKiOoCELEOjxPoVZ9nDlG/5XqVyNoyWCUhnU8iAOb5mI0cmXXiJ8Cy5r0KGKcf0mFopQ5S6hD4SHUONJ5tZfF5fyXF+NqMk8XzLjRr1Um+4/zPJDScf46M=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F050ACB8D;
        Wed, 10 Mar 2021 17:08:37 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 522552DA004F;
        Wed, 10 Mar 2021 17:08:36 -0500 (EST)
Date:   Wed, 10 Mar 2021 17:08:36 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     kernel-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <CAKwvOdk4y3Ekc_TiWuk6D2KNbH_6YHZLRK9TtAnOP=cLP6E0Rw@mail.gmail.com>
Message-ID: <2npq25ps-q960-795-96s5-rq6736pq693q@syhkavp.arg>
References: <20210225112122.2198845-1-arnd@kernel.org> <20210226211323.arkvjnr4hifxapqu@google.com> <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com> <1614559739.p25z5x88wl.astroid@bobo.none> <CAK7LNATUSJ5T6bs-aA3sMQgXKWfcyWJLDfhmteBhQ5FuUR52Zg@mail.gmail.com>
 <CAK8P3a3yF+JV3+Xq5QtD_59JqxA7akz=u=0t05Gv-isHD9Kv4A@mail.gmail.com> <CAKwvOdk4y3Ekc_TiWuk6D2KNbH_6YHZLRK9TtAnOP=cLP6E0Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 29C36E84-81ED-11EB-B246-74DE23BA3BAF-78420484!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021, Nick Desaulniers wrote:

> On Wed, Mar 10, 2021 at 1:08 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Wed, Mar 10, 2021 at 9:50 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > On Mon, Mar 1, 2021 at 10:11 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > > Excerpts from Arnd Bergmann's message of February 27, 2021 7:49 pm:
> >
> > >
> > > masahiro@oscar:~/ref/linux$ echo  'void this_func_is_unused(void) {}'
> > > >>  kernel/cpu.c
> > > masahiro@oscar:~/ref/linux$ export
> > > CROSS_COMPILE=/home/masahiro/tools/powerpc-10.1.0/bin/powerpc-linux-
> > > masahiro@oscar:~/ref/linux$ make ARCH=powerpc  defconfig
> > > masahiro@oscar:~/ref/linux$ ./scripts/config  -e EXPERT
> > > masahiro@oscar:~/ref/linux$ ./scripts/config  -e LD_DEAD_CODE_DATA_ELIMINATION
> > > masahiro@oscar:~/ref/linux$
> > > ~/tools/powerpc-10.1.0/bin/powerpc-linux-nm -n  vmlinux | grep
> > > this_func
> > > c000000000170560 T .this_func_is_unused
> > > c000000001d8d560 D this_func_is_unused
> > > masahiro@oscar:~/ref/linux$ grep DEAD_CODE_ .config
> > > CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
> > > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
> > >
> > >
> > > If I remember correctly,
> > > LD_DEAD_CODE_DATA_ELIMINATION dropped unused functions
> > > when I tried it last time.
> > >
> > >
> > > I also tried arm64 with a HAVE_LD_DEAD_CODE_DATA_ELIMINATION hack.
> > > The result was the same.
> > >
> > >
> > >
> > > Am I missing something?
> >
> > It's possible that it only works in combination with CLANG_LTO now
> > because something broke. I definitely saw a reduction in kernel
> > size when both options are enabled, but did not try a simple test
> > case like you did.
> >
> > Maybe some other reference gets created that prevents the function
> > from being garbage-collected unless that other option is removed
> > as well?
> 
> I wish the linker had a debug flag that could let developers discover
> the decisions it made during --gc-sections as to why certain symbols
> were retained/kept or not.

The GNU LD has --print-gc-sections to list those sections that were 
dropped. And normally you should be able to find why a section wasn't 
dropped by looking for dependencies in the linker map file.


Nicolas
