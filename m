Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B68346232
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhCWPBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhCWPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:01:21 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF846C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:01:20 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x16so10602733qvk.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zgh8aUOKNTyxThPCr85/xxGDpm9eLgZzd2NlgtKpAo4=;
        b=AFRXisxkAPOvvYt9/IY+qLGdtY3Dmt9QINj0Pct5q2rZAjY/MZbqCDqlX7+4p3LmXS
         g652Xu6Bk0hfGxFHwsgmBYrgdkkPm8A6LNZR0j/44/764LiFUp/Dhqq4OjII7cdUC+Hi
         oPfb0teemlv6lGp2bBB0ayURMEhw21Y2qe+Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zgh8aUOKNTyxThPCr85/xxGDpm9eLgZzd2NlgtKpAo4=;
        b=CQouQt4TE5d4mUBVkt6QT+7dU8o5ecvl6Gu2IeNyr64BzKJzG2ge85XKrd92paQs3j
         EO3yVP50IdDCi7AjrWWn4g+1LX+1ktR92I5ncbr4h2l8m3rlz4EfHnuNzVpKrCEKHGmh
         CSVZRRfIDexgtcZmW8i0C2PipbvuLYELQUuH9deo4Vr/oulomYnREJhm77s5GGoZ1rmK
         TbNNW8fwDThrSe8/cEsAxbuWkRJF8Znfsx8B+x+gjcnjpQF6Ij3/jWtYqQBAxnOI4e48
         rRKQmU/DxMXn2/6az+lI9MSeJSO2EQ4nCoe1IELBrvQ6aycWbag360jfFtWe8AcO132F
         osPg==
X-Gm-Message-State: AOAM533UYBPCUzDDwl3qBjLqsAZ6Fn3KCx67bqtCshGSbftVq1tGOwVQ
        lF/dQ41LG9v6olo81zrO6kJGyML9Db7gerG2M+VUow==
X-Google-Smtp-Source: ABdhPJzkQ2Gi2C+hfzbXqYhepfMG6MP1FewNMuW/XTE0FfXwpv7iVI3G3PN3KkRNcKWkiBfe3LgGwCVlQEQ+YKBzIUQ=
X-Received: by 2002:a05:6214:1424:: with SMTP id o4mr5249801qvx.34.1616511678087;
 Tue, 23 Mar 2021 08:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
 <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info> <YFkSqIN90S4a3HiF@mit.edu>
 <54aeb1f7-ffc7-74e1-a731-8970d44ff852@leemhuis.info>
In-Reply-To: <54aeb1f7-ffc7-74e1-a731-8970d44ff852@leemhuis.info>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Tue, 23 Mar 2021 11:01:06 -0400
Message-ID: <CAMwyc-Sqbkg=VxCWcfRazkGG7vkwEQ43m9Dov_Nawia5MN_oUQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] RFC: create mailing list "linux-issues"
 focussed on issues/bugs and regressions
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 at 04:58, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >  If we can
> > actually get users to *read* it, I think it's going to save kernel
> > developers a huge amount of time and frustration.
>
> And users hopefully as well. But yes, making them read it is the
> problem. :-/

I've added a very visible admonition on the front of
bugzilla.kernel.org. Hopefully, it will help direct some users to
their distro bug trackers first.

> > I wonder if it might be useful to have a form which users could be
> > encouraged to fill out so that (a) the information is available in a
> > structured format so it's easier for developers to find the relevant
> > information, (b) so it is easier for programs to parse, for easier
> > reporting or indexing, and (c) as a nudge so that users remember to
> > report critical bits of information such as the hardware
> > configuration, the exact kernel version, which distribution userspace
> > was in use, etc.
> >
> > There could also be something in the text form which would make it
> > easier for lore.kernel.org searches to identify bug reports.  (e.g.,
> > "LINUX KERNEL BUG REPORTER TEMPLATE")
>
> Hmmm, yeah, I like that idea. I'll keep it in mind for later: I would
> prefer to get reporting-issues.rst officially blessed and
> reporting-bugs.rst gone before working on further enhancements.

To my knowledge, git project uses a tool for that:
https://git-scm.com/docs/git-bugreport

Theoretically, a similar tool could exist for the kernel.

-K
