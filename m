Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7041130FD2E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhBDTod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhBDTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:44:27 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D77AC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 11:43:47 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d26so1525643pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kgb/YSMbLJoQSXAwYx5oByXM+QqtdTuysP9uC+LOVY=;
        b=Jo6inYMe+oAf/ZNWs+rdh0hwRaP31M8CMmpKBThsY5WdazEC1grF551bbNI2uj10BI
         9ZKob5V12cBrfYe+gq92asoo3x5EhO3kbxsoex6lmH+GfAT1ufZ3/JAhYuDGoOziwINt
         g9azF5imCgzkCIFhEifVOOsNbzt8ugUjJf850TdfwenzYrrtwxl1DvintomA9REJx84k
         VpWlC4hhZmVMBqtYPyiwzExcSVFDljIrzTkoKG6pG+sAvhBLGXZE8jpaibHtLWkUv3HV
         hvzSXEIapqSXthvQLkWZ5GHrUrKbcp0p5Al6ya0yVoaVwtRGCLeC+H7CNpGCSY3YjzwF
         GMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kgb/YSMbLJoQSXAwYx5oByXM+QqtdTuysP9uC+LOVY=;
        b=Sj46Fqlsgr7g+FLqvOnAKwEYyZWr0jxSjbXoJrv9CZ437XAxvhFipFGzvmgeP48RqA
         rhJCpCi10eFG24yTuLbqk6WqKV4zOFMODviAo0DEQNLnNdfOG05r2uUst8UI8XmWKfLY
         m4a8YLAIjZczhXFmqfUpX+pM7Bzo2pe8hxgm2BHxDfMaGiyqeax+Q9+s1yCYtVet2fAa
         YmHCzh3XtY+SjXuTXny95fHINGboiwgQQoO+6v9pTtiki8uIvFw7MQ9ghU2Njq7XCUOP
         XgenxdHohpymESLrunf1ZS/zv0YO1e4W5OETjDw0uDTbLar3bR3/TqQXtUMzhV9vZlo9
         9azQ==
X-Gm-Message-State: AOAM531LfvANC79WcHJtDVc5fnJQ84wkcjlryUIqDHM1pLqUExI7L08s
        lTuHXSwb1khC+qybSrYSbuX3q7zzUcJRrNX/ES6cX0rtnh5wjg==
X-Google-Smtp-Source: ABdhPJxQJ8tBTeSJ8nCb7YyZX9ImArmYqpV0jOz1Wj7zW9BC+iSj35fvPxdyuo4MVKdGgu1OF9GqMxSNk34iSmXWVis=
X-Received: by 2002:a62:fc84:0:b029:1ba:9b85:2e92 with SMTP id
 e126-20020a62fc840000b02901ba9b852e92mr860888pfh.38.1612467826595; Thu, 04
 Feb 2021 11:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20210204173045.1138504-1-dlatypov@google.com> <20210204173045.1138504-2-dlatypov@google.com>
In-Reply-To: <20210204173045.1138504-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 4 Feb 2021 11:43:35 -0800
Message-ID: <CAFd5g47N2ec7KTG9Lk-DgxqEnOEdqYjoQ1+V=aE6NTXbY0-MMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kunit: add kunit.filter_glob cmdline option to
 filter suites
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 9:31 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> E.g. specifying this would run suites with "list" in their name.
>   kunit.filter_glob=list*
>
> Note: the executor prints out a TAP header that includes the number of
> suites we intend to run.
> So unless we want to report empty results for filtered-out suites, we
> need to do the filtering here in the executor.
> It's also probably better in the executor since we most likely don't
> want any filtering to apply to tests built as modules.
>
> This code does add a CONFIG_GLOB=y dependency for CONFIG_KUNIT=y.
> But the code seems light enough that it shouldn't be an issue.
>
> For now, we only filter on suite names so we don't have to create copies
> of the suites themselves, just the array (of arrays) holding them.
>
> The name is rather generic since in the future, we could consider
> extending it to a syntax like:
>   kunit.filter_glob=<suite_glob>.<test_glob>
> E.g. to run all the del list tests
>   kunit.filter_glob=list-kunit-test.*del*
>
> But at the moment, it's far easier to manually comment out test cases in
> test files as opposed to messing with sets of Kconfig entries to select
> specific suites.
> So even just doing this makes using kunit far less annoying.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

One minor issue below, otherwise:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  lib/kunit/Kconfig    |  1 +
>  lib/kunit/executor.c | 91 +++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 83 insertions(+), 9 deletions(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 00909e6a2443..0b5dfb001bac 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -4,6 +4,7 @@
>
>  menuconfig KUNIT
>         tristate "KUnit - Enable support for unit tests"
> +       select GLOB if KUNIT=y
>         help
>           Enables support for kernel unit tests (KUnit), a lightweight unit
>           testing and mocking framework for the Linux kernel. These tests are
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index a95742a4ece7..996efb80dba6 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include <kunit/test.h>
> +#include <linux/glob.h>
> +#include <linux/moduleparam.h>
>
>  /*
>   * These symbols point to the .kunit_test_suites section and are defined in
> @@ -11,14 +13,79 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
>
>  #if IS_BUILTIN(CONFIG_KUNIT)
>
> -static void kunit_print_tap_header(void)
> +static char *filter_glob;
> +module_param(filter_glob, charp, 0);

You should probably also use MODULE_PARM_DESC().
