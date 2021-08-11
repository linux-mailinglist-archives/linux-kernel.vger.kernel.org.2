Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19253E880D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhHKChp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231699AbhHKChp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:37:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21EF260EC0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628649442;
        bh=MHlVCJfEpTNGT+yzyF+RQ8u5NVXIOPzi87+tKm6W6iA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OAVjFx91OCFJcmNgdJOp6YzJT9IFPvYAAmttvY7TrRHcEsMBvyb3GNXGKcTbzHc4/
         e9BisN7nnu6Po6D1Ocxzm3anfnUARe0WipfZnL1jrKhWmuUNRJHJpjSweN5jrtmJMq
         AuHkyCTVLD2dWyPQHML82fh0ua7dLdbQ+Ja/pJM1KIzAun4QvHbqPozhhJF95DwffP
         iCJqphM9Q6Tkf1G8VWvaRbeLR4x+3wjrf8f6rhuWBrtssniJ1osfp8segpvdK77oHa
         i3S2fdiPFzFj60Hv0nUVY+hh3YfAxo0zTnTF9ek6CfwQHD9W7qTpitIVsKZWjcg282
         g+6jD+hbkrzaQ==
Received: by mail-lf1-f45.google.com with SMTP id g13so2246261lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:37:22 -0700 (PDT)
X-Gm-Message-State: AOAM531L0n4NHBR9iiJBZDI5tXCc13ew/qungqcB4AGNdcN/28a82zCp
        IrHIWvDeBo/vAKvbFzAAg/Wmu/KKSgdPAMcVfpI=
X-Google-Smtp-Source: ABdhPJw2vA7JqVfl0uZjLyoxurCd7RC53bidiEj+txGH/1tG2+XLGVDDueUTzDPrAS/5k0eYj7TUPpO3IUSTD5ZtQSQ=
X-Received: by 2002:ac2:47e8:: with SMTP id b8mr1163135lfp.555.1628649440441;
 Tue, 10 Aug 2021 19:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210806121521.124365-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20210806121521.124365-1-xianting.tian@linux.alibaba.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 11 Aug 2021 10:37:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQue-szv1MqFoxuceCL0cN70XHW44hqcDOrj5Vird6neQ@mail.gmail.com>
Message-ID: <CAJF2gTQue-szv1MqFoxuceCL0cN70XHW44hqcDOrj5Vird6neQ@mail.gmail.com>
Subject: Re: [PATCH] mailbox: fix a UAF bug in msg_submit()
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     jassisinghbrar@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 8:15 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> We met a UAF issue during our mailbox testing.
>
> In synchronous mailbox, we use mbox_send_message() to send a message
> and wait for completion. mbox_send_message() calls msg_submit() to
> send the message for the first time, if timeout, it will send the
> message in tx_tick() for the second time.
Yes, in chan->cl->tx_block will give a second chance to transmit the
msg in tx_tick. If chan->mbox->ops->send_data returned error again,
then mbox_send_message would return to the user's driver, and the user
driver would free the mssg which is still in chan->msg_data &
msg_count. Then it caused "Used After Free" problem.

The current second chance for chan->cl->tx_block is tricky and it's
hard for mailbox driver and user driver implementation in the way.
I recommend deleting the second chance mechanism totally to make the
code understandable. (If first failed, 2th & 3th & 4th would be still
failed.)


>
> We assume message sending failed for both two times,  then the message
> will be still in the internal buffer of a chan(chan->msg_data[idx]).
> It will be send again in the same way when mbox_send_message() is
> called next time. But, at this time this message (chan->msg_data[idx])
> may be a UAF pointer, as the message is passed to mailbox core by user.
> User may free it after last calling of mbox_send_message() returned
> or not. Who knows!!!
>
> In this patch, if the first time sending timeout, we pass timeout
> info(-ETIME) to msg_submit() when do the second time sending by
> tx_tick(). If it still send failed (chan->mbox->ops->send_data()
> returned non-zero value) in the second time, we will give up this
> message(chan->msg_count--) sending. It doesn't matter, user can chose
> to send it again.
>
> Actually, the issue I described above doesn't exist if
> 'chan->mbox->ops->send_data()' always return 0. Because if it always
> returns 0, we will always do 'chan->msg_count=E2=80=94' regardless of mes=
sage
> sending success or failure. We have such mailbox driver, for example,
> hi6220_mbox_send_data() always return 0. But we still have mailbox
> drivers, which don't always return 0, for example, flexrm_send_data()
> of drivers/mailbox/bcm-flexrm-mailbox.c.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/mailbox/mailbox.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 3e7d4b20a..3e010aafa 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -50,7 +50,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *ms=
sg)
>         return idx;
>  }
>
> -static void msg_submit(struct mbox_chan *chan)
> +static void msg_submit(struct mbox_chan *chan, int last_submit)
>  {
>         unsigned count, idx;
>         unsigned long flags;
> @@ -75,7 +75,7 @@ static void msg_submit(struct mbox_chan *chan)
>                 chan->cl->tx_prepare(chan->cl, data);
>         /* Try to submit a message to the MBOX controller */
>         err =3D chan->mbox->ops->send_data(chan, data);
> -       if (!err) {
> +       if (!err || last_submit =3D=3D -ETIME) {
>                 chan->active_req =3D data;
>                 chan->msg_count--;
>         }
> @@ -101,7 +101,7 @@ static void tx_tick(struct mbox_chan *chan, int r)
>         spin_unlock_irqrestore(&chan->lock, flags);
>
>         /* Submit next message */
> -       msg_submit(chan);
> +       msg_submit(chan, r);
>
>         if (!mssg)
>                 return;
> @@ -260,7 +260,7 @@ int mbox_send_message(struct mbox_chan *chan, void *m=
ssg)
>                 return t;
>         }
>
> -       msg_submit(chan);
> +       msg_submit(chan, 0);
>
>         if (chan->cl->tx_block) {
>                 unsigned long wait;
> --
> 2.17.1
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
