Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472B131352A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhBHO2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhBHOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:07:44 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E11C061788;
        Mon,  8 Feb 2021 06:06:53 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id q85so2117801qke.8;
        Mon, 08 Feb 2021 06:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBl2joP9w5qOOSdCC0bZ4+hsmWCUM+bc11/M8AdporU=;
        b=m3pi9v/a15e1N7xVeOi27UbFUjgAinW2cTOAU6uIbOAgrIZnq7OvSp+rpnFBZ0h8WS
         ukuj5jVEFDrfgf2X2eKs+o/dGGn20yPMiVBC8CIgXr9WrREIeBJglkiGTCqzAT073Nsv
         H9KB3fy56isg/DJ5omf6jg89gWau0RdDkO9bZrLqaK+C3lTmMsN0Q7QIbNmkcUolzSFQ
         4CFU1loTafvqqObhdH0oqY0lDo8BiJHEBu8Yd6FxbZRqLmyJOLoxX10M4ZE9LCUP9Bwe
         +YIeQqJ6mTOel1wL1XS762+XgD9cgT7XuY5+rAxsLTbPoxAFTe/jOG7yM3ZGDl/tChY6
         8C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBl2joP9w5qOOSdCC0bZ4+hsmWCUM+bc11/M8AdporU=;
        b=tQbIuFzyT9U5yov0QCgHZRWVa2PxRtNekv3vDBt8l89yTSHbv4DrsD5z/7dJQEHX0p
         VVnBxo/EHJL4wqVHuAWIxwWka7RMKy7ptZzQ2H/X31T1SkHHt8F7srh12gL9pUgPZO+L
         8Ivc7f6jsOjNnTUb9XDZwiIs0hWcp8LWHzTbzdivYSDx7c5jH7yxVDXoTw4bvwnfgF7u
         IiS1E2WGAq8XIdXH8ZczVr08u5EguigL8xbdNRB3VoKP9R8ATSIQmxRcrXMPhAi9LEnW
         KoZm57PieneJThRd6pWmC26he9TtmIjU8IzWuSrwi5Gw8S03t915CVg3JTvSKBVBdWD+
         SWEg==
X-Gm-Message-State: AOAM532PXR5Eu1zbOxioifXBtB9PnJ9cu1SREgRTtBvTy5FG2I6wmzP+
        U/DspNDE02J9+BAFTBt2Glo8msSjPVvwDWYhkUm9i4p7
X-Google-Smtp-Source: ABdhPJw1/o6Wi3lIaWwHO6x1a9NSYUqh7mKo1pp4lgXpMlKixhxQLCalakhpAckI4aI17ZQJn+gnUy1ic00UwkRL5jg=
X-Received: by 2002:a37:4d8e:: with SMTP id a136mr15952916qkb.317.1612793212802;
 Mon, 08 Feb 2021 06:06:52 -0800 (PST)
MIME-Version: 1.0
References: <1612785064-3072-1-git-send-email-orsonzhai@gmail.com>
In-Reply-To: <1612785064-3072-1-git-send-email-orsonzhai@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 8 Feb 2021 22:06:47 +0800
Message-ID: <CADBw62qiUG2dunB_i1iOp_srkAJP4CrVJX9mU25no++_b10hpg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailbox: sprd: Introduce refcnt when clients
 requests/free channels
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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

Hi Orson,

On Mon, Feb 8, 2021 at 7:52 PM Orson Zhai <orsonzhai@gmail.com> wrote:
>
> From: Orson Zhai <orson.zhai@unisoc.com>
>
> Unisoc mailbox has no way to be enabled/disabled for any single channel.
> They can only be set to startup or shutdown as a whole device at same time.
>
> Add a variable to count references to avoid mailbox FIFO being reset
> unexpectedly when clients are requesting or freeing channels.
>
> Also add a lock to dismiss possible conflicts from register r/w in
> different startup or shutdown threads.
>
> Fixes: ca27fc26cd22 ("mailbox: sprd: Add Spreadtrum mailbox driver")
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> ---
>  drivers/mailbox/sprd-mailbox.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
> index f6fab24..e606f52 100644
> --- a/drivers/mailbox/sprd-mailbox.c
> +++ b/drivers/mailbox/sprd-mailbox.c
> @@ -60,6 +60,8 @@ struct sprd_mbox_priv {
>         struct clk              *clk;
>         u32                     outbox_fifo_depth;
>
> +       struct mutex            lock;
> +       u32                     refcnt;
>         struct mbox_chan        chan[SPRD_MBOX_CHAN_MAX];
>  };
>
> @@ -215,18 +217,22 @@ static int sprd_mbox_startup(struct mbox_chan *chan)
>         struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
>         u32 val;
>
> -       /* Select outbox FIFO mode and reset the outbox FIFO status */
> -       writel(0x0, priv->outbox_base + SPRD_MBOX_FIFO_RST);
> +       mutex_lock(&priv->lock);
> +       if (priv->refcnt++ == 0) {
> +               /* Select outbox FIFO mode and reset the outbox FIFO status */
> +               writel(0x0, priv->outbox_base + SPRD_MBOX_FIFO_RST);
>
> -       /* Enable inbox FIFO overflow and delivery interrupt */
> -       val = readl(priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> -       val &= ~(SPRD_INBOX_FIFO_OVERFLOW_IRQ | SPRD_INBOX_FIFO_DELIVER_IRQ);
> -       writel(val, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> +               /* Enable inbox FIFO overflow and delivery interrupt */
> +               val = readl(priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> +               val &= ~(SPRD_INBOX_FIFO_OVERFLOW_IRQ | SPRD_INBOX_FIFO_DELIVER_IRQ);
> +               writel(val, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
>
> -       /* Enable outbox FIFO not empty interrupt */
> -       val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> -       val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
> -       writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> +               /* Enable outbox FIFO not empty interrupt */
> +               val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> +               val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
> +               writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> +       }
> +       mutex_unlock(&priv->lock);

I think using the atomic_add/sub_and_test() related APIs can remove
the mutex lock.

>
>         return 0;
>  }
> @@ -235,9 +241,13 @@ static void sprd_mbox_shutdown(struct mbox_chan *chan)
>  {
>         struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
>
> -       /* Disable inbox & outbox interrupt */
> -       writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> -       writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> +       mutex_lock(&priv->lock);
> +       if (--priv->refcnt == 0) {
> +               /* Disable inbox & outbox interrupt */
> +               writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> +               writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> +       }
> +       mutex_unlock(&priv->lock);
>  }
>
>  static const struct mbox_chan_ops sprd_mbox_ops = {
> @@ -266,6 +276,8 @@ static int sprd_mbox_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         priv->dev = dev;
> +       priv->refcnt = 0;

No need to do this, the priv structure is already cleared to 0.

> +       mutex_init(&priv->lock);
>
>         /*
>          * The Spreadtrum mailbox uses an inbox to send messages to the target
> --
> 2.7.4
>


-- 
Baolin Wang
