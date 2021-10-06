Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C857C4243F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbhJFRYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhJFRYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:24:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD77C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:22:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2893415pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuFD3DjuAsecBQETsr19lKvC+u97mJmjB+UnZRmfCzg=;
        b=pC7j8eITFbGqLmwjrio4yjY/CCYQVie5jvH66MeBxVkW5gfU4x8W5aVLT2GxxNugxp
         Sq+rlPEX3g9WStsf5PLNDgOYnlZEwL8txN9bP8JZ1+xxu0t3Rbae2AmME/JcqZA3dCi1
         UHDMxl50lugiTXCpQ93Tyt6RbWM1XLoAjeWMvXSyme7Ed3o3LTgiGLovPsGKxiOAmZHf
         vUz29Wsvt9V62o7Dmh9LOMtvhAldAqwLg/sepf/306CXsybmwbJ7AutVydDymJZgrnOe
         t+Vp19ucgC3i8KumMcJ+kNUXC7XyW85G5bfqRldk6cV6dx/TvyESqPybsZOww09R2kCo
         ezcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuFD3DjuAsecBQETsr19lKvC+u97mJmjB+UnZRmfCzg=;
        b=jt6DTwBYim9wZVBgLXoYIQpV4e4Anu5CcdG3LCW5FY2EKXszra+5M713GaVU7Eqne5
         ABF04ZLF4WT4amcteE76PPOAh7NfVmRQhoeSTm9ZCdM3WhtBtkLmb7NLW3zyBwzp9oQ1
         MI/eMLtnHydegNYTPCopxqnTa09NMsAp4yaX90pLmDEElFA3K/0hgOo03ZWKi2xNBCa1
         sf3g9Ue8AtFfUM5YpLwQ+4iMSBeKJQ/J2z2+W+5Jxndswr3z7kQW36NDuFPLJtOm3+Om
         jhhFgQ9U2lP5FfKoGklImyGAkiIMvdCFuHCAasEiksvK26uRrBe0/kHs/Wz1OArI/a7O
         CXaw==
X-Gm-Message-State: AOAM531RmsaZVq3wF876dkGOVn+3GlB9oyBxwiUy+wikMEhp3e+BtAsp
        2iN/ZJx1sDldpWmxLpH0ei7knoTaeZdqNPYddLEXGdZ6NU1QvQ==
X-Google-Smtp-Source: ABdhPJxrCy4jllWoM0mTHfBjDMShNYpfxu2qKtoN3zGIl418b5CzQx26hThBRjmoM4nTC66Beuw9UnPEPB629gWMf2g=
X-Received: by 2002:a17:90b:3552:: with SMTP id lt18mr12079130pjb.63.1633540937948;
 Wed, 06 Oct 2021 10:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com> <20210930222048.1692635-5-dlatypov@google.com>
In-Reply-To: <20210930222048.1692635-5-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Oct 2021 10:22:07 -0700
Message-ID: <CAFd5g455K5XLR2m0zHtfUQwVP+iNBumE0zp5T7-H1ncB+_BVmw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kunit: tool: support running each suite/test separately
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 3:21 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The new --run_isolated flag makes the tool boot the kernel once per
> suite or test, preventing leftover state from one suite to impact the
> other. This can be useful as a starting point to debugging test
> hermeticity issues.
>
> Note: it takes a lot longer, so people should not use it normally.
>
> Consider the following very simplified example:
>
>   bool disable_something_for_test = false;
>   void function_being_tested() {
>     ...
>     if (disable_something_for_test) return;
>     ...
>   }
>
>   static void test_before(struct kunit *test)
>   {
>     disable_something_for_test = true;
>     function_being_tested();
>     /* oops, we forgot to reset it back to false */
>   }
>
>   static void test_after(struct kunit *test)
>   {
>     /* oops, now "fixing" test_before can cause test_after to fail! */
>     function_being_tested();
>   }
>
> Presented like this, the issues are obvious, but it gets a lot more
> complicated to track down as the amount of test setup and helper
> functions increases.
>
> Another use case is memory corruption. It might not be surfaced as a
> failure/crash in the test case or suite that caused it. I've noticed in
> kunit's own unit tests, the 3rd suite after might be the one to finally
> crash after an out-of-bounds write, for example.
>
> Example usage:
>
> Per suite:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
> ...
> Starting KUnit Kernel (1/7)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> ....
> Testing complete. 5 tests run. 0 failed. 0 crashed. 0 skipped.
> Starting KUnit Kernel (2/7)...
> ============================================================
> ======== [PASSED] kunit-try-catch-test ========
> ...
>
> Per test:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
> Starting KUnit Kernel (1/23)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> [PASSED] parse_filter_test
> ============================================================
> Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
> Starting KUnit Kernel (2/23)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> [PASSED] filter_subsuite_test
> ...
>
> It works with filters as well:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite example
> ...
> Starting KUnit Kernel (1/1)...
> ============================================================
> ======== [PASSED] example ========
> ...
>
> It also handles test filters, '*.*skip*' runs these 3 tests:
>   kunit_status.kunit_status_mark_skipped_test
>   example.example_skip_test
>   example.example_mark_skipped_test
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
