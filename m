Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75303302A6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 16:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhCGPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 10:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhCGPXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 10:23:18 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7879C06174A;
        Sun,  7 Mar 2021 07:23:17 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id x10so6932937qkm.8;
        Sun, 07 Mar 2021 07:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPQ3DeJRL8XtDGmuX7K2vCZNv7d4zbvPHFELytuIbHk=;
        b=uvofaxe0GRs3uRjoYWs+Ja0VGYA4ytfA1NjZxKEue9d3DuArYABdzkbbv4sRiDLgcg
         Nnd4lKyOId8z7Na0AMNzBT/anp8EhsnCPm6UV0WuCdifcTU/T1nzirZxCoR74f+vlNhc
         zOcBJIUpz3SOBrufb1zAcOUUldmturCSbNiN57y4DPoI5ytOvq9UtSc2Qr3xjVovffEB
         NqY40vG8pmrhNXEw2SF/ZjJ1tZvwYSmDwFxWrjMV57BYT6OMRsnRo2fB/knKwSN8Q7Fm
         bTMcFwNoBBMpD/dQCJg1ZXJZSr5EQ+7x6OoQ9zPXDXvnyhf+vW/NE/ZTs9mxMyFTyezQ
         Kdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPQ3DeJRL8XtDGmuX7K2vCZNv7d4zbvPHFELytuIbHk=;
        b=Fr9l/LdgLfodjqkRaVOs0l6yPg3DQ2YSPYyOdsCefv98Gan+4AI23+4/Qkry5f0RcH
         dopdpxuq8x4huD7aZEnSUdn5UJCBUDoechoc2l8A3ZcSG4TcWAya/6QlS/MgLpyGtxK/
         z6BQNf8F4HW6r6LWsc0ZIszTK2Iu/A7N2o5GXwOVGtv0tY8OQR5QIdbYawSikouQsV+q
         iQSygLmv8v0ZT65NHiEAKeYWoO8UnfGQvyWXwv/S7D1/2mn4ovWlyei5i2s+jkZx3ksV
         BckUhVMBafwY0jKy5z1xN5ey4tVe5Pj5fh0ddA+VN1XGFC9k8i/Zou4NW2mpdpGZgpy0
         BAJw==
X-Gm-Message-State: AOAM531RRM3Cf5b5Zojh/RcQ5DpwXgLcKnPagaJvdbjhFJ91Ae5p67YF
        sqLC4y2fF762/O/1D3OdreGLxMkvOp5PkKiyosNqjQt/
X-Google-Smtp-Source: ABdhPJwzWdk+YMq0oT+K8PvSrlQNsKsWKJbl7BwPPtXgX+k/1EkARuX+8QtcrysN03VJb2EI1EcxNlkpE25capOx7bM=
X-Received: by 2002:a37:46c5:: with SMTP id t188mr17569564qka.47.1615130596833;
 Sun, 07 Mar 2021 07:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20210213122143.19240-1-orsonzhai@gmail.com> <20210213122143.19240-2-orsonzhai@gmail.com>
In-Reply-To: <20210213122143.19240-2-orsonzhai@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Sun, 7 Mar 2021 23:23:15 +0800
Message-ID: <CADBw62q2VFPP+P8XabPsKXMf0RuCeUFzbMwcauwH0UFZOj_YzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mailbox: sprd: Introduce refcnt when clients
 requests/free channels
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Haidong Yao <yaohaidong369@gmail.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 8:22 PM Orson Zhai <orsonzhai@gmail.com> wrote:
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
> different startup or shutdown threads. And fix the crash problem when early
> interrupts come from channel which has not been requested by client yet.
>
> Fixes: ca27fc26cd22 ("mailbox: sprd: Add Spreadtrum mailbox driver")
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>

Sorry for the late reply. LGTM.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/mailbox/sprd-mailbox.c | 43 +++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
> index f6fab24ae8a9..920de7b9dce1 100644
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
> @@ -115,7 +117,11 @@ static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
>                 id = readl(priv->outbox_base + SPRD_MBOX_ID);
>
>                 chan = &priv->chan[id];
> -               mbox_chan_received_data(chan, (void *)msg);
> +               if (chan->cl)
> +                       mbox_chan_received_data(chan, (void *)msg);
> +               else
> +                       dev_warn_ratelimited(priv->dev,
> +                                   "message's been dropped at ch[%d]\n", id);
>
>                 /* Trigger to update outbox FIFO pointer */
>                 writel(0x1, priv->outbox_base + SPRD_MBOX_TRIGGER);
> @@ -215,18 +221,22 @@ static int sprd_mbox_startup(struct mbox_chan *chan)
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
>
>         return 0;
>  }
> @@ -235,9 +245,13 @@ static void sprd_mbox_shutdown(struct mbox_chan *chan)
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
> @@ -266,6 +280,7 @@ static int sprd_mbox_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         priv->dev = dev;
> +       mutex_init(&priv->lock);
>
>         /*
>          * The Spreadtrum mailbox uses an inbox to send messages to the target
> --
> 2.17.1
>


-- 
Baolin Wang
