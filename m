Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6213DC311
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 06:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhGaEE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 00:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhGaEE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 00:04:26 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F86EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 21:04:19 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f6so8044512ioc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 21:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFmzRvrQwwX+/h5T5pEHk6Y9rzp+9zbf/fzAExZsDUs=;
        b=ByDAtRrTejpUQn1ptsavPV5TqWsShnWxLIUUnQGbO8wetrhp+7fwCXl/tUk+a48ojP
         wHMNDd5ICBsX7VxtJPbE+nOGBb25m8zC9e4wKVGaj6F450uWc9Cyzdt5BNha9AG9P29x
         SAQ5Tv0znx3sw8topp2ax9llpLOUB7V+onfECLECVLjgzdrlRxGEPmQCzdaDoutxjzPy
         VTR3vMCMpQvNbeKwmHnhb9TYUNMI28LGf9Hp/QBDjRu3Z/dBd5GrmsJ15OMolioT7zIE
         hdRBLvRf7oZp7KQieTTwl5PpHo4DIlPmJNM9dBABnVAFVGQwhKoIcGAmv+IHNOcCm38G
         WsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFmzRvrQwwX+/h5T5pEHk6Y9rzp+9zbf/fzAExZsDUs=;
        b=ZkB2dm18L6NKHZdYAudR0oUpD6JfsCFm/1Kw/xkBAmt18TVO0Fg/fLwTZoOwTd7Agz
         wqMZzgIwDUCbdRs0kUqVTkAf97IQvZbvY0LhxmMP2wH7LJncP8tqnUoDyZCoga3bPVAe
         Kbuul95pVn7a1DXwB5P5jsal+zpayshWQAf+uu0cjLgit7fAy3LoPFsMqOMqhCtKlSut
         IEHMwucm9Sfb62EQC/kNfd8xi+iGoOycvqqc6iO/04l7e1JzXX3mCuPB8Uw1uUQ42Pnh
         Lh2GeU8RzBvqNPp0MCe6OTIKX7M/acS7HHDxzRu3L/o0J3geHFu7VU1JoSSEgTTHp99i
         Fwag==
X-Gm-Message-State: AOAM531qtKDRllajSySE6tjjlBqaRcc+r7VIuq6sZw7RYrXfqULa/bRv
        a4x/RlMzTSZ43MAgus3RctqyBbKypPc3sZNfYVMGDiKgeqQ=
X-Google-Smtp-Source: ABdhPJwY3j+LM5B6toBq9lu8MGJoV4JDSVu8zpnYQkps2H8n0WGIKR+RVJmqF922K1TxIS0ed5QMXZ4HuRFNkqHSU+M=
X-Received: by 2002:a05:6638:204c:: with SMTP id t12mr4753823jaj.129.1627704259008;
 Fri, 30 Jul 2021 21:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <4336554.LvFx2qVVIh@kreacher>
In-Reply-To: <4336554.LvFx2qVVIh@kreacher>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 30 Jul 2021 21:04:10 -0700
Message-ID: <CAAYoRsX+NnOom6f7s6=xOM8rwa_S6tPaQyReYfgDGU4wDkG2uQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] cpuidle: teo: Fix selection when idle state 0 is disabled
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 7:39 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi,
>
> Patch [1/2] fixes idle state selection in the teo governor when idle state 0
> is disabled (which is broken after recent changes in that governor) and patch
> [2/2] renames two local variables on top of that change.
>
> Please see the patch changelogs for details.

Hi Rafael,

I tested this version of the patches, and the idle state 0
disabled issue has been fixed.

... Doug
