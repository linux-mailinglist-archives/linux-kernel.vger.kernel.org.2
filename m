Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB1366DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbhDUOOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbhDUOOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:14:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D1DC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:13:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g8so67124638lfv.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KT5Z/sPJXf0qDYy55bMraiO4nEL20VpFAQ+FPYD2/dw=;
        b=WFAWOqMmzOQnQNVjpAKoR6YqWuxUDxMFdKgszw7Kn8uz7r8hz4pWSNkrWd5wNrvPGp
         q39wDsrIdJmGWqrYNH8EUO6pO+DVhIsP8AaaNicOjCkRz1CNsoCn+ETNeFl3Q8hL00Ct
         CI1EzrSnzpp4EWE1LXyyb2yFXfBfV/RmqRZCM6pQdzS7WbVf46BwNckO0u6hNrXyZKcf
         0nxRN8JIvGm8b0shRuwYStgnyt9mEE0rBE+HLxDOYWOElrfF7Tk4/ZSmZiS4411A4+bU
         38t+fVT8D6CfEj3lIXI40eG7FQCx5Bzpg1adr0Ij4D6cG3oMI17mt+20w8Tl4tniDdvW
         Xiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KT5Z/sPJXf0qDYy55bMraiO4nEL20VpFAQ+FPYD2/dw=;
        b=t0BSkimq25+6McerXD6CpbblkIBhNfM8F2YoCX1Qk1zXkNUrLnMaqx4XxNECqI0z+d
         BBMgyHg7kjCL4VFDnVeeCXNCh4g3LL5Kv8RQ8gcla/ss6f5i/pHsCW8RPLKijh61+pAQ
         hiDQylcP1MkKajRJbxaZ0ST8kHrVtxIuoxDkCB95HG+pdBoczUOEP6SzTNNcp8h8PlGP
         O6l9xcevMPnjKIbZ4TG/eUvKNoOmXTCxKbTr7I1UYwzYAk0kdmnOO47LDBuaW0kooojA
         qPMkQ08RHGL3rWoHEDAtkcAuadIsBEfPn3sdFbUfIlr2NRTd/MMIfoBgCb2JFvpUqcS3
         /dEw==
X-Gm-Message-State: AOAM532Kb7CT8gJksSo5R+rPAc8cPn1emcodyMcYc3zCm9bFWNpf5er2
        9nt3oCIsrBPUQzFqrX+kEF4GXLnIFo8Qe/T23Sd+Aw==
X-Google-Smtp-Source: ABdhPJwKfxnLC0EMvkKJWK7JOfls96yUQHQql2a1N5hFMm4auIb20AtzZv8tv5ao9CXlQJFzRhkSNO40dAKrV1P9OBM=
X-Received: by 2002:a05:6512:2037:: with SMTP id s23mr19348557lfs.358.1619014436354;
 Wed, 21 Apr 2021 07:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH8o5iIau85FaeLw@carbon.DHCP.thefacebook.com> <CALvZod7dXuFPeMv5NGu96uCosFpWY_Gy07iDsfSORCA0dT_zsA@mail.gmail.com>
 <YH/S2dVxk2le8SMw@dhcp22.suse.cz>
In-Reply-To: <YH/S2dVxk2le8SMw@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 21 Apr 2021 07:13:45 -0700
Message-ID: <CALvZod6oCBB6tDh5wABSwdHfcDzLX7S7cOTLp_4Qk4DCi50X_A@mail.gmail.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 12:23 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
> > In our observation the global reclaim is very non-deterministic at the
> > tail and dramatically impacts the reliability of the system. We are
> > looking for a solution which is independent of the global reclaim.
>
> I believe it is worth purusing a solution that would make the memory
> reclaim more predictable. I have seen direct reclaim memory throttling
> in the past. For some reason which I haven't tried to examine this has
> become less of a problem with newer kernels. Maybe the memory access
> patterns have changed or those problems got replaced by other issues but
> an excessive throttling is definitely something that we want to address
> rather than work around by some user visible APIs.
>

I agree we want to address the excessive throttling but for everyone
on the machine and most importantly it is a moving target. The reclaim
code continues to evolve and in addition it has callbacks to diverse
sets of subsystems.

The user visible APIs is for one specific use-case i.e. oom-killer
which will indirectly help in reducing the excessive throttling.

[...]
> > So, the suggestion is to have a per-task flag to (1) indicate to not
> > throttle and (2) fail allocations easily on significant memory
> > pressure.
> >
> > For (1), the challenge I see is that there are a lot of places in the
> > reclaim code paths where a task can get throttled. There are
> > filesystems that block/throttle in slab shrinking. Any process can get
> > blocked on an unrelated page or inode writeback within reclaim.
> >
> > For (2), I am not sure how to deterministically define "significant
> > memory pressure". One idea is to follow the __GFP_NORETRY semantics
> > and along with (1) the userspace oom-killer will see ENOMEM more
> > reliably than stucking in the reclaim.
>
> Some of the interfaces (e.g. seq_file uses GFP_KERNEL reclaim strength)
> could be more relaxed and rather fail than OOM kill but wouldn't your
> OOM handler be effectivelly dysfunctional when not able to collect data
> to make a decision?
>

Yes it would be. Roman is suggesting to have a precomputed kill-list
(pidfds ready to send SIGKILL) and whenever oom-killer gets ENOMEM, it
would go with the kill-list. Though we are still contemplating the
ways and side-effects of preferably returning ENOMEM in slowpath for
oom-killer and in addition the complexity to maintain the kill-list
and keeping it up to date.

thanks,
Shakeel
