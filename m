Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F5832EE4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCEPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhCEPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:18:59 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9F9C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 07:18:59 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id a9so2233182qkn.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Is9vMcVQC0jiR/bY3goerqoWdcu0QpBRJ6X8l+xAMI=;
        b=b5PIs8orsX4xYD+gYzt/4+pf3KXx7tMdpyIIg2xeAkj3kWUtpxXJRw+XYldfcu1r6K
         TeNM7MjnvHxsNKu1ptI+8Swf+PxMK3iyjypcMYFXz0kYMUWSbDmMZCDUKezn6blDZD1U
         eLgK3Le3XKxZwtVa8sBRNpS4PWca8LlbXaa38S0FupO8oCcxCxJiS/O/Gg5qqWdbvcv+
         iX4dj7Bx1I3QPMjg4xPLFKzEST/gsjxRvjfXSX1Hs3WtTDRwfT+qKvKD2lJn+O6dekpc
         dWuSS8+YjBTJopRMtTQJ4O/Tx7/h0UvRUf1HNCSFKtvYgXOcdaOH0VLrzGWm8ifTkM+X
         NE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Is9vMcVQC0jiR/bY3goerqoWdcu0QpBRJ6X8l+xAMI=;
        b=CELMfnuyATrDs7XEWjbbjXXTYeDO/RzMX0URRX5gTBN7VX8ti/cCpVGfRPmoBH6i9t
         X+4u3YBcLXQJVPXcriYtqaHQAdubPOwRgDNQ40R2tMZs5h3Fzv+yPhPM+7Rnjx3hCyQy
         RBOA4ESeLarD03evfSKDAlWN12z/0k8HeWwysdN5cbzJLZ/P69QtOC/4L1YrMnInkYvl
         01EgkX2Ngkr0181zm/KY9mjO8uygMbIoZ+rGUsJwGMq7DFcIIoF/CzKnSrB3LXwU1JgJ
         4wmXngwLPzAxoRMdgu2NpCW6QUc9dDNWEzzYUhLu3NAMCr7n4Zn9uyG70ccV+1lNcgvn
         nDcg==
X-Gm-Message-State: AOAM533NkD/wgS8wF6WHlsg89zMHZsStsFXKG4Umh4sJnYgwy+uIxyS9
        TrIMXUzN3I1Md6lZCRWD3Qwnb6nA+SAh9seV/z/i40wAti+stA==
X-Google-Smtp-Source: ABdhPJyZo9ka344zgC8WXuMkPkcI/p1xgGNofsWH/8m/zfgX1fFTImyIga0n+FheaeEsuqCuzK5ZGQwZsuPL7eQwhjg=
X-Received: by 2002:a37:96c4:: with SMTP id y187mr10177900qkd.231.1614957538234;
 Fri, 05 Mar 2021 07:18:58 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YytChe9Tv5etacBL4snEDu+A2fNzF4zKiKtfmH0C0roQ@mail.gmail.com>
 <20210203160543.GA19512@duo.ucw.cz> <20210203172834.GA3943@mipc>
 <CACT4Y+bkQOAwAwEnRoZVwKM2sDpHW3bzeWdga4MhxhERvZKT+Q@mail.gmail.com> <20210203192453.GA21047@amd>
In-Reply-To: <20210203192453.GA21047@amd>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Mar 2021 16:18:46 +0100
Message-ID: <CACT4Y+aG1JEkLfFvvBhC0ZSpk-huWwAshdb8nwKExFbw2fq59Q@mail.gmail.com>
Subject: Re: syzbot reporting less duplicates
To:     Pavel Machek <pavel@ucw.cz>
Cc:     bobwxc <bobwxc@email.cn>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 8:24 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> On Wed 2021-02-03 19:22:34, Dmitry Vyukov wrote:
> > On Wed, Feb 3, 2021 at 6:39 PM bobwxc <bobwxc@email.cn> wrote:
> > >
> > > On Wed, Feb 03, 2021 at 05:05:43PM +0100, Pavel Machek wrote:
> > > > On Mon 2021-02-01 11:52:12, Dmitry Vyukov wrote:
> > > > Could we please get common prefix (like syzbot: KASAN:....) so that
> > > > the bulk of emails is easier to remove?
> > > There are several bots testing on the kernel, maybe we should give a prefix
> > > format for all bot.
> > > Also we can use mail-address to fliter email, but it's still a little
> > > inconvenient.
> >
> > Hi Pavel, bobwxc,
> >
> > Yes, I was wondering if syzbot in From/To/CC can be used for
> > filtering? I assume email clients that can filter based on subject can
> > also filter based on From/To/CC.
> > Does anybody filter syzbot emails? Maybe you can share what works
> > best?
>
> From does not really work. So... syzbot reports for subsystems I don't
> maintain are uninteresting, and so is the resulting discussion.
>
> While filtering on "From:" is easy for initial report, it does not
> make it easy to remove follow up discussion.n
>
> > I am not sure a common prefix for all bots is useful because it
> > supports only all or nothing. There are also some bots that
> > maintainers use now that seem to be fundamental to the process, if one
> > is ignoring them, then they are effectively ignoring what the
> > maintainer is saying.
>
> I'm pretty sure common prefix for all bots is useful.

This is now implemented and deployed:
https://github.com/google/syzkaller/pull/2472

Here is the first example report with the prefix:
https://lore.kernel.org/lkml/0000000000002592aa05bccabae5@google.com/T/#u
