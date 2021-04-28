Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C021436E117
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 23:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhD1Vmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 17:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhD1Vmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 17:42:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 867026109E;
        Wed, 28 Apr 2021 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619646121;
        bh=/FqzLyiQG2TidUZeI8wOLrCqqNWXPY9fDvUK5Ou+J9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzOjGkJGZZuNZqMtVxcYh6/GsOckaascVKZeMTOxQculdz5GnxPqljv9kJDIW5Zsr
         /691JfquDatnK0+x6CgFGyRtJYoDjq05QjyqcBYAOXPRs/gVXWf92UmIxbNDkhcbZ/
         yl74brMI8bWDjTQ5beBbP9xaWY/YX6KQzDmt/V6SpCqtDhNEct7n8DPqzHqKQWME+4
         hpOZPSvU4bTReDjuQMKS3g+k3EjiN38GyqqHxyiJ4P3czBxqTfJJ2IIvG0fIRLT6JP
         gF0F6F2oXbDFu7RYV+jVWHlhMlObB7ZBcrGU7tFc3bsHBaaqCFVRGTBMUpvvqRYrfP
         yURNSuw3GSBbQ==
Date:   Wed, 28 Apr 2021 14:41:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Avoid clang uninitialized warning in
 __get_user_size_allowed
Message-ID: <YInWpCO/bFzcmawv@archlinux-ax161>
References: <20210426203518.981550-1-nathan@kernel.org>
 <32a0f305-031b-e4da-345d-0f03b2b42189@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32a0f305-031b-e4da-345d-0f03b2b42189@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 07:05:12AM +0200, Christophe Leroy wrote:
> 
> 
> Le 26/04/2021 à 22:35, Nathan Chancellor a écrit :
> > Commit 9975f852ce1b ("powerpc/uaccess: Remove calls to __get_user_bad()
> > and __put_user_bad()") switch to BUILD_BUG() in the default case, which
> > leaves x uninitialized. This will not be an issue because the build will
> > be broken in that case but clang does static analysis before it realizes
> > the default case will be done so it warns about x being uninitialized
> > (trimmed for brevity):
> > 
> >   In file included from mm/mprotect.c:13:
> >   In file included from ./include/linux/hugetlb.h:28:
> >   In file included from ./include/linux/mempolicy.h:16:
> >   ./include/linux/pagemap.h:772:16: warning: variable '__gu_val' is used
> >   uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
> >                   if (unlikely(__get_user(c, uaddr) != 0))
> >                                ^~~~~~~~~~~~~~~~~~~~
> >   ./arch/powerpc/include/asm/uaccess.h:266:2: note: expanded from macro '__get_user'
> >           __get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err);      \
> >           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   ./arch/powerpc/include/asm/uaccess.h:235:2: note: expanded from macro
> >   '__get_user_size_allowed'
> >          default: BUILD_BUG();                                   \
> >          ^~~~~~~
> > 
> > Commit 5cd29b1fd3e8 ("powerpc/uaccess: Use asm goto for get_user when
> > compiler supports it") added an initialization for x because of the same
> > reason. Do the same thing here so there is no warning across all
> > versions of clang.
> 
> Ah yes, I tested with Clang 11 which has CONFIG_CC_HAS_ASM_GOTO_OUTPUT,
> that's the reason why I hit that warning only in the
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT branch.
> 
> But regardless, is that normal that Clang warns that on a never taken branch ? That's puzzling.

It seems to be related to the fact that the value of sizeof is assigned
to a variable. At this point in the pipeline, clang does not realize
that the default branch is never taken because __gu_size has not
actually been evaluated. If you stuck a numeric constant in there, it
would not fire.

A simple example: https://godbolt.org/z/jbrqEbh1j

It is possible that could be improved in clang but I am not sure.

> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1359
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks for taking a look!

Cheers,
Nathan

> > ---
> >   arch/powerpc/include/asm/uaccess.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> > index a4e791bcd3fe..a09e4240c5b1 100644
> > --- a/arch/powerpc/include/asm/uaccess.h
> > +++ b/arch/powerpc/include/asm/uaccess.h
> > @@ -232,7 +232,7 @@ do {								\
> >   	case 2: __get_user_asm(x, (u16 __user *)ptr, retval, "lhz"); break;	\
> >   	case 4: __get_user_asm(x, (u32 __user *)ptr, retval, "lwz"); break;	\
> >   	case 8: __get_user_asm2(x, (u64 __user *)ptr, retval);  break;	\
> > -	default: BUILD_BUG();					\
> > +	default: x = 0; BUILD_BUG();				\
> >   	}							\
> >   } while (0)
> > 
> > base-commit: ee6b25fa7c037e42cc5f3b5c024b2a779edab6dd
> > 
