Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470A83B8B22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 02:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbhGAAVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 20:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhGAAVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 20:21:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7015C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:19:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q18so8418674lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/CG640Lc2WlWabIvLJm9NXIcCA/KplWLKdPf3hf/cNI=;
        b=FAkN/08P/90nWgSkJc7L+wrN7B1QLzMymQTCG7qJ0k1xwbLmA8dEfmdwRnyoUk2qbW
         i6/QaE6HPbvcg8AoUpl+0hcqc38prTWvkA80zgPYYh+IPMoxRJ6/CsItYec4KCwFsvrn
         49F8za2RC64Ob+mm9wBQQt+1iewP0zFw79CbnEK21v1wSp/gsg/wJYDptCXP/TiPC6m8
         ay9j4OEaS5L+kfbEdi00qT9X8RMRdJzjgshDuOUGgz8Ftdmgs4ePLbIpnViDeETcqtPL
         qr0sWNb8qqgwNDrJ0XsLRqK7SNnWoGfohEVXNHMfFWYJ6dOeRBDZNgiDwQ3sctELb7ir
         iXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CG640Lc2WlWabIvLJm9NXIcCA/KplWLKdPf3hf/cNI=;
        b=LVcJRGn48jsHl2LYJjauCfZFzlciWIq/GVuZylD72aGcL+hUzbq7EfFGzPoB2GS4fO
         cTQYJIOy0DlfBXrpj5kD2iYNNX8g2ahc2jWqqPKoji9vqNz0/Y76MEQB4pFRdcoI/OSm
         zPPRrtBNLAEWpvF0udpb3uVyt4njPsvcIYGabLEJGcqBqnHo39FpeVJRePVZMFZN1DuK
         GJMffcwejh/YQbKv+jzfaJdDnpukV+yTMcokwAxNlyw5iYe1OAGQYZTF0sJhCMzXPZkH
         oCeer0oYo8P4cYwm5OmFTRsnTc2e8JY4gs03sDDzOFeQ8Tkx76gnNi1fZ7IR0EcVHCxM
         1L8w==
X-Gm-Message-State: AOAM533amNwXO6Ad2/fTXdgOcEbSixIfNdCDhhZH7SrH86nzRW+tiD+P
        0qaOSyeB3uRJgxrJ9UITS9a9zdPh1JKK8BWGYe2EOA==
X-Google-Smtp-Source: ABdhPJyrzqfZ4GqBdHhEisbEDRI9b2ya4zX2ZwzqgjYzVwmdCdFZJwOrHhhY/8Jv2UXgbZnc17zXZkkYZ6Tv/HiF6pg=
X-Received: by 2002:a05:6512:1191:: with SMTP id g17mr28938164lfr.347.1625098757807;
 Wed, 30 Jun 2021 17:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210621083108.17589-1-sj38.park@gmail.com> <20210621083108.17589-6-sj38.park@gmail.com>
 <CALvZod4zE812VjubFKfbTG_jF7-uX5kT48=XQ+2cYxnzsY9-fQ@mail.gmail.com>
In-Reply-To: <CALvZod4zE812VjubFKfbTG_jF7-uX5kT48=XQ+2cYxnzsY9-fQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 30 Jun 2021 17:19:06 -0700
Message-ID: <CALvZod5=Bbih1ryTz33NzDvaKojx=tAj7UF49Eo00B_19-L+fw@mail.gmail.com>
Subject: Re: [PATCH v31 05/13] mm/damon: Implement primitives for the virtual
 memory address spaces
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, greg@kroah.com,
        Greg Thelen <gthelen@google.com>, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, Mel Gorman <mgorman@suse.de>, mheyne@amazon.de,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        sieberf@amazon.com, snu@zelle79.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        zgf574564920@gmail.com, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 5:18 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Jun 21, 2021 at 1:31 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit introduces a reference implementation of the address space
> > specific low level primitives for the virtual address space, so that
> > users of DAMON can easily monitor the data accesses on virtual address
> > spaces of specific processes by simply configuring the implementation to
> > be used by DAMON.
> >
> > The low level primitives for the fundamental access monitoring are
> > defined in two parts:
> >
> > 1. Identification of the monitoring target address range for the address
> >    space.
> > 2. Access check of specific address range in the target space.
> >
> > The reference implementation for the virtual address space does the
> > works as below.
> >
> > PTE Accessed-bit Based Access Check
> > -----------------------------------
> >
> > The implementation uses PTE Accessed-bit for basic access checks.  That
> > is, it clears the bit for the next sampling target page and checks
> > whether it is set again after one sampling period.  This could disturb
> > the reclaim logic.  DAMON uses ``PG_idle`` and ``PG_young`` page flags
> > to solve the conflict, as Idle page tracking does.
> >
> > VMA-based Target Address Range Construction
> > -------------------------------------------
> >
> > Only small parts in the super-huge virtual address space of the
> > processes are mapped to physical memory and accessed.  Thus, tracking
> > the unmapped address regions is just wasteful.  However, because DAMON
> > can deal with some level of noise using the adaptive regions adjustment
> > mechanism, tracking every mapping is not strictly required but could
> > even incur a high overhead in some cases.  That said, too huge unmapped
> > areas inside the monitoring target should be removed to not take the
> > time for the adaptive mechanism.
> >
> > For the reason, this implementation converts the complex mappings to
> > three distinct regions that cover every mapped area of the address
> > space.  Also, the two gaps between the three regions are the two biggest
> > unmapped areas in the given address space.  The two biggest unmapped
> > areas would be the gap between the heap and the uppermost mmap()-ed
> > region, and the gap between the lowermost mmap()-ed region and the stack
> > in most of the cases.  Because these gaps are exceptionally huge in
> > usual address spaces, excluding these will be sufficient to make a
> > reasonable trade-off.  Below shows this in detail::
> >
> >     <heap>
> >     <BIG UNMAPPED REGION 1>
> >     <uppermost mmap()-ed region>
> >     (small mmap()-ed regions and munmap()-ed regions)
> >     <lowermost mmap()-ed region>
> >     <BIG UNMAPPED REGION 2>
> >     <stack>
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > Reviewed-by: Fernand Sieber <sieberf@amazon.com>
>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Ok that was by mistake. The ACK is for v32.
