Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E3E36E0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 23:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhD1V11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 17:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhD1V10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 17:27:26 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D00C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 14:26:41 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id c18so52938685iln.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 14:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7l9IIcxFbTcNjI/lVJy/EpURY/RPEveNoN2MojstM8=;
        b=mqEdKQbFcvoqKDS76//hW3eJJ847NaXt7dzadA734Txj+MapGmgRSooSa9ltUC1FLo
         IWwrauXRzvOawwNUOli6iyPoKio/uVfIAFAWhy1Kx00oIueSp3biuW47E/jCLywpVBuf
         CIsC/4SvH2IECG4U1917cE2PBH52u4Z23xg4VHTJz4NR1sHkYrERYJiFchVtW1SBS6HB
         nnscHh/CnCkq70vtTpI0AB66K5kBZ9lQ81Llop+GS7SQh05KusnQjbO6nA5aZTe49zX3
         l+15Q0V/N09gqa8LAtb51oZLPw0Hlu3cCxGZValERqNpwmMpyt5pGqJHoCvgMotEIX3F
         NO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7l9IIcxFbTcNjI/lVJy/EpURY/RPEveNoN2MojstM8=;
        b=Xl3POJXaZk0qHE8OszNeJm9VGb8B05UgyD3O9V5y37t4UU4tvhN++ejOuRPEDRaHSq
         hWKu0WdTsZU/VTgxI8J44Wpnisz89NlfbSYXSoBwpoEb+UWXX7ltsAceWznexWtsXx5b
         8v9ozc/MmRFSlzUF5X/xYBI00MvRHmByAZyD0K/Ym/OF/BXvxyxVj/TGqn0AhOKpF6Hu
         tCJtU7FNMfxxsvjn3mvWw5//VIGIqYbTGnNl1/vkRhz7TBeshhXnSjwjL8pPEX1FmbCl
         /+cwDWSMIxZKV0+46wIYZ9X8v3r+vjxSP4FOGZ2SR28AzBhXUImGm7TXkGGspVEnW6qO
         dcbw==
X-Gm-Message-State: AOAM531yG4LA7OSVtrlnB8f2+7Vpaa4PKrYfQ7S5OphKfGab3P/+9Bak
        bNMLOjapVcIOCZ333JQD9YkIWcbW6LpIFgsODF4nmw==
X-Google-Smtp-Source: ABdhPJw7CrFZibeylky/W9Lgj1mYBNImV7tGNZoPq5C5XZP9XSnUHV196AatCpSnAps5cmunP5rgeXn0A2rWMOr4mXc=
X-Received: by 2002:a05:6e02:1a4b:: with SMTP id u11mr24482288ilv.258.1619645200469;
 Wed, 28 Apr 2021 14:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210428180109.293606-1-axelrasmussen@google.com>
 <20210428183943.GH6584@xz-x1> <alpine.LSU.2.11.2104281338380.9009@eggly.anvils>
 <20210428212430.GA6462@xz-x1>
In-Reply-To: <20210428212430.GA6462@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 28 Apr 2021 14:26:03 -0700
Message-ID: <CAJHvVcj43SPX-fZ3y3brKQ3xkW2omOR=b_61M_GoGv8Dy+5G1g@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: release page in error path to avoid BUG_ON
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 2:24 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Apr 28, 2021 at 02:03:05PM -0700, Hugh Dickins wrote:
>
> [...]
>
> > > > +                 put_page(*pagep);
> > > > +                 *pagep = NULL;
> > > > +         }
> > > >           goto out;
> > >
> > > All "goto out" in this functions looks weird as it returns directly... so if
> > > you're touching this after all, I suggest we do "return -ENOMEM" directly and
> > > drop the "ret = -ENOMEM".
> >
> > No strong feeling either way from me on that: whichever looks best
> > to you.  But I suspect the "ret = -ENOMEM" cannot be dropped,
> > because it's relied on further down too?
>
> Ah sorry I just noticed Axel didn't really touch that line.. :) So yeah please
> also feel free to keep it as is.
>
> If to drop it, "ret = -ENOMEM" can go as well, I think.. since all later errors
> should always reset variable "ret".

Although I can see a refactor which simplifies the error handling a
bit, my inclination is to leave it alone in this patch, since it's
trying to be a simple fix and especially considering we may need to
backport it as far back as 4.14.

But, I'll keep this feedback in mind and try to apply it as much as
possible to my other series which is significantly refactoring this
function already, so the end state ought to be as simple + consistent
error handling as possible.

>
> Thanks,
>
> --
> Peter Xu
>
