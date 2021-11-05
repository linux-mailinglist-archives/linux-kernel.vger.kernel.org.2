Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE944634F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 13:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhKEMY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 08:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhKEMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:24:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49AC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PjIxPicrN868USbTKxSucpRSmbCgV7/yRn/TvvMlpO0=; b=j+E6AYC0M8Jw375g9QIbcUSMqb
        VLw7L1E9JhvA+x83nb9fLTFp2DJFVc5JGy5zqO0gab9qhjmXIUi8GeCS/mNUHSf8256FQPpYyt9P+
        U6v6y7LM1twFN6Ah3NK4M0AnV/Us7tyiOcKo6vmvRjgyInhKfEyPrd9ClehuFLULX7SKCG+hDKlhy
        RcJB/YlxBQ4+Fy46UHaCkw1/Sa/SCOahp8K9N60GdLN9Gre1eKA06SOPrHzGZqiFPcAVzCXN3i1FK
        dy9C+NeEAQ3fRMnb97Cs+SVYwDTV57tVK3R82vIryDDMZW/6Rt1Z9Dveauzyzo91OwCbIkzKLQQtx
        ZWcWH5bQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miyDu-00EL90-WD; Fri, 05 Nov 2021 12:21:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8AE023000DD;
        Fri,  5 Nov 2021 13:21:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 416A720D9F97F; Fri,  5 Nov 2021 13:21:33 +0100 (CET)
Date:   Fri, 5 Nov 2021 13:21:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:x86/wip.extable 1/22]
 drivers/crypto/ccree/cc_driver.c:117:18: warning: result of comparison of
 constant 18446744073709551615 with expression of type 'typeof
 (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0,
 signed char: (unsigned char)0, unsigned shor...
Message-ID: <YYUhzUEbK4t5/hOC@hirez.programming.kicks-ass.net>
References: <202111051833.sOedoq8J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111051833.sOedoq8J-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 06:17:44PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.extable
> head:   a4d149db054a77aa35b04bb088f749cbb9a2edea
> commit: 4b9e954553a4137f7504e068438851c27edc6b22 [1/22] bitfield.h: Fix "type of reg too small for mask" test
> config: riscv-randconfig-r032-20211105 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 847a6807332b13f43704327c2d30103ec0347c77)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=4b9e954553a4137f7504e068438851c27edc6b22
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue x86/wip.extable
>         git checkout 4b9e954553a4137f7504e068438851c27edc6b22
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/crypto/ccree/cc_driver.c:117:18: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
>            cache_params |= FIELD_PREP(mask, val);
>                            ^~~~~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:111:3: note: expanded from macro 'FIELD_PREP'
>                    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:68:53: note: expanded from macro '__BF_FIELD_CHECK'
>                    BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                        ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
>    include/linux/compiler_types.h:322:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:310:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:302:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~

I'm confused here.. the code reads:


#define __scalar_type_to_unsigned_cases(type)				\
		unsigned type:	(unsigned type)0,			\
		signed type:	(unsigned type)0

#define __unsigned_scalar_typeof(x) typeof(				\
		_Generic((x),						\
			char:	(unsigned char)0,			\
			__scalar_type_to_unsigned_cases(char),		\
			__scalar_type_to_unsigned_cases(short),		\
			__scalar_type_to_unsigned_cases(int),		\
			__scalar_type_to_unsigned_cases(long),		\
			__scalar_type_to_unsigned_cases(long long),	\
			default: (x)))

#define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))

#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
	({								\
		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
				 _pfx "mask is not constant");		\
		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
				 _pfx "value too large for the field"); \
		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
				 __bf_cast_unsigned(_reg, ~0ull),	\
				 _pfx "type of reg too small for mask"); \
		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
					      (1ULL << __bf_shf(_mask))); \
	})

#define FIELD_PREP(_mask, _val)						\
	({								\
		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");	\
		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
	})


static void init_cc_cache_params(struct cc_drvdata *drvdata)
{
	struct device *dev = drvdata_to_dev(drvdata);
	u32 cache_params, ace_const, val, mask;

	...

	mask = CC_GENMASK(CC_AXIM_CACHE_PARAMS_AWCACHE);	<-- *BOOM*
	cache_params &= ~mask;
	cache_params |= FIELD_PREP(mask, val);

	...
}

So we're having "(unsigned int)mask > (unsigned long long)~0ull" as
a compile time constant input to the BUILD_BUG_ON_MSG(), and clang-14 is
now complaining it's a constant ?!?

It is that by design.
