Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76803D40D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 21:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhGWSvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 14:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhGWSvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 14:51:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3865AC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 12:31:41 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id m13so3831747iol.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4duAkdP8nGjwQz3gP8+9f75sObkeoEVncrqoagaAf8=;
        b=Qt8EzUllMk+BQxwjEg3h2dLhND6WXelcF1KCJ/OESaIZQAXOBaluspkozlZW4JU2R+
         Znk6RH2WGkvMVtpnF6jQsDJNRstUK2sj7oCQyqLlSAZGRo+RcEouepg9OhlYyiS/p4yQ
         s9ltX/w4poTJ8k5MZwNSxVDzds6mULz9zIVop40Cl/D4JyEaTpsTD49WyrV2fPgZYlhG
         XcFHEPNTXItFCgL5d2CgCSWzRH/nvr1uyeVYf5CLU3ivAePMLLTfgV+8gexujzqlY15+
         aQvrAO63kiibVX+tnhTalXzk/+TvDNI9CpZMk4mheAcD9/zMdCubD3WiP9JyDYFvu1mI
         jzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4duAkdP8nGjwQz3gP8+9f75sObkeoEVncrqoagaAf8=;
        b=BWkFNTcxrvrpCmWFW6uJA/hafUZYfmuloM3q4NlB2LTomMoWAe+qq9KXWkv/1TnJ3q
         hHShIrg3TxGeRGypZ39mhhXYNm2Ki2UOG1u2bCDEuY1oW+/+JuQkcDeAFf/SS6avM0uS
         st3hmXQgBClV5HSWZx1n9V8utyb3b3O1PZobHavW8J+BGSfDn76GiCNYuL0ENtVQU5kk
         XXVDXwXvB1bn44XfW0rxYadeeejYa2plW2GbCOr5JSJOhdfoggmFDj1yU1M4U9OGOpCp
         BmpNWYt0nOE713tk3yYRQXq1Ph6jv7YzahHG31ExzWGMR3qWCgMVspbflmPNYtqdLSTE
         uyQA==
X-Gm-Message-State: AOAM53280muRrajibGxDX64wkTd0IbzKpIZyazkyqGIAFbbMA0X+XWsx
        lbfycSIZ9Oy0D1zNoih6IeidxPmgVt1jtTUbnt0JGA==
X-Google-Smtp-Source: ABdhPJzQnB2OGYyKJRiAlpkY+h5/eC/6eYxynuNX9zjXWewneFpScPqGwjaHuFnLWDGRX/KG8nxcoAVFaz+fzETIVUI=
X-Received: by 2002:a5d:9599:: with SMTP id a25mr5155045ioo.86.1627068700385;
 Fri, 23 Jul 2021 12:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210715213138.1363079-1-dlatypov@google.com> <20210715213138.1363079-2-dlatypov@google.com>
 <20210723064328.GA7986@gondor.apana.org.au>
In-Reply-To: <20210723064328.GA7986@gondor.apana.org.au>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 23 Jul 2021 12:31:28 -0700
Message-ID: <CAGS_qxqOD+Bcvy7xti7_eg8+H1cJcfp94BtnRhuzijDcaGF_uA@mail.gmail.com>
Subject: Re: [RFC v1 1/2] crypto: tcrypt: minimal conversion to run under KUnit
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 11:43 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Jul 15, 2021 at 02:31:37PM -0700, Daniel Latypov wrote:
> >> == Questions ==
> > * does this seem like it would make running the test easier?
>
> I don't mind.  tcrypt these days isn't used so much for correctness
> testing.  It's mostly being used for speed testing.  A secondary
> use is to instantiate templates.

Thanks, that makes a lot of sense.
In that case, how useful would `kunit.py run` be? I.e. Do people
mostly want to see numbers on bare metal?

The default mode of `kunit.py run` is to use ARCH=um.
I assume (for at least most of the library-type crypto code) it should
have the same performance characteristics, but that might not be the
case. I can try and get some numbers on that.

There's an option to make `kunit.py run` use ARCH=86_64, but it'll be
in a QEMU VM, so again there's some performance overhead.

If either option seems useful, then perhaps a minimal patch like this
would be beneficial.
I can make it even smaller and less intrusive by restoring the "ret +=
..." code and having a single `KUNIT_EXPECT_EQ_MSG(test, ret, 0, "at
least one test case failed")` at the very end.

It does not sound like patch #2 or any future attempts to try and make
use of KUnit features is necessarily worth it, if correctness testing
isn't really the goal of tcrypt.c anymore.

>
> > * does `tvmem` actually need page-aligned buffers?
>
> I think it may be needed for those split-SG test cases where
> we deliberately create a buffer that straddles a page boundary.
>
> > * I have no clue how FIPS intersects with all of this.
>
> It doesn't really matter because in FIPS mode when a correctness
> test fails the kernel panics.
>
> >   * would it be fine to leave the test code built-in for FIPS instead of
> >   returning -EAGAIN?
>
> The returning -EAGAIN is irrelevant in FIPS mode.  It's more of
> an aid in normal mode when you use tcrypt for speed testing.
>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
