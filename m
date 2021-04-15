Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23743612F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 21:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhDOTgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 15:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhDOTgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 15:36:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EF7C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 12:35:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m11so16754614pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1hh0MzoZdTJ4Xb+ynQUqqNm53RO3pmbcc0xFxC3ICI=;
        b=Hct6xiMBs5RV1Sv/HtXA+VQbUi/vvwFUpSJA22Fd7UQNsSl55H2jv3rniJK0ZnY0fC
         ciRiqxM+a+BMKNjuk706wItI/ZY/+/lu1n04GE2ae92cZcpjznzmUvtn2+o5Ms+z09lw
         iF3STDGrJVvZe9FAchLRFUMZwZyaUd/kVWvg3UnWOBjPvvjFBkC9rcAn4FDAZC6kkDaB
         Kl3JrrKQJwvMqrOOknp+UV6vTOAsBG+DpODw8PEcvNbiOAtXLWVxw1uaDJZ2bzW1lvj8
         8e0O9vKNnDl5XZS5/M/IAJ+38tFuSzWSE2W+oK5r0ajoJ5nGwKrYumWY/im0RIkp3xSL
         LInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1hh0MzoZdTJ4Xb+ynQUqqNm53RO3pmbcc0xFxC3ICI=;
        b=in9SsbaoXuxlVdi4+OUnGBecN9WFvgDRJtMiUi640ibBhSTl+rzygLaxIB38WH/S9C
         OrhMdAXwjxxrnzjYcoi1yn4guA8R6oRKY95SOI+pBE+wKSn8T6gPuWg3ovBi2hp2xMur
         rVQaMumDR23h+UuKKP2wenl2zKMPxPfdBbzpmbOYfbHabLcWQJIu79hiDI1dzNyISS4S
         6DEVS7FfjdWXCqKgD44qY15acNQCrWCjnOoyBW53yzKKJyLf9COpCuAKZxIo9CbK9ayM
         hMDdvmaytFCMX1rhpoPR2g4agH1N396yZQId2adcWHTw2J/YVIYxQJ4Tg+fBN6kDLzn9
         Cx6w==
X-Gm-Message-State: AOAM530PJrvGcxSyrbrApDZfDo4rhLjDLsdQyiLyrLkMsBuMeY/P99iE
        vE6K7ceiSSXLUbU0uF0r8VO7X5qLWDdEmPJeL7A1Xw==
X-Google-Smtp-Source: ABdhPJwu8zc/HOITd8q4SQ2u9TGsiMv324Gd2tmRUzsB+t0pIREOOWz/MiNe64PuUy9RcyrJfVoLa0BgLGfW5AZ7Stg=
X-Received: by 2002:a63:e509:: with SMTP id r9mr4993212pgh.384.1618515352368;
 Thu, 15 Apr 2021 12:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210414222256.1280532-1-dlatypov@google.com>
In-Reply-To: <20210414222256.1280532-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 15 Apr 2021 12:35:41 -0700
Message-ID: <CAFd5g45Qx9xyrPz1U36PXtBYFf+nOk2K=anOpBobLS+2xd8NCw@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: kunit: add tips for running KUnit
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
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

On Wed, Apr 14, 2021 at 3:23 PM Daniel Latypov <dlatypov@google.com> wrote:
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
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
