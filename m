Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF441F93A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 03:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhJBBnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 21:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhJBBnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 21:43:20 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FCCC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 18:41:35 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h129so13741149iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 18:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgEscKj+8UDBDiRhNzMMOlJXsRPIFTvm7YYXD1gUv8E=;
        b=GMxeIr7kErI/fOs955L9lS8dIs2Tbf+tfumHdpyJL21unUR3IyiCKtql/QihBeibiv
         VBDxB2QfIJZ9hMa4duYKlHzQK+f96VE14KsAGbs1MCdsgc/i/l8m83iBEqep8pyOLxTM
         5AbLHOJosf/DswM066035bVw0Uc69nYQ2x2ldtkGWo5FA7EmnZ+ixc42YF3P/gR79shW
         w4UrXki8W1NGpUOcNdf9K4y+CXmHsbjBAELwUQNif8gd1aBd2UbGtSA69HrNHtugR5Gj
         qpofF2brR7N+3l+0XYOqbYukGkqj8V0E8CeYxyHtiN3DBWlxlXmjhCkUm0o5bYUX9AQ0
         XmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgEscKj+8UDBDiRhNzMMOlJXsRPIFTvm7YYXD1gUv8E=;
        b=ob3eTKIv0lIEU7yUuyoi6qLL10BnbzlktXtG1/JC+AxGOQlPAm221xn+ivk6IKKn8v
         CHwfYElTj6vqFx7YULwPevIc+8T3/sWaj5q8VE3Qh3hChGQEoWaAVJ9FE/1kC01KjWU9
         88pBhKMZdxFuwWQlyhqq496leap+sJky/0iWAtKoWXCzMWT0ED11Leb+bZFUMXDw/+ub
         wOP+8TuayVW5ufK3jL6lRd1jLlRC/kpkN2AzhWM2YsfShHGZOqxKWV9o1BxmxPiBNUlb
         tX8lpVyu+3BPOC0rJWEl45zJsfO2lSziH5ghMnktHwNf1t37MjudsiiOpAOjejXkEGs0
         TIfw==
X-Gm-Message-State: AOAM532Sv263FD1DHypGwonDyYVxGRLWkqT0fmlCwEzIVnWYoITlXr4o
        FM36nMRA+AQTWQqxSKGkay+3TD39wJMudo9L1DT1bw==
X-Google-Smtp-Source: ABdhPJzvGeuzcQcAzfGI6d//ekmtuNT9ritBdXrRty2n1+LDUT7cOC5fqcYgfL980xXbsLdaRSQKc37zpi23Vm9f/jw=
X-Received: by 2002:a05:6638:59:: with SMTP id a25mr933541jap.92.1633138894629;
 Fri, 01 Oct 2021 18:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210930063730.GC29843@xsang-OptiPlex-9020> <CAGS_qxrY53c9jY50ujpgnyqWTuLbgayK6StEn5rAA0+7vnyRpg@mail.gmail.com>
In-Reply-To: <CAGS_qxrY53c9jY50ujpgnyqWTuLbgayK6StEn5rAA0+7vnyRpg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 1 Oct 2021 18:41:22 -0700
Message-ID: <CAGS_qxrH25tAvXxk8rvNZQuKwQ2aDDrosawLpsezj5Fm3k1LnQ@mail.gmail.com>
Subject: Re: [kunit] 3b29021ddd: BUG:kernel_NULL_pointer_dereference,address
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:14 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, Sep 29, 2021 at 11:17 PM kernel test robot
> <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Greeting,
> >
> > FYI, we noticed the following commit (built with clang-14):
> >
> > commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33 ("kunit: tool: allow filtering test cases via glob")
> > https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git kunit
> >
> >
> > in testcase: boot
> >
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> > +--------------------------------------------------------------------------+------------+------------+
> > |                                                                          | 2e53f56af3 | 3b29021ddd |
> > +--------------------------------------------------------------------------+------------+------------+
> > | BUG:kernel_NULL_pointer_dereference,address                              | 0          | 22         |
> > | Oops:#[##]                                                               | 0          | 23         |
> > | EIP:strcmp                                                               | 0          | 20         |
> > | Kernel_panic-not_syncing:Fatal_exception                                 | 0          | 22         |
> > +--------------------------------------------------------------------------+------------+------------+
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >
> >
> > [   74.983767][  T243] BUG: kernel NULL pointer dereference, address: 00000000
> > [   74.984577][  T243] #PF: supervisor read access in kernel mode
> > [   74.984946][  T243] #PF: error_code(0x0000) - not-present page
> > [   74.985316][  T243] *pde = 00000000
> > [   74.985549][  T243] Oops: 0000 [#1]
> > [   74.985776][  T243] CPU: 0 PID: 243 Comm: kunit_try_catch Tainted: G        W         5.15.0-rc1-00002-g3b29021ddd10 #1
> > [   74.986494][  T243] EIP: strcmp+0xe/0x40
> > [   74.986753][  T243] Code: 75 f7 31 c0 c4 04 5e 5f c4 04 5e 5f 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 00 55 89 e5 00 55 89 e5 89 c6 ac ae 89 c6 <ac> ae 75
> > f8 31 c0 75 f8 31 c0 0c 01 5e 5f 0c 01 5e 5f 90 90 90 90
> > [   74.987988][  T243] EAX: 00000000 EBX: f53c0108 ECX: 00000001 EDX: c33a266c
> > [   74.988425][  T243] ESI: 00000000 EDI: c33a266c EBP: f52d3ee0 ESP: f52d3ed8
> > [   74.988864][  T243] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
> > [   74.989332][  T243] CR0: 80050033 CR2: 00000000 CR3: 03ec2000 CR4: 000406d0
> > [   74.989771][  T243] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [   74.990219][  T243] DR6: fffe0ff0 DR7: 00000400
> > [   74.990505][  T243] Call Trace:
> > [   74.990708][  T243]  filter_suites_test+0x319/0x340
>
> This is happening in executor_test.c, in one of the test updated  for
> test filtering support.
> So this _might_ be an issue just with our unit tests, and not KUnit itself.

This is a KUnit issue.
Specifically when using a kunit.filter_glob that only has a suite
part, and no test part.

The fix is https://lore.kernel.org/linux-kselftest/20211002013635.2076371-1-dlatypov@google.com/

>
> Given it's complaining about strcmp, I'd assume that means it's in
> that last line of the test?
>
>    151          KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
>    152          KUNIT_EXPECT_STREQ(test, (const char
> *)filtered.start[0][0]->name, "suite0");
>    153  }
>
> > [   74.991021][  T243]  ? kunit_binary_ptr_assert_format+0xc0/0xc0
>
> But the problem is, I don't understand what this is doing in the stack.
> I'd expect kunit_binary_str_assert_format here.
>
> I don't even know how this test case can call that function.
> The only pointer related assertions are KUNIT_ASSERT_NOT_ERR_OR_NULL,
> but that would go to kunit_ptr_not_err_assert_format.
>
> So I'm clearly missing something when it comes to reading kernel stack traces.
> David, Brendan, any ideas or tips?
>
> > [   74.991394][  T243]  ? trace_hardirqs_on+0x4f/0xc0
> > [   74.991701][  T243]  kunit_try_run_case+0x3c/0xc0
> > [   74.992000][  T243]  kunit_generic_run_threadfn_adapter+0x16/0x40
> > [   74.992383][  T243]  kthread+0x14c/0x180
> > [   74.992634][  T243]  ? kunit_try_catch_run+0x180/0x180
> > [   74.992971][  T243]  ? kthread_unuse_mm+0xc0/0xc0
> > [   74.993269][  T243]  ret_from_fork+0x1c/0x28
> > [   74.993541][  T243] Modules linked in:
> > [   74.993779][  T243] CR2: 0000000000000000
> > [   74.994045][  T243] ---[ end trace e46267553c50ccd5 ]---
> > [   74.994391][  T243] EIP: strcmp+0xe/0x40
> > [   74.994643][  T243] Code: 75 f7 31 c0 c4 04 5e 5f c4 04 5e 5f 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 00 55 89 e5 00 55 89 e5 89 c6 ac ae 89 c6 <ac> ae 75
> > f8 31 c0 75 f8 31 c0 0c 01 5e 5f 0c 01 5e 5f 90 90 90 90
> > [   74.995853][  T243] EAX: 00000000 EBX: f53c0108 ECX: 00000001 EDX: c33a266c
> > [   74.996456][  T243] ESI: 00000000 EDI: c33a266c EBP: f52d3ee0 ESP: f52d3ed8
> > [   74.997031][  T243] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
> > [   74.997499][  T243] CR0: 80050033 CR2: 00000000 CR3: 03ec2000 CR4: 000406d0
> > [   74.997937][  T243] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [   74.998384][  T243] DR6: fffe0ff0 DR7: 00000400
> > [   74.998670][  T243] Kernel panic - not syncing: Fatal exception
> > [   74.999042][  T243] Kernel Offset: disabled
> >
> >
> >
> > To reproduce:
> >
> >         # build kernel
> >         cd linux
> >         cp config-5.15.0-rc1-00002-g3b29021ddd10 .config
> >         make HOSTCC=clang-14 CC=clang-14 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> >
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> >
> >
> >
> > ---
> > 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> > https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> >
> > Thanks,
> > Oliver Sang
> >
