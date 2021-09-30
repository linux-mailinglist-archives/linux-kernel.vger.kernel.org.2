Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77241D2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 07:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348156AbhI3FtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 01:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348126AbhI3FtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 01:49:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6152BC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 22:47:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s21so7967128wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 22:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EzwNWjTA5Fd4xVXh78xrF5nbIKyF+4Pya3O8qiR1rIQ=;
        b=iRNJz/xqpqPoyQSLh2ywRVa0n3uxvx/wojGCs5GD4Y46iHvtmD2RbrQPoQShBDj7jV
         5U4WVatDOnZz7lcBbJuzazHLx7kFrEUd4pCUEF4Ku0W9YD0QVb5GPge0j+i5KeFYIER3
         Ld5CTKmmdfGNB+oh2aARdjI+i9Us3Y9EFpAvlGc/FdoG8pScnD/WryLC5IjDT1PCS31w
         iqm+8zLlW39WZxW+NPPHqRc6Nr5wV3we3jty1LZxBD5j2LvAltCzESLqPM3hhpSR4/Bd
         9B8j3Kw/lANMm/WIrbPLHb0dtdoRJ8hPJH8fcwvuKVB5lXrqeV15d22TyLkQmwVc7qRd
         3O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EzwNWjTA5Fd4xVXh78xrF5nbIKyF+4Pya3O8qiR1rIQ=;
        b=CKTLHdUVigJbOChkE5bHilDnzjZyQxqS9FiwqTQtZPKaJDC+ZPcqedJjdUBCKW9oIE
         pIbivb2wMlGhhqSsZVKdneH8xTZRfJUsJ2y0O++osnU5U5E6MYtJTorLV5sEkIisZ93U
         ew0+YKTSlfyX+UBsEjNdW69zycevVVG/An2b0WkSYCwh3dstPsDewqemSztlFnBkU6uH
         g+AvRL6VIyjbtSEAhfh4TOMVg+Q9tc3SZi2Nvt4GGRypVhAXddK+7rCwOf6mXEazRE1Q
         6cIuQhcBI7FkitIxvQIgGbfJi+dGmZNcAsWJb/V9dvB/5ITGWUWJKj0UY0gQkXLwlwvu
         Bwrw==
X-Gm-Message-State: AOAM532TWWnjzbQ6Iod0WfEkKLW3o4qKr11/fTRv2B302bD+Y9RGyYEx
        8lHFjmGPr+dlNZjqe6tWfvE0wA==
X-Google-Smtp-Source: ABdhPJzHH5fuu3NOH3D91vWmB3Krt08tYXnI2l0GMVsYoBCqe6guLSe24o0X2MIAIj2+fAibSYRBkw==
X-Received: by 2002:adf:a18d:: with SMTP id u13mr3915822wru.83.1632980836200;
        Wed, 29 Sep 2021 22:47:16 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:4c54:2b8f:fabf:78b0])
        by smtp.gmail.com with ESMTPSA id h11sm1333555wru.10.2021.09.29.22.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 22:47:15 -0700 (PDT)
Date:   Thu, 30 Sep 2021 07:47:09 +0200
From:   Marco Elver <elver@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mark:arm64/kcsan 11/13] ld.lld: error: undefined symbol:
 __tsan_atomic64_fetch_add
Message-ID: <YVVPXS6I6TwOudcX@elver.google.com>
References: <202109300534.s1xCnxOR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109300534.s1xCnxOR-lkp@intel.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 05:48AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/kcsan
> head:   4fe9d6c2ef85257d80291086e4514eaaebd3504e
> commit: f5bc7f69b328f00a6accd9a11f5981d2d0c11cb5 [11/13] kcsan: remove atomic builtin support
> config: x86_64-randconfig-a011-20210929 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=f5bc7f69b328f00a6accd9a11f5981d2d0c11cb5
>         git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
>         git fetch --no-tags mark arm64/kcsan
>         git checkout f5bc7f69b328f00a6accd9a11f5981d2d0c11cb5
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: undefined symbol: __tsan_atomic64_fetch_add
>    >>> referenced by initcall.h:10 (include/trace/events/initcall.h:10)
>    >>>               main.o:(__traceiter_initcall_level) in archive init/built-in.a
>    >>> referenced by initcall.h:10 (include/trace/events/initcall.h:10)
>    >>>               main.o:(__traceiter_initcall_level) in archive init/built-in.a
>    >>> referenced by initcall.h:10 (include/trace/events/initcall.h:10)
>    >>>               main.o:(__traceiter_initcall_level) in archive init/built-in.a
>    >>> referenced 744943 more times

This was another reason why I added the __tsan_atomic instrumentation
calls -- to avoid chasing the odd driver or however this happened using
builtin atomics and the blame always falling on KCSAN. ;-)

This happened more than once, and I just got frustrated and added them,
also in preparation of other odd arches wanting it. I think KCSAN isn't
meant to be the do-not-use-atomic-builtins linter.

If you can somehow keep them, I would prefer that, just to avoid going
back to a world where I have to chase the odd builtin atomic user after
they broke the KCSAN build.

Would a $(call cc-option,-mno-outline-atomics) help?

--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -8,7 +8,8 @@ CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
 
 CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
-	-fno-stack-protector -DDISABLE_BRANCH_PROFILING
+	-fno-stack-protector -DDISABLE_BRANCH_PROFILING \
+	$(call cc-option,-mno-outline-atomics)
 
 obj-y := core.o debugfs.o report.o
 obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o

A quick test with a compiler version which generated outline
atomics suggests that this works.

Thanks,
-- Marco
