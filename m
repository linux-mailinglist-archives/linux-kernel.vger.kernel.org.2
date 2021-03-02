Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABC532AD94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359584AbhCBWBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444882AbhCBTPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:15:51 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAF8C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 11:15:06 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 18so12985456qty.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 11:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZikdE+7DLZ1JD1DCu42GT/9qzzNugvdBEIi0wizGvrk=;
        b=a1kPDI4zlBu3FH6xgGwR3rM1zw+SD2IE9rgAdEYCwLTPe8nEUz3IXJj7Kbi7lp0jiw
         XnG2LY4NdTuzPmB0meHsurRhxIJDKlpJDFRMsIsUWFeerN/1CVf4fgAJ1C3wkMV+Xha9
         Wsl/+Gh/6VNyU5bu15DBWcuqnZhGk9sNYdoRJzbNIYMmLHo16FnCRQ9kdTUioTMS2iCC
         lAO1UWusfuac4oS9Zr1PDVzKxldBN1eRCQhFQZH3VobDjA3h4HG/IRP1pK0DHhuNjaSd
         qauqR09WqiEdbxKeQ8S/p/XbBCCyzOrog8H136f8RvNIXAa+DwVMJiElmC/6YYXaSb7u
         5CLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZikdE+7DLZ1JD1DCu42GT/9qzzNugvdBEIi0wizGvrk=;
        b=D+dJVYL6Yk+lMfOVWwYXV1klhBiJ00gJFRJeEC4vXX8Nw+CJ6KjfZr/+pOyadq5ZXT
         xIWpBkdeBjbXwxaEebhwRvJKDVn7pQaCsZhSC2d/DfvcUI4QsWsvbTXRQVD6V1qkQZ89
         bZTDMv9K9MFVwZ3ULGjvodLbhxxrDQ5d52H57bg8h11pmNTL9LS3yXFgtPscqInUQBYv
         9YZcorATLXs81cBATsMzBQNoYJhOEYiqHlP0j3//M5cceLH5s8a7T9LEVe2T93kpDrRA
         70IivXitF+lpvFtApvUjd5biOvsp5SIbQEM7+5WH2zZXPgkYBvdAq02H/CUMPNTZnsVN
         p8vQ==
X-Gm-Message-State: AOAM5323/bdJOFH2Tusrw8ztuF+2D/zk1D7crVLaiLgtyf57s6tJVNpB
        K9n+yOkdc9dDhAiI9aP+Dl7DqX5+PzHAGRbQR6D8xA==
X-Google-Smtp-Source: ABdhPJwaBXK1fev/fK3G9E1MCoG39LnfYsI8hMqs7jeZ3GlJrcuQG7zIP81C8cwBRXcx0ZLyRiqVKDopT4stCfWTxuE=
X-Received: by 2002:a05:622a:c9:: with SMTP id p9mr18909276qtw.337.1614712505694;
 Tue, 02 Mar 2021 11:15:05 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006305c005bc8ba7f0@google.com> <CACT4Y+YFtUHzWcU3VBvxsdq-V_4hN_ZDs4riZiHPt4f0cy8ryA@mail.gmail.com>
 <CAHC9VhTxrGgBDW_439HeSP=_F9Jt2_cYrrQ7DtAXtKG4evGb9g@mail.gmail.com>
In-Reply-To: <CAHC9VhTxrGgBDW_439HeSP=_F9Jt2_cYrrQ7DtAXtKG4evGb9g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 Mar 2021 20:14:54 +0100
Message-ID: <CACT4Y+YEu3f059=nGu9KxTi4sg6-POtziQ+0jx-KN2adjGJHRg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in cipso_v4_genopt
To:     Paul Moore <paul@paul-moore.com>
Cc:     syzbot <syzbot+9ec037722d2603a9f52e@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, dsahern@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 5:10 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Mar 2, 2021 at 6:03 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
>
> ...
>
> > Besides these 2 crashes, we've also seen one on a 4.19 based kernel, see below.
> > Based on the reports with mismatching stacks, it looks like
> > cipso_v4_genopt is doing some kind of wild pointer access (uninit
> > pointer?).
>
> Hmm, interesting.  Looking quickly at the stack dump, it appears that
> the problem occurs (at least in the recent kernel) when accessing the
> cipso_v4_doi.tags[] array which is embedded in the cipso_v4_doi
> struct.  Based on the code in cipso_v4_genopt() it doesn't appear that
> we are shooting past the end of the array/struct and the cipso_v4_doi
> struct appears to be refcounted correctly in cipso_v4_doi_getdef() and
> cipso_v4_doi_putdef().  I'll look at it some more today to see if
> something jumps out at me, but obviously a reproducer would be very
> helpful if you are able to find one.
>
> It's also worth adding that this code really hasn't changed much in a
> *long* time, not that this means it isn't broken, just that it might
> also be worth looking at other odd memory bugs to see if there is
> chance they are wandering around and stomping on memory ...

Not sure if it's the root cause or not, but I am looking at this
reference drop in cipso_v4_doi_remove:
https://elixir.bootlin.com/linux/v5.12-rc1/source/net/ipv4/cipso_ipv4.c#L522
The thing is that it does not remove from the list if reference is not
0, right? So what if I send 1000 of netlink remove messages? Will it
drain refcount to 0?
I did not read all involved code, but the typical pattern is to drop
refcount and always remove from the list. Then the last use will
delete the object.
Does it make any sense?
