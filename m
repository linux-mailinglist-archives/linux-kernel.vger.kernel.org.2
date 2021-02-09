Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD132314DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhBIK4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhBIKww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:52:52 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AACC06178A;
        Tue,  9 Feb 2021 02:52:11 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id v206so5799849qkb.3;
        Tue, 09 Feb 2021 02:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ENKk6tiQleP0iDXPSQKQWMMrjhG0n1xhZHpyVdmgpYU=;
        b=gwkGAm+1D/22sMK2n2syhxThOc45LHFGC6PvoypAcMpkPKTvUPr5O72kf5a3w9nFQI
         R4dV+hz90EG3Q9NAv3sM6Ooe4WnFms7SO32PHGYLS92m2Uu7aj6A4azdf1O7fHh1lkPl
         TpNgI/ctaJPu/7tVVVmf7SBJts2YVl03KYDcjiEM1LCGkKAfjiVA5WpimfjMUWhIqcqg
         FkMHOne8Wo4boZ7o/giZk7UtTH7NWJQ5uxShJgC71n+otLCkkRDVgCcRnxfj2+Vs5ztX
         gl0T4fceIe3grE3tTK2nAONDwhNXzye/8nPhbm6GwrpAXTgsmKW4moroxDZYwPdr46wd
         lhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ENKk6tiQleP0iDXPSQKQWMMrjhG0n1xhZHpyVdmgpYU=;
        b=I1EMOACg3iwZ3cWR+j/pSlglFSsE2846NTLEKM6u7tRhZeIDlFkIe9sA9ZISQTQ/v4
         NKWGePt68sf4ZL0gaIJiynpG/wjd91UXFGnf35CqhL+fnOtlBn/zVMEFB5H0iLfdY2jZ
         OAAe8/Dqre974aHVHE0eUmxq/pDOtfDJB9iJ4VueG2vXc5Xy0CJgxtF40NRZeR5yp1y8
         uUCyHrJI0GdPBc+b6rge9fY5ua774HDVvb9yn7FHVG5szlbyPJzJs9upxKO3U2QVRwTC
         OuIuu8yFZM1lLNHcbe0ECGNTJb5jUyRv4e0GaAKes8yrFCv9H+aGLPSBLqyMVUjsIlLJ
         2Siw==
X-Gm-Message-State: AOAM532aO7fjI+nsQxR2UzBWu3gsKSxQ9EYvy6PK1QsKLp3DvvcDf97J
        aAtLX0qBwJs8I5r0FpFwBZT/qq0G+V/+zzipDa1WSlMuuus=
X-Google-Smtp-Source: ABdhPJzk2jJFIpJvOmXlsr4s225meLMNVfNadOICOaOUghKYRzue8p98b8D/Lb1djYRJ/h/SRLohQALxhpKl8Fvhlco=
X-Received: by 2002:a37:c01:: with SMTP id 1mr9564536qkm.493.1612867931240;
 Tue, 09 Feb 2021 02:52:11 -0800 (PST)
MIME-Version: 1.0
References: <1612785064-3072-1-git-send-email-orsonzhai@gmail.com>
 <CADBw62qiUG2dunB_i1iOp_srkAJP4CrVJX9mU25no++_b10hpg@mail.gmail.com> <20210209032838.GA24248@lenovo>
In-Reply-To: <20210209032838.GA24248@lenovo>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 9 Feb 2021 18:52:06 +0800
Message-ID: <CADBw62o+D--S0HGvd0v4vVV3yqWM=ytJonnNJMfw16P-ghiZgw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailbox: sprd: Introduce refcnt when clients
 requests/free channels
To:     Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Haidong Yao <haidong.yao@unisoc.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 11:28 AM Orson Zhai <orsonzhai@gmail.com> wrote:
>
> On Mon, Feb 08, 2021 at 10:06:47PM +0800, Baolin Wang wrote:
> > Hi Orson,
> >
> > On Mon, Feb 8, 2021 at 7:52 PM Orson Zhai <orsonzhai@gmail.com> wrote:
> > >
> > > From: Orson Zhai <orson.zhai@unisoc.com>
> > >
> > > Unisoc mailbox has no way to be enabled/disabled for any single channel.
> > > They can only be set to startup or shutdown as a whole device at same time.
> > >
> > > Add a variable to count references to avoid mailbox FIFO being reset
> > > unexpectedly when clients are requesting or freeing channels.
> > >
> > > Also add a lock to dismiss possible conflicts from register r/w in
> > > different startup or shutdown threads.
> > >
> > > Fixes: ca27fc26cd22 ("mailbox: sprd: Add Spreadtrum mailbox driver")
> > > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > > ---
> > >  drivers/mailbox/sprd-mailbox.c | 38 +++++++++++++++++++++++++-------------
> > >  1 file changed, 25 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
> > > index f6fab24..e606f52 100644
> > > --- a/drivers/mailbox/sprd-mailbox.c
> > > +++ b/drivers/mailbox/sprd-mailbox.c
> > > @@ -60,6 +60,8 @@ struct sprd_mbox_priv {
> > >         struct clk              *clk;
> > >         u32                     outbox_fifo_depth;
> > >
> > > +       struct mutex            lock;
> > > +       u32                     refcnt;
> > >         struct mbox_chan        chan[SPRD_MBOX_CHAN_MAX];
> > >  };
> > >
> > > @@ -215,18 +217,22 @@ static int sprd_mbox_startup(struct mbox_chan *chan)
> > >         struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
> > >         u32 val;
> > >
> > > -       /* Select outbox FIFO mode and reset the outbox FIFO status */
> > > -       writel(0x0, priv->outbox_base + SPRD_MBOX_FIFO_RST);
> > > +       mutex_lock(&priv->lock);
> > > +       if (priv->refcnt++ == 0) {
> > > +               /* Select outbox FIFO mode and reset the outbox FIFO status */
> > > +               writel(0x0, priv->outbox_base + SPRD_MBOX_FIFO_RST);
> > >
> > > -       /* Enable inbox FIFO overflow and delivery interrupt */
> > > -       val = readl(priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > > -       val &= ~(SPRD_INBOX_FIFO_OVERFLOW_IRQ | SPRD_INBOX_FIFO_DELIVER_IRQ);
> > > -       writel(val, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > > +               /* Enable inbox FIFO overflow and delivery interrupt */
> > > +               val = readl(priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > > +               val &= ~(SPRD_INBOX_FIFO_OVERFLOW_IRQ | SPRD_INBOX_FIFO_DELIVER_IRQ);
> > > +               writel(val, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > >
> > > -       /* Enable outbox FIFO not empty interrupt */
> > > -       val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > > -       val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
> > > -       writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > > +               /* Enable outbox FIFO not empty interrupt */
> > > +               val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > > +               val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
> > > +               writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > > +       }
> > > +       mutex_unlock(&priv->lock);
> >
> > I think using the atomic_add/sub_and_test() related APIs can remove
> > the mutex lock.
>
> Yes, atomic could make refcnt itself safe. But mutex lock is to make whole processing of
> reading/writing registers safe.
>
> Consider case like this:
>
>   channel #1             channel #2
> -------------------------------------
>    startup
>    .....
>    shutdown               startup
>      |-refcnt==0            |
>      |                      |-retcnt+1
>      |                      |-enable mailbox
>      |-disable mailbox
>
> Mailbox will be wrongly disabled after client requests channel #2's startup.

Yeah, you are right. Sorry for noise.

> >
> > >
> > >         return 0;
> > >  }
> > > @@ -235,9 +241,13 @@ static void sprd_mbox_shutdown(struct mbox_chan *chan)
> > >  {
> > >         struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
> > >
> > > -       /* Disable inbox & outbox interrupt */
> > > -       writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > > -       writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > > +       mutex_lock(&priv->lock);
> > > +       if (--priv->refcnt == 0) {
> > > +               /* Disable inbox & outbox interrupt */
> > > +               writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > > +               writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > > +       }
> > > +       mutex_unlock(&priv->lock);
> > >  }
> > >
> > >  static const struct mbox_chan_ops sprd_mbox_ops = {
> > > @@ -266,6 +276,8 @@ static int sprd_mbox_probe(struct platform_device *pdev)
> > >                 return -ENOMEM;
> > >
> > >         priv->dev = dev;
> > > +       priv->refcnt = 0;
> >
> > No need to do this, the priv structure is already cleared to 0.
>
> Right, will remove at next version.
>
> Thanks for reviewing!
>
> -Orson
>
> >
> > > +       mutex_init(&priv->lock);
> > >
> > >         /*
> > >          * The Spreadtrum mailbox uses an inbox to send messages to the target
> > > --
> > > 2.7.4
> > >
> >
> >
> > --
> > Baolin Wang



-- 
Baolin Wang
