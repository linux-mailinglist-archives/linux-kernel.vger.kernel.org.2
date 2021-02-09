Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AD631474D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 05:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBIEFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 23:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhBIDmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:42:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4BAC061786;
        Mon,  8 Feb 2021 19:28:44 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id my11so814192pjb.1;
        Mon, 08 Feb 2021 19:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iNkvVbVPjvkONhlILwVRwh9nXa2Wj/wsvujkY/JhyuM=;
        b=DtAKq9YCmmp3nhieg5RaC5F/0aChM7KbLSPPB4PxecWaRQjbsBDAhICKW+Na4tgmH4
         dY9dKT5RHkKGkoFh3byCYiqBjkdrLaiBka8WxhFS6pAk4YlriQzJ4l1q9qAeMSUqRcQW
         sgs0MitnA/d0ahIiDTY4r406X67ORimTkOKAtFh+XsaYQtr52DRs9RoZRu/jR5ChOXty
         IbkbLcoJin9mC6JnbZwV98BDiqDIhg2sh0VEM1ioXk5e+L+H3F5+kLqqKF9LMggiejzM
         L8srmTyqTEGkPze5t1ynjCgjzgbuE8qyfy9ENaH5Mwaf+EPu4EdzYOgYRDCo5rRb4lan
         RLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=iNkvVbVPjvkONhlILwVRwh9nXa2Wj/wsvujkY/JhyuM=;
        b=obeEJ5gl3qoJGpwUdDZCP3g1iQ+PxAU4gTw5Ej27F/pmPCmySjTjonm9DLioYgTU33
         EusVK7gKJ7K2hePhnNMR//daUkyXSn223qozJ++VZGcPRy0P7JHQ707UUJATuOx5Y13W
         htpQEMQVgIqUG2Sv+vAnaXVmadSZrzKJsy7A0IRIqqTjAlxy28shPx5KiNvZhcoEdvb/
         ssYc9hx+HwbZZYZEsNprumvz1oFm4F4OtHmV2BiOQ9C14RmO5qcbeaFXP+GBAtaAKWZg
         KHrMc/ZeAZU7U8f6rFOH/Am4k882ZdfyuGYYGJCc56vuDStMK9rl6zN/bwt3Dd73Xlfv
         8YZA==
X-Gm-Message-State: AOAM532kLlKjLIVMpLIgm6SQPdwfVc44RBnJYfW0X4gdk/X7Z/Mi47zd
        t1WxHmgT1VUrLBnHmw2GHYra1i+6q2slHA==
X-Google-Smtp-Source: ABdhPJwS4m692WkJDHRki0OD1NmzMYo3U9c5MT7W2cpmC2agASAx0ZlEHkOJuyYJgmdCfpjXfwSkNA==
X-Received: by 2002:a17:902:d48e:b029:e2:efbc:5fed with SMTP id c14-20020a170902d48eb02900e2efbc5fedmr2991833plg.53.1612841324367;
        Mon, 08 Feb 2021 19:28:44 -0800 (PST)
Received: from lenovo ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a9sm14374382pfr.204.2021.02.08.19.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 19:28:43 -0800 (PST)
Date:   Tue, 9 Feb 2021 11:28:38 +0800
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Haidong Yao <haidong.yao@unisoc.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: Re: [PATCH 1/3] mailbox: sprd: Introduce refcnt when clients
 requests/free channels
Message-ID: <20210209032838.GA24248@lenovo>
Mail-Followup-To: Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Haidong Yao <haidong.yao@unisoc.com>,
        Orson Zhai <orson.zhai@unisoc.com>
References: <1612785064-3072-1-git-send-email-orsonzhai@gmail.com>
 <CADBw62qiUG2dunB_i1iOp_srkAJP4CrVJX9mU25no++_b10hpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBw62qiUG2dunB_i1iOp_srkAJP4CrVJX9mU25no++_b10hpg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 10:06:47PM +0800, Baolin Wang wrote:
> Hi Orson,
> 
> On Mon, Feb 8, 2021 at 7:52 PM Orson Zhai <orsonzhai@gmail.com> wrote:
> >
> > From: Orson Zhai <orson.zhai@unisoc.com>
> >
> > Unisoc mailbox has no way to be enabled/disabled for any single channel.
> > They can only be set to startup or shutdown as a whole device at same time.
> >
> > Add a variable to count references to avoid mailbox FIFO being reset
> > unexpectedly when clients are requesting or freeing channels.
> >
> > Also add a lock to dismiss possible conflicts from register r/w in
> > different startup or shutdown threads.
> >
> > Fixes: ca27fc26cd22 ("mailbox: sprd: Add Spreadtrum mailbox driver")
> > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > ---
> >  drivers/mailbox/sprd-mailbox.c | 38 +++++++++++++++++++++++++-------------
> >  1 file changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
> > index f6fab24..e606f52 100644
> > --- a/drivers/mailbox/sprd-mailbox.c
> > +++ b/drivers/mailbox/sprd-mailbox.c
> > @@ -60,6 +60,8 @@ struct sprd_mbox_priv {
> >         struct clk              *clk;
> >         u32                     outbox_fifo_depth;
> >
> > +       struct mutex            lock;
> > +       u32                     refcnt;
> >         struct mbox_chan        chan[SPRD_MBOX_CHAN_MAX];
> >  };
> >
> > @@ -215,18 +217,22 @@ static int sprd_mbox_startup(struct mbox_chan *chan)
> >         struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
> >         u32 val;
> >
> > -       /* Select outbox FIFO mode and reset the outbox FIFO status */
> > -       writel(0x0, priv->outbox_base + SPRD_MBOX_FIFO_RST);
> > +       mutex_lock(&priv->lock);
> > +       if (priv->refcnt++ == 0) {
> > +               /* Select outbox FIFO mode and reset the outbox FIFO status */
> > +               writel(0x0, priv->outbox_base + SPRD_MBOX_FIFO_RST);
> >
> > -       /* Enable inbox FIFO overflow and delivery interrupt */
> > -       val = readl(priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > -       val &= ~(SPRD_INBOX_FIFO_OVERFLOW_IRQ | SPRD_INBOX_FIFO_DELIVER_IRQ);
> > -       writel(val, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > +               /* Enable inbox FIFO overflow and delivery interrupt */
> > +               val = readl(priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > +               val &= ~(SPRD_INBOX_FIFO_OVERFLOW_IRQ | SPRD_INBOX_FIFO_DELIVER_IRQ);
> > +               writel(val, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> >
> > -       /* Enable outbox FIFO not empty interrupt */
> > -       val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > -       val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
> > -       writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > +               /* Enable outbox FIFO not empty interrupt */
> > +               val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > +               val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
> > +               writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > +       }
> > +       mutex_unlock(&priv->lock);
> 
> I think using the atomic_add/sub_and_test() related APIs can remove
> the mutex lock.

Yes, atomic could make refcnt itself safe. But mutex lock is to make whole processing of
reading/writing registers safe.

Consider case like this:

  channel #1             channel #2
-------------------------------------
   startup
   .....
   shutdown               startup
     |-refcnt==0            |
     |                      |-retcnt+1
     |                      |-enable mailbox
     |-disable mailbox 

Mailbox will be wrongly disabled after client requests channel #2's startup.

> 
> >
> >         return 0;
> >  }
> > @@ -235,9 +241,13 @@ static void sprd_mbox_shutdown(struct mbox_chan *chan)
> >  {
> >         struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
> >
> > -       /* Disable inbox & outbox interrupt */
> > -       writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > -       writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > +       mutex_lock(&priv->lock);
> > +       if (--priv->refcnt == 0) {
> > +               /* Disable inbox & outbox interrupt */
> > +               writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > +               writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > +       }
> > +       mutex_unlock(&priv->lock);
> >  }
> >
> >  static const struct mbox_chan_ops sprd_mbox_ops = {
> > @@ -266,6 +276,8 @@ static int sprd_mbox_probe(struct platform_device *pdev)
> >                 return -ENOMEM;
> >
> >         priv->dev = dev;
> > +       priv->refcnt = 0;
> 
> No need to do this, the priv structure is already cleared to 0.

Right, will remove at next version.

Thanks for reviewing!

-Orson

> 
> > +       mutex_init(&priv->lock);
> >
> >         /*
> >          * The Spreadtrum mailbox uses an inbox to send messages to the target
> > --
> > 2.7.4
> >
> 
> 
> -- 
> Baolin Wang
