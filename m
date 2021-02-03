Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9644330E7FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhBCX4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhBCX4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:56:36 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F5AC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 15:55:56 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id i8so2006522ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 15:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXB9D1nDfOLyhyhmoOAMcF3XxJqUZI6h6Q/nQ7sUHPQ=;
        b=bP3wdUZxDzflTRAwpugTbr9SOTaqZynXn2N+WUuZ4A9thV2sTa0Z+vD00cTclkBmOG
         fAF4dMeLOsOnPQrOPa297G5pDr6J+n7BMzQfeIfWIVVLi2STL4AnYbupmvCuFAe7Jw3p
         jSATtb38L7sS/oNWq2rDkHjx6uUEqqDos7EGJx4KrhTR0/ZiPaH+uMI5MfnaR1dsj5Vo
         pKLyLrpXqIIi+DjqKFlJnQMOAnTHadN0bOynA2lYHg0QSNIvadhnF6YmaGwtAasLYMrA
         NpKeBV6d3mQkN/kil6sL8j0lXIzSiGPhLqC0GXAzVvuXINcf1YEw42PUqsE3++Uk1M/T
         WPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXB9D1nDfOLyhyhmoOAMcF3XxJqUZI6h6Q/nQ7sUHPQ=;
        b=D07NXU6wn1P8NxxiGhyj1Qjggrsoj/jkFOoJKsXdMJR8Ek0X8bgdhnZu4DP3GHsrp8
         LAFeuF6tqz0HDOj5C04jm54QxIMEsk3DnF8phE2g9K0nocLzbktLufril6rqH3H50qwK
         2rh/of4df9IO9cIhntVv2PvJbAylODinhZrnkuJ7rOOWvEI1BBgv/Ars+dSMTxAy96mb
         Xuk+ciO5aA0yOLChHwNr3KujIm0nwlE0l3XGsgXVeSUqLK1Szz9/Bdck38koMOhoaEsF
         Ncg9zH2cU+1qMr3eILdJ0TQsiEhQu2/+NOVtZV9+DSeJFN+JBEsglcdCEIKMfD1aluVK
         Yi2w==
X-Gm-Message-State: AOAM533aBsvnMwwbA+1zL6PaUmndrpJOMrn1665diUDQ5/FfC2kQSOr0
        Cau25uai4L8GzC+MOVACUL7+bQTSQkKJ+wfGd9jo3w==
X-Google-Smtp-Source: ABdhPJy7GBDgONXJ/ZN1jKQZvonAHDNfTk9fMNFmMxmQWQAg4Nzootr0sIu8PZXpHj7+vb7WrSKByspMGG8yxAdI0nI=
X-Received: by 2002:a17:906:27d7:: with SMTP id k23mr5679195ejc.300.1612396554765;
 Wed, 03 Feb 2021 15:55:54 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
 <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net> <CAP045AoMRNjvVd1PdHvdf-nn3LNpTDp66sp+SAmZgNU888iFQQ@mail.gmail.com>
 <CAP045ApWnr=UQrBrv3fHj-C6EweukMWEyrCgsiY6Bt_i1Vdj6A@mail.gmail.com>
 <CAHk-=wgqRgk0hjvpjHNixK7xSOS_F3fpt3bL9ZUJVhCL3oGgyw@mail.gmail.com>
 <CAHk-=wgOp10DO9jtMC=B=RoTLWe7MFTS5pH4JeZ78-tbqTY1vw@mail.gmail.com>
 <87h7mtc9pr.fsf_-_@collabora.com> <CAP045Ao=WK7whYP2mT5Nx4zxsJTO=8A4eXWdeB4MM=MOYDoGTQ@mail.gmail.com>
In-Reply-To: <CAP045Ao=WK7whYP2mT5Nx4zxsJTO=8A4eXWdeB4MM=MOYDoGTQ@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 3 Feb 2021 15:55:43 -0800
Message-ID: <CAP045ApGeWQDJXbMUm230aRceJpSX46dfyjX7G7iypNe93Kc9Q@mail.gmail.com>
Subject: Re: [PATCH] entry: Fix missed trap after single-step on system call return
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 10:11 AM Kyle Huey <me@kylehuey.com> wrote:
>
> On Wed, Feb 3, 2021 at 10:00 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> > This seems to pass Kyle's test case.  Kyle, can you verify it works with
> > rr?
>
> I will test it later today.

I have verified that a) the test case I sent earlier passes now and b)
all rr tests pass now.

Tested-by: Kyle Huey <me@kylehuey.com>

- Kyle
