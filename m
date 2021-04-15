Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2083607E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhDOLB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhDOLB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:01:57 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B453DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 04:01:33 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so22172803otk.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IFP44EoHv+xxG03nkNR4GHUNpt/BWmDmChQZTykWcJM=;
        b=I1EYyJfYWiaNNE76vfMp+ymJJsb+kgNA5IUfXSmMKhD0UgFtNun9i2+Yt7VraR4v1Y
         xyCGU3ruhru3JhXF/E7AJZuwW6FyU0whukie3r9ccNC8UFdoqvaHe+8gKdSD56D5GcJE
         w+jRhEzsDJr+bKuEElT3oCoKtJBauTK48QaqgBPly8aKEBbWOX2UVE7gZ78UTXYeAdGV
         vPPAc4deRxfrDHDf6GJE1tIs9XhzU9BVVDiRpWcpY1JvrH/1Hv7aEASkzyAFzq+6IPSg
         bjE/JqXcCWwqyX9wlGLsed8a1jC9aP0LgE7cDFHGeC5BoKbMxCQxQBYnKVY28z0SD4/Q
         4CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IFP44EoHv+xxG03nkNR4GHUNpt/BWmDmChQZTykWcJM=;
        b=pEPTxK1dfCgsnSss/Nfvjm3oHv6rd3k3/HkXqITbx2JrBh7ulVI1rPpNHbaRVrnFcb
         TVNMVdzNHu6fPIGrUUI7EZIqWQv/2AbuUp+GsOjBk9tl6SmCFz1DYLVY2j7VBmWNm+yg
         aa8DR8kjIaDpyYQMUASxmQvIpOuVmy6gm98zMQ5d1j7sED5GSNuMfwwIKlz2MxdiuNJG
         IZ5W3CfBCV1uwYuPQnuggcExOxmA3WBEkgi7ISHw0clsOxqEF6gQlLjvurpaim2WTzoI
         XtjF9bxwvJxaQu0k/V+iiaSYCpv8djG/sQG9xMa21BERpFnj9CT0mtcE4wFTYOPBqV+q
         FtXQ==
X-Gm-Message-State: AOAM532y+2vZrrN8mY2cv7FO3MKCM5J4Ma+8YTNnQhxsfqITaoVNHJQn
        KyW0ktjGFf03m5JSMYq6h4k//pTBEJzDbD/Xrh3qzQ==
X-Google-Smtp-Source: ABdhPJxosqBAzdRMrnAL2d6JoX9t4Hd36XsCoJp3rPmD5a+tT4/RPNgNrwhWjFD0usJNPoXQzSMbCBz6CuOlykdLwXA=
X-Received: by 2002:a05:6830:241b:: with SMTP id j27mr2282851ots.17.1618484492855;
 Thu, 15 Apr 2021 04:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210413100747.4921-1-glittao@gmail.com> <20210413100747.4921-2-glittao@gmail.com>
 <CANpmjNOOWuiR6Lb1igX+5Lp=PwcEE7Gx5co5KeGCnGz2WxbjNQ@mail.gmail.com>
 <CAD=R=qq9fUKnD7vxayigTPUF4E=_3w-4uZwM=ym4DfqXwP3QSw@mail.gmail.com> <23e27bc2-2f12-d65a-b3ac-8ecb7a37a8c1@suse.cz>
In-Reply-To: <23e27bc2-2f12-d65a-b3ac-8ecb7a37a8c1@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Thu, 15 Apr 2021 13:01:21 +0200
Message-ID: <CANpmjNNGGmhe+GxeP+MYgt1F-RXoC7K-3Sh0h4gOnwpE=RuNXQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/slub, kunit: add a KUnit test for SLUB
 debugging functionality
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Oliver Glitta <glittao@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 at 12:38, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/15/21 12:10 PM, Oliver Glitta wrote:
> > ut 13. 4. 2021 o 15:54 Marco Elver <elver@google.com> nap=C3=ADsal(a):
> >>
> >> On Tue, 13 Apr 2021 at 12:07, <glittao@gmail.com> wrote:
> >> > From: Oliver Glitta <glittao@gmail.com>
> >> >
> >> > SLUB has resiliency_test() function which is hidden behind #ifdef
> >> > SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> >> > runs it. KUnit should be a proper replacement for it.
> >> >
> >> > Try changing byte in redzone after allocation and changing
> >> > pointer to next free node, first byte, 50th byte and redzone
> >> > byte. Check if validation finds errors.
> >> >
> >> > There are several differences from the original resiliency test:
> >> > Tests create own caches with known state instead of corrupting
> >> > shared kmalloc caches.
> >> >
> >> > The corruption of freepointer uses correct offset, the original
> >> > resiliency test got broken with freepointer changes.
> >> >
> >> > Scratch changing random byte test, because it does not have
> >> > meaning in this form where we need deterministic results.
> >> >
> >> > Add new option CONFIG_SLUB_KUNIT_TEST in Kconfig.
> >> > Because the test deliberatly modifies non-allocated objects, it depe=
nds on
> >> > !KASAN which would have otherwise prevented that.
> >>
> >> Hmm, did the test fail with KASAN? Is it possible to skip the tests
> >> and still run a subset of tests with KASAN? It'd be nice if we could
> >> run some of these tests with KASAN as well.
> >>
> >> > Use kunit_resource to count errors in cache and silence bug reports.
> >> > Count error whenever slab_bug() or slab_fix() is called or when
> >> > the count of pages is wrong.
> >> >
> >> > Signed-off-by: Oliver Glitta <glittao@gmail.com>
> >>
> >> Reviewed-by: Marco Elver <elver@google.com>
> >>
> >
> > Thank you.
> >
> >> Thanks, this all looks good to me. But perhaps do test what works with
> >> KASAN, to see if you need the !KASAN constraint for all cases.
> >
> > I tried to run tests with KASAN functionality disabled with function
> > kasan_disable_current() and three of the tests failed with wrong
> > errors counts.
> > So I add the !KASAN constraint for all tests, because the merge window
> > is coming, we want to know if this version is stable and without other
> > mistakes.
> > We will take a closer look at that in the follow-up patch.
>
> Agreed. In this context, KASAN is essentially a different implementation =
of the
> same checks that SLUB_DEBUG offers (and also does other checks) and we ex=
cercise
> these SLUB_DEBUG checks by deliberately causing the corruption that they =
detect
> - so instead, KASAN detects it, as it should. I assume that once somebody=
 opts
> for a full KASAN kernel build, they don't need the SLUB_DEBUG functionali=
ty at
> that point, as KASAN is more extensive (On the other hand SLUB_DEBUG kern=
els can
> be (and are) shipped as production distro kernels where specific targette=
d
> debugging can be enabled to help find bugs in production with minimal dis=
ruption).
> So trying to make both cooperate can work only to some extent and for now=
 we've
> chosen the safer way.

Sounds reasonable. In any case, I'm fine with this version to land and
my Reviewed-by above remains valid. :-)

Thanks,
-- Marco
