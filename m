Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383C337AE70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhEKS0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:26:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0253C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:25:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2so30014518lft.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pernos.co; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9RyWF22KzwLKArKaPRg8pNWC1t+VofvpkH4MjpQva4=;
        b=aszYMCricCo5Ag2eeDk8OCI5dD4USw7RzHUgzv2ez4K73y68yotiOfwA5n075q4HxL
         o/D6aSm6ed5gNiXxemb/fl3o9pA7tsWjzQWfvmnAxCq7CP0zulbRGJCe/id7PNoi7xY2
         EJnBGhHxuido7XftseRe1uF8HKYP60atm4Rhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9RyWF22KzwLKArKaPRg8pNWC1t+VofvpkH4MjpQva4=;
        b=NpQam4gQvmSn5LGQHhGrDgu7ql7dCiFw7TGkeQBBKMDpLq4HU3sMk6M5mk7wfxyMPk
         ZoPoyCAYytm1QeEeGcXut3u0Xkn/vMmsUC1xUOmtwlahLs3GiYxeYZVtKlPWbEFpkdD1
         8dQoCXR7U0UBjKTD7fBf5N57IMtDQq4wr33dGM6S887zeevbxB5MzCGF0NmnFX3bRbsz
         h+asEf0WZ7PszbcTJPbVH5nRdJFrUrNQc3bbttaf61Krw6CNZtZGnLapI9zQUPd5+gd7
         u4+86rLq9VdgGqriEtIx1edp4EFFJ0N1oFPugcSSX/cXGM+op2ytcFiqtj0QvyxG8r2N
         CuRQ==
X-Gm-Message-State: AOAM533+hVwW3wkwfENvm1UNFu8Wf03I+xnBmcaKDG5W29pjxn+MtDs3
        kJSAku/OFCzAOh1YuGoliHI0OErC+F5CgGkFW7UjaOgi/ns=
X-Google-Smtp-Source: ABdhPJwgY7J4Ug37iFaEo37AHTgndWxjBuFbh4z5GujTsg43tHgFCKVtGnYy+QoX5ltXg2X46reWPWHpq6VaTI+s0Vw=
X-Received: by 2002:a05:6512:3aa:: with SMTP id v10mr21501747lfp.263.1620757520265;
 Tue, 11 May 2021 11:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLZ8GR8DKCZLQJKPS7oeP1CX4L3ijBFDBePGX4q6z-DQhg@mail.gmail.com>
 <CAJHvVci_q5rxuo-N+EH_CNxX_M3oxWcLyitvbdySa_PMH3e_Dg@mail.gmail.com>
In-Reply-To: <CAJHvVci_q5rxuo-N+EH_CNxX_M3oxWcLyitvbdySa_PMH3e_Dg@mail.gmail.com>
From:   Kyle Huey <khuey@pernos.co>
Date:   Tue, 11 May 2021 11:25:07 -0700
Message-ID: <CALWUPBdTcHrnbtZuMPjmxt4sAD6hoJsOZOvsc8vCuCAttzUbTg@mail.gmail.com>
Subject: Re: Userspace notifications for observing userfaultfd faults
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     "Robert O'Callahan" <roc@pernos.co>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 11:12 AM Axel Rasmussen
<axelrasmussen@google.com> wrote:
>
> On Mon, May 10, 2021 at 5:38 PM Robert O'Callahan <roc@pernos.co> wrote:
> >
> > For rr (https://rr-project.org) to support recording and replaying
> > applications that use userfaultfd, we need to observe that a task we
> > are controlling has blocked on a userfault. Currently this is very
> > difficult to do, especially if a task blocks on a userfault on a page
> > where some other task has already triggered a userfault, so no new
> > userfaultfd event is generated. We also need to observe which page has
> > been faulted on so we can determine when the fault has been serviced
> > and the task is ready to run again.
> >
> > I've tried to find workarounds with existing APIs and it doesn't seem
> > tractable. See https://github.com/rr-debugger/rr/issues/2852#issuecomment-837514946
> > for some thoughts about that.
> >
> > It seems to me that a sufficient API for us would be a new software
> > perf event, e.g. PERF_COUNT_SW_USERFAULTS, with an associated
> > PERF_SAMPLE_ADDR that would give us the address of the page. Does that
> > sounds like a reasonable thing to add?
>
> Is some combination of bpf and kprobes a possible solution? There are
> some seemingly relevant examples here:
> https://github.com/iovisor/bpftrace/blob/master/docs/tutorial_one_liners.md
>
> I haven't tried it, but it seems like attaching to handle_userfault()
> would give similar information to perf_count_sw_page_faults, but for
> userfaults.

My understanding is that using bpf/kprobes requires new permissions
that are both not currently required by rr and would not be required
by our proposed solution.

- Kyle
