Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4333807D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhENLAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhENLAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:00:52 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D61DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:59:41 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso26053059otb.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhVFchyLVYHHGtDSOVkVEFKwEwJD9MBI+lGS78m6qC4=;
        b=HYZDmLl5tUzz6aid5e8scuT9bC7VqZ6gKMZwnutBdojvGlw5KJ4o5/VlRNZRLfh8N6
         G8fbGJG9t+VN9zuu8Q1xkJaX9hcz7Bh9KKpISHfFJBn6mkDJf301wCvxb12m4G2FP/PS
         epvApun2Wy2eHMgikWBHx1SZd/O6c4ZRAwHHaEYw9xpftkt/eOqCmL1P9UJCc4tWq7li
         oqv0Q8c8ZdnXjufmDWvsaO5CxH7cBazl6B6d/z7XdyfsMJrsdKVnyH4P8rLEJnXxdCq3
         c7BL3n7bIAcAuvr1NysywraYlLN0eg64XCwc3ZLf5iT7WATqHWVHw8ToSyTbAuqzNnzD
         wFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhVFchyLVYHHGtDSOVkVEFKwEwJD9MBI+lGS78m6qC4=;
        b=uV01jkSmBT0MFmYlD7OLv/oDgaR5CXq7geExT0TyAs47Km8QAx83IkDAwU2JsfXg9n
         QaOe8ABHsWUW53v30Ri/f+fsBmAJmusRs7FCHT5bdR7/ItfQ5Ez0pKTSBBQwe/UGmGsB
         ACiB6qEVY1CaXmqHf+Yg2hYAhFvfh4aAngmE4V+gXMfQilnfidsjMKphKF9KiUCZ+0DP
         vOZ9v8DJGRasJwpQdoO6H0hub8QbebEDe7PaWsbME+5iLBj3dT4x42p3J5l/4szNL7L/
         TNpTZwVWSte3JejBWp3ebv+IwLbdm22TvDb/4cAdWbEeR54YUGhxhiSJIm2vPQ6SPU1i
         jX0w==
X-Gm-Message-State: AOAM5338d+oszYjCbR11thurOY4ZZj0f0HRbcCYnEwB4b6RlvDf/3WT5
        1PQNT0McAPYBA8Pai9YHoAkQhlLsa0makgxNaVkIA9uw1QRoHQ==
X-Google-Smtp-Source: ABdhPJxer8iIIDQmhQyQboS596+pw1PqfsaAojNfu3O0F/vnuPLq3OWeCTE4DIIFGKM5r5E/+gnoe0mjvrSgMFun/nY=
X-Received: by 2002:a05:6830:349b:: with SMTP id c27mr22116714otu.251.1620989980895;
 Fri, 14 May 2021 03:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210514092139.3225509-1-svens@linux.ibm.com> <20210514092139.3225509-3-svens@linux.ibm.com>
 <CANpmjNOLSuqeTr8YOnvz-V=eudBwraNvm+9V+YxEBUCm=EFwxw@mail.gmail.com> <yt9dk0o1inzu.fsf@linux.ibm.com>
In-Reply-To: <yt9dk0o1inzu.fsf@linux.ibm.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 14 May 2021 12:59:29 +0200
Message-ID: <CANpmjNNWyu2a7zqkiPK9inSM8+shXW_ppR=BKd8GFHTTi_+z9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] kfence: only handle kernel mode faults
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 at 12:55, Sven Schnelle <svens@linux.ibm.com> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> > On Fri, 14 May 2021 at 11:22, Sven Schnelle <svens@linux.ibm.com> wrote:
> >>
> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >> ---
> >>  mm/kfence/core.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> >> index bc15e3cb71d5..161df492750c 100644
> >> --- a/mm/kfence/core.c
> >> +++ b/mm/kfence/core.c
> >> @@ -813,6 +813,9 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
> >>         enum kfence_error_type error_type;
> >>         unsigned long flags;
> >>
> >> +       if (user_mode(regs))
> >> +               return false;
> >> +
> >
> > I don't think it's required on all architectures, correct? If so, I
> > think this should be part of the arch-specific code, i.e. just do "if
> > (user_mode(regs) && kfence_handle_page_fault(...))" or similar.

Ah, this should have obviously been "if (!user_mode(regs) &&
kfence_handle_page_fault(...))", but I think you would have caught
that anyway. ;-)

> > Because otherwise we'll wonder in future why we ever needed this, and
> > e.g. determine it's useless and remove it again. ;-) Either that, or a
> > comment. But I'd prefer to just keep it in the arch-specific code if
> > required, because it seems to be the exception rather than the norm.
>
> Ok, that's fine, i add it to our code then.

Sounds good.

Thanks,
-- Marco

> Thanks
> Sven
