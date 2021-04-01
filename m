Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE54351FC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhDAT1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbhDAT1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:27:36 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485AAC05BD22
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 12:04:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r17so2981464ilt.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LLQJNEFOm9Ts0HUhzhDYAp21SAMZYQh+9Qju2BbjdB0=;
        b=Qxc0FnWBJ2czSRGeVki6p9Xkb4bmzXi0TPubVhl04YQ6ThlbF5FFkUjZx2tR90gNes
         CI/hluPyHg559uQCWvomMqT1ti3/qHIiZu227TasC3XhKZZPMi6oQWWTDPDLxgyaoAjS
         DFPsRrck9q0xACPWBFX3cNX6HoH5uSOUEXyQLriF3TsanQ7DouMypYtTcixtOG02lg8P
         zUMfDNzU5v7j3YcdPEKr1FWBpo9vL4+AjKJ9Bz9BEk1CSr+9t2nWsz0iPpcTDVMxmy4S
         y6WK2r7M1R4Vi77wmhESPOmFaKItP5C9oawB9t3LeXZLe4vieTioEKzhma2XQMJPviK8
         cTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLQJNEFOm9Ts0HUhzhDYAp21SAMZYQh+9Qju2BbjdB0=;
        b=dyAGvIb/RNh+uK+qM69Sj1V9YIDU/Lo5/B+FqzGaTlKcBBnKFNoXxwldujOEVMCz9v
         N+W4VXYuKrj4+KfVwS/s0gvmZSKeR7aBr+GjH1IAUaTK6FW39UQhkR9F49HKoMbdv6B/
         ZwFZdgpG2YRIUl/3pcX3ey697xs5MrIUgZssMPxN1lHYypN5E0quznDiAnPoJMhNbvoc
         Su6rGuoI+SWKB8vFJeCh4aGvFYphDviU6gIw2xf6P2Z/Sw40zr1Z2d5iiC44ZR6MTNej
         EpVeJ9H671b6RH9X031BkqK0fJolKYcBDRX8fzOMUMi+c8L6GN+MNdiLAzj2vXCf0I6F
         fWkQ==
X-Gm-Message-State: AOAM531YHdf+oVU6kz6N4LEkBcz6wuO/Ja9JVQb1w+Nu5lta44ymIHZ2
        Qa3vxYw+thJmfcs52adPSEHq7JsvG95OAqgfW2e+jA==
X-Google-Smtp-Source: ABdhPJzx3EiN+FEoA8TNrHIX67Zp92OvZLBYZQtRu5X+v4j+cxQDVYv5uVm+dF7p8dDEq5hF/R2K3jOPzBF6w/YSoeY=
X-Received: by 2002:a05:6e02:214d:: with SMTP id d13mr8205778ilv.136.1617303882392;
 Thu, 01 Apr 2021 12:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210331085156.5028-1-glittao@gmail.com> <YGWPdFywfNUl4d3S@elver.google.com>
In-Reply-To: <YGWPdFywfNUl4d3S@elver.google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 1 Apr 2021 12:04:30 -0700
Message-ID: <CAGS_qxpWtNLJ7_i5pDYhiGq_Jy+oPPc+HpWjNTJKAPyvQf+gsQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: add a KUnit test for SLUB debugging functionality
To:     Marco Elver <elver@google.com>
Cc:     glittao@gmail.com, cl@linux.com, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 2:16 AM 'Marco Elver' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> [Note, if you'd like me to see future versions, please Cc me, otherwise
> it's unlikely I see it in time. Also add kunit-dev@googlegroups.com if
> perhaps a KUnit dev should have another look, too.]
>
> On Wed, Mar 31, 2021 at 10:51AM +0200, glittao@gmail.com wrote:
> > From: Oliver Glitta <glittao@gmail.com>
> >
> > SLUB has resiliency_test() function which is hidden behind #ifdef
> > SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> > runs it. KUnit should be a proper replacement for it.
> >
> > Try changing byte in redzone after allocation and changing
> > pointer to next free node, first byte, 50th byte and redzone
> > byte. Check if validation finds errors.
> >
> > There are several differences from the original resiliency test:
> > Tests create own caches with known state instead of corrupting
> > shared kmalloc caches.
> >
> > The corruption of freepointer uses correct offset, the original
> > resiliency test got broken with freepointer changes.
> >
> > Scratch changing random byte test, because it does not have
> > meaning in this form where we need deterministic results.
> >
> > Add new option CONFIG_SLUB_KUNIT_TEST in Kconfig.
> >
> > Add a counter field "errors" to struct kmem_cache to count number
> > of errors detected in cache.
> >
> > Silence bug report in SLUB test. Add SLAB_SILENT_ERRORS debug flag.
> > Add SLAB_SILENT_ERRORS flag to SLAB_NEVER_MERGE, SLAB_DEBUG_FLAGS,
> > SLAB_FLAGS_PERMITTED macros.
> >
> > Signed-off-by: Oliver Glitta <glittao@gmail.com>
> > ---
> > Changes since v2
> >
> > Use bit operation & instead of logical && as reported by kernel test
> > robot and Dan Carpenter
> >
> > Changes since v1
> >
> > Conversion from kselftest to KUnit test suggested by Marco Elver.
> > Error silencing.
> > Error counting improvements.
> >
> >  include/linux/slab.h     |   2 +
> >  include/linux/slub_def.h |   2 +
> >  lib/Kconfig.debug        |   5 ++
> >  lib/Makefile             |   1 +
> >  lib/test_slub.c          | 124 +++++++++++++++++++++++++++++++++++++++
> >  mm/slab.h                |   7 ++-
> >  mm/slab_common.c         |   2 +-
> >  mm/slub.c                |  64 +++++++++++++-------
> >  8 files changed, 184 insertions(+), 23 deletions(-)
> >  create mode 100644 lib/test_slub.c
> >
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 7ae604076767..ed1a5a64d028 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -25,6 +25,8 @@
> >   */
> >  /* DEBUG: Perform (expensive) checks on alloc/free */
> >  #define SLAB_CONSISTENCY_CHECKS      ((slab_flags_t __force)0x00000100U)
> > +/* DEBUG: Silent bug reports */
> > +#define SLAB_SILENT_ERRORS   ((slab_flags_t __force)0x00000200U)
>
> This flag wouldn't be necessary if you do the design using
> kunit_resource (see below).
>
> (But perhaps I missed a conversation that said that this flag is
> generally useful, but if so, it should probably be in a separate patch
> justifying why it is required beyond the test.)
>
> >  /* DEBUG: Red zone objs in a cache */
> >  #define SLAB_RED_ZONE                ((slab_flags_t __force)0x00000400U)
> >  /* DEBUG: Poison objects */
> > diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> > index dcde82a4434c..e4b51bb5bb83 100644
> > --- a/include/linux/slub_def.h
> > +++ b/include/linux/slub_def.h
> > @@ -133,6 +133,8 @@ struct kmem_cache {
> >       unsigned int usersize;          /* Usercopy region size */
> >
> >       struct kmem_cache_node *node[MAX_NUMNODES];
> > +
> > +     int errors;                     /* Number of errors in cache */
>
> So, I think it's bad design to add a new field 'errors', just for the
> test. This will increase kmem_cache size for all builds, which is
> unnecessary.
>
> Is there use to retrieve 'errors' elsewhere?
>
> While you could guard this with #ifdef CONFIG_SLUB_DEBUG or so, there's
> a better design option if this is just for the KUnit test's benefit: use
> kunit_resource.
>
> The way it'd work is that for each test (you can add a common init
> function) you add a named resource, in this case just an 'int' I guess,
> that slab would be able to retrieve if this test is being run.
>
> In the test somewhere, you could add something like this:
>
>
>         static struct kunit_resource resource;
>         static int slab_errors;
>
>         ..........
>
>         static int test_init(struct kunit *test)
>         {
>                 slab_errors = 0;
>                 kunit_add_named_resource(test, NULL, NULL, &resource,
>                                          "slab_errors", &slab_errors);
>                 return 0;
>         }
>
>         ...... tests now check slab_errors .....
>
> and then in slub.c you'd have:
>
>         #if IS_ENABLED(CONFIG_KUNIT)
>         static bool slab_add_kunit_errors(void)
>         {
>                 struct kunit_resource *resource;
>
>                 if (likely(!current->kunit_test))
>                         return false;
>                 resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
>                 if (!resource)
>                         return false;
>                 (*(int *)resource->data)++;
>                 kunit_put_resource(resource);
>         }
>         #else
>         static inline bool slab_add_kunit_errors(void) { return false; }
>         #endif
>
> And anywhere you want to increase the error count, you'd call
> slab_add_kunit_errors().
>
> Another benefit of this approach is that if KUnit is disabled, there is
> zero overhead and no additional code generated (vs. the current
> approach).

The resource approach looks really good, but...
You'd be picking up a dependency on
https://lore.kernel.org/linux-kselftest/20210311152314.3814916-2-dlatypov@google.com/
current->kunit_test will always be NULL unless CONFIG_KASAN=y &&
CONFIG_KUNIT=y at the moment.
My patch drops the CONFIG_KASAN requirement and opens it up to all tests.

At the moment, it's just waiting another look over from Brendan or David.
Any ETA on that, folks? :)

So if you don't want to get blocked on that for now, I think it's fine to add:
  #ifdef CONFIG_SLUB_KUNIT_TEST
  int errors;
  #endif

Side note: the resource example is really good, and maybe we should
steal it and add it near
https://www.kernel.org/doc/html/latest/dev-tools/kunit/tips.html#injecting-test-only-code
I had plans to update that section at some point after my patch landed
and added in `kunit_fail_current_test()`.
But this is an interesting inversion of that where we want the test to
only pass if that code gets executed.


>
> >  };
> >
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 2779c29d9981..e0dec830c269 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2371,6 +2371,11 @@ config BITS_TEST
> >
> >         If unsure, say N.
> >
> > +config SLUB_KUNIT_TEST
> > +     tristate "KUnit Test for SLUB cache error detection" if !KUNIT_ALL_TESTS
> > +     depends on SLUB_DEBUG && KUNIT
> > +     default KUNIT_ALL_TESTS
>
> Help text please.
>
> > +
> >  config TEST_UDELAY
> >       tristate "udelay test driver"
> >       help
> > diff --git a/lib/Makefile b/lib/Makefile
> > index b5307d3eec1a..e1eb986c0e87 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -352,5 +352,6 @@ obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> >  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> >  obj-$(CONFIG_BITS_TEST) += test_bits.o
> >  obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
> > +obj-$(CONFIG_SLUB_KUNIT_TEST) += test_slub.o
>
> Any reason to not name this slub_kunit.c? This is a new test, and it
> could follow the naming convention of the other KUnit tests.
>
> Some of it is also documented:
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html
>
> >  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
> > diff --git a/lib/test_slub.c b/lib/test_slub.c
> > new file mode 100644
> > index 000000000000..4f8ea3c7d867
> > --- /dev/null
> > +++ b/lib/test_slub.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <kunit/test.h>
> > +#include <linux/mm.h>
> > +#include <linux/slab.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include "../mm/slab.h"
> > +
> > +
> > +static void test_clobber_zone(struct kunit *test)
> > +{
> > +     struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_alloc", 64, 0,
> > +                             SLAB_RED_ZONE | SLAB_SILENT_ERRORS, NULL);
> > +     u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> > +
> > +     p[64] = 0x12;
> > +
> > +     validate_slab_cache(s);
> > +     KUNIT_EXPECT_EQ(test, 1, s->errors);
> > +
> > +     kmem_cache_free(s, p);
> > +     kmem_cache_destroy(s);
> > +}
> > +
> > +static void test_next_pointer(struct kunit *test)
> > +{
> > +     struct kmem_cache *s = kmem_cache_create("TestSlub_next_ptr_free", 64, 0,
> > +                             SLAB_POISON | SLAB_SILENT_ERRORS, NULL);
> > +     u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> > +     unsigned long tmp;
> > +     unsigned long *ptr_addr;
> > +
> > +     kmem_cache_free(s, p);
> > +
> > +     ptr_addr = (unsigned long *)(p + s->offset);
> > +     tmp = *ptr_addr;
> > +     p[s->offset] = 0x12;
> > +
> > +     /*
> > +      * Expecting two errors.
> > +      * One for the corrupted freechain and the other one for the wrong
> > +      * count of objects in use.
> > +      */
> > +     validate_slab_cache(s);
> > +     KUNIT_EXPECT_EQ(test, 2, s->errors);
> > +
> > +     /*
> > +      * Try to repair corrupted freepointer.
> > +      * Still expecting one error for the wrong count of objects in use.
> > +      */
> > +     *ptr_addr = tmp;
> > +
> > +     validate_slab_cache(s);
> > +     KUNIT_EXPECT_EQ(test, 1, s->errors);
> > +
> > +     /*
> > +      * Previous validation repaired the count of objects in use.
> > +      * Now expecting no error.
> > +      */
> > +     validate_slab_cache(s);
> > +     KUNIT_EXPECT_EQ(test, 0, s->errors);
> > +
> > +     kmem_cache_destroy(s);
> > +}
> > +
> > +static void test_first_word(struct kunit *test)
> > +{
> > +     struct kmem_cache *s = kmem_cache_create("TestSlub_1th_word_free", 64, 0,
> > +                             SLAB_POISON | SLAB_SILENT_ERRORS, NULL);
> > +     u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> > +
> > +     kmem_cache_free(s, p);
> > +     *p = 0x78;
> > +
> > +     validate_slab_cache(s);
> > +     KUNIT_EXPECT_EQ(test, 1, s->errors);
> > +
> > +     kmem_cache_destroy(s);
> > +}
> > +
> > +static void test_clobber_50th_byte(struct kunit *test)
> > +{
> > +     struct kmem_cache *s = kmem_cache_create("TestSlub_50th_word_free", 64, 0,
> > +                             SLAB_POISON | SLAB_SILENT_ERRORS, NULL);
> > +     u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> > +
> > +     kmem_cache_free(s, p);
> > +     p[50] = 0x9a;
> > +
> > +     validate_slab_cache(s);
> > +     KUNIT_EXPECT_EQ(test, 1, s->errors);
> > +     kmem_cache_destroy(s);
> > +}
> > +
> > +static void test_clobber_redzone_free(struct kunit *test)
> > +{
> > +     struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_free", 64, 0,
> > +                             SLAB_RED_ZONE | SLAB_SILENT_ERRORS, NULL);
> > +     u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> > +
> > +     kmem_cache_free(s, p);
> > +     p[64] = 0xab;
> > +
> > +     validate_slab_cache(s);
> > +     KUNIT_EXPECT_EQ(test, 1, s->errors);
> > +     kmem_cache_destroy(s);
> > +}
> > +
> > +static struct kunit_case test_cases[] = {
> > +     KUNIT_CASE(test_clobber_zone),
> > +     KUNIT_CASE(test_next_pointer),
> > +     KUNIT_CASE(test_first_word),
> > +     KUNIT_CASE(test_clobber_50th_byte),
> > +     KUNIT_CASE(test_clobber_redzone_free),
> > +     {}
> > +};
> > +
> > +static struct kunit_suite test_suite = {
> > +     .name = "slub_test",
> > +     .test_cases = test_cases,
>
> Here you could add a
>
>         .init = test_init,
>
> or so, if you go with the kunit_resource design.
>
> > +};
> > +kunit_test_suite(test_suite);
> > +
> > +MODULE_LICENSE("GPL");
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 076582f58f68..382507b6cab9 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -134,7 +134,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
> >  #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
> >  #elif defined(CONFIG_SLUB_DEBUG)
> >  #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
> > -                       SLAB_TRACE | SLAB_CONSISTENCY_CHECKS)
> > +                       SLAB_TRACE | SLAB_CONSISTENCY_CHECKS | \
> > +                       SLAB_SILENT_ERRORS)
> >  #else
> >  #define SLAB_DEBUG_FLAGS (0)
> >  #endif
> > @@ -164,7 +165,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
> >                             SLAB_NOLEAKTRACE | \
> >                             SLAB_RECLAIM_ACCOUNT | \
> >                             SLAB_TEMPORARY | \
> > -                           SLAB_ACCOUNT)
> > +                           SLAB_ACCOUNT | \
> > +                           SLAB_SILENT_ERRORS)
> >
> >  bool __kmem_cache_empty(struct kmem_cache *);
> >  int __kmem_cache_shutdown(struct kmem_cache *);
> > @@ -215,6 +217,7 @@ DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
> >  DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
> >  #endif
> >  extern void print_tracking(struct kmem_cache *s, void *object);
> > +long validate_slab_cache(struct kmem_cache *s);
> >  #else
> >  static inline void print_tracking(struct kmem_cache *s, void *object)
> >  {
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 88e833986332..239c9095e7ea 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -55,7 +55,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
> >   */
> >  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
> >               SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> > -             SLAB_FAILSLAB | kasan_never_merge())
> > +             SLAB_FAILSLAB | SLAB_SILENT_ERRORS | kasan_never_merge())
> >
> >  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
> >                        SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 3021ce9bf1b3..7083e89432d0 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -673,14 +673,16 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
> >
> >  static void slab_fix(struct kmem_cache *s, char *fmt, ...)
> >  {
> > -     struct va_format vaf;
> > -     va_list args;
> > -
> > -     va_start(args, fmt);
> > -     vaf.fmt = fmt;
> > -     vaf.va = &args;
> > -     pr_err("FIX %s: %pV\n", s->name, &vaf);
> > -     va_end(args);
> > +     if (!(s->flags & SLAB_SILENT_ERRORS)) {
>
> This style of guarding causes lots of line diffs.
>
> Instead, if the whole function is to be skipped, please prefer:
>
>         if (skip_things_if_true)
>                 return;
>
> instead of
>
>         if (!skip_things_if_true) {
>                 ...
>         }
>
> here and everywhere else.
>
> Specifically, for the kunit_resource design, this would simply become:
>
>         if (slab_add_kunit_errors())
>                 return;
>
> Meaning that whenever a KUnit test has a resource "slab_errors", no
> messages are printed -- otherwise it'll always print a message.
>
> > +             struct va_format vaf;
> > +             va_list args;
> > +
> > +             va_start(args, fmt);
> > +             vaf.fmt = fmt;
> > +             vaf.va = &args;
> > +             pr_err("FIX %s: %pV\n", s->name, &vaf);
> > +             va_end(args);
> > +     }
> >  }
> >
> >  static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
> > @@ -739,8 +741,10 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
> >  void object_err(struct kmem_cache *s, struct page *page,
> >                       u8 *object, char *reason)
> >  {
> > -     slab_bug(s, "%s", reason);
> > -     print_trailer(s, page, object);
> > +     if (!(s->flags & SLAB_SILENT_ERRORS)) {
> > +             slab_bug(s, "%s", reason);
> > +             print_trailer(s, page, object);
> > +     }
> >  }
> >
> >  static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
> > @@ -752,9 +756,11 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
> >       va_start(args, fmt);
> >       vsnprintf(buf, sizeof(buf), fmt, args);
> >       va_end(args);
> > -     slab_bug(s, "%s", buf);
> > -     print_page_info(page);
> > -     dump_stack();
> > +     if (!(s->flags & SLAB_SILENT_ERRORS)) {
> > +             slab_bug(s, "%s", buf);
> > +             print_page_info(page);
> > +             dump_stack();
> > +     }
> >  }
> >
> >  static void init_object(struct kmem_cache *s, void *object, u8 val)
> > @@ -798,11 +804,13 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
> >       while (end > fault && end[-1] == value)
> >               end--;
> >
> > -     slab_bug(s, "%s overwritten", what);
> > -     pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> > +     if (!(s->flags & SLAB_SILENT_ERRORS)) {
> > +             slab_bug(s, "%s overwritten", what);
> > +             pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> >                                       fault, end - 1, fault - addr,
> >                                       fault[0], value);
> > -     print_trailer(s, page, object);
> > +             print_trailer(s, page, object);
> > +     }
> >
> >       restore_bytes(s, what, value, fault, end);
> >       return 0;
> > @@ -964,6 +972,7 @@ static int check_slab(struct kmem_cache *s, struct page *page)
> >
> >       if (!PageSlab(page)) {
> >               slab_err(s, page, "Not a valid slab page");
> > +             s->errors += 1;
>
> So to me it looks like errors is set whenever there's a slab_err() or
> slab_fix() call. So why not move setting that an error occurred into
> those functions?
>
> >               return 0;
> >       }
> >
> > @@ -971,11 +980,13 @@ static int check_slab(struct kmem_cache *s, struct page *page)
> >       if (page->objects > maxobj) {
> >               slab_err(s, page, "objects %u > max %u",
> >                       page->objects, maxobj);
> > +             s->errors += 1;
> >               return 0;
> >       }
> >       if (page->inuse > page->objects) {
> >               slab_err(s, page, "inuse %u > max %u",
> >                       page->inuse, page->objects);
> > +             s->errors += 1;
> >               return 0;
> >       }
> >       /* Slab_pad_check fixes things up after itself */
> > @@ -1008,8 +1019,10 @@ static int on_freelist(struct kmem_cache *s, struct page *page, void *search)
> >                               page->freelist = NULL;
> >                               page->inuse = page->objects;
> >                               slab_fix(s, "Freelist cleared");
> > +                             s->errors += 1;
> >                               return 0;
> >                       }
> > +                     s->errors += 1;
> >                       break;
> >               }
> >               object = fp;
> > @@ -1026,12 +1039,14 @@ static int on_freelist(struct kmem_cache *s, struct page *page, void *search)
> >                        page->objects, max_objects);
> >               page->objects = max_objects;
> >               slab_fix(s, "Number of objects adjusted.");
> > +             s->errors += 1;
> >       }
> >       if (page->inuse != page->objects - nr) {
> >               slab_err(s, page, "Wrong object count. Counter is %d but counted were %d",
> >                        page->inuse, page->objects - nr);
> >               page->inuse = page->objects - nr;
> >               slab_fix(s, "Object count adjusted.");
> > +             s->errors += 1;
> >       }
> >       return search == NULL;
> >  }
> > @@ -4629,8 +4644,10 @@ static void validate_slab(struct kmem_cache *s, struct page *page)
> >               u8 val = test_bit(__obj_to_index(s, addr, p), map) ?
> >                        SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
> >
> > -             if (!check_object(s, page, p, val))
> > +             if (!check_object(s, page, p, val)) {
> > +                     s->errors += 1;
> >                       break;
> > +             }
> >       }
> >       put_map(map);
> >  unlock:
> > @@ -4650,9 +4667,11 @@ static int validate_slab_node(struct kmem_cache *s,
> >               validate_slab(s, page);
> >               count++;
> >       }
> > -     if (count != n->nr_partial)
> > +     if (count != n->nr_partial) {
> >               pr_err("SLUB %s: %ld partial slabs counted but counter=%ld\n",
> >                      s->name, count, n->nr_partial);
> > +             s->errors += 1;
> > +     }
> >
> >       if (!(s->flags & SLAB_STORE_USER))
> >               goto out;
> > @@ -4661,20 +4680,23 @@ static int validate_slab_node(struct kmem_cache *s,
> >               validate_slab(s, page);
> >               count++;
> >       }
> > -     if (count != atomic_long_read(&n->nr_slabs))
> > +     if (count != atomic_long_read(&n->nr_slabs)) {
> >               pr_err("SLUB: %s %ld slabs counted but counter=%ld\n",
> >                      s->name, count, atomic_long_read(&n->nr_slabs));
> > +             s->errors += 1;
>
> I think these here are a few cases where there's no slab_err() or
> slab_fix() call, and open coding setting errors is still required...
>
> > +     }
> >
> >  out:
> >       spin_unlock_irqrestore(&n->list_lock, flags);
> >       return count;
> >  }
> >
> > -static long validate_slab_cache(struct kmem_cache *s)
> > +long validate_slab_cache(struct kmem_cache *s)
> >  {
> >       int node;
> >       unsigned long count = 0;
> >       struct kmem_cache_node *n;
> > +     s->errors = 0;
>
> This would also go away if you use the kunit_resource design. I also
> think it's better if the test fully controls 'slab_errors', and it isn't
> reset by this function.
>
> >       flush_all(s);
> >       for_each_kmem_cache_node(s, node, n)
> > @@ -4682,6 +4704,8 @@ static long validate_slab_cache(struct kmem_cache *s)
> >
> >       return count;
> >  }
> > +EXPORT_SYMBOL(validate_slab_cache);
> > +
> >  /*
> >   * Generate lists of code addresses where slabcache objects are allocated
> >   * and freed.
> > --
> > 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/YGWPdFywfNUl4d3S%40elver.google.com.
