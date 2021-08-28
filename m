Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C5B3FA50C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhH1Kmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233732AbhH1Kmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:42:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FD5660E73
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 10:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630147324;
        bh=LGF0WKQUZra+/yE5pzuIRGhLxWYzaW5Afa09kh8HU8U=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=FLG7n2gDsLlkYI1z8MwxlkP1FcBwDbNbRsGchEjCIwY83pGIiuUa4CLdA5423Kkc9
         hJ/rqZdIKSlG+lu1mGVZr4+NltPDD31BKvRcdpWDOZIYvq3hKviuW0c6BS6vR3vLP5
         pzmTWlXdX/qDc3VQoiAW9TImxNtFfC9XTV6tQKk743EfNk0ANtfxHv6Yxx4R/rzIGc
         xQuxycBHLB3d82N72qLEa+2qTQf6mLrJSVWAvkaT+twudnfRqwPCssljVhGzlAAZxU
         GksW7WoPcTZtiCTKdIfZP1uFY8djTxIB/h1omDPwnnKlTuwylKfNgkctjZXMctHuuW
         +m5n9szCtBP7A==
Received: by mail-oi1-f182.google.com with SMTP id bi4so9469132oib.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:42:04 -0700 (PDT)
X-Gm-Message-State: AOAM532AR+7e/A4x9ryd3ZliMHB8gb+iPMEIhRr60dNbWTMjo1nf5sSD
        yAQiQr3YP0baqLJP4fyKO9Ag1A0PISWY+f3Of00=
X-Google-Smtp-Source: ABdhPJwszUx2URDxwC4eHDTx25vlI8b5liaDoOvDuNm8WfYbZ3odpjvucFSaOoXqsmK5YS2q0JlzMUOZhzc7HzHtH3Q=
X-Received: by 2002:aca:1b19:: with SMTP id b25mr18261273oib.138.1630147323365;
 Sat, 28 Aug 2021 03:42:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:1bc6:0:0:0:0:0 with HTTP; Sat, 28 Aug 2021 03:42:02
 -0700 (PDT)
In-Reply-To: <202108281623.Fc90gBsN-lkp@intel.com>
References: <202108281623.Fc90gBsN-lkp@intel.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 28 Aug 2021 19:42:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Fg=3qE+D6Cww4Kncuxwac_w5v2xJizyX9XCH1O6fYYQ@mail.gmail.com>
Message-ID: <CAKYAXd_Fg=3qE+D6Cww4Kncuxwac_w5v2xJizyX9XCH1O6fYYQ@mail.gmail.com>
Subject: Re: [kees:kspp/memcpy/next-20210816/v2 34/63] include/linux/fortify-string.h:265:4:
 warning: call to '__write_overflow_field' declared with attribute warning:
 detected write beyond size of field (1st parameter); maybe use struct_group()?
To:     kernel test robot <lkp@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2021-08-28 17:55 GMT+09:00, kernel test robot <lkp@intel.com>:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
> kspp/memcpy/next-20210816/v2
> head:   0f0894ea4d0761cc43917960b4878fa3d1ed7a5f
> commit: 1db8308d772a6ac9744a973ea07cbc811c608c04 [34/63] fortify: Detect
> struct member overflows in memcpy() at compile-time
> config: x86_64-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         #
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=1db8308d772a6ac9744a973ea07cbc811c608c04
>         git remote add kees
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
>         git fetch --no-tags kees kspp/memcpy/next-20210816/v2
>         git checkout 1db8308d772a6ac9744a973ea07cbc811c608c04
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
Thanks for your report!
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/string.h:253,
>                     from include/linux/bitmap.h:10,
>                     from include/linux/cpumask.h:12,
>                     from arch/x86/include/asm/cpumask.h:5,
>                     from arch/x86/include/asm/msr.h:11,
>                     from arch/x86/include/asm/processor.h:22,
>                     from arch/x86/include/asm/cpufeature.h:5,
>                     from arch/x86/include/asm/thread_info.h:53,
>                     from include/linux/thread_info.h:60,
>                     from arch/x86/include/asm/preempt.h:7,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/wait.h:9,
>                     from include/linux/wait_bit.h:8,
>                     from include/linux/fs.h:6,
>                     from fs/ksmbd/ndr.c:7:
>    In function 'fortify_memcpy_chk',
>        inlined from 'ndr_read_string' at fs/ksmbd/ndr.c:86:2,
>        inlined from 'ndr_decode_dos_attr' at fs/ksmbd/ndr.c:167:2:
>>> include/linux/fortify-string.h:265:4: warning: call to
>>> '__write_overflow_field' declared with attribute warning: detected write
>>> beyond size of field (1st parameter); maybe use struct_group()?
>>> [-Wattribute-warning]
>      265 |    __write_overflow_field(p_size_field, size);
>          |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
We have fixed this issue reported by Dan Carpenter yesterday and
queued the patch to #cifsd-for-next.

Thanks!
>
>
> vim +/__write_overflow_field +265 include/linux/fortify-string.h
>
>    211	
>    212	/*
>    213	 * To make sure the compiler can enforce protection against buffer
> overflows,
>    214	 * memcpy(), memmove(), and memset() must not be used beyond
> individual
>    215	 * struct members. If you need to copy across multiple members,
> please use
>    216	 * struct_group() to create a named mirror of an anonymous struct
> union.
>    217	 * (e.g. see struct sk_buff.)
>    218	 *
>    219	 * Mitigation coverage
>    220	 *					Bounds checking at:
>    221	 *					+-------+-------+-------+-------+
>    222	 *					| Compile time  | Run time      |
>    223	 * memcpy() argument sizes:		| write | read  | write | read  |
>    224	 *					+-------+-------+-------+-------+
>    225	 * memcpy(known,   known,   constant)	|   y   |   y   |  n/a  |  n/a
> |
>    226	 * memcpy(unknown, known,   constant)	|   n   |   y   |   V   |  n/a
> |
>    227	 * memcpy(known,   unknown, constant)	|   y   |   n   |  n/a  |   V
> |
>    228	 * memcpy(unknown, unknown, constant)	|   n   |   n   |   V   |   V
> |
>    229	 * memcpy(known,   known,   dynamic)	|   n   |   n   |   b   |   B
> |
>    230	 * memcpy(unknown, known,   dynamic)	|   n   |   n   |   V   |   B
> |
>    231	 * memcpy(known,   unknown, dynamic)	|   n   |   n   |   b   |   V
> |
>    232	 * memcpy(unknown, unknown, dynamic)	|   n   |   n   |   V   |   V
> |
>    233	 *					+-------+-------+-------+-------+
>    234	 *
>    235	 * y = deterministic compile-time bounds checking
>    236	 * n = cannot do deterministic compile-time bounds checking
>    237	 * n/a = no run-time bounds checking needed since compile-time
> deterministic
>    238	 * b = perform run-time bounds checking
>    239	 * B = can perform run-time bounds checking, but current unenforced
>    240	 * V = vulnerable to run-time overflow
>    241	 *
>    242	 */
>    243	__FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
>    244						 const size_t p_size,
>    245						 const size_t q_size,
>    246						 const size_t p_size_field,
>    247						 const size_t q_size_field,
>    248						 const char *func)
>    249	{
>    250		if (__builtin_constant_p(size)) {
>    251			/*
>    252			 * Length argument is a constant expression, so we
>    253			 * can perform compile-time bounds checking where
>    254			 * buffer sizes are known.
>    255			 */
>    256	
>    257			/* Error when size is larger than enclosing struct. */
>    258			if (p_size > p_size_field && p_size < size)
>    259				__write_overflow();
>    260			if (q_size > q_size_field && q_size < size)
>    261				__read_overflow2();
>    262	
>    263			/* Warn when write size argument larger than dest field. */
>    264			if (p_size_field < size)
>  > 265				__write_overflow_field(p_size_field, size);
>    266			/*
>    267			 * Warn for source field over-read when building with W=1
>    268			 * or when an over-write happened, so both can be fixed at
>    269			 * the same time.
>    270			 */
>    271			if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
>    272			    q_size_field < size)
>    273				__read_overflow2_field(q_size_field, size);
>    274		}
>    275		/*
>    276		 * At this point, length argument may not be a constant expression,
>    277		 * so run-time bounds checking can be done where buffer sizes are
>    278		 * known. (This is not an "else" because the above checks may only
>    279		 * be compile-time warnings, and we want to still warn for run-time
>    280		 * overflows.)
>    281		 */
>    282	
>    283		/*
>    284		 * Always stop accesses beyond the struct that contains the
>    285		 * field, when the buffer's remaining size is known.
>    286		 * (The -1 test is to optimize away checks where the buffer
>    287		 * lengths are unknown.)
>    288		 */
>    289		if ((p_size != (size_t)(-1) && p_size < size) ||
>    290		    (q_size != (size_t)(-1) && q_size < size))
>    291			fortify_panic(func);
>    292	}
>    293	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
