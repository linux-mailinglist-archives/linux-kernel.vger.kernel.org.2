Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867A543046C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 21:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbhJPTG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 15:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbhJPTGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 15:06:54 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3575DC061765;
        Sat, 16 Oct 2021 12:04:46 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y67so11588962iof.10;
        Sat, 16 Oct 2021 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4dBmL7Or+XGppRZhAI8kfYrI3l8Cuhl2ukP8vzEog8=;
        b=gFsFSMP/EqTJ6S885ibMbrPIMLH3KmlXfagqsGL3YTXFVj8K89AVkUqhLbAFh24fYp
         TVJhHw564egf5A9HhbX/M8NGCCpEJiq7JayYdstu6OKCsIHn0oPfG6CUO5bfYTi/oaQ6
         sSDRXm/HDkbGJoN24LSlhavH/isNZlaY1+sXQ2DpjGgcXFv/lLdDufJAOIzRaE7MUQ/M
         x1moFooq5HnS3VS6y/gizdkTZUlfYfSF8QaLEzp153d0ggS4ZqXruYVoY392TPXFxDQe
         zQLgzWbqqWXqD+uxJ0XVUnK2uPKaowTcp17WU3pXDJ6TfectoTwbjaAhebOp+K55U49S
         lKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4dBmL7Or+XGppRZhAI8kfYrI3l8Cuhl2ukP8vzEog8=;
        b=dHKVUotZa1iDbNhbOSqI5OWTEatWSfbAz9laVWdCCYZmB6mPoZpmjOuSzOgP1J6Lq2
         t6Gw05HpDyB8gWce4w4HCMtobY7z9JydwRU4xf+E+qTWmqseh5URBGtappLdmZce8BUT
         6HsZzyGuv9LO6IV+cgVUJaP6T0LYWL1mL9GGWQQNyCHDzc7rxxKDL0DQpB0PV9ZsQKjR
         hO0l+lLo36S+b0q7R+ayWw6yVr+Y/CScRK03PlQtv6p1EZl3esj4BGeWYkNQvziRHEsw
         uKQ5rUkoAsVxrDKIPFr19poCgsLA5WKzAL4d5yCyEPrQ0zZnAPW/AEPIHcUEzZ9YwjAH
         i+Zw==
X-Gm-Message-State: AOAM532enq3O7OdVhg8yjfBvYnweWPWYm3bKbtkEBXj/D/T46QoCEoXs
        poIwrqdx2pbA1VuVfZVWJ/e9nQFghj7k2sulON8=
X-Google-Smtp-Source: ABdhPJyCcZ0h2XhbbC9yEkSvjxVn1g7mh5AcmWsbru+PqJZJ+I5elDlRZSFmASz6l+bruizx+A9QtXwAPXeOhMMN7WE=
X-Received: by 2002:a05:6602:2dd2:: with SMTP id l18mr9031050iow.86.1634411085596;
 Sat, 16 Oct 2021 12:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210916154911.3168-1-sven@svenpeter.dev> <20210916154911.3168-3-sven@svenpeter.dev>
In-Reply-To: <20210916154911.3168-3-sven@svenpeter.dev>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 16 Oct 2021 14:04:34 -0500
Message-ID: <CABb+yY2XxpQa-QqsVnzVsYb+msSiOiELE1R5UFjE02Diwww2Ew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mailbox: apple: Add driver for Apple mailboxes
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 10:49 AM Sven Peter <sven@svenpeter.dev> wrote:

....
> +static const struct apple_mbox_hw apple_mbox_asc_hw = {
> +       .control_full = APPLE_ASC_MBOX_CONTROL_FULL,
> +       .control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
> +
> +       .a2i_control = APPLE_ASC_MBOX_A2I_CONTROL,
> +       .a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
> +       .a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
> +
> +       .i2a_control = APPLE_ASC_MBOX_I2A_CONTROL,
> +       .i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
> +       .i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
> +
> +       .has_irq_controls = false,
> +};
> +
> +static const struct apple_mbox_hw apple_mbox_m3_hw = {
> +       .control_full = APPLE_M3_MBOX_CONTROL_FULL,
> +       .control_empty = APPLE_M3_MBOX_CONTROL_EMPTY,
> +
> +       .a2i_control = APPLE_M3_MBOX_A2I_CONTROL,
> +       .a2i_send0 = APPLE_M3_MBOX_A2I_SEND0,
> +       .a2i_send1 = APPLE_M3_MBOX_A2I_SEND1,
> +
> +       .i2a_control = APPLE_M3_MBOX_I2A_CONTROL,
> +       .i2a_recv0 = APPLE_M3_MBOX_I2A_RECV0,
> +       .i2a_recv1 = APPLE_M3_MBOX_I2A_RECV1,
> +
> +       .has_irq_controls = true,
> +       .irq_enable = APPLE_M3_MBOX_IRQ_ENABLE,
> +       .irq_ack = APPLE_M3_MBOX_IRQ_ACK,
> +       .irq_bit_recv_not_empty = APPLE_M3_MBOX_IRQ_I2A_NOT_EMPTY,
> +       .irq_bit_send_empty = APPLE_M3_MBOX_IRQ_A2I_EMPTY,
> +};
> +
> +static const struct of_device_id apple_mbox_of_match[] = {
> +       { .compatible = "apple,t8103-asc-mailbox", .data = &apple_mbox_asc_hw },
> +       { .compatible = "apple,t8103-m3-mailbox", .data = &apple_mbox_m3_hw },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, apple_mbox_of_match);
> +
Traditionally, these go at the end of file.

....
> +
> +static int apple_mbox_hw_send(struct apple_mbox *apple_mbox,
> +                             struct apple_mbox_msg *msg)
> +{
> +       if (!apple_mbox_hw_can_send(apple_mbox))
> +               return -EBUSY;
> +
> +       dev_dbg(apple_mbox->dev, "> TX %016llx %08x\n", msg->msg0, msg->msg1);
> +
> +       /*
> +        * This message may be related to a shared memory buffer and we must
> +        * ensure all previous writes to normal memory are visible before
> +        * submitting it.
> +        */
> +       dma_wmb();
> +
This may cause unnecessary overhead.
mbox_client.tx_prepare() is where the SHMEM data is copied, which
should also call dma_wmb() just before return.
......

> +
> +static int apple_mbox_hw_recv(struct apple_mbox *apple_mbox,
> +                             struct apple_mbox_msg *msg)
> +{
> +       if (!apple_mbox_hw_can_recv(apple_mbox))
> +               return -ENOMSG;
> +
> +       msg->msg0 = readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv0);
> +       msg->msg1 = FIELD_GET(
> +               APPLE_MBOX_MSG1_MSG,
> +               readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv1));
> +
> +       dev_dbg(apple_mbox->dev, "< RX %016llx %08x\n", msg->msg0, msg->msg1);
> +
> +       /*
> +        * This message may be related to a shared memory buffer and we must
> +        * ensure any following reads from normal memory only happen after
> +        * having read this message.
> +        */
> +       dma_rmb();
> +
.... similarly should be done by the client as the first thing in recv callback.


> +static struct mbox_chan *apple_mbox_of_xlate(struct mbox_controller *mbox,
> +                                            const struct of_phandle_args *spec)
> +{
> +       struct apple_mbox *apple_mbox = dev_get_drvdata(mbox->dev);
> +
> +       if (spec->args_count != 0)
> +               return ERR_PTR(-EINVAL);
> +       if (apple_mbox->chan.con_priv)
> +               return ERR_PTR(-EBUSY);
> +
> +       apple_mbox->chan.con_priv = apple_mbox;
> +       return &apple_mbox->chan;
> +}
> +
we could do without of_xlate callback, by assigning  chan.con_priv
already in the .probe()


> diff --git a/include/linux/apple-mailbox.h b/include/linux/apple-mailbox.h
> +
> +struct apple_mbox_msg {
> +       u64 msg0;
> +       u32 msg1;
> +};
> +
Aren't msg0/1 the Tx and Rx channels? If so you may want to separate
them out as such. But of course, I don't know the h/w details so I may
be wrong.

Cheers!
