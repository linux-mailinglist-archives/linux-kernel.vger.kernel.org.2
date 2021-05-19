Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B73389926
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhESWQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhESWQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:16:19 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6B6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 15:14:58 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d25so2810965ioe.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4BGE3cAJ9kHb/1CdQOHmMZv5nnP/8YAg0m2FJ9mK7oA=;
        b=X9KFHKwH/TeimTM1ooxl0X20KzsRI33rRq+Tuj74qpZ8SvfirjPSdFt37Zjaz33OH6
         nn6pbQYyY+9RjDMgNFvIexK0eK2vl1aMDWviasunWrY2BnRpuJOtERnfPEYj93Xe1g0V
         H8MIwALJDPXkNonPBJoNr6wayTT/yN9zub/8VXPs3GXcAhzKKdtx9dX7hLa8Uh/qY1DN
         BgJi6xvogpKYuJ/9IlvDj/WOwMxfRkYlGkebF/fWxV6HX1ZX/0oUzlB6SB/EDsD2COn/
         HEbc21P3h+shGS1ty9aeGYSQNDoZtkN3qe5lAQx4ngn4+pL+Ya1kEvcoU+A6jx0+cb+4
         ogQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BGE3cAJ9kHb/1CdQOHmMZv5nnP/8YAg0m2FJ9mK7oA=;
        b=Mkaj41SB00gjQ/ry8pKRkg25o48irR1syTixbiC0PvXOqdJDUXkQAFOlflPlAK206e
         akLDMtQbM8Sa7rhSeJF9unNrW1AyChkpbf4VVTPNNhZO+KCdoWnP8GITUPRvY4uvZemh
         TqEFOGBOddVWJemlhUJjbKor2+Hp34fSk/ehFpUEtQGrcJJEx+RydJ8CM0E0hXHBJmYc
         BMaqB5+9S57oqCqx9HDGxlikVM4V0dzlouatQMYnj6n7UvnTUU0z2v2QqeYZEqzhVS1A
         brm8eBI55s5gEnZ2A3RSnR0MFFbGpr1W6dKZx5N3IzhsIbF6/sPwbZ+NWImRqItRGgjM
         OkKA==
X-Gm-Message-State: AOAM532Cp+dhB8KPLC8kbY38EACRuFEAJgYlWcaRlLP6aN23OMyJkKH5
        P/FWqeJNGJ1WD1G27tDoMU7ps4gdvWKc5NUvgxPz3g==
X-Google-Smtp-Source: ABdhPJyHbs0vqGXKvVXyLlqXiIy96VY3m7paU3ic7oQQHHvEcoMlnX5zcT+vCzrjWCT9x4OI9aMhU7Y4JAvnAdmHrQ4=
X-Received: by 2002:a6b:3b92:: with SMTP id i140mr1912219ioa.23.1621462497284;
 Wed, 19 May 2021 15:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
 <20210519200339.829146-3-axelrasmussen@google.com> <CANgfPd-dF+vWafBC5DsNhf5C0M12+LxRQLhsBM=CzOKTsep+og@mail.gmail.com>
In-Reply-To: <CANgfPd-dF+vWafBC5DsNhf5C0M12+LxRQLhsBM=CzOKTsep+og@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 19 May 2021 15:14:21 -0700
Message-ID: <CAJHvVcizVoAs+-wOXeO7bc=8c2G3oEC4KSVyPm5E9Z6YMCsvaw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] KVM: selftests: simplify setup_demand_paging
 error handling
To:     Ben Gardon <bgardon@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 2:45 PM Ben Gardon <bgardon@google.com> wrote:
>
> On Wed, May 19, 2021 at 1:03 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > A small cleanup. Our caller writes:
> >
> >   r = setup_demand_paging(...);
> >   if (r < 0) exit(-r);
> >
> > Since we're just going to exit anyway, instead of returning an error we
> > can just re-use TEST_ASSERT. This makes the caller simpler, as well as
> > the function itself - no need to write our branches, etc.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  .../selftests/kvm/demand_paging_test.c        | 51 +++++++------------
> >  1 file changed, 19 insertions(+), 32 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> > index 9398ba6ef023..601a1df24dd2 100644
> > --- a/tools/testing/selftests/kvm/demand_paging_test.c
> > +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> > @@ -9,6 +9,8 @@
> >
> >  #define _GNU_SOURCE /* for pipe2 */
> >
> > +#include <inttypes.h>
> > +#include <stdint.h>
>
> Why do the includes need to change in this commit? Is it for the PRIu64 below?

Right, I didn't actually try compiling without these, but inttypes.h
defines PRIu64 and stdint.h defines uint64_t. In general I tend to
prefer including things like this because we're using their
definitions directly, even if we might be picking them up transiently
some other way.

>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <time.h>
> > @@ -198,42 +200,32 @@ static void *uffd_handler_thread_fn(void *arg)
> >         return NULL;
> >  }
> >
> > -static int setup_demand_paging(struct kvm_vm *vm,
> > -                              pthread_t *uffd_handler_thread, int pipefd,
> > -                              useconds_t uffd_delay,
> > -                              struct uffd_handler_args *uffd_args,
> > -                              void *hva, uint64_t len)
> > +static void setup_demand_paging(struct kvm_vm *vm,
> > +                               pthread_t *uffd_handler_thread, int pipefd,
> > +                               useconds_t uffd_delay,
> > +                               struct uffd_handler_args *uffd_args,
> > +                               void *hva, uint64_t len)
> >  {
> >         int uffd;
> >         struct uffdio_api uffdio_api;
> >         struct uffdio_register uffdio_register;
> >
> >         uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> > -       if (uffd == -1) {
> > -               pr_info("uffd creation failed\n");
> > -               return -1;
> > -       }
> > +       TEST_ASSERT(uffd >= 0, "uffd creation failed, errno: %d", errno);
> >
> >         uffdio_api.api = UFFD_API;
> >         uffdio_api.features = 0;
> > -       if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
> > -               pr_info("ioctl uffdio_api failed\n");
> > -               return -1;
> > -       }
> > +       TEST_ASSERT(ioctl(uffd, UFFDIO_API, &uffdio_api) != -1,
> > +                   "ioctl UFFDIO_API failed: %" PRIu64,
> > +                   (uint64_t)uffdio_api.api);
> >
> >         uffdio_register.range.start = (uint64_t)hva;
> >         uffdio_register.range.len = len;
> >         uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> > -       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
> > -               pr_info("ioctl uffdio_register failed\n");
> > -               return -1;
> > -       }
> > -
> > -       if ((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) !=
> > -                       UFFD_API_RANGE_IOCTLS) {
> > -               pr_info("unexpected userfaultfd ioctl set\n");
> > -               return -1;
> > -       }
> > +       TEST_ASSERT(ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) != -1,
> > +                   "ioctl UFFDIO_REGISTER failed");
> > +       TEST_ASSERT((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) ==
> > +                   UFFD_API_RANGE_IOCTLS, "unexpected userfaultfd ioctl set");
> >
> >         uffd_args->uffd = uffd;
> >         uffd_args->pipefd = pipefd;
> > @@ -243,8 +235,6 @@ static int setup_demand_paging(struct kvm_vm *vm,
> >
> >         PER_VCPU_DEBUG("Created uffd thread for HVA range [%p, %p)\n",
> >                        hva, hva + len);
> > -
> > -       return 0;
> >  }
> >
> >  struct test_params {
> > @@ -321,13 +311,10 @@ static void run_test(enum vm_guest_mode mode, void *arg)
> >                                   O_CLOEXEC | O_NONBLOCK);
> >                         TEST_ASSERT(!r, "Failed to set up pipefd");
> >
> > -                       r = setup_demand_paging(vm,
> > -                                               &uffd_handler_threads[vcpu_id],
> > -                                               pipefds[vcpu_id * 2],
> > -                                               p->uffd_delay, &uffd_args[vcpu_id],
> > -                                               vcpu_hva, vcpu_mem_size);
> > -                       if (r < 0)
> > -                               exit(-r);
> > +                       setup_demand_paging(vm, &uffd_handler_threads[vcpu_id],
> > +                                           pipefds[vcpu_id * 2], p->uffd_delay,
> > +                                           &uffd_args[vcpu_id], vcpu_hva,
> > +                                           vcpu_mem_size);
> >                 }
> >         }
> >
> > --
> > 2.31.1.751.gd2f1c929bd-goog
> >
