Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75700446B9B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 01:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhKFAiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 20:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhKFAiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 20:38:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ABAC061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 17:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9ulRg+0CDxeaK3pVQblVl0zHlWvAP/RaGBQT7+mtiSo=; b=ZTBwljMWMgFDCdTscD2Wzzzij3
        LpZSyL2fw4LeVQLKg+EQFSqChmOGzuABlRUKQWHWR/M9HTyS1QS/qUUV7hOo1usZ8RSrW4ZMEmfCN
        Qj9vnSvuUW27vKvjF+JboKorlUOGdfMlB3ghhUrc/VTYtGxmaPakhxEpZYRACZkdcHKRHZQZGeydo
        hfWP2UQ/4dpPBF8UBnTSQGU4nk0/NtZQZJ7daPRiwzsj0HE5LOo0WEL95sc0OuAwt4uDC9d1jrd7s
        OPmTqCn+ttuwCNdFH3ecnOcv3GdsAwdrTKzCJRJ6SWrUyqnbA3RV7QAuzCH0Cz81w/UBYIxyXvfcr
        5GoKynUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj9en-006xR9-S8; Sat, 06 Nov 2021 00:34:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F21630031A;
        Sat,  6 Nov 2021 01:34:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15ABB2C8F4FD0; Sat,  6 Nov 2021 01:34:04 +0100 (CET)
Date:   Sat, 6 Nov 2021 01:34:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:x86/wip.extable 1/22]
 drivers/crypto/ccree/cc_driver.c:117:18: warning: result of comparison of
 constant 18446744073709551615 with expression of type 'typeof
 (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0,
 signed char: (unsigned char)0, unsigned shor...
Message-ID: <YYXNfJFjdjT9x3+D@hirez.programming.kicks-ass.net>
References: <202111051833.sOedoq8J-lkp@intel.com>
 <YYUhzUEbK4t5/hOC@hirez.programming.kicks-ass.net>
 <CAKwvOdnPWrBDasA73CRZQPwPt8Bd6H6B3qWTxqWt6UkdkAo=Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnPWrBDasA73CRZQPwPt8Bd6H6B3qWTxqWt6UkdkAo=Uw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 02:06:22PM -0700, Nick Desaulniers wrote:
> On Fri, Nov 5, 2021 at 5:21 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > I'm confused here.. the code reads:
> >
> >
> > #define __scalar_type_to_unsigned_cases(type)                           \
> >                 unsigned type:  (unsigned type)0,                       \
> >                 signed type:    (unsigned type)0
> >
> > #define __unsigned_scalar_typeof(x) typeof(                             \
> >                 _Generic((x),                                           \
> >                         char:   (unsigned char)0,                       \
> >                         __scalar_type_to_unsigned_cases(char),          \
> >                         __scalar_type_to_unsigned_cases(short),         \
> >                         __scalar_type_to_unsigned_cases(int),           \
> >                         __scalar_type_to_unsigned_cases(long),          \
> >                         __scalar_type_to_unsigned_cases(long long),     \
> >                         default: (x)))
> >
> > #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
> >
> > #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                       \
> >         ({                                                              \
> >                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
> >                                  _pfx "mask is not constant");          \
> >                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
> >                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
> >                                  ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
> >                                  _pfx "value too large for the field"); \
> >                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
> >                                  __bf_cast_unsigned(_reg, ~0ull),       \
> >                                  _pfx "type of reg too small for mask"); \
> >                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
> >                                               (1ULL << __bf_shf(_mask))); \
> >         })
> >
> > #define FIELD_PREP(_mask, _val)                                         \
> >         ({                                                              \
> >                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
> >                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
> >         })
> >
> >
> > static void init_cc_cache_params(struct cc_drvdata *drvdata)
> > {
> >         struct device *dev = drvdata_to_dev(drvdata);
> >         u32 cache_params, ace_const, val, mask;
> >
> >         ...
> >
> >         mask = CC_GENMASK(CC_AXIM_CACHE_PARAMS_AWCACHE);        <-- *BOOM*
> >         cache_params &= ~mask;
> >         cache_params |= FIELD_PREP(mask, val);
> >
> >         ...
> > }
> >
> > So we're having "(unsigned int)mask > (unsigned long long)~0ull" as
> > a compile time constant input to the BUILD_BUG_ON_MSG(), and clang-14 is
> > now complaining it's a constant ?!?
> 
> No, the error message (trimmed for clarity):
> >> warning: result of comparison of constant 18446744073709551615  (ie ~0ull / ULLONG_MAX) with expression of type ... 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
> 
> Is `val` an int, but should be a long long? We're comparing if an
> unsigned int is greater than ULLONG_MAX, which is impossible (or
> rather a tautology; something that's always either true or false, in
> this case false).  Or maybe mask and reg are different widths?

They are, for FIELD_PREP() as is the case here, _mask is u32 while _reg
is typeof(0ULL). In my reading of the code this is on purpose to
basically disable the test for this caller.
