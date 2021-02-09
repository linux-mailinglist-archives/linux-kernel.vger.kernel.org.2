Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC3E314795
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 05:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhBIEgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 23:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhBIEKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 23:10:05 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB3CC061786;
        Mon,  8 Feb 2021 20:09:01 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s15so8997002plr.9;
        Mon, 08 Feb 2021 20:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=02EOcFWr5jIJ/6O25CjkcEVxZp68K1F7OXXiPpRMOLk=;
        b=V2r1C0F6ACmjgaZHHh6gigL0LxySexLeKaXRVf3XHvZUJsomVijryNIVZVSCNViC7Q
         hyKy7V64rXGmEpXu5fvVZgCC+C4MWDsbQcSFuuKtyvR5M8EAY8GaLE1FI8gpP97YIaoe
         LuLi/0IMD6HNT1iUl8ATOIUbtYx86ONzUplxDNs1bCmHBrgbaq3LyWtxx8knZ6kfN0EN
         OirrEzRfFv9Uy9kThkKQm6x2zGkj0Pe/a8nJzmWvnTia2VMEPweeuB22DNKQrzkvAWGQ
         jVoL6ouWNml0G1RDT9vDuZtG7QdzSChM7vOWkq3uAwxeQZLRWq4a350272WlIbmQcvvC
         MYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=02EOcFWr5jIJ/6O25CjkcEVxZp68K1F7OXXiPpRMOLk=;
        b=PQKUdu2e1j6/qvTqCYn2xuIH/aorVLe0WFFLwjjoklltyNQhEEjXqUXocXklWGzXBA
         lXZozFto91wUdagV6gCNllVgahtdw/C7V7j0JuOaaCr7LV6skpT8D0pdE0/Rc+M0mZNB
         l/AV69ptNocwUAMuaYRLRBnuYKB2lBKUyipf5yJ2Ca20BSfbqcVqQTRKjt76a4vdvUCs
         hHY8EnfsNdlNnlffwAPd0N1466MycprOM984VnagrPoFckNQdvy4XOH0sRTVq5wlf6oH
         u1LUil6V/dai01B4z54IcgtKnDhbP7TAAfKrf5vT5/pusXRs/WXhl3DJDOwD5sHAnCdR
         LTBw==
X-Gm-Message-State: AOAM530iKH9XPRGXBSuAlNzl4CrZ95WjIQWXBTim/NTax9dyxI6CMX+G
        kYVgzoxVHIFI/7rvTUMpj0c=
X-Google-Smtp-Source: ABdhPJx54msXQoyNqba8OJd6u37Zu7MBQTuAMQw48i/bmuE3YDaIKTuvvr0Nnmi6H5Gjfj7qgn6QQg==
X-Received: by 2002:a17:90a:7187:: with SMTP id i7mr2148021pjk.216.1612843740901;
        Mon, 08 Feb 2021 20:09:00 -0800 (PST)
Received: from lenovo ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id z2sm20474798pfa.121.2021.02.08.20.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 20:09:00 -0800 (PST)
Date:   Tue, 9 Feb 2021 12:08:55 +0800
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
Subject: Re: [PATCH 2/3] mailbox: sprd: Add supplementary inbox support
Message-ID: <20210209040855.GA25057@lenovo>
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
 <1612785064-3072-2-git-send-email-orsonzhai@gmail.com>
 <CADBw62qJRoDGdaY8jB1pppgd8S6JnJ+A5sT+c00uXDO9wXucmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBw62qJRoDGdaY8jB1pppgd8S6JnJ+A5sT+c00uXDO9wXucmg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 10:27:47PM +0800, Baolin Wang wrote:
> On Mon, Feb 8, 2021 at 7:52 PM Orson Zhai <orsonzhai@gmail.com> wrote:
> >
> > From: Orson Zhai <orson.zhai@unisoc.com>
> >
> > Some sensors connected to Unisoc mailbox will send data very frequently.
> > This makes channel 0 very busy and the messages from other remote cores
> > not able to be handled as soon as possible.
> >
> > Then a supplementary inbox is added to the host core side for transferring
> > mass but not emergency messages from the remote cores, such as step
> > counting sensor, with an independent FIFO and interrupt.
> 
> So this is another part of the mailbox hardware, containing a batch of
> hardware channels?

No. Actually it is an inbox assigned to one of the remote cores before but
being exposed to host cpu core for now. 

> I did not see it before, its function is similar
> with inbox/outbox?

Exactly same with any other channel.
But only the part of outbox is exposed to host side. Inbox part of this channel
is still kept for original remote core to use.

It's a trick (un-documented) from our ASIC designers to resolve some special requirements.
I was also shocked when hearing it :)

I guess other vendors will add another mailbox module to resovle this, but our guys might
consider the hardware cost...
 
> 
> >
> > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > ---
> >  drivers/mailbox/sprd-mailbox.c | 93 ++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 75 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
> > index e606f52..74648db 100644
> > --- a/drivers/mailbox/sprd-mailbox.c
> > +++ b/drivers/mailbox/sprd-mailbox.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/io.h>
> >  #include <linux/mailbox_controller.h>
> >  #include <linux/module.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/clk.h>
> >
> > @@ -50,13 +51,17 @@
> >  #define SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ         BIT(0)
> >  #define SPRD_OUTBOX_FIFO_IRQ_MASK              GENMASK(4, 0)
> >
> > +#define SPRD_OUTBOX_BASE_SPAN                  0x1000
> >  #define SPRD_MBOX_CHAN_MAX                     8
> > +#define SPRD_SUPP_INBOX_ID_SC9860              6
> >
> >  struct sprd_mbox_priv {
> >         struct mbox_controller  mbox;
> >         struct device           *dev;
> >         void __iomem            *inbox_base;
> >         void __iomem            *outbox_base;
> > +       /*  Base register address for supplementary outbox */
> > +       void __iomem            *supp_base;
> >         struct clk              *clk;
> >         u32                     outbox_fifo_depth;
> >
> > @@ -96,14 +101,13 @@ static u32 sprd_mbox_get_fifo_len(struct sprd_mbox_priv *priv, u32 fifo_sts)
> >         return fifo_len;
> >  }
> >
> > -static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
> > +static inline irqreturn_t do_outbox_isr(void __iomem *base, struct sprd_mbox_priv *priv)
> 
> No need to add an explicit 'inline' tag, the compiler can do the smart
> things than us.

I thought it will help to increase perfermance of isr execution before.

Will fix at next.

> 
> >  {
> > -       struct sprd_mbox_priv *priv = data;
> >         struct mbox_chan *chan;
> >         u32 fifo_sts, fifo_len, msg[2];
> >         int i, id;
> >
> > -       fifo_sts = readl(priv->outbox_base + SPRD_MBOX_FIFO_STS);
> > +       fifo_sts = readl(base + SPRD_MBOX_FIFO_STS);
> >
> >         fifo_len = sprd_mbox_get_fifo_len(priv, fifo_sts);
> >         if (!fifo_len) {
> > @@ -112,23 +116,41 @@ static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
> >         }
> >
> >         for (i = 0; i < fifo_len; i++) {
> > -               msg[0] = readl(priv->outbox_base + SPRD_MBOX_MSG_LOW);
> > -               msg[1] = readl(priv->outbox_base + SPRD_MBOX_MSG_HIGH);
> > -               id = readl(priv->outbox_base + SPRD_MBOX_ID);
> > +               msg[0] = readl(base + SPRD_MBOX_MSG_LOW);
> > +               msg[1] = readl(base + SPRD_MBOX_MSG_HIGH);
> > +               id = readl(base + SPRD_MBOX_ID);
> >
> >                 chan = &priv->chan[id];
> > -               mbox_chan_received_data(chan, (void *)msg);
> > +               if (chan->cl)
> > +                       mbox_chan_received_data(chan, (void *)msg);
> > +               else
> > +                       dev_warn_ratelimited(priv->dev,
> > +                                   "message's been dropped at ch[%d]\n", id);
> >
> >                 /* Trigger to update outbox FIFO pointer */
> > -               writel(0x1, priv->outbox_base + SPRD_MBOX_TRIGGER);
> > +               writel(0x1, base + SPRD_MBOX_TRIGGER);
> >         }
> >
> >         /* Clear irq status after reading all message. */
> > -       writel(SPRD_MBOX_IRQ_CLR, priv->outbox_base + SPRD_MBOX_IRQ_STS);
> > +       writel(SPRD_MBOX_IRQ_CLR, base + SPRD_MBOX_IRQ_STS);
> >
> >         return IRQ_HANDLED;
> >  }
> >
> > +static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
> > +{
> > +       struct sprd_mbox_priv *priv = data;
> > +
> > +       return do_outbox_isr(priv->outbox_base, priv);
> > +}
> > +
> > +static irqreturn_t sprd_mbox_supp_isr(int irq, void *data)
> > +{
> > +       struct sprd_mbox_priv *priv = data;
> > +
> > +       return do_outbox_isr(priv->supp_base, priv);
> > +}
> > +
> >  static irqreturn_t sprd_mbox_inbox_isr(int irq, void *data)
> >  {
> >         struct sprd_mbox_priv *priv = data;
> > @@ -231,6 +253,14 @@ static int sprd_mbox_startup(struct mbox_chan *chan)
> >                 val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> >                 val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
> >                 writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > +
> > +               /* Enable supplementary outbox as the fundamental one */
> > +               if (priv->supp_base) {
> > +                       writel(0x0, priv->supp_base + SPRD_MBOX_FIFO_RST);
> > +                       val = readl(priv->supp_base + SPRD_MBOX_IRQ_MSK);
> > +                       val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
> > +                       writel(val, priv->supp_base + SPRD_MBOX_IRQ_MSK);
> > +               }
> >         }
> >         mutex_unlock(&priv->lock);
> >
> > @@ -246,6 +276,10 @@ static void sprd_mbox_shutdown(struct mbox_chan *chan)
> >                 /* Disable inbox & outbox interrupt */
> >                 writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> >                 writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > +
> > +               if (priv->supp_base)
> > +                       writel(SPRD_OUTBOX_FIFO_IRQ_MASK,
> > +                              priv->supp_base + SPRD_MBOX_IRQ_MSK);
> >         }
> >         mutex_unlock(&priv->lock);
> >  }
> > @@ -268,8 +302,8 @@ static int sprd_mbox_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> >         struct sprd_mbox_priv *priv;
> > -       int ret, inbox_irq, outbox_irq;
> > -       unsigned long id;
> > +       int ret, inbox_irq, outbox_irq, supp_irq;
> > +       unsigned long id, supp;
> >
> >         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >         if (!priv)
> > @@ -280,11 +314,15 @@ static int sprd_mbox_probe(struct platform_device *pdev)
> >         mutex_init(&priv->lock);
> >
> >         /*
> > -        * The Spreadtrum mailbox uses an inbox to send messages to the target
> > -        * core, and uses an outbox to receive messages from other cores.
> > +        * Unisoc mailbox uses an inbox to send messages to the target
> > +        * core, and uses (an) outbox(es) to receive messages from other
> > +        * cores.
> > +        *
> > +        * Thus in general the mailbox controller supplies 2 different
> > +        * register addresses and IRQ numbers for inbox and outbox.
> >          *
> > -        * Thus the mailbox controller supplies 2 different register addresses
> > -        * and IRQ numbers for inbox and outbox.
> > +        * If necessary, a supplementary inbox could be enabled optionally
> > +        * with an independent FIFO and an extra interrupt.
> >          */
> >         priv->inbox_base = devm_platform_ioremap_resource(pdev, 0);
> >         if (IS_ERR(priv->inbox_base))
> > @@ -310,7 +348,7 @@ static int sprd_mbox_probe(struct platform_device *pdev)
> >                 return ret;
> >         }
> >
> > -       inbox_irq = platform_get_irq(pdev, 0);
> > +       inbox_irq = platform_get_irq_byname(pdev, "inbox");
> 
> I think you should put the dt changes before this patch.

OK.

Thanks,
Orson
> 
> >         if (inbox_irq < 0)
> >                 return inbox_irq;
> >
> > @@ -321,7 +359,7 @@ static int sprd_mbox_probe(struct platform_device *pdev)
> >                 return ret;
> >         }
> >
> > -       outbox_irq = platform_get_irq(pdev, 1);
> > +       outbox_irq = platform_get_irq_byname(pdev, "outbox");
> >         if (outbox_irq < 0)
> >                 return outbox_irq;
> >
> > @@ -332,6 +370,24 @@ static int sprd_mbox_probe(struct platform_device *pdev)
> >                 return ret;
> >         }
> >
> > +       /* Supplementary outbox IRQ is optional */
> > +       supp_irq = platform_get_irq_byname(pdev, "supp-outbox");
> > +       if (supp_irq > 0) {
> > +               ret = devm_request_irq(dev, supp_irq, sprd_mbox_supp_isr,
> > +                                      IRQF_NO_SUSPEND, dev_name(dev), priv);
> > +               if (ret) {
> > +                       dev_err(dev, "failed to request outbox IRQ: %d\n", ret);
> > +                       return ret;
> > +               }
> > +
> > +               supp = (unsigned long) of_device_get_match_data(dev);
> > +               if (!supp) {
> > +                       dev_err(dev, "no supplementary outbox specified\n");
> > +                       return -ENODEV;
> > +               }
> > +               priv->supp_base = priv->outbox_base + (SPRD_OUTBOX_BASE_SPAN * supp);
> > +       }
> > +
> >         /* Get the default outbox FIFO depth */
> >         priv->outbox_fifo_depth =
> >                 readl(priv->outbox_base + SPRD_MBOX_FIFO_DEPTH) + 1;
> > @@ -354,7 +410,8 @@ static int sprd_mbox_probe(struct platform_device *pdev)
> >  }
> >
> >  static const struct of_device_id sprd_mbox_of_match[] = {
> > -       { .compatible = "sprd,sc9860-mailbox", },
> > +       { .compatible = "sprd,sc9860-mailbox",
> > +         .data = (void *)SPRD_SUPP_INBOX_ID_SC9860 },
> >         { },
> >  };
> >  MODULE_DEVICE_TABLE(of, sprd_mbox_of_match);
> > --
> > 2.7.4
> >
> 
> 
> -- 
> Baolin Wang
