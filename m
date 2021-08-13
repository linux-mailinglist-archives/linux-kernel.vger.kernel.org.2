Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414FE3EAFBB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 07:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbhHMFlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 01:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhHMFls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 01:41:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C556AC0617AD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 22:41:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k29so11605638wrd.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 22:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLwpQVESMtB7Px0KV25LdFPuzmYyFWY9mCGmCMvsuQ4=;
        b=cQpjzn17L+RGafsKD7DhXJdvtW/UZ7YCbBDJF0DLA2UQbFdfTUfMfu/0wv4Skrbu7L
         JmftWWMOByiASYlP1EOO4hV1QbYUXrRZUZnSCVyKBn63rWloelSh4kZjOfp3wpnNYqrq
         t7H9sbtyhsYdIW96zowseeDWocUWtv1haf/A+zQpAOx2wCr1Tq4RBZDAYILe2IFo5e6p
         RZcX6Qsotcj97LMCAF+uJODvnx4h9Ium2FCPP13DDQSVZ5S+UXKhXVL5yYgcRBr9BabR
         esgjgRRyb67So5eu2Vv23KXKFHLXDVRgoU64dunTSGrUqLgpIDnVTDK2w65V3iX2jRv1
         oCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLwpQVESMtB7Px0KV25LdFPuzmYyFWY9mCGmCMvsuQ4=;
        b=aIpQMhonK8HYJpwNMcfip05uEIy4fkjkZ7IvvZriB+v0+4sW1AKOfF3VZ19djwnijU
         P7KoIuP4mNLs4Z464r5v1md6LactxtFWpz+HA1lNxIcNSUMu5Oy5MXN9FK3yRuphCSV6
         R1Cu9JPrQJVSrJVRQuaJ05pJkcC569xqqApdFTsjOIgg/B7eCtkIfvFwV78afLBlt00F
         XT/hNR5KLa61Cf5BI7oGACf+3NBFaHmVyqCjLg6NvlZxw9gDfrvGeBchrXnNZnHu3BaV
         E9Nc2WLOPB2/Y3nAPpqZj6KBLx+zgEfK0HwfTXcjCPzVBHH86Cbl4gbCmZPD6j0Iq1WR
         1/cg==
X-Gm-Message-State: AOAM532ViX7ulyOwCXobUjZ7OP0Rc0zMxeT+izRu64xwfzyXdmJy9k5E
        +lkFkBQRDfh1Dk/sHv/I5rdstXvtEgPAzXeU4oVuew==
X-Google-Smtp-Source: ABdhPJw2ny7d7EXRCt8dvHa23ZO6vC/xOncTvPca+y3Lt6S8tuB8RnfF9K7QTxUZAFwyzCo4QQuZP5Ap7a/QXIL1yZI=
X-Received: by 2002:a5d:6090:: with SMTP id w16mr936270wrt.38.1628833279673;
 Thu, 12 Aug 2021 22:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210804050809.628266-1-davidgow@google.com> <CAFd5g44suSKUDXhAh6CNewGeg00BDJurYNMyY4vaAsaEZ1puWQ@mail.gmail.com>
In-Reply-To: <CAFd5g44suSKUDXhAh6CNewGeg00BDJurYNMyY4vaAsaEZ1puWQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 13 Aug 2021 13:41:08 +0800
Message-ID: <CABVgOSnLeeRJzn0G3pcVKiByuFTZ3SJd9hU5aR5fr4=sFGbB8Q@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Print test statistics on failure
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 2:15 AM 'Brendan Higgins' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Tue, Aug 3, 2021 at 10:08 PM David Gow <davidgow@google.com> wrote:
> >
> > When a number of tests fail, it can be useful to get higher-level
> > statistics of how many tests are failing (or how many parameters are
> > failing in parameterised tests), and in what cases or suites. This is
> > already done by some non-KUnit tests, so add support for automatically
> > generating these for KUnit tests.
> >
> > This change adds a 'kunit.stats_enabled' switch which has three values:
> > - 0: No stats are printed (current behaviour)
> > - 1: Stats are printed only for tests/suites with more than one
> >      subtest (new default)
> > - 2: Always print test statistics
> >
> > For parameterised tests, the summary line looks as follows:
> > "    # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16"
> > For test suites, there are two lines looking like this:
> > "# ext4_inode_test: pass:1 fail:0 skip:0 total:1"
> > "# Totals: pass:16 fail:0 skip:0 total:16"
> >
> > The first line gives the number of direct subtests, the second "Totals"
> > line is the accumulated sum of all tests and test parameters.
> >
> > This format is based on the one used by kselftest[1].
> >
> > [1]: https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/kselftest.h#L109
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> This looks great, David!
>
> My only suggestion, can you maybe provide a sample of the TAP output
> with your change running on the thread? I think it looks great, but I
> imagine that it has the potential of being more interesting to people
> other than you, Daniel, and myself rather than the actual code change.
> (To be clear, I think the summary and the code both look good, IMO.)

Sure. The lines in the commit description I think cover the actual
change pretty well:

"    # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16"

"# ext4_inode_test: pass:1 fail:0 skip:0 total:1"
"# Totals: pass:16 fail:0 skip:0 total:16"

Nevertheless, here's the complete output of the 'example' and
'rational' suites, which should give a more complete overview. (This
is with the default configuration of only printing out lines where the
number of subtests is >1)

TAP version 14
1..2
   # Subtest: example
   1..3
   # example_simple_test: initializing
   ok 1 - example_simple_test
   # example_skip_test: initializing
   # example_skip_test: You should not see a line below.
   ok 2 - example_skip_test # SKIP this test should be skipped
   # example_mark_skipped_test: initializing
   # example_mark_skipped_test: You should see a line below.
   # example_mark_skipped_test: You should see this line.
   ok 3 - example_mark_skipped_test # SKIP this test should be skipped
# example: pass:1 fail:0 skip:2 total:3
# Totals: pass:1 fail:0 skip:2 total:3
ok 1 - example
   # Subtest: rational
   1..1
   # rational_test: ok 1 - Exceeds bounds, semi-convergent term > 1/2 last term
   # rational_test: ok 2 - Exceeds bounds, semi-convergent term < 1/2 last term
   # rational_test: ok 3 - Closest to zero
   # rational_test: ok 4 - Closest to smallest non-zero
   # rational_test: ok 5 - Use convergent
   # rational_test: ok 6 - Exact answer
   # rational_test: ok 7 - Semiconvergent, numerator limit
   # rational_test: ok 8 - Semiconvergent, denominator limit
   # rational_test: pass:8 fail:0 skip:0 total:8
   ok 1 - rational_test
# Totals: pass:8 fail:0 skip:0 total:8
ok 2 - rational
