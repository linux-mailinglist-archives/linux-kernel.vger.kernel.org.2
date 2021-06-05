Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07D239C993
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhFEPrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 11:47:42 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:40505 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 11:47:41 -0400
Received: by mail-wr1-f43.google.com with SMTP id y7so7654641wrh.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2vsk87dnHMG/fs0zle4jjIj1AH9GGbHYe9vPgURJko=;
        b=QgFDDpyjuTZpCoQhPJkqY6Qy4LZvRy5CZUvXYDXBs3mOW2Jq8HMpCrAsotCX7tMq6k
         erw2zbGcuTyazUfRDSUnJwPAkTGtSPDR7Ii4UZWsar0AlOaleZidwvC0zbhGmWRRaAN4
         SfGe9lI/gECLyNiwQM5zUEF6hS7m76XH24cPVsJuXdRRMRdCS6j6lvfIYDiUCIl30Ebg
         t1sbJ2zKCFLxX+wbfk9hddxIma8Pkp6P6YzbqvYJc8AnHoDpaioKW2Efy3/W4S6+MS6s
         ovgBqtkvyKypldHLmo7LnvRdgWIT6GEEhpoALagIRwH6iZYrGvdmZFU2SNzOdNKgbxEi
         ZMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2vsk87dnHMG/fs0zle4jjIj1AH9GGbHYe9vPgURJko=;
        b=Egao07fLLgulrMd+JcGZv4r89cA1gQ6CKz8W4R+prfYSB1Vb6BkdOZTAhihI3NvFbQ
         q4+zACxX+US1r4RAxjyLWLqeYJyiYBG89whrBFdnJTr47TOiewqVvvobiXsTO+tWMohm
         yNq7krE0qBXs8KSGdRidAGeqHSGuX7BdVTiKWoy0iYW/9DH8p3c57vPOwdg99mtq5J/P
         JDIQrAcWOxuBCH5nAJfawu9WsLpMmp6Q82kjl4vRKct1USTmJVMN3v2ZO/qPn2plkbzm
         FuFju/Dd2GrSOVfcdMIGfu8veZoJaJw5UugMZUxz4IM6ICQEPyhgkI9r1O1/YkG8qC5N
         nwUw==
X-Gm-Message-State: AOAM532LwedLdqk0piuYNCAaG9mRkr95lFKs9KWhTjavqBBCNWv6c+el
        6p61LcC8+fP8TFWeMdPqWFvIoU1HntyOMOZD54y2ew==
X-Google-Smtp-Source: ABdhPJz+T2a59gzdr7YO33fCHbpW2ZvzX9LJIXoodPk7PZ+jfi1TwptU2G+Om9koTBGRYlACSN2lnAtO9dy/2ZerJKs=
X-Received: by 2002:adf:fe4a:: with SMTP id m10mr9110264wrs.332.1622907892696;
 Sat, 05 Jun 2021 08:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622898327.git.mchehab+huawei@kernel.org> <a3ad84108a5b254e545f88e58d411f5fe2e25c7e.1622898327.git.mchehab+huawei@kernel.org>
In-Reply-To: <a3ad84108a5b254e545f88e58d411f5fe2e25c7e.1622898327.git.mchehab+huawei@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 5 Jun 2021 23:44:41 +0800
Message-ID: <CABVgOSnz_94ZO2Sa8Vf70eV_tf0gksDBUhZXYXX1VS=qFR=zPw@mail.gmail.com>
Subject: Re: [PATCH 14/34] docs: dev-tools: kunit: avoid using ReST :doc:`foo` markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 9:18 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

This is much better, thanks! Do note that there's a merge conflict
(and another :doc:`` tag which needs updating) in the kunit-fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=11dbc62a73a7da9f3697e8ce83d07503c11dcabb

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>  Documentation/dev-tools/kunit/faq.rst   |  2 +-
>  Documentation/dev-tools/kunit/index.rst | 14 +++++++-------
>  Documentation/dev-tools/kunit/start.rst |  6 +++---
>  Documentation/dev-tools/kunit/tips.rst  |  5 +++--
>  Documentation/dev-tools/kunit/usage.rst |  8 +++++---
>  5 files changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
> index 8d5029ad210a..5c6555d020f3 100644
> --- a/Documentation/dev-tools/kunit/faq.rst
> +++ b/Documentation/dev-tools/kunit/faq.rst
> @@ -97,7 +97,7 @@ things to try.
>     modules will automatically execute associated tests when loaded. Test results
>     can be collected from ``/sys/kernel/debug/kunit/<test suite>/results``, and
>     can be parsed with ``kunit.py parse``. For more details, see "KUnit on
> -   non-UML architectures" in :doc:`usage`.
> +   non-UML architectures" in Documentation/dev-tools/kunit/usage.rst.
>
>  If none of the above tricks help, you are always welcome to email any issues to
>  kunit-dev@googlegroups.com.
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index 848478838347..25d92a9a05ea 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -36,7 +36,7 @@ To make running these tests (and reading the results) easier, KUnit offers
>  results. This provides a quick way of running KUnit tests during development,
>  without requiring a virtual machine or separate hardware.
>
> -Get started now: :doc:`start`
> +Get started now: Documentation/dev-tools/kunit/start.rst
>
>  Why KUnit?
>  ==========
> @@ -88,9 +88,9 @@ it takes to read their test log?
>  How do I use it?
>  ================
>
> -*   :doc:`start` - for new users of KUnit
> -*   :doc:`tips` - for short examples of best practices
> -*   :doc:`usage` - for a more detailed explanation of KUnit features
> -*   :doc:`api/index` - for the list of KUnit APIs used for testing
> -*   :doc:`kunit-tool` - for more information on the kunit_tool helper script
> -*   :doc:`faq` - for answers to some common questions about KUnit
> +*   Documentation/dev-tools/kunit/start.rst - for new users of KUnit
> +*   Documentation/dev-tools/kunit/tips.rst - for short examples of best practices
> +*   Documentation/dev-tools/kunit/usage.rst - for a more detailed explanation of KUnit features
> +*   Documentation/dev-tools/kunit/api/index.rst - for the list of KUnit APIs used for testing
> +*   Documentation/dev-tools/kunit/kunit-tool.rst - for more information on the kunit_tool helper script
> +*   Documentation/dev-tools/kunit/faq.rst - for answers to some common questions about KUnit
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index 0e65cabe08eb..ee21e482a0de 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -21,7 +21,7 @@ The wrapper can be run with:
>         ./tools/testing/kunit/kunit.py run
>
>  For more information on this wrapper (also called kunit_tool) check out the
> -:doc:`kunit-tool` page.
> +Documentation/dev-tools/kunit/kunit-tool.rst page.
>
>  Creating a .kunitconfig
>  -----------------------
> @@ -234,7 +234,7 @@ Congrats! You just wrote your first KUnit test!
>
>  Next Steps
>  ==========
> -*   Check out the :doc:`tips` page for tips on
> +*   Check out the Documentation/dev-tools/kunit/tips.rst page for tips on
>      writing idiomatic KUnit tests.
> -*   Optional: see the :doc:`usage` page for a more
> +*   Optional: see the Documentation/dev-tools/kunit/usage.rst page for a more
>      in-depth explanation of KUnit.
> diff --git a/Documentation/dev-tools/kunit/tips.rst b/Documentation/dev-tools/kunit/tips.rst
> index 8d8c238f7f79..492d2ded2f5a 100644
> --- a/Documentation/dev-tools/kunit/tips.rst
> +++ b/Documentation/dev-tools/kunit/tips.rst
> @@ -125,7 +125,8 @@ Here's a slightly in-depth example of how one could implement "mocking":
>
>
>  Note: here we're able to get away with using ``test->priv``, but if you wanted
> -something more flexible you could use a named ``kunit_resource``, see :doc:`api/test`.
> +something more flexible you could use a named ``kunit_resource``, see
> +Documentation/dev-tools/kunit/api/test.rst.
>
>  Failing the current test
>  ------------------------
> @@ -185,5 +186,5 @@ Alternatively, one can take full control over the error message by using ``KUNIT
>
>  Next Steps
>  ==========
> -*   Optional: see the :doc:`usage` page for a more
> +*   Optional: see the Documentation/dev-tools/kunit/usage.rst page for a more
>      in-depth explanation of KUnit.
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 650f99590df5..3ee7ab91f712 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -10,7 +10,7 @@ understand it. This guide assumes a working knowledge of the Linux kernel and
>  some basic knowledge of testing.
>
>  For a high level introduction to KUnit, including setting up KUnit for your
> -project, see :doc:`start`.
> +project, see Documentation/dev-tools/kunit/start.rst.
>
>  Organization of this document
>  =============================
> @@ -99,7 +99,8 @@ violated; however, the test will continue running, potentially trying other
>  expectations until the test case ends or is otherwise terminated. This is as
>  opposed to *assertions* which are discussed later.
>
> -To learn about more expectations supported by KUnit, see :doc:`api/test`.
> +To learn about more expectations supported by KUnit, see
> +Documentation/dev-tools/kunit/api/test.rst.
>
>  .. note::
>     A single test case should be pretty short, pretty easy to understand,
> @@ -216,7 +217,8 @@ test suite in a special linker section so that it can be run by KUnit either
>  after late_init, or when the test module is loaded (depending on whether the
>  test was built in or not).
>
> -For more information on these types of things see the :doc:`api/test`.
> +For more information on these types of things see the
> +Documentation/dev-tools/kunit/api/test.rst.
>
>  Common Patterns
>  ===============
> --
> 2.31.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/a3ad84108a5b254e545f88e58d411f5fe2e25c7e.1622898327.git.mchehab%2Bhuawei%40kernel.org.
