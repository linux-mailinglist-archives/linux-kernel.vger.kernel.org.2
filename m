Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E28735AD16
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbhDJLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbhDJLxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:53:25 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619D1C061764
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:53:11 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id b17so6922259ilh.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UqHyWL3oxbBOPvZDEfhlmI0XD6uz4gURZs7GlIYu4NQ=;
        b=dkPNBKBgeyudWCTk/ALi6a8OaiLlYopdZr0Bbfr2N0wOI3NhIbSQMm108TcXB4dK5h
         bokXeAvwlmDhMQbbY0JtPvtC/kLrH0H0CTgf3B+po+SR27Aqn8Y/Z2gJQKF84gYafQ/b
         23yhu7Dx2V7g3TNnMytjNGUIHjTFpTockw7ei+KFqMZ6GVE/kBBTKMAXVkGXb3b3BYZr
         YdvOoU19d2k/wyjsdbloQR12N6LguPfDg4yUet2Na1MyEs45NEOzv82WfQCVgsqdap+n
         Z9PjD2jRCS7VDq6nDoh9QteVUD1MxNU6ETwLRWa4CwDii9DN4sNfmGoDr/mwLpRmNhk2
         b36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UqHyWL3oxbBOPvZDEfhlmI0XD6uz4gURZs7GlIYu4NQ=;
        b=PiCizxwG5LLwhAgVdYaWFBkNwJmo4+1m5ICv6BATVwimrk8EQzV0Y6PAWZZqhfKlxw
         qhz5CkOUPGs0fnx2Pq0W1tgN+KwjTMZe+2JRVGiUjpXIsJRzT4gXooZQ1V3Q9TO8YfC7
         jHoZh7BjCEdKDdRPFPMe76q96ZPfkBl9hZ9lyljD8xUBAC6oI3i3op1TY4pvZT3njjIu
         VBJ4+RhYcctJbvAqJBp81CyLEl3IDt5yvwxNpLoz+GRcZ9XxD1OH2mpxcJiKSVnNzPip
         mgfuU2jvm2htJJX0g77yjkKItOR2as8qjQXCDGyteq1R8inx/SJZVaKzJbCcb2t7AuoZ
         sovA==
X-Gm-Message-State: AOAM532phgWhZ+xgtyeqeVs7oSOrlOw5Ee5hdwTbLhAmVmVC7ts2KEtH
        zrHUuHlc9hrSutyGbuW9YId/cX04W67npRi1kyMdfg==
X-Google-Smtp-Source: ABdhPJw9pNWrBK9bvqLhuqJMRykGiGD8xqr+zp41WM9p80GuiqyyH6qQA6BwfkXsLMN/MQxvbgfO/PybhxWo10LtwV8=
X-Received: by 2002:a92:6f07:: with SMTP id k7mr13620113ilc.194.1618055590247;
 Sat, 10 Apr 2021 04:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210410070529.4113432-1-davidgow@google.com>
In-Reply-To: <20210410070529.4113432-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Sat, 10 Apr 2021 04:52:59 -0700
Message-ID: <CAGS_qxo=BCVfePBcN8NWSAb=htf4pdybcvQuGf2aaWMvfiQMsA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: dev-tools: Add Testing Overview
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-doc@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 12:05 AM David Gow <davidgow@google.com> wrote:
>
> The kernel now has a number of testing and debugging tools, and we've
> seen a bit of confusion about what the differences between them are.
>
> Add a basic documentation outlining the testing tools, when to use each,
> and how they interact.
>
> This is a pretty quick overview rather than the idealised "kernel
> testing guide" that'd probably be optimal, but given the number of times
> questions like "When do you use KUnit and when do you use Kselftest?"
> are being asked, it seemed worth at least having something. Hopefully
> this can form the basis for more detailed documentation later.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  Documentation/dev-tools/index.rst            |   3 +
>  Documentation/dev-tools/testing-overview.rst | 102 +++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/dev-tools/testing-overview.rst
>
> diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/=
index.rst
> index 1b1cf4f5c9d9..f590e5860794 100644
> --- a/Documentation/dev-tools/index.rst
> +++ b/Documentation/dev-tools/index.rst
> @@ -7,6 +7,8 @@ be used to work on the kernel. For now, the documents hav=
e been pulled
>  together without any significant effort to integrate them into a coheren=
t
>  whole; patches welcome!
>
> +A brief overview of testing-specific tools can be found in :doc:`testing=
-overview`.
> +
>  .. class:: toc-title
>
>            Table of contents
> @@ -14,6 +16,7 @@ whole; patches welcome!
>  .. toctree::
>     :maxdepth: 2
>
> +   testing-overview
>     coccinelle
>     sparse
>     kcov
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation=
/dev-tools/testing-overview.rst
> new file mode 100644
> index 000000000000..8452adcb8608
> --- /dev/null
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -0,0 +1,102 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Kernel Testing Guide
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +There are a number of different tools for testing the Linux kernel, so k=
nowing
> +when to use each of them can be a challenge. This document provides a ro=
ugh
> +overview of their differences, and how they fit together.
> +
> +
> +Writing and Running Tests
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The bulk of kernel tests are written using either the :doc:`kselftest
> +<kselftest>` or :doc:`KUnit <kunit/index>` frameworks. These both provid=
e
> +infrastructure to help make running tests and groups of tests easier, as=
 well
> +as providing helpers to aid in writing new tests.
> +
> +If you're looking to verify the behaviour of the Kernel =E2=80=94 partic=
ularly specific
> +parts of the kernel =E2=80=94 then you'll want to use `KUnit` or `kselft=
est`.
> +
> +
> +The Difference Between KUnit and kselftest
> +------------------------------------------

This section does a good job, but on a pragmatic level, there are a
few more reasons to pick one or the other.
E.g. the edit/build/test cycle will likely always be faster in KUnit.

I'd also initially drafted up a _very_ long list of reasons to prefer
kselftest as well.
But looking back at them, a lot will hopefully be mitigated soon, or
naturally get better with more usage/time, and you touched on that it
can be easier to set up state from userspace already down below.

> +
> +:doc:`KUnit <kunit/index>` is an entirely in-kernel system for "white bo=
x"
> +testing: because test code is part of the kernel, it can access internal
> +structures and functions which aren't exposed to userspace.
> +
> +`KUnit` tests therefore are best written against small, self-contained p=
arts
> +of the kernel, which can be tested in isolation. This aligns well with t=
he
> +concept of Unit testing.

Nit: we have "Unit testing" here and "'system' or 'end-to-end' testing."
Perhaps: 'unit' testing

> +
> +For example, a KUnit test might test an individual kernel function (or e=
ven a
> +single codepath through a function, such as an error handling case), rat=
her
> +than a feature as a whole.
> +
> +There is a KUnit test style guide which may give further pointers

Seems like this sentence got truncated?
Hmm, I'm not sure what this would be referring to however.
I'm not sure there's a doc that touches on what's amenable to being unit te=
sted.

> +
> +
> +:doc:`kselftest <kselftest>`, on the other hand, is largely implemented =
in
> +userspace, and tests are normal userspace scripts or programs.
> +
> +This makes it easier to write more complicated tests, or tests which nee=
d to
> +manipulate the overall system state more (e.g., spawning processes, etc.=
).
> +However, it's not possible to call kernel functions directly unless they=
're

Saying it's not possible to call kernel code before mentioning the use
of kernel modules to call kernel code directly is a bit confusing.

Perhaps instead:
  However, it's not possible to call kernel functions directly unless
you write a companion kernel module for the test. If your test is
mostly or entirely inside a kernel module, `KUnit` may be the better
tool.

> +exposed to userspace (by a syscall, device, filesystem, etc.) Some tests=
 to
> +also provide a kernel module which is loaded by the test, though for tes=
ts
> +which run mostly or entirely within the kernel, `KUnit` may be the bette=
r tool.
> +
> +`kselftest` is therefore suited well to tests of whole features, as thes=
e will
> +expose an interface to userspace, which can be tested, but not implement=
ation
> +details. This aligns well with 'system' or 'end-to-end' testing.
> +
> +
> +Code Coverage Tools
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Linux Kernel supports two different code coverage mesurement tools. =
These

*measurement

> +can be used to verify that a test is executing particular functions or l=
ines
> +of code. This is useful for determining how much of the kernel is being =
tested,
> +and for finding corner-cases which are not covered by the appropriate te=
st.
> +
> +:doc:`kcov` is a feature which can be built in to the kernel to allow
> +capturing coverage on a per-task level. It's therefore useful for fuzzin=
g and
> +other situations where information about code executed during, for examp=
le, a
> +single syscall is useful.
> +
> +:doc:`gcov` is GCC's coverage testing tool, which can be used with the k=
ernel
> +to get global or per-module coverage. Unlike KCOV, it does not record pe=
r-task
> +coverage. Coverage data can be read from debugfs, and interpreted using =
the
> +usual gcov tooling.

Nit: I think gcov is the one most people reading this doc are going to
be interested in, so I'd mention it first.

> +
> +
> +Sanitizers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The kernel also supports a number of sanitizers, which attempt to detect
> +classes of issues when the occur in a running kernel. These typically

*they occur

> +look for undefined behaviour of some kind, such as invalid memory access=
es,
> +concurrency issues such as data races, or other undefined behaviour like
> +integer overflows.
> +
> +* :doc:`kmemleak` (Kmemleak) detects possible memory leaks.
> +* :doc:`kasan` detects invalid memory accesses such as out-of-bounds and
> +  use-after-free errors.
> +* :doc:`ubsan` detects behaviour that is undefined by the C standard, li=
ke
> +  integer overflows.
> +* :doc:`kcsan` detects data races.
> +* :doc:`kfence` is a low-overhead detector of memory issues, which is mu=
ch
> +  faster than KASAN and can be used in production.

Hmm, it lives elsewhere, but would also calling out lockdep here be useful?
I've also not heard anyone call it a sanitizer before, but it fits the
definition you've given.

Now that I think about it, I've never looked for documentation on it,
is this the best page?
https://www.kernel.org/doc/html/latest/locking/lockdep-design.html


> +
> +These tools tend to test the kernel as a whole, and do not "pass" like
> +kselftest or KUnit tests. They can be combined with KUnit or kselftest b=
y
> +running tests on a kernel with a sanitizer enabled: you can then be sure
> +that none of these errors are occurring during the test.
> +
> +Some of these sanitizers integrate with KUnit or kselftest and will
> +automatically fail tests if an issue is detected by a sanitizer.
> +
> --
> 2.31.1.295.g9ea45b61b8-goog
>
