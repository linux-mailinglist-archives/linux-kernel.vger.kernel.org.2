Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5356840C70A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhIOOH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:07:27 -0400
Received: from mail-vk1-f179.google.com ([209.85.221.179]:34374 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbhIOOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:07:25 -0400
Received: by mail-vk1-f179.google.com with SMTP id 13so1058941vkl.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2WChWZGlQxsFYb5JrGN7t7fX8JCDCZT6o4viPHxy0o=;
        b=nw0C5Uw/tu2oB3OWJ0HECEELgkRg2Cu7w0/um964f5lAfcbUW/JZsdVSmSc8iBLKQd
         TIkh4JHk2IrO9aomGoETnGZx6JvHGvDnH6S6mCPqdKKvRx6VMJimaVHO+3cURggkWklT
         xeoR+Z2NxT+ukKeyQPwdW852cP2+t58ZOIwUylt/1bW7G0slm8QXB4tMV8LvVthq5ApX
         QQRnebvYQC8/yuJZxRBgWXlY+rpaWJHFxiwcE1AvwDnx15Gact/+F2JG5IkvgSX6obO9
         All0oqFTg0o8mfizlFCBfbgar+NoHSEhlqOpGfumtna6QupsEkWfSC+GK3LVbD7Aw2et
         bXMQ==
X-Gm-Message-State: AOAM530Vdeb+mTiu5BqVvp9dS+7ep/xf3wdvddY65cJKtijujiVSCgMw
        Qbva+QtrgxN+3/hey8ixFj2X+telrwSdD9KjRTk=
X-Google-Smtp-Source: ABdhPJwq88uag8sLUL0AAvEneG0eyseE6jdVcHHOoZVOoMhrvYMxKtjvnZFdumRCf3JC/GN0NhYm1F6kBQUNf2bP8S0=
X-Received: by 2002:a1f:230c:: with SMTP id j12mr224041vkj.11.1631714766406;
 Wed, 15 Sep 2021 07:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <a52baa8b-6743-7570-aaa6-411b5b13c8aa@labbott.name>
 <CAMuHMdXMbuFww73q3QgdroEYmWXe00rKsbd9pCgYd2zsuc06FQ@mail.gmail.com> <20210826074311.r2aumout2fvmncby@wittgenstein>
In-Reply-To: <20210826074311.r2aumout2fvmncby@wittgenstein>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Sep 2021 16:05:55 +0200
Message-ID: <CAMuHMdWx0C5bVdKEYQi-xgKF3LygGd95948_aK68vQOdQS9_Jg@mail.gmail.com>
Subject: Re: [Tech-board-discuss] Linux Foundation Technical Advisory Board
 election: call for nominees
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Laura Abbott <laura@labbott.name>, ksummit@lists.linux.dev,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 9:43 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Wed, Aug 25, 2021 at 06:34:53PM +0200, Geert Uytterhoeven wrote:
> > On Wed, Aug 25, 2021 at 4:27 PM Laura Abbott <laura@labbott.name> wrote:
> > > Over the last year, matters tended to by the TAB include proposals for
> > > developer workflow improvement, overseeing the Linux Plumbers
> > > Conference, supporting the review of the University of Minnesota
> > > patches and more.  Minutes from TAB meetings can be found here:
> > >
> > >      https://git.kernel.org/pub/scm/docs/tab/tab.git/tree/minutes
> >
> > It seems there are no minutes more recent than October 2020?
> > Are they just missing, or were there no meetings?
>
> Hey Geert,
>
> Thanks for pointing that out. There definitely were meetings. It seems
> the minutes repo simply hasn't been kept up to date.
> I just brought this up and we will update the repo soon and I'll notify
> here.

Thanks, the minutes until June 2021 have appeared.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
