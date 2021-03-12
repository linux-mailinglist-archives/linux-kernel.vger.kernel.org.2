Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A80B3398B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhCLUwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235010AbhCLUv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:51:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 390AB64F80;
        Fri, 12 Mar 2021 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615582316;
        bh=n7hLKA65MLnWnyhDn1QhiMolk6b6aTzL+tooLHSLrFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJxryTk9stYCZcWS8oAHCEKZjJxeGQLihWJm2RGh3VtYRlf9UtRFBW/GTCF5Kl75f
         k2Qa16Pf4Ol5Q7gMEe8U3qCFFrIaAMYDLINmREe01y7iRaNsSAl40SybnsRR3nTH96
         82IlW358XXHj91IqoyEjFfTn+txHAlz4N88fNJJdGul7VurYfbxk21CKt8nHNucZa/
         NHM69krP+jXcffSeJJ5rFVlZJZV6nQWjdbAdGJruXUmGh/ao7I6qoR2H+AMdBH/A+X
         C9Wsv9qwfYeA7ORvE8kdLEVWnLJHpbil1b/4A/3DsN1DvA7VTO/fMNy6OD/qNyacdL
         npi5s6LcJFXig==
Date:   Fri, 12 Mar 2021 13:51:51 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fangrui Song <maskray@google.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] gcov: fix clang-11+ support
Message-ID: <20210312205151.orzr7hxhxngnftxi@archlinux-ax161>
References: <20210312192139.2503087-1-ndesaulniers@google.com>
 <20210312195815.2hnhuyk3qo4p7ysr@archlinux-ax161>
 <CAKwvOdnTVobEoOR2n41qsGMZ50ZYBa8zOvV+Lek86r84racidA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnTVobEoOR2n41qsGMZ50ZYBa8zOvV+Lek86r84racidA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 12:14:42PM -0800, Nick Desaulniers wrote:
> On Fri, Mar 12, 2021 at 11:58 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Fri, Mar 12, 2021 at 11:21:39AM -0800, Nick Desaulniers wrote:
> > > LLVM changed the expected function signatures for llvm_gcda_start_file()
> > > and llvm_gcda_emit_function() in the clang-11 release. Users of clang-11
> > > or newer may have noticed their kernels failing to boot due to a panic
> > > when enabling CONFIG_GCOV_KERNEL=y +CONFIG_GCOV_PROFILE_ALL=y.  Fix up
> > > the function signatures so calling these functions doesn't panic the
> > > kernel.
> > >
> > > When we drop clang-10 support from the kernel, we should carefully
> > > update the original implementations to try to preserve git blame,
> > > deleting these implementations.
> > >
> > > Link: https://reviews.llvm.org/rGcdd683b516d147925212724b09ec6fb792a40041
> > > Link: https://reviews.llvm.org/rG13a633b438b6500ecad9e4f936ebadf3411d0f44
> > > Cc: Fangrui Song <maskray@google.com>
> > > Reported-by: Prasad Sodagudi<psodagud@quicinc.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > I can reproduce the panic (as a boot hang) in QEMU before this patch and
> > it is resolved after it so:
> >
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> >
> > However, the duplication hurts :( would it potentially be better to just
> > do the full update to clang-11+ and require it for CONFIG_GCOV_KERNEL?
> >
> >     depends on CC_IS_GCC || CLANG_VERSION >= 110000?
> 
> I'm not opposed, and value your input on the matter.  Either way, this
> will need to be back ported to stable.  Should we be concerned with
> users of stable's branches before we mandated clang-10 as the minimum
> supported version?
> 
> commit 1f7a44f63e6c ("compiler-clang: add build check for clang 10.0.1")
> 
> first landed in v5.10-rc1. Does not exist in v5.4.y.  The diff you

Hmmm fair point, I did not realize that this support had landed in 5.2
meaning that 5.4 needs it as well at 5.10.

> suggest is certainly easier to review to observe the differences, and
> I we don't have users of the latest Android or CrOS kernels using
> older clang, but I suspect there may be older kernel versions where if
> they try to upgrade their version of clang, GCOV support will regress
> for them.  Though, I guess that's fine since either approach will fix
> this for them. I guess if they don't want to upgrade from clang-10 say
> for example, then this approach can be backported to stable.

If people are happy with this approach, it is the more "stable friendly"
change because it fixes it for all versions of clang that should have
been supported at their respective times. Maybe it is worthwhile to do
both? This change gets picked up with a Cc: stable@vger.kernel.org then
in a follow up patch, we remove the #ifdef's and gate GCOV on clang-11?
The CLANG_VERSION string is usually what we will search for when
removing old workarounds. Additionally, your patch could just use

#if CLANG_VERSION <= 110000

to more easily see this. I have no strong opinion one way or the other
though. If people are happy with this approach, let's do it.

Cheers,
Nathan

> >
> > > ---
> > >  kernel/gcov/clang.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 69 insertions(+)
> > >
> > > diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> > > index c94b820a1b62..20e6760ec05d 100644
> > > --- a/kernel/gcov/clang.c
> > > +++ b/kernel/gcov/clang.c
> > > @@ -75,7 +75,9 @@ struct gcov_fn_info {
> > >
> > >       u32 num_counters;
> > >       u64 *counters;
> > > +#if __clang_major__ < 11
> > >       const char *function_name;
> > > +#endif
> > >  };
> > >
> > >  static struct gcov_info *current_info;
> > > @@ -105,6 +107,7 @@ void llvm_gcov_init(llvm_gcov_callback writeout, llvm_gcov_callback flush)
> > >  }
> > >  EXPORT_SYMBOL(llvm_gcov_init);
> > >
> > > +#if __clang_major__ < 11
> > >  void llvm_gcda_start_file(const char *orig_filename, const char version[4],
> > >               u32 checksum)
> > >  {
> > > @@ -113,7 +116,17 @@ void llvm_gcda_start_file(const char *orig_filename, const char version[4],
> > >       current_info->checksum = checksum;
> > >  }
> > >  EXPORT_SYMBOL(llvm_gcda_start_file);
> > > +#else
> > > +void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum)
> > > +{
> > > +     current_info->filename = orig_filename;
> > > +     current_info->version = version;
> > > +     current_info->checksum = checksum;
> > > +}
> > > +EXPORT_SYMBOL(llvm_gcda_start_file);
> > > +#endif
> > >
> > > +#if __clang_major__ < 11
> > >  void llvm_gcda_emit_function(u32 ident, const char *function_name,
> > >               u32 func_checksum, u8 use_extra_checksum, u32 cfg_checksum)
> > >  {
> > > @@ -133,6 +146,24 @@ void llvm_gcda_emit_function(u32 ident, const char *function_name,
> > >       list_add_tail(&info->head, &current_info->functions);
> > >  }
> > >  EXPORT_SYMBOL(llvm_gcda_emit_function);
> > > +#else
> > > +void llvm_gcda_emit_function(u32 ident, u32 func_checksum,
> > > +             u8 use_extra_checksum, u32 cfg_checksum)
> > > +{
> > > +     struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
> > > +
> > > +     if (!info)
> > > +             return;
> > > +
> > > +     INIT_LIST_HEAD(&info->head);
> > > +     info->ident = ident;
> > > +     info->checksum = func_checksum;
> > > +     info->use_extra_checksum = use_extra_checksum;
> > > +     info->cfg_checksum = cfg_checksum;
> > > +     list_add_tail(&info->head, &current_info->functions);
> > > +}
> > > +EXPORT_SYMBOL(llvm_gcda_emit_function);
> > > +#endif
> > >
> > >  void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters)
> > >  {
> > > @@ -295,6 +326,7 @@ void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
> > >       }
> > >  }
> > >
> > > +#if __clang_major__ < 11
> > >  static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
> > >  {
> > >       size_t cv_size; /* counter values size */
> > > @@ -322,6 +354,28 @@ static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
> > >       kfree(fn_dup);
> > >       return NULL;
> > >  }
> > > +#else
> > > +static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
> > > +{
> > > +     size_t cv_size; /* counter values size */
> > > +     struct gcov_fn_info *fn_dup = kmemdup(fn, sizeof(*fn),
> > > +                     GFP_KERNEL);
> > > +     if (!fn_dup)
> > > +             return NULL;
> > > +     INIT_LIST_HEAD(&fn_dup->head);
> > > +
> > > +     cv_size = fn->num_counters * sizeof(fn->counters[0]);
> > > +     fn_dup->counters = vmalloc(cv_size);
> > > +     if (!fn_dup->counters) {
> > > +             kfree(fn_dup);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     memcpy(fn_dup->counters, fn->counters, cv_size);
> > > +
> > > +     return fn_dup;
> > > +}
> > > +#endif
> > >
> > >  /**
> > >   * gcov_info_dup - duplicate profiling data set
> > > @@ -362,6 +416,7 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
> > >   * gcov_info_free - release memory for profiling data set duplicate
> > >   * @info: profiling data set duplicate to free
> > >   */
> > > +#if __clang_major__ < 11
> > >  void gcov_info_free(struct gcov_info *info)
> > >  {
> > >       struct gcov_fn_info *fn, *tmp;
> > > @@ -375,6 +430,20 @@ void gcov_info_free(struct gcov_info *info)
> > >       kfree(info->filename);
> > >       kfree(info);
> > >  }
> > > +#else
> > > +void gcov_info_free(struct gcov_info *info)
> > > +{
> > > +     struct gcov_fn_info *fn, *tmp;
> > > +
> > > +     list_for_each_entry_safe(fn, tmp, &info->functions, head) {
> > > +             vfree(fn->counters);
> > > +             list_del(&fn->head);
> > > +             kfree(fn);
> > > +     }
> > > +     kfree(info->filename);
> > > +     kfree(info);
> > > +}
> > > +#endif
> > >
> > >  #define ITER_STRIDE  PAGE_SIZE
> > >
> > >
> > > base-commit: f78d76e72a4671ea52d12752d92077788b4f5d50
> > > --
> > > 2.31.0.rc2.261.g7f71774620-goog
> > >
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
