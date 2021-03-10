Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204073349D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhCJV2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:28:13 -0500
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:61644 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCJV1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:27:46 -0500
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 16:27:46 EST
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 3C0B2362D5;
        Wed, 10 Mar 2021 16:19:17 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=+ikDOTaiocyRzcnsYX9MefRYaeU=; b=mBw3ZT
        HLb7f4zGl6oZKM9B1U2NSR2xaW/0m5e1NkBM+YdYpJNU151J5TFynTlMLFbbhQna
        rFPakgxHXn8FPp6kiuRcvYHGkv8SbHcTHZsa+eiuq/tnvh/DTJmPIhakbp29v8fU
        n2GgthUXshEMgvRgsdrNMCj3lTKg7fD/p3UMU=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 1A606362D2;
        Wed, 10 Mar 2021 16:19:17 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=ze0IECsgkSchYV8g9uFehQ68VL1bMlDOcSVbtAt/QfI=; b=02i/XrhGxivkHajojkhNK3NV3e7xYD1CnAqLSQa++hhnJb33ixDuvOIK75UY3ExYvcOlwcDQlau9mSsK0aMhuBVcIqnhdbg6xJAvHnt+tnIxm7PahlCsq2aRkxUv2oD8wXTtPDqJDbyrUKgbEoTopU0AP8pkic/Pq64LUgauoiU=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 854AAB49BA;
        Wed, 10 Mar 2021 16:19:16 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 89D8C2DA004F;
        Wed, 10 Mar 2021 16:19:15 -0500 (EST)
Date:   Wed, 10 Mar 2021 16:19:15 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Nicholas Piggin <npiggin@gmail.com>
cc:     Arnd Bergmann <arnd@kernel.org>, Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
In-Reply-To: <1614559739.p25z5x88wl.astroid@bobo.none>
Message-ID: <3o63p7pp-50o9-2789-s3qo-99pp5nrnnoqp@syhkavp.arg>
References: <20210225112122.2198845-1-arnd@kernel.org> <20210226211323.arkvjnr4hifxapqu@google.com> <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com> <1614559739.p25z5x88wl.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 450A1582-81E6-11EB-8521-D152C8D8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021, Nicholas Piggin wrote:

> Excerpts from Arnd Bergmann's message of February 27, 2021 7:49 pm:
> > Unlike what Nick expected in his submission, I now think the annotations
> > will be needed for LTO just like they are for --gc-sections.
> 
> Yeah I wasn't sure exactly what LTO looks like or how it would work.
> I thought perhaps LTO might be able to find dead code with circular / 
> back references, we could put references from the code back to these 
> tables or something so they would be kept without KEEP. I don't know, I 
> was handwaving!
> 
> I managed to get powerpc (and IIRC x86?) working with gc sections with
> those KEEP annotations, but effectiveness of course is far worse than 
> what Nicolas was able to achieve with all his techniques and tricks.
> 
> But yes unless there is some other mechanism to handle these tables, 
> then KEEP probably has to stay. I suggest this wants a very explicit and 
> systematic way to handle it (maybe with some toolchain support) rather 
> than trying to just remove things case by case and see what breaks.
> 
> I don't know if Nicolas is still been working on his shrinking patches
> recenty but he probably knows more than anyone about this stuff.

Looks like not much has changed since last time I played with this stuff.

There is a way to omit the KEEP() on tables, but something must create a 
dependency from the code being pointed to by those tables to the table 
entries themselves. I did write my findings in the following article 
(just skip over the introductory blurb): 

https://lwn.net/Articles/741494/

Once that dependency is there, then the KEEP() may go and 
garbage-collecting a function will also garbage-collect the table entry 
automatically.

OTOH this trickery is not needed with LTO as garbage collection happens 
at the source code optimization level. The KEEP() may remain in that 
case as unneeded table entries will simply not be created in the first 
place.


Nicolas
