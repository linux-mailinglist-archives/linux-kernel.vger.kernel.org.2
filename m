Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83860419434
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhI0M3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhI0M33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:29:29 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0810C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:27:51 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so24151876otb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elnv/dvTCghhthSbzUFQClfuNaZTFLaDjWJp6GbnFH4=;
        b=XwYTs8G9luBiF4vsPYyk3cifUaOLLBwCUmzHsdH+fgZBRzy0bwqFSonEbSwuNs7R4S
         KLAi4gvWpA2aSixcCYQVH2wQPM/KEh8i7Uk9v1jfk+sjRPftQnJN8/wNxE1iN3QL0+oz
         rlTs5ka14QkhiIFFH/pdp04AmzLx+8oKn0TU7t3jLTnaOnT9AnwTD6xAVH0YfyWU2mUr
         McdEmwsypSuxPMb9qmMO2KhxLbqRF45Ve2Rm6wdZPtBao6Bwapd0OQiMuxVdR1e6BD2S
         8tQnVPyqOK1g9EW1Kmnri1XipN9eLeXL93GpI/HrPX6Oz7hMtf1zYCTBwZBqYwMpUfTz
         fdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elnv/dvTCghhthSbzUFQClfuNaZTFLaDjWJp6GbnFH4=;
        b=f0bqi/D1V0clEmLIfSKOQ8094wGDeZku+cOHbaNODMHN9XlqmYrmFx4YH2lmDVfZ5A
         CQCEU4kUwlxWuQO35R1wevnvAo+Sc+DJv9SnzwSlnMIIpSH02v75Ps8wRnzfAJ4jU64J
         GvWjzgltLGL/R6prwW12bGAc1GKbtOQ+4Imv4lwk5V5olAbUuPsXPNdyadt8r4sYVDLC
         zXxgGL6DmoUMeOW173d/jDQ1tAWj5XbP99eFILGEPGOnd8WUQHARFknQGQL69Ft/7rrV
         l+ywmvZt8DftC4wI+TSuvutQ9sH86X7na1oSHbG5dwmq3H2w39Sa02HApWyxwxxwJpzb
         txnw==
X-Gm-Message-State: AOAM532QjS8x7+hgc1o9vtS6y1X1yJc4tjUBdHdsE09AVgliYnBzm0x1
        H9VuhIq2moKxp1RHiYrEf0VccygG0t/T1n/5UwPZ3A==
X-Google-Smtp-Source: ABdhPJzUSC0PeN/rD5ocMlf3qwuqtGW85Qw5ho+qhTvuZwkYwEj7f5Ye5RSeUkEgsyVpltrRqtjYcV8B9gh5mMZQGus=
X-Received: by 2002:a9d:135:: with SMTP id 50mr16747038otu.295.1632745670769;
 Mon, 27 Sep 2021 05:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
 <20210926223322.848641-4-isabellabdoamaral@usp.br> <CANpmjNN4z9YsD=KjGjgdXsQbKD68RGh5bu-AEX6FeryZ2GdXCQ@mail.gmail.com>
 <CAAniXFQv6r+dmVYc9e-MuJxLqDoyayFLfBZw0FqW3hP7+RQXjg@mail.gmail.com>
In-Reply-To: <CAAniXFQv6r+dmVYc9e-MuJxLqDoyayFLfBZw0FqW3hP7+RQXjg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 27 Sep 2021 14:27:39 +0200
Message-ID: <CANpmjNP6eZqQ8c+E5EsWdBSW-Q85FeJEu6gc7Puqro3igOXmWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] test_hash.c: split test_hash_init
To:     Isabella B do Amaral <isabellabdoamaral@usp.br>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Enzo Ferreira <ferreiraenzoa@gmail.com>,
        =?UTF-8?Q?Augusto_Dur=C3=A3es_Camargo?= 
        <augusto.duraes33@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 14:03, Isabella B do Amaral
<isabellabdoamaral@usp.br> wrote:
>
> Hi, Marco,
>
> On Mon, Sep 27, 2021 at 5:17 AM Marco Elver <elver@google.com> wrote:
> >
> > On Mon, 27 Sept 2021 at 00:33, 'Isabella Basso' via KUnit Development
> > <kunit-dev@googlegroups.com> wrote:
> > >
> > > Split up test_hash_init so that it calls each test more explicitly
> > > insofar it is possible without rewriting the entire file. This aims at
> > > improving readability.
> > >
> > > Split tests performed on string_or as they don't interfere with those
> > > performed in hash_or. Also separate pr_info calls about skipped tests as
> > > they're not part of the tests themselves, but only warn about
> > > (un)defined arch-specific hash functions.
> > >
> > > Changes since v1:
> > > - As suggested by David Gow:
> > >   1. Rename arch-specific test functions.
> > >   2. Remove spare whitespace changes.
> > > - As suggested by Marco Elver:
> > >   1. Add struct for carrying test variables.
> >
> > Did the patches get mixed up? The struct doesn't appear to be introduced here.
>
> Yeah, thanks for the heads up! I must have mixed the messages when rebasing.
> Sorry about that. The struct was actually introduced in patch 2/5. Do
> you want to
> have a look at it or should I send the v3 with the correct message before that?

For review it's fine as-is, given it's a trivial change, but the final
series should have it in the right place.
