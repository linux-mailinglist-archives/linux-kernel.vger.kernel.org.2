Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7257437B199
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhEKWZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKWZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:25:47 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A32C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 15:24:40 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id t3so19689189iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7udKTzo5uQZqNjObTNB6UA4nLmncb2xfLc5gKzOgoI=;
        b=S4CunIRVCOoCTIsC5PY+66+xpOc4qR6h0uWlajU/X6pvUDvf4TiDX2iQ/yk/9GiEWH
         0YRwPde+q68uOYKU5aO25MOA9TfLr71lVsYMs2xg3lQLGsQH+VFzF73U1KE17XYT3/7m
         xrtANrUMvBpvmkVdWzmChhuLrGbSy7ojd7cq/qMGE7vM5o5f4MxN20cQ0VjlNWy/bfk0
         4QH7QZUXVPNFp/AUkQCPyD7Qqm5rR8Sm/XRI6xeDtXJgr5/9EC5b+5Ijz4l9fH+3ezr9
         8OyeA3w6obRFchydBtNsQXQutBUZYVB9fwMjA6T2u+ZanFI9x3XcgtNIUiLmDXGGQgY0
         oT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7udKTzo5uQZqNjObTNB6UA4nLmncb2xfLc5gKzOgoI=;
        b=V8nrUaS55VWmvdNqftcFZAVKe0fSnwCQyrH7POaakba5k+EoIgmFoYa8RiOF0v4LqE
         Yu7PoWPo4O8lytaBVciYo4/+gho3zfcJK4Qm7Ti9Ou46BZj1lqqiyNCUI0J7gjZkgwSd
         +OjCEul4MvSj58gZ6RGz5Xn6QbISj8scc3rZPcMsFBx5UvUCb6S0KJJApSFTlvTYAAlr
         ArGz1X6y81/JIRZSXdO6Ppg6Y25YfgIbhT2jk3ceiP4aOxMZQ3SRF+bBfUQ529LhGbj4
         MJWr78AqrLythkXT2nJOnk4gvfhabXzKAZeFfvPbncMVHqu1ptyZeVVIOkMXYOzLjDHt
         WU8g==
X-Gm-Message-State: AOAM530DMDE0sHu9iqpIurcVeeM6TuqlY9S4+e/WelLFfAjcT01Iv5Ww
        lFn2ZwFBqkC6ESPz5AO4Exn3hY6wowxbpWTqmENFlA==
X-Google-Smtp-Source: ABdhPJyVU7muj6jg460tt7Ak7wRhD7TDhhQ1tkM3QlSH0Z+idgPfxEVdT4JpLXFBh6GdZmj/7AjmzatmBKQjah6I6T0=
X-Received: by 2002:a02:a381:: with SMTP id y1mr29186423jak.1.1620771880329;
 Tue, 11 May 2021 15:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOp6jLZ8GR8DKCZLQJKPS7oeP1CX4L3ijBFDBePGX4q6z-DQhg@mail.gmail.com>
 <CAJHvVci_q5rxuo-N+EH_CNxX_M3oxWcLyitvbdySa_PMH3e_Dg@mail.gmail.com> <CAOp6jLaSLC4O0ZayFz1BiO6UqC7pK_umFUb29bgXDu6U5dUQgg@mail.gmail.com>
In-Reply-To: <CAOp6jLaSLC4O0ZayFz1BiO6UqC7pK_umFUb29bgXDu6U5dUQgg@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 11 May 2021 15:24:03 -0700
Message-ID: <CAJHvVciAMt_PJ=V-q8_7X02cQmor3wVCTMKbpSQ9UhpnwFAa1A@mail.gmail.com>
Subject: Re: Userspace notifications for observing userfaultfd faults
To:     "Robert O'Callahan" <roc@pernos.co>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Kyle Huey <khuey@pernos.co>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 3:15 PM Robert O'Callahan <roc@pernos.co> wrote:
>
> On Wed, May 12, 2021 at 6:12 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
> > Is some combination of bpf and kprobes a possible solution? There are
> > some seemingly relevant examples here:
> > https://github.com/iovisor/bpftrace/blob/master/docs/tutorial_one_liners.md
> >
> > I haven't tried it, but it seems like attaching to handle_userfault()
> > would give similar information to perf_count_sw_page_faults, but for
> > userfaults.
>
> That would probably work in some cases, but as Kyle said that requires
> privileges and currently rr can run unprivileged (if you set
> perf_event_paranoid to 1 or less) and usually does. Also, AFAIK,
> kprobing handle_userfault would not be a stable ABI.

True, it would not be a stable ABI. That could be solved by adding a
real tracepoint, instead of just relying on a kprobe on a particular
function. But, I don't think that solves the concern around
permissions.

I am no expert on perf_count_sw_page_faults and similar, so I'll leave
it up to others to give an opinion on extending that.

>
> Rob
