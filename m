Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8AB336850
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCKADu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCKADn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:03:43 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE7FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:03:43 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z9so17339092iln.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFWDtf2wFIR6Z0pjhiaIXpIQXNSN34oYlbsbQvsmVJQ=;
        b=btcspacds/zBLnwErhu3LItaqtsVPPFk8yn1Il+UOyDX17OD/7ZmfHtxdgTAt/9r20
         lVRadOU5TBXqinOGT971pBLSKnxKW8lHnCe0ev1VOmc9CABqKT/6MDAeR7VcQqU7nMe1
         v9plKBiRUElJPpWfvbQTcsPso9OS3DqRt48x5QJ22Ho51JHOy06/AdYAjZnlzPQBH+mD
         SrLHJUgS22v2qhGRQ5q7Zdd2AfjYfaWYnKSyuZU9u3bb1DiX7mnqazRUoGeRJ1nRqrEo
         zfGmEwrmlXwKwCyQ38snSEJEosiOkXTt6eeJ0BUSO9jQdh+O/zbPbggeVyp7nGkIZYae
         fb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFWDtf2wFIR6Z0pjhiaIXpIQXNSN34oYlbsbQvsmVJQ=;
        b=KZvAGGSKX0gnDbmiRWBgjlFZAKgvdjHC48n+NI+iQPICdg7rBeN6PaPgF6EqG/AJc7
         UoveGVMVbFJUV97u+eqd1gNfSvFVjLYKTvsY7sngH8aq3aJq8JgV/F9ODP7TqiBSWlNp
         frhYxzq7pWgJQI9HOHPLsm4Eb1mUvJzL8s9MPFi3wpIhMmbrI/iuDdNY0XGQHUwA1qi1
         RR0HXIBZIRYNrjW8Q2N+wohOCjkbLobRtX4DlUajn5/Wz4P8ZnKEx6as4MvHNF4Oy6OS
         9dEWPLQNe7CgwJ4RzSsnML/bc3Alj+szxS2v3jZLQ55fBF4NnuplyLkuYnOQlgltHtqg
         QGQQ==
X-Gm-Message-State: AOAM532LIIb32LTHmPWZKCDy7Sf02khBHyLr1XmS9CDaSW27gjjXmqbM
        7LvzflY80PRKgKdKAbR5PwAH2pRw7C5VMkFm3AwJPQ==
X-Google-Smtp-Source: ABdhPJyLrvA8Vrt99tQd0EnIs1ywVAucAjG2yA+NMXBWB267ZiFSDoDNqjCM7FP2REc7oqap+CH/rZcaHu3cDuWUcHY=
X-Received: by 2002:a92:cd81:: with SMTP id r1mr4695898ilb.252.1615421023280;
 Wed, 10 Mar 2021 16:03:43 -0800 (PST)
MIME-Version: 1.0
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com> <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
 <20210308161548.GA37664@chenyu-desktop>
In-Reply-To: <20210308161548.GA37664@chenyu-desktop>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Wed, 10 Mar 2021 16:03:31 -0800
Message-ID: <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
To:     Chen Yu <yu.c.chen@intel.com>, bas@basnieuwenhuizen.nl,
        erwanaliasr1@gmail.com, owen.si@ucloud.cn
Cc:     youling257 <youling257@gmail.com>, lenb@kernel.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

I am just resending your e-mail, adjusting the "To:" list to
include the 3 others that have submitted similar patches.

... Doug

On Mon, Mar 8, 2021 at 8:11 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Hi,
> On Mon, Mar 08, 2021 at 07:37:07AM -0800, Doug Smythies wrote:
> > On Mon, Mar 8, 2021 at 5:50 AM youling257 <youling257@gmail.com> wrote:
> > >
> > > this cause turbostat not work on amd cpu.
> > >
> > > root@localhost:~# /turbostat
> > > turbostat version 20.09.30 - Len Brown <lenb@kernel.org>
> > > CPUID(0): AuthenticAMD 0xd CPUID levels; 0x8000001f xlevels; family:model:stepping 0x17:18:1 (23:24:1)
> >
> > There are already two fixes for this in the queue.
> > https://marc.info/?l=linux-pm&m=161382097503925&w=2
> > https://marc.info/?l=linux-pm&m=161141701219263&w=2
> Thanks for reporting and pointing this out. I assume these two patches are both fixing the
> same issue? It looks like these two patches should be merged into one:
> 1. Bingsong's patch access MSR_PKG_ENERGY_STAT only when RAPL_AMD_F17H is set,
>    which is consistent with the original context.
> 2. Bas Nieuwenhuizen's patch also fixes the issue in idx_valid()
>    in case RAPL_PKG was not set but with RAPL_AMD_F17H set.
>
> thanks,
> Chenyu
