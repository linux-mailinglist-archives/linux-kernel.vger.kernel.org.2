Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D379E339815
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhCLUPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbhCLUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:14:56 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C66C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:14:55 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 16so8787362ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qU0gl5uKQ0B+uAaqmPScMXDjNGZ5YlPDwsCmS9RV+0=;
        b=FH2ccx7L1rRN39GF/paQUOT0M3DO0lDuhSRq+NkEq5638kBJ7SlSyZ6VFZRIVBXu0u
         I5totygusq7cIVWyeHV4FnjRtiWrhu81qjBSi/nBt0uumBtuSz2b3VOG7sYkpq0PDYTA
         Ok1PFXH03U1gzu9BiQwr67eS9W3lJnlQ96SWIGbLXIjD+fYCra02WAw57PD1b9zfXijr
         4qcfYR3hHXAksrVwsyYSBMv4oyAasr0R2AxeQ7WKx7nJ5HEDGCewzOZAQHz3Ly5fQ2uO
         W9xuFYgP95G+zkFgiPV0jOHfxgo6i6iwU4KuFPzNcCL9GCeNTpYh8PXhD5+ca83Ckh9r
         M3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qU0gl5uKQ0B+uAaqmPScMXDjNGZ5YlPDwsCmS9RV+0=;
        b=evrve8iiPdrk5VK1ubbd1rmneBZ/SlRmHPpOr80FwHTwlG6vYdB1ilVkizXjmZvPgJ
         3kKc6gNSvt96zAEdrZOps258WyJmAX/jIPumskTirXyJNBjoAlNKnudHdE96TH7iy1yU
         Yinr4/2T6al1mxs2aWib2PXrPlzZIsOS2DGyDuiGIQ/6d1rI7mdpqbff4U9AE0xXqSSc
         DJjSb40Z/izUuoXyfiubMYgxB0cb6BYuVYwYXuAb6+bnMeAQvgOaRyxapnDsV+treTD+
         vpd40MUN+BGbNhgduQ5byMxhQAo71yrgb6yGaJH4wWJo1V6xqaTn81vTDp1SI8gX4tEu
         7QEg==
X-Gm-Message-State: AOAM530UnOYMnD69DP8OUR7JeNqP/nTKWonIzdxsZf+ymorAS3JbgvIh
        MnBUCUx5s2ur/JAPU+/1AgxQ7TEyM2Zfaxl/vYiWmg==
X-Google-Smtp-Source: ABdhPJzAWkjxKIyotg3sDQyKClIKs7X9v7VdnnAnAi3k2pE7hX0WCudG/nrZMShmmaHcuFZsXnyphKnULyBlwaCWomU=
X-Received: by 2002:a19:5055:: with SMTP id z21mr511114lfj.297.1615580093852;
 Fri, 12 Mar 2021 12:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20210312192139.2503087-1-ndesaulniers@google.com> <20210312195815.2hnhuyk3qo4p7ysr@archlinux-ax161>
In-Reply-To: <20210312195815.2hnhuyk3qo4p7ysr@archlinux-ax161>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Mar 2021 12:14:42 -0800
Message-ID: <CAKwvOdnTVobEoOR2n41qsGMZ50ZYBa8zOvV+Lek86r84racidA@mail.gmail.com>
Subject: Re: [PATCH] gcov: fix clang-11+ support
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fangrui Song <maskray@google.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 11:58 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Mar 12, 2021 at 11:21:39AM -0800, Nick Desaulniers wrote:
> > LLVM changed the expected function signatures for llvm_gcda_start_file()
> > and llvm_gcda_emit_function() in the clang-11 release. Users of clang-11
> > or newer may have noticed their kernels failing to boot due to a panic
> > when enabling CONFIG_GCOV_KERNEL=y +CONFIG_GCOV_PROFILE_ALL=y.  Fix up
> > the function signatures so calling these functions doesn't panic the
> > kernel.
> >
> > When we drop clang-10 support from the kernel, we should carefully
> > update the original implementations to try to preserve git blame,
> > deleting these implementations.
> >
> > Link: https://reviews.llvm.org/rGcdd683b516d147925212724b09ec6fb792a40041
> > Link: https://reviews.llvm.org/rG13a633b438b6500ecad9e4f936ebadf3411d0f44
> > Cc: Fangrui Song <maskray@google.com>
> > Reported-by: Prasad Sodagudi<psodagud@quicinc.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> I can reproduce the panic (as a boot hang) in QEMU before this patch and
> it is resolved after it so:
>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>
> However, the duplication hurts :( would it potentially be better to just
> do the full update to clang-11+ and require it for CONFIG_GCOV_KERNEL?
>
>     depends on CC_IS_GCC || CLANG_VERSION >= 110000?

I'm not opposed, and value your input on the matter.  Either way, this
will need to be back ported to stable.  Should we be concerned with
users of stable's branches before we mandated clang-10 as the minimum
supported version?

commit 1f7a44f63e6c ("compiler-clang: add build check for clang 10.0.1")

first landed in v5.10-rc1. Does not exist in v5.4.y.  The diff you
suggest is certainly easier to review to observe the differences, and
I we don't have users of the latest Android or CrOS kernels using
older clang, but I suspect there may be older kernel versions where if
they try to upgrade their version of clang, GCOV support will regress
for them.  Though, I guess that's fine since either approach will fix
this for them. I guess if they don't want to upgrade from clang-10 say
for example, then this approach can be backported to stable.

>
> > ---
> >  kernel/gcov/clang.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >
> > diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> > index c94b820a1b62..20e6760ec05d 100644
> > --- a/kernel/gcov/clang.c
> > +++ b/kernel/gcov/clang.c
> > @@ -75,7 +75,9 @@ struct gcov_fn_info {
> >
> >       u32 num_counters;
> >       u64 *counters;
> > +#if __clang_major__ < 11
> >       const char *function_name;
> > +#endif
> >  };
> >
> >  static struct gcov_info *current_info;
> > @@ -105,6 +107,7 @@ void llvm_gcov_init(llvm_gcov_callback writeout, llvm_gcov_callback flush)
> >  }
> >  EXPORT_SYMBOL(llvm_gcov_init);
> >
> > +#if __clang_major__ < 11
> >  void llvm_gcda_start_file(const char *orig_filename, const char version[4],
> >               u32 checksum)
> >  {
> > @@ -113,7 +116,17 @@ void llvm_gcda_start_file(const char *orig_filename, const char version[4],
> >       current_info->checksum = checksum;
> >  }
> >  EXPORT_SYMBOL(llvm_gcda_start_file);
> > +#else
> > +void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum)
> > +{
> > +     current_info->filename = orig_filename;
> > +     current_info->version = version;
> > +     current_info->checksum = checksum;
> > +}
> > +EXPORT_SYMBOL(llvm_gcda_start_file);
> > +#endif
> >
> > +#if __clang_major__ < 11
> >  void llvm_gcda_emit_function(u32 ident, const char *function_name,
> >               u32 func_checksum, u8 use_extra_checksum, u32 cfg_checksum)
> >  {
> > @@ -133,6 +146,24 @@ void llvm_gcda_emit_function(u32 ident, const char *function_name,
> >       list_add_tail(&info->head, &current_info->functions);
> >  }
> >  EXPORT_SYMBOL(llvm_gcda_emit_function);
> > +#else
> > +void llvm_gcda_emit_function(u32 ident, u32 func_checksum,
> > +             u8 use_extra_checksum, u32 cfg_checksum)
> > +{
> > +     struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
> > +
> > +     if (!info)
> > +             return;
> > +
> > +     INIT_LIST_HEAD(&info->head);
> > +     info->ident = ident;
> > +     info->checksum = func_checksum;
> > +     info->use_extra_checksum = use_extra_checksum;
> > +     info->cfg_checksum = cfg_checksum;
> > +     list_add_tail(&info->head, &current_info->functions);
> > +}
> > +EXPORT_SYMBOL(llvm_gcda_emit_function);
> > +#endif
> >
> >  void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters)
> >  {
> > @@ -295,6 +326,7 @@ void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
> >       }
> >  }
> >
> > +#if __clang_major__ < 11
> >  static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
> >  {
> >       size_t cv_size; /* counter values size */
> > @@ -322,6 +354,28 @@ static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
> >       kfree(fn_dup);
> >       return NULL;
> >  }
> > +#else
> > +static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
> > +{
> > +     size_t cv_size; /* counter values size */
> > +     struct gcov_fn_info *fn_dup = kmemdup(fn, sizeof(*fn),
> > +                     GFP_KERNEL);
> > +     if (!fn_dup)
> > +             return NULL;
> > +     INIT_LIST_HEAD(&fn_dup->head);
> > +
> > +     cv_size = fn->num_counters * sizeof(fn->counters[0]);
> > +     fn_dup->counters = vmalloc(cv_size);
> > +     if (!fn_dup->counters) {
> > +             kfree(fn_dup);
> > +             return NULL;
> > +     }
> > +
> > +     memcpy(fn_dup->counters, fn->counters, cv_size);
> > +
> > +     return fn_dup;
> > +}
> > +#endif
> >
> >  /**
> >   * gcov_info_dup - duplicate profiling data set
> > @@ -362,6 +416,7 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
> >   * gcov_info_free - release memory for profiling data set duplicate
> >   * @info: profiling data set duplicate to free
> >   */
> > +#if __clang_major__ < 11
> >  void gcov_info_free(struct gcov_info *info)
> >  {
> >       struct gcov_fn_info *fn, *tmp;
> > @@ -375,6 +430,20 @@ void gcov_info_free(struct gcov_info *info)
> >       kfree(info->filename);
> >       kfree(info);
> >  }
> > +#else
> > +void gcov_info_free(struct gcov_info *info)
> > +{
> > +     struct gcov_fn_info *fn, *tmp;
> > +
> > +     list_for_each_entry_safe(fn, tmp, &info->functions, head) {
> > +             vfree(fn->counters);
> > +             list_del(&fn->head);
> > +             kfree(fn);
> > +     }
> > +     kfree(info->filename);
> > +     kfree(info);
> > +}
> > +#endif
> >
> >  #define ITER_STRIDE  PAGE_SIZE
> >
> >
> > base-commit: f78d76e72a4671ea52d12752d92077788b4f5d50
> > --
> > 2.31.0.rc2.261.g7f71774620-goog
> >



-- 
Thanks,
~Nick Desaulniers
