Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4AD443C48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 05:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhKCEvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 00:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhKCEvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 00:51:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A1C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 21:48:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r8so1618480wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 21:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87974z5AtJmOln+zwYWiwSnZztUMWAZ2LkjaXiT2MxY=;
        b=iW6iWKTWBYsCImYrih+6jD6BL6qW31QNIf1MhcIipNBV+T1/YZFlIJboDjw5Te6eEv
         AjqSP/7df2OJv40xYMhcBJjaxnRAY6185jxwr+8r5OceIDKubIFFKIvbPT0N6xvbd8Up
         scDnHGMmZ0ruwn+0zbjbUL/aQm3cGf1oIM6mrSubuYdvpy6ZHRWSJHn2NtKeMf7sawVW
         T36xev27ocoy1r/Pzf31CK5sygwmQU2pbJ8B0BVOhaN5ikiGj0OsHGKpti7ziSdx0csk
         9xlZ0Pvlt18omSGDD0Pct2+ks5+rpJvr2Nd/XcguE7x4YytT2FTds4es2HKftuHFdyWB
         v61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87974z5AtJmOln+zwYWiwSnZztUMWAZ2LkjaXiT2MxY=;
        b=uEfuOy76ojoTg0BxI11t1BQB3PoBkqkFuNd7X1gryfIemJsikbtESZnu5cVYM2OnZy
         WCOwSBvJK8AUYbvjCnSP9YbLO7nP52yxEeya9dRaRy4OcxhV2v96jv6lNMS24qJb9xT7
         M3mbnHY3RHzutJBNOo9WQ5CbYXMOG63QawZmw9iJY+EzBptM+KeMwKHMns5vLrqqEWv6
         fBrQkzyy8lv21ZvjM+PABihMqRdFwQiqanaoM71wN2H8oeoZwUv5t858peyX5ZYL1VpJ
         d1+ZqcKpEWHQY3SBHb3kh++ZR9GkRpPCIcFJ1t0vtu3UaxA/+PbyUf3kzHjDzxeJ+LY7
         QuJQ==
X-Gm-Message-State: AOAM533OhykON3E9pb1jaRZLLB/tDBCpeTfQyYIeHvsaajSnHepgCGT7
        JxtmmYYgdKNgsmb8wCJ5eAJcNKSERYU9u+pQ9NTVPN5w0LJR6w==
X-Google-Smtp-Source: ABdhPJzgZcfUYgphAObDCJ7ZlKG/hkC2+JnD658GVFTfICkxiCG/wyerCejBDhWQm47ai/Fp8r7KayCwSI6hQpUuOes=
X-Received: by 2002:a5d:4882:: with SMTP id g2mr51606109wrq.399.1635914910551;
 Tue, 02 Nov 2021 21:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211103042228.586967-1-dlatypov@google.com>
In-Reply-To: <20211103042228.586967-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 3 Nov 2021 12:48:19 +0800
Message-ID: <CABVgOSmivNm9=Zoq-1n4qpVwHbTkvTjW=chk-bEuJjt1SN6KEA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: add run_checks.py script to validate kunit changes
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 12:22 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> This formalizes the checks KUnit maintainers have been running (or in
> other cases: forgetting to run).
>
> This script also runs them all in parallel to minimize friction (pytype
> can be fairly slow, but not slower than running kunit.py).
>
> Example output:
> $ ./tools/testing/kunit/run_checks.py
> Waiting on 4 checks (kunit_tool_test.py, kunit smoke test, pytype, mypy)...
> kunit_tool_test.py: PASSED
> mypy: PASSED
> pytype: PASSED
> kunit smoke test: PASSED
>
> On failure or timeout (5 minutes), it'll dump out the stdout/stderr.
> E.g. adding in a type-checking error:
>   mypy: FAILED
>   > kunit.py:54: error: Name 'nonexistent_function' is not defined
>   > Found 1 error in 1 file (checked 8 source files)
>
> mypy and pytype are two Python type-checkers and must be installed.
> This file treats them as optional and will mark them as SKIPPED if not
> installed.
>
> This tool also runs `kunit.py run --kunitconfig=lib/kunit` to run
> KUnit's own KUnit tests and to verify KUnit kernel code and kunit.py
> play nicely together.
>
> It uses --build_dir=kunit_run_checks so as not to clobber the default
> build_dir, which helps make it faster by reducing the need to rebuild,
> esp. if you're been passing in --arch instead of using UML.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---

Works a treat, thanks.

This is still
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
