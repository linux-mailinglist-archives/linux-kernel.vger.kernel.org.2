Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD42543B387
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhJZOFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230119AbhJZOFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:05:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53D4260D07;
        Tue, 26 Oct 2021 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635256966;
        bh=jf046iBN2pgX9ep9EdmfiHHDhGaD9VLYXiqA222lDBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcYmtMmA+B6622uCVjok524Q7axWOqq/F+FL96MUvTsTW0dyHIQncKyWnjcI3cxRA
         TJOIcgvOAl38iiVftPP9TCymnjc+5rzfFD41prwn27/kvOQ53iZD6aqUcbNxbwgHmi
         11LMU4juimXbloLghA57nk2I45iBw5Yw1fed9Ah0MgNpxu0G4i4LEbSb5BFTbCZL51
         pTohkzjOHOfdZc8tcGyR2oZzxmCDYe18Lm57/e6LG4YiFM4KqefcyBgierFYfu3MuW
         u3sMdOJ8uYZSyBxGDYVVUcZsjdzBtiUd4w5UjBuTELmHALggvfyqbg2xPOBszQkluz
         Z8fxmnr00/SbA==
Date:   Tue, 26 Oct 2021 07:02:41 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Nick Terrell' <terrelln@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] lib: zstd: Add cast to silence clang's
 -Wbitwise-instead-of-logical
Message-ID: <YXgKgQMHQzvQgE4J@archlinux-ax161>
References: <20211021202353.2356400-1-nathan@kernel.org>
 <4245BD7A-4B12-4172-B4EE-76A99C717C7D@fb.com>
 <d21e97487ba3447194538ccf0e88ead9@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21e97487ba3447194538ccf0e88ead9@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:34:31AM +0000, David Laight wrote:
> From: Nick Terrell
> > Sent: 26 October 2021 02:18
> > 
> > > On Oct 21, 2021, at 1:23 PM, Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > A new warning in clang warns that there is an instance where boolean
> > > expressions are being used with bitwise operators instead of logical
> > > ones:
> > >
> > > lib/zstd/decompress/huf_decompress.c:890:25: warning: use of bitwise '&' with boolean operands [-
> > Wbitwise-instead-of-logical]
> > >                        (BIT_reloadDStreamFast(&bitD1) == BIT_DStream_unfinished)
> > >                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > zstd does this frequently to help with performance, as logical operators
> > > have branches whereas bitwise ones do not.
> ...
> > > The first U32 cast is to silence an instance of -Wshorten-64-to-32
> > > because __builtin_expect() returns long so it cannot be moved.
> 
> Isn't enabling that warning completely stupid?
> The casts required to silence it could easily cause more problems
> - by hiding more important bugs. And seriously affect code readability.

Which warning?

-Wbitwise-instead-of-logical is included in clang's -Wall and I do not
think it should be disabled; this is the first instance of the warning
that has been silenced with a cast.

-Wshorten-64-to-32 will never be enabled for Linux but zstd is a
separate project that can be built for a variety of operating systems so
that has to be considered when developing changes for the kernel because
the kernel changes need to go upstream eventually if they touch core
zstd code, otherwise they will just get blown away on the next import.
Specifically, this warning was enabled on iOS:
https://github.com/facebook/zstd/pull/2062

> ...c
> > > index 05570ed5f8be..5105e59ac04a 100644
> > > --- a/lib/zstd/decompress/huf_decompress.c
> > > +++ b/lib/zstd/decompress/huf_decompress.c
> > > @@ -886,7 +886,7 @@ HUF_decompress4X2_usingDTable_internal_body(
> > >             HUF_DECODE_SYMBOLX2_0(op2, &bitD2);
> > >             HUF_DECODE_SYMBOLX2_0(op3, &bitD3);
> > >             HUF_DECODE_SYMBOLX2_0(op4, &bitD4);
> > > -            endSignal = (U32)LIKELY(
> > > +            endSignal = (U32)LIKELY((U32)
> > >                         (BIT_reloadDStreamFast(&bitD1) == BIT_DStream_unfinished)
> > >                       & (BIT_reloadDStreamFast(&bitD2) == BIT_DStream_unfinished)
> > >                       & (BIT_reloadDStreamFast(&bitD3) == BIT_DStream_unfinished)
> 
> Isn't that the same as:
> 	((BIT_reload() & BIT_reload() & BIT_reload()) == BIT_DStream_unfinished)
> which will generate much better code.
> Especially on cpu without 'seteq' instructions.

I don't think so. Feel free to double check my math.

BIT_reloadDStreamFast() can return either BIT_DStream_unfinished (0) or
BIT_DStream_overflow (3). Let's say the second call returns
BIT_DStream_overflow but the others return BIT_DStream_unfinished.

Current code:

(BIT_reloadDStreamFast(&bitD1) == BIT_DStream_unfinished) &
(BIT_reloadDStreamFast(&bitD2) == BIT_DStream_unfinished) &
(BIT_reloadDStreamFast(&bitD3) == BIT_DStream_unfinished)

(BIT_DStream_unfinished == BIT_DStream_unfinished) &
(BIT_DStream_overflow == BIT_DStream_unfinished) &
(BIT_DStream_unfinished == BIT_DStream_unfinished)

(1 & 0 & 1)

Final result: 0

Your suggestion:

(BIT_reloadDStreamFast(&bitD1) &
 BIT_reloadDStreamFast(&bitD2) &
 BIT_reloadDStreamFast(&bitD3)) == BIT_DStream_unfinished

(BIT_DStream_unfinished &
 BIT_DStream_overflow &
 BIT_DStream_unfinished) == BIT_DStream_unfinished

(0 & 3 & 0) == 0

(0) == 0

Final result: 1

Clang 13.0.0 and GCC 11.2.0 appear agree with me:

https://godbolt.org/z/M78s1TTEx

Cheers,
Nathan
