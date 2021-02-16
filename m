Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2831C7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBPJM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBPJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:12:05 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9D1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:11:25 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w18so5746476pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdNZztHmJx28lm1YqPNW9/HMTJK3XzFZq3cJHhEcHYE=;
        b=YduCyImG8fvCNJ0Ln/GZcl1hAv48xJw1jreTDfYpxVD8y7K1Pha+O1+bP1I9k4a4Zg
         wdSwcd7xqamfxneaxTHx5RXG8zl2MiTItG4Arbrb69mF4CrIhqcMMPzRxWlrUpCVFmes
         Hb5vhimAiIZVj/msqenF0msWoqk1IS3iP2FYKDZ1WxNeoq7SGNNwHtFMsgLQyUNeeoXe
         yr2joY4unXXLA+b5h23YqqCJz/rFtcVoWFelo+e/R4CZSeK6Y2QeR6mRkm3iyymyrETm
         jqAkHGzScg1XnuvvdZRXQ3mr0oYvHJDvd0BlRxfgUbabsQE1K0x3WnHedaw8V2q6MW0a
         Fj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdNZztHmJx28lm1YqPNW9/HMTJK3XzFZq3cJHhEcHYE=;
        b=mbfUDp3gU8KRIEA7STpu1dY3pCbsuhJZ73zJUiXOwB7eKxHDTYugUOL7vkd8muD99H
         DipPQtC9pyl3CuXOsfOHkqyCIHQK4HMqldlbwGn0hZp+ALBdjUCSTpb9eWi5i3utfRT0
         nazxTIHHdxzbU1NDgBQYAewFaovLIsq1HHgVxGBmP3CLE2ph/iRI+ZvbcweCoIX8ZXPA
         KmQCdyg65B5TH5xlmCuxmeJlCmhqEQGYJfYj2qbNZyvXt+Ilyzyv9jGhl1iEujV2PoAK
         AlHqS9K8DiqKoyWov3eQel8mqEiN36+MbpYHaaGfEgsz+p0xgCy7Aq7lfujLAd+URwsD
         f9qA==
X-Gm-Message-State: AOAM533S2G9jFVtdzl8sy27bVP/gQr6+1Wk3bBq9S/Xz+j7qxSvDp2UU
        hEFLP0gLSVnVRp4DmFZJGQnVos7ZKuMI3epc2/o=
X-Google-Smtp-Source: ABdhPJy0x8KyOvfVQ64PSQs8w5E55gpQxMn2DaDOG4tqdJnQrhRnAVxYyCUWBUdqxAUIJSGNmaK4x42OCc3U+rJNNew=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr19254746pfk.73.1613466684665; Tue, 16
 Feb 2021 01:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20210216072334.7575-1-jbe@pengutronix.de> <20210216072334.7575-2-jbe@pengutronix.de>
 <CAHp75Vcha++UUE6hw0n_pBnA24q_uJQekABSSktmjCoinfpSoA@mail.gmail.com>
In-Reply-To: <CAHp75Vcha++UUE6hw0n_pBnA24q_uJQekABSSktmjCoinfpSoA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Feb 2021 11:11:08 +0200
Message-ID: <CAHp75VftQ6y58w+D6=nSwx3DRcLH3iwfx3RT8yv6rgS8O6OWHw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: ubifs: set s_uuid in super block to support
 ima/evm uuid options
To:     Juergen Borleis <jbe@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Stephen

Stephen, do you have a check in Linux Next to catch the problem that
Co-developed-by is not being accompanied by a corresponding SoB?

On Tue, Feb 16, 2021 at 11:09 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Feb 16, 2021 at 9:24 AM Juergen Borleis <jbe@pengutronix.de> wrote:
> >
> > From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >
> > This is required to provide uuid based integrity functionality for:
> > ima_policy (fsuuid option) and the 'evmctl' command ('--uuid' option).
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> One issue below has to be addressed nevertheless.
>
> > Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Co-developed-by: Juergen Borleis <jbe@pengutronix.de>
>
> According to the documentation [1] above has two issues:
> - all Co-developed-by *must* be accompanied with corresponding SoBs
> - commiter must provide his SoB (but it will be implied by the
> previous requirement in this case)
>
> [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
>
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  fs/ubifs/super.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> > index 138b9426c6c1..a8383ca39a47 100644
> > --- a/fs/ubifs/super.c
> > +++ b/fs/ubifs/super.c
> > @@ -2230,6 +2230,8 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
> >                 goto out_umount;
> >         }
> >
> > +       import_uuid(&sb->s_uuid, c->uuid);
> > +
> >         mutex_unlock(&c->umount_mutex);
> >         return 0;
> >
> > --
> > 2.20.1
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
