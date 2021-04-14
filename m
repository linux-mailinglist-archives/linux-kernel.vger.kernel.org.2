Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDDB35EBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhDNEWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhDNEWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:22:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEFFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 21:22:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a1so21863694ljp.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 21:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ed47Zap+Jm6v6LkB17Gtao1csFaOpRgN07gt7qnUJFs=;
        b=aZ03d0rLRWSZ5+99OAhdQg0cUYtUxyoyybB5+jqI/KlDHMssOtMZDLCYjXWC8CVAFT
         yPJhKktbHXo1vb2Sz3/aWgOm6vSO6ZfBJlp6fh7pPQEdtm94XBqBwJhHuDpvBMjKaAR/
         0kO1Hn6BZWr/MHyoFno6xXW9eW/JXF3ORSsb0gqSwBWSjirsZ44LMLiEurExACh5w5VA
         GGLD/vDoFUKdUlo3xKh0sAicAV6cyhWnb0MLOjahDD94dqz4ajPKEKahKjOTKhg1R9NS
         JYyfl0ogtQjzeNeTkGMncJnomIRUdFi0ZUkWlTgd6uZ56Sk5+F+Z7Lt0wguzJeiHfmHH
         RjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ed47Zap+Jm6v6LkB17Gtao1csFaOpRgN07gt7qnUJFs=;
        b=cwMU6mPRmpzpu+vrYRX3Wq46tH3UNPCl4y/WQCBT8Chppl10YMiUo8i5gKdjNgh5l0
         i0XlEistEsc+iFJVX/1y13DsQ03f02kkKg7G00EYUsqZdVTZi0JOXkCF6lSgQcXwaIMe
         S2q2rKiOpTSG0JDT9RyQ6ufAtp+0UmOlTe5Tyl05QH9AmXL8yAM/7bBLKv8tFU/kAJNs
         Sj7XM882Gp//zS4FrfoyoeyL3C3zf9tjQ9dFxQS9fhkJg1MOkuzN+ii6mDqZ7AL1k0/5
         8CLCDMdZzft6mIWPhnGETUF1O+fveuF5IY0uyfS+cMEjDWAZGGWHBhBi1QBiIWio0HFM
         C0Pg==
X-Gm-Message-State: AOAM531I6Clb5AXBIcX14Yu4VS0Kcg+UHyE23o2FRDs8KDBbmnWoivtb
        ykFrQc/A+8mCbL1ha/3JbqOE5ppYKGwiz8PTBg1yPw==
X-Google-Smtp-Source: ABdhPJxTX3cikTX/eKxutfvDFFK8lRHmedOT93WY406+DV4r4wz+hxULKlxHSrC312/0Bz/cprPVHNdImzdTdcYPXjo=
X-Received: by 2002:a2e:9cc2:: with SMTP id g2mr6473922ljj.245.1618374137046;
 Tue, 13 Apr 2021 21:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210414004518.1116248-1-dlatypov@google.com>
In-Reply-To: <20210414004518.1116248-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 14 Apr 2021 12:22:05 +0800
Message-ID: <CABVgOSm6VY_vVvjryYc8eAvw7QcNuisP1iesdw4s3Td4Dxo1aw@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: kunit: add tips for running KUnit
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 8:45 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This is long overdue.
>
> There are several things that aren't nailed down (in-tree
> .kunitconfig's), or partially broken (GCOV on UML), but having them
> documented, warts and all, is better than having nothing.
>
> This covers a bunch of the more recent features
> * kunit_filter_glob
> * kunit.py run --kunitconfig
> * slightly more detail on building tests as modules
> * CONFIG_KUNIT_DEBUGFS
>
> By my count, the only headline features now not mentioned are the KASAN
> integration and KernelCI json output support (kunit.py run --json).
>
> And then it also discusses how to get code coverage reports under UML
> and non-UML since this is a question people have repeatedly asked.
>
> Non-UML coverage collection is no different from normal, but we should
> probably explicitly call this out.
>
> As for UML, I was able to get it working again with two small hacks.*
> E.g. with CONFIG_KUNIT=y && CONFIG_KUNIT_ALL_TESTS=y
>   Overall coverage rate:
>     lines......: 15.1% (18294 of 120776 lines)
>     functions..: 16.8% (1860 of 11050 functions)
>
> Note: this doesn't document --alltests since this is not stable yet.
> Hopefully being run more frequently as part of KernelCI will help...
>
> *Using gcc/gcov-6 and not using uml_abort() in os_dump_core().
> I've documented these hacks in "Notes" but left TODOs for
> brendanhiggins@google.com who tracked down the runtime issue in GCC.
> To be clear: these are not issues specific to KUnit, but rather to UML.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I'm very happy with this now: all my issues with the previous versions
are addressed. I'm particularly excited to have code coverage
documented somewhere.

Assuming Brendan's happy with the TODOs being there, I think this is
ready to go.

I also built this with Sphinx and gave it a quick look, and it all
looks good there as well.

Therefore, this is:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
