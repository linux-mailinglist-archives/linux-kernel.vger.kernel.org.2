Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1499E34D40B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhC2PgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhC2Pf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:35:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A58C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:35:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v8so4570960plz.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fx+rvtB644CNXiO/TUepH6reSL0YwAJ6JLaNdbj/zqw=;
        b=cStsAmX+CX7QfYY/KS6OnFxrlo2nfPeUwg6CbUvhQohZQgsy1+uSmf9N0jRadpK1yc
         MbR5i2te9cFq5CevUInBlFqTmpqOiNiqBJz3G518yt6dHUO/EBxEJa+umll5oZvu2ty5
         dD+I0S8qknryLb8iN8nnURLOFlgi7b4bddooPIRAX2WiaCKmva3J2DuTSgmwOYkPjpP/
         gjcaa2Mzve5BVOXj1HIbTvNB82qsOkht69ii+pat0V8ZzgxHiKwVjzbeK9TmmU/NUvvI
         z5LKeS39lgkcFMBl7BWKtHcNIexVnEdh5t4Bid3rbNQ5qPkVBgqS0j3SQTG9kbL0MnJw
         C7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fx+rvtB644CNXiO/TUepH6reSL0YwAJ6JLaNdbj/zqw=;
        b=pykFUw5VvJrzBo+lNfqNYTVoasWrkry8XGSama6n8uFE6tT+VnCZiWyZ2K/ihWBAT5
         DS4xAC3LydF18OYp5aA4rSlJigI1kelK50wYFll/VwW7PS1di9CttYKBb8KBFpY21z5A
         7yomy8TktIHnPG1Ibpc9z9/rGxjtI5qi6nCIwmdClovxYwiXkaCcWvhqRMXV53RrFxA4
         N88nJihQQSgpGoqllTCHyefm9nh+1Ozw9x5YQPUxx7VqW+KofBEHhqUA/aLwlP9RQ4Hl
         pMPS//TR8CEMoPtS8vC7uYbPyMq/dkqyF4uCeDwygdu3cphrbHEUyFfok5/6wfM/PsNE
         jt4g==
X-Gm-Message-State: AOAM530OaY5+rm8nOHs8oXfuAGwgVNfQy8qzopQRqqJE3FJVtSmKoHr7
        J9W0RDqFJ5nKCu+3ySkwUGmNBpnv0xVdxs/kUOYuQA==
X-Google-Smtp-Source: ABdhPJwq/8+p3NQEz0kNU6ag4EEvC72RBQlT9kJNJWT4uT6gkgdj12pJdnQw3k9i2ztRvrsw0wCmM1en+r6DHFZBvLw=
X-Received: by 2002:a17:902:bb83:b029:e5:dacc:9035 with SMTP id
 m3-20020a170902bb83b02900e5dacc9035mr28859471pls.80.1617032156468; Mon, 29
 Mar 2021 08:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210329082416.40b7f449@canb.auug.org.au> <CAC0gqY5+tcmNOoRrjiNMsffWbrQEF_pwjvne-oP+sGbr+84suA@mail.gmail.com>
 <CADnq5_PXCSDmU7YKQVawZSk10RjCBT-XoxPYNGt78x1ShbiXOA@mail.gmail.com>
In-Reply-To: <CADnq5_PXCSDmU7YKQVawZSk10RjCBT-XoxPYNGt78x1ShbiXOA@mail.gmail.com>
From:   Mark Yacoub <markyacoub@google.com>
Date:   Mon, 29 Mar 2021 11:35:42 -0400
Message-ID: <CAC0gqY6r1dXtWtftfWWn3L3vdSHs2P67pWc9epRhr_K-6FqMLg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the amdgpu tree
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Awesome, thank you so much Alex!

On Mon, Mar 29, 2021 at 11:35 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Hi Mark.  I've fixed this up in my tree.
>
> Alex
>
> On Mon, Mar 29, 2021 at 10:18 AM Mark Yacoub <markyacoub@google.com> wrote:
> >
> > oh this sucks. I'll look into my config and fix it. Thanks Stephen for
> > bringing it to my attention!
> >
> > On Sun, Mar 28, 2021 at 5:24 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > Commit
> > >
> > >   0ea5088407fa ("drm/amdgpu: Ensure that the modifier requested is supported by plane.")
> > >
> > > is missing a Signed-off-by from its author.
> > >
> > > The author is "Mark Yacoub <markyacoub@google.com>", but the SOB is
> > > "default avatarMark Yacoub <markyacoub@chromium.org>" :-(
> > >
> > > --
> > > Cheers,
> > > Stephen Rothwell
