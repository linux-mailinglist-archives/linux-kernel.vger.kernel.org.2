Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75C1435D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhJUJCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhJUJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:02:37 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE06C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:00:21 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t4so56581oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxeQAhKq35QFKlvh0wF1hKrofkjgeU944O74OCk+Hsc=;
        b=AIY0ZvgmHs1i2Jjewb/l7F+u1TVlacdEKavBVM+t4cp0J8AdxfOoodcM9OiO6xIxwU
         g0wct/DAnD8STZH0RivKu5czP7QryMpzdZsdoa/hpqB08G1sVrOqNBGq+Jg1Zdwij3eO
         h3pGGihW4Vj1g5pKuypqmC7n8MAGlnJCSMAOl+H3xp8qR5ZrY6dGWsu3/sRtUrm/PIkT
         SnDTRETq6vw03AWK7c2uFkTAxDAnc+J4r+dvBfhBt7M9s9/+8dlFfuxS+xtguKC4Zc99
         DCCG+6rMPLO1fIpcnnhwq68dvrCFaobDR/9weVjd5b0opaRTKjhBsR4kNJRINREATGwB
         kWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxeQAhKq35QFKlvh0wF1hKrofkjgeU944O74OCk+Hsc=;
        b=Dr+K2REnd640n6dFynvlGOU/WiEAZzm0jJzVUlXIDGYuO2Sb7lwgruYLaveOkQwmes
         YRhVYb3zRTR8UgUdy63M+Ybnm3WWv/yCQFwUdI8smKBSu/FRb9zySLNVD0PkgDjwtpot
         wlDuNmfuTIvRHv0EMXfgWsUOibRNlr+QqqwhXliY9m6CNNlpc1KBI1565sahEusega3p
         E6K1m8NQEdZ/rjH/4Lc9SP6YLosu+N8SHJdqWu5BUXbkskBOpCS5ZwyiO9TVqykE+zQs
         Rm99LKf7eH4AO8P0FJz9n1yVmM21D0Svn/wIL0AURIgRdTsYM3CaAsRsk8SB+px4vRTp
         3H0Q==
X-Gm-Message-State: AOAM530KGbhovcaMoVwOpwk7t0csTGPM3TnX3cgT2CXWuqG+vy8HHokl
        fkNNhW5i/eUhuKHl1XGRG8CrtFy1rLaPZWZHkYuryA==
X-Google-Smtp-Source: ABdhPJw0EqXC972LTR3d9LQ+cFNpenvaE/C+SPIaBoTi8mq6VP1mHeAwXqLj90EHQe+j5liHQBl16VdrBUimnz7kddE=
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr3594527oiv.160.1634806820945;
 Thu, 21 Oct 2021 02:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210820043339.2151352-1-jordy@pwning.systems>
 <202108192227.8BE02F1C@keescook> <YST8vi6J1NlCdirU@kernel.org>
In-Reply-To: <YST8vi6J1NlCdirU@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 Oct 2021 11:00:09 +0200
Message-ID: <CACT4Y+b1sW6-Hkn8HQYw_SsT7X3tp-CJNh2ci0wG3ZnQz9jjig@mail.gmail.com>
Subject: Re: [PATCH] mm/secretmem: use refcount_t instead of atomic_t
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jordy Zomer <jordy@pwning.systems>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        James Bottomley <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 at 16:06, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Thu, Aug 19, 2021 at 10:33:49PM -0700, Kees Cook wrote:
> > On Fri, Aug 20, 2021 at 06:33:38AM +0200, Jordy Zomer wrote:
> > > When a secret memory region is active, memfd_secret disables
> > > hibernation. One of the goals is to keep the secret data from being
> > > written to persistent-storage.
> > >
> > > It accomplishes this by maintaining a reference count to
> > > `secretmem_users`. Once this reference is held your system can not be
> > > hibernated due to the check in `hibernation_available()`. However,
> > > because `secretmem_users` is of type `atomic_t`, reference counter
> > > overflows are possible.
> >
> > It's an unlikely condition to hit given max-open-fds, etc, but there's
> > no reason to leave this weakness. Changing this to refcount_t is easy
> > and better than using atomic_t.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > > As you can see there's an `atomic_inc` for each `memfd` that is opened
> > > in the `memfd_secret` syscall. If a local attacker succeeds to open 2^32
> > > memfd's, the counter will wrap around to 0. This implies that you may
> > > hibernate again, even though there are still regions of this secret
> > > memory, thereby bypassing the security check.
> >
> > IMO, this hibernation check is also buggy, since it looks to be
> > vulnerable to ToCToU: processes aren't frozen when
> > hibernation_available() checks secretmem_users(), so a process could add
> > one and fill it before the process freezer stops it.
> >
> > And of course, there's still the ptrace hole[1], which is think is quite
> > serious as it renders the entire defense moot.
>
> I thought about what can be done here and could not come up with anything
> better that prevent PTRACE on a process with secretmem, but this seems to
> me too much from usability vs security POV.
>
> Protecting against root is always hard and secretmem anyway does not
> provide 100% guarantee by itself but rather makes an accidental data leak
> or non-target attack much harder.
>
> To be effective it also presumes that other hardening features are turned
> on by the system administrator on production systems, so it's not
> unrealistic to rely on ptrace being disabled.

Hi,

The issue existed before this change, but I think refcount_inc needs
to be done before fd_install. After fd_install finishes, the fd can be
used by userspace and we can have secret data in memory before the
refcount_inc.

A straightforward mis-use where a user will predict the returned fd in
another thread before the syscall returns and will use it to store
secret data is somewhat dubious because such a user just shoots
themself in the foot.

But a more interesting mis-used would be to close the predicted fd and
decrement the refcount before the corresponding refcount_inc, this way
one can briefly drop the refcount to zero while there are other users
of secretmem.
