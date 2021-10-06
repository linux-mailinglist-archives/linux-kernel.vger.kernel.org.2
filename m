Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F382424400
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbhJFRY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbhJFRY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:24:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C7C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:23:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 66so3068531pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gAHqzYvLDyBGObyBMLlGZK8rVEPIoaC9tnX5qrAT9S8=;
        b=jKCbkPWJtgdWuMqqBwIk5ZdH4rzC9VQGTQ/YDKdL2fueoBX8vuGuxGvrzRa6qzjkrO
         mRljNh3gCUkEb1R/oG1AjA6pY08ySWyFE3qbDrRLoVrYA6YEyINezeggJ+aWQxN9afSb
         oCFXmy45+fO135U2wL+GYETPwTf91tCmpUEgvP5IK0OIjqkKe93Iv9SGmCPFNPzM5bzy
         ael/KXivVT7ggXvfXdv6dDBDL6M1ZhXvwj+8kSgoF7M4hy9uSy9MguoDC/3KCsZhhrqT
         43aDpcith2cg7VoywmuWWgPt6pZKIunI7xaxYpqeo6V9V9geb6NUY0mWgwWycqY/Ri+e
         UhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAHqzYvLDyBGObyBMLlGZK8rVEPIoaC9tnX5qrAT9S8=;
        b=7yyHjwwVJWiPR5IkgzO0siKbHJdlv64TCAPhq3Q9OjvnPhHWrYj6gQBcN2Fi3jhd54
         vErUkeZ5jhr7CR8DNgMNZTeNTIHWDQXWWBJ2ds4tF20dBV91i3xOEFwI+tF/jySMmNMT
         Pdfbglle1QUqXBzy4pSn9Z0EGTdgt0p9m++/McojD2llYMwxsCnMOuj2+Hms4d7ea6Iw
         naAOp8HmeEwCegFl6kq9xtlUMN+dr0xq3mrcXEy9UZI1zUb3QSMdtTYM0gPIT/SnL0Zy
         QxNVmjWsHJn+hmZMvqMdL18LyQiYz1ihPqJ614HdOUFSqyCF/voGMbQQkHhI0j2aWKeW
         rh5g==
X-Gm-Message-State: AOAM530Dq+XBk7JAKfazu+CfsAOedOdq9T7dqUzhvvkbSEfN8SxyOlOL
        8ZxEEm8Ic6+fnMbTlTHS+C75hc4a0eYIMOBOL2qAC+murRY=
X-Google-Smtp-Source: ABdhPJzHN3vB2rQM0cqY/JkZqpfm62hWzIv8fT/SMlnS9JhR6RriUY2uZr3gyyS5MDT+PCWwBUOrv7As5mIEvEMwMSg=
X-Received: by 2002:a63:790b:: with SMTP id u11mr21217624pgc.71.1633540985947;
 Wed, 06 Oct 2021 10:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com> <20210930222048.1692635-5-dlatypov@google.com>
 <CABVgOS=SVHSrnTaa0hYsyn8KV_A7FCTaAmDx5ST6Jb2k4TXWSg@mail.gmail.com>
In-Reply-To: <CABVgOS=SVHSrnTaa0hYsyn8KV_A7FCTaAmDx5ST6Jb2k4TXWSg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Oct 2021 10:22:55 -0700
Message-ID: <CAFd5g45qD0H1sO2n-NcgpVKm-QRRBVSHXLyMRr9mmJxKDgpWMw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kunit: tool: support running each suite/test separately
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 4:05 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Oct 1, 2021 at 6:21 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > The new --run_isolated flag makes the tool boot the kernel once per
> > suite or test, preventing leftover state from one suite to impact the
> > other. This can be useful as a starting point to debugging test
> > hermeticity issues.
> >
> > Note: it takes a lot longer, so people should not use it normally.
> >
> > Consider the following very simplified example:
> >
> >   bool disable_something_for_test = false;
> >   void function_being_tested() {
> >     ...
> >     if (disable_something_for_test) return;
> >     ...
> >   }
> >
> >   static void test_before(struct kunit *test)
> >   {
> >     disable_something_for_test = true;
> >     function_being_tested();
> >     /* oops, we forgot to reset it back to false */
> >   }
> >
> >   static void test_after(struct kunit *test)
> >   {
> >     /* oops, now "fixing" test_before can cause test_after to fail! */
> >     function_being_tested();
> >   }
> >
> > Presented like this, the issues are obvious, but it gets a lot more
> > complicated to track down as the amount of test setup and helper
> > functions increases.
> >
> > Another use case is memory corruption. It might not be surfaced as a
> > failure/crash in the test case or suite that caused it. I've noticed in
> > kunit's own unit tests, the 3rd suite after might be the one to finally
> > crash after an out-of-bounds write, for example.
> >
> > Example usage:
> >
> > Per suite:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
> > ...
> > Starting KUnit Kernel (1/7)...
> > ============================================================
> > ======== [PASSED] kunit_executor_test ========
> > ....
> > Testing complete. 5 tests run. 0 failed. 0 crashed. 0 skipped.
> > Starting KUnit Kernel (2/7)...
> > ============================================================
> > ======== [PASSED] kunit-try-catch-test ========
> > ...
> >
> > Per test:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
> > Starting KUnit Kernel (1/23)...
> > ============================================================
> > ======== [PASSED] kunit_executor_test ========
> > [PASSED] parse_filter_test
> > ============================================================
> > Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
> > Starting KUnit Kernel (2/23)...
> > ============================================================
> > ======== [PASSED] kunit_executor_test ========
> > [PASSED] filter_subsuite_test
> > ...
> >
> > It works with filters as well:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite example
> > ...
> > Starting KUnit Kernel (1/1)...
> > ============================================================
> > ======== [PASSED] example ========
> > ...
> >
> > It also handles test filters, '*.*skip*' runs these 3 tests:
> >   kunit_status.kunit_status_mark_skipped_test
> >   example.example_skip_test
> >   example.example_mark_skipped_test
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > Reviewed-by: David Gow <davidgow@google.com>
> > ---
>
> Thanks -- this version works for me.
>
> I think the requirement that test and suite names contain neither full
> stops nor spaces is a reasonable one. There aren't any current tests
> which would break it, as far as I know.

I agree. Is this currently codified in the test naming conventions document?
