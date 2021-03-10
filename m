Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B81F334A32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhCJV4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:56:50 -0500
Received: from pb-sasl-trial20.pobox.com ([173.228.157.50]:60664 "EHLO
        pb-sasl-trial20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhCJV4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:56:22 -0500
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 16:56:22 EST
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 2602A1D123;
        Wed, 10 Mar 2021 16:47:55 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=i+EEhpOIzYGRI0g4C4YHfxUGVbY=; b=kl2TCk
        L03XOSJ247uByISeVdnxUCsMBZHrMlGfmf+YXPvjJtpkNwLqgM+K70UqN5XpXAUF
        HZHlm4P9do1U7EKmixT3ot0yRPFAOar2HsIK7n39r5eK1375BjRnkhIyesOl/mV2
        HbSHnhtZSV2YDpIbKMFYWYvuFbtL7z0HwlUL4=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 090D11D120;
        Wed, 10 Mar 2021 16:47:55 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=pOv0CrVAzO2rWPsLUvMZRUiGATfAGrQpGeNjU/+31FE=; b=MKKUhi2+FM2CTDzaG8bEkJdxKY/fSSHY5SweTBdCGkjXb/SeRVjGGnKjQP8t9r9wa7cblzkU9c4xgAvVe78f7OV0eJTkiXVNUWt2KcL2O/ny8ju6odBcwWf/ZBa7HkvXSF4hzNHSmOO024e663JoczkB6tpQtyEywZYyjFVpbGw=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D55B612399B;
        Wed, 10 Mar 2021 16:47:51 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id ED20E2DA004F;
        Wed, 10 Mar 2021 16:47:49 -0500 (EST)
Date:   Wed, 10 Mar 2021 16:47:49 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Sedat Dilek <sedat.dilek@gmail.com>
cc:     Arnd Bergmann <arnd@kernel.org>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <CA+icZUWk-9i8BSf70qE_9f=mekscQ063q+aUKzSNBymNLAbcTA@mail.gmail.com>
Message-ID: <ros2o1p7-r65q-n4p-3o38-oo36rr58q041@syhkavp.arg>
References: <20210225112122.2198845-1-arnd@kernel.org> <20210226211323.arkvjnr4hifxapqu@google.com> <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com> <1614559739.p25z5x88wl.astroid@bobo.none> <CAK7LNATUSJ5T6bs-aA3sMQgXKWfcyWJLDfhmteBhQ5FuUR52Zg@mail.gmail.com>
 <CAK8P3a3yF+JV3+Xq5QtD_59JqxA7akz=u=0t05Gv-isHD9Kv4A@mail.gmail.com> <CA+icZUWk-9i8BSf70qE_9f=mekscQ063q+aUKzSNBymNLAbcTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 43744EB4-81EA-11EB-9BB5-D609E328BF65-78420484!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021, Sedat Dilek wrote:

> The best results on size-reduction of vmlinux I got with Clang-CFI on x86-64.
> 
> Clang-LTO and Clang-CFI:
> I was able to build with CONFIG_TRIM_UNUSED_KSYMS=y which needs to add
> a whitelist file or add a whitelist to scripts/gen_autoksyms.sh.
> And boot on bare metal.
> Furthermore, I was able to compile
> CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y with and without
> CONFIG_TRIM_UNUSED_KSYMS=y.
> Every kernel I had CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y does not boot.
> Yes, there is a size reduction with both enabled but not that good as
> with Clang-CFI.
> All testings with several iterations of LLVM/Clang v13-git.
> With CONFIG_TRIM_UNUSED_KSYMS=y I see a 3x-loops of building .version
> and folowing steps - got no answer if this is intended.

Yes it is intended. I explained it here:

https://lkml.org/lkml/2021/3/9/1099

With CONFIG_TRIM_UNUSED_KSYMS some EXPORT_SYMBOL() are removed, which 
allows for optimizing away the corresponding code, which in turn opens 
the possibility for more EXPORT_SYMBOL() to be removed, etc. The process 
eventually converge to a stable build. Normally only 2 passes are needed 
to converge, but LTO opens the possibilities for extra passes.

> Means longer build-time.

Oh, absolutely.  LTO (at least when I played with it) is slow. Add the 
multi-pass from CONFIG_TRIM_UNUSED_KSYMS on top of that and your kernel 
build becomes agonizingly slow. This is not something you want when 
doing kernel development.

> I did not follow this anymore as both Kconfigs with Clang-LTO consume
> more build-time and the resulting vmlinux is some MiB bigger than with
> Clang-CFI.

That's rather strange. At least with gcc LTO I always obtained smaller 
kernels.


Nicolas
