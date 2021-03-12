Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5673390E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhCLPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbhCLPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:11:09 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DBFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:11:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so12435688wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jcr1/ntj/CbpMghQTHSbkEub+1AngnBAtvqWktUi4eA=;
        b=knGlT/faP7TxY8Y+0IyOjYkT4OmjPT4nFFpiaDQrjRqtM2yHTLe2/LQAj5jvPcZpbX
         nGKsH9cJFkxEjBv9BVwzHsv0AoChAuCcWPEXbazHfI005GLKLPJPDAjKQporN/RcEfg7
         DxZDZ2dYOhCrAAb1qJtv0QOlzZDXXyEwDlFYDOAHQlYwYDsmiJzHMzUXIh3WoovAfqoF
         4HRC2BB+QTXzg1YQSI4cLRMZuzV89Ar3pOq0m+2tx4Tzt6UAJ12CeXCa7DEqiZnBjcqN
         /uMd3P0RXpbp63K5qCNz7BFlIugdk/A8MyB0uOnpfXcSbWXGap/JrsVEU/yvJvxU8mBp
         vgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jcr1/ntj/CbpMghQTHSbkEub+1AngnBAtvqWktUi4eA=;
        b=Jovwx9/47A6rryS/myjjBqOsVOnYvO7NdSRfyFNz+fAnjzQqDo/PUaxzTA1jw6ule7
         +FoJdgcnXhGx8sNLOZxQHOWoM2BLjtmZExrETNy7cm92GsW7SU//DUxDDhj3xpI+1Q8r
         aB3mcfMsPSXIHK5d6vqzUJdFHJ2VeoxYoVzVrEpedPiqxQfWXmaVvqyEB8EuxIu0io8y
         /n/wIcFIB2Pow829ah0hOjP9kBXmiu8T1Ivwrj98IyN+wVAtpI5fjEjLfcwBMUpFCc4s
         rIzBf6hth2RpC2YT4IxnwJt5VlZloSdw8KOD7kV2RXQ5+NT875xL6qFdCCUexhm5HHp2
         3zwQ==
X-Gm-Message-State: AOAM532nMhamZcZ1CqnYWnFcgqaSQOYJWaA4gzrDeD4iGpn+yEvd4ZF3
        nKnLa45dX72DPWXUku//8JNzfw==
X-Google-Smtp-Source: ABdhPJyDDn2k+jQAE9N0hV6Jgr+iFDDhyjZy3wcg7PQBX0dc2+SErraBTRSaXykKhauEUZO1BSjoRw==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr14133600wmj.119.1615561867587;
        Fri, 12 Mar 2021 07:11:07 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id z25sm2801177wmi.23.2021.03.12.07.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:11:06 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:11:01 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] kasan: docs: update tests section
Message-ID: <YEuEhc1JBq5dTpxp@elver.google.com>
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
 <fb08845e25c8847ffda271fa19cda2621c04a65b.1615559068.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb08845e25c8847ffda271fa19cda2621c04a65b.1615559068.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:24PM +0100, Andrey Konovalov wrote:
> Update the "Tests" section in KASAN documentation:
> 
> - Add an introductory sentence.
> - Add proper indentation for the list of ways to run KUnit tests.
> - Punctuation, readability, and other minor clean-ups.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> 
> Changes v1->v2:
> - Fix missing snippet delimeter around "test_kasan.ko".
> - Drop "the" before "test_kasan.ko".
> ---
>  Documentation/dev-tools/kasan.rst | 32 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 5749c14b38d0..a8c3e0cff88d 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -411,19 +411,20 @@ saving and restoring the per-page KASAN tag via
>  Tests
>  ~~~~~
>  
> -KASAN tests consist of two parts:
> +There are KASAN tests that allow verifying that KASAN works and can detect
> +certain types of memory corruptions. The tests consist of two parts:
>  
>  1. Tests that are integrated with the KUnit Test Framework. Enabled with
>  ``CONFIG_KASAN_KUNIT_TEST``. These tests can be run and partially verified
> -automatically in a few different ways, see the instructions below.
> +automatically in a few different ways; see the instructions below.
>  
>  2. Tests that are currently incompatible with KUnit. Enabled with
>  ``CONFIG_KASAN_MODULE_TEST`` and can only be run as a module. These tests can
> -only be verified manually, by loading the kernel module and inspecting the
> +only be verified manually by loading the kernel module and inspecting the
>  kernel log for KASAN reports.
>  
> -Each KUnit-compatible KASAN test prints a KASAN report if an error is detected.
> -Then the test prints its number and status.
> +Each KUnit-compatible KASAN test prints one of multiple KASAN reports if an
> +error is detected. Then the test prints its number and status.
>  
>  When a test passes::
>  
> @@ -451,27 +452,24 @@ Or, if one of the tests failed::
>  
>          not ok 1 - kasan
>  
> -
>  There are a few ways to run KUnit-compatible KASAN tests.
>  
>  1. Loadable module
>  
> -With ``CONFIG_KUNIT`` enabled, ``CONFIG_KASAN_KUNIT_TEST`` can be built as
> -a loadable module and run on any architecture that supports KASAN by loading
> -the module with insmod or modprobe. The module is called ``test_kasan``.
> +   With ``CONFIG_KUNIT`` enabled, KASAN-KUnit tests can be built as a loadable
> +   module and run by loading ``test_kasan.ko`` with ``insmod`` or ``modprobe``.
>  
>  2. Built-In
>  
> -With ``CONFIG_KUNIT`` built-in, ``CONFIG_KASAN_KUNIT_TEST`` can be built-in
> -on any architecure that supports KASAN. These and any other KUnit tests enabled
> -will run and print the results at boot as a late-init call.
> +   With ``CONFIG_KUNIT`` built-in, KASAN-KUnit tests can be built-in as well.
> +   In this case, the tests will run at boot as a late-init call.
>  
>  3. Using kunit_tool
>  
> -With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, it's also
> -possible use ``kunit_tool`` to see the results of these and other KUnit tests
> -in a more readable way. This will not print the KASAN reports of the tests that
> -passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
> -for more up-to-date information on ``kunit_tool``.
> +   With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, it is also
> +   possible to use ``kunit_tool`` to see the results of KUnit tests in a more
> +   readable way. This will not print the KASAN reports of the tests that passed.
> +   See `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
> +   for more up-to-date information on ``kunit_tool``.
>  
>  .. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
