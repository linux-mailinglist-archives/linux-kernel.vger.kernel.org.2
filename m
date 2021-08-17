Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994FB3EF622
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 01:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhHQXeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 19:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHQXeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 19:34:24 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB907C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:33:50 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id y3so283443ilm.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ebbyQDf83lAGccwLMh/Kj0c9OGvQBXHcZK7MoJ9b83Y=;
        b=dMI6TH2cPMXRz0w3x4mlOXmoteQh0DmYw/n+ewd3MbAq8T4cJ/idcugeP+UAALx8tf
         u+CPsJR8ZVxHQjmZb4ILik3LON4CF77S7ECXYA51mzhEZ3BQa92dEky+6fTNkG80URoA
         jFay5z/nM07lU6EuszflCWEU6AgD41XbtPOLC/QF028Sd2eJQZNd3TX1HhYaZv8XdsP0
         +P+3Ss53/mCXM3A4Ya9SXU8d3uPuaPigiMPhk4FCtAFTxufXXFsZf/QU44D6anXvQB1Z
         au4oO1YajGd0ERhtNdFo458tH9hX0PuUJKt8TpPHADxdq8XCPUnUBo8EfVlOE59FzjBp
         aReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ebbyQDf83lAGccwLMh/Kj0c9OGvQBXHcZK7MoJ9b83Y=;
        b=lk4yHaSErGw3Tigz9LQsLvLVpzJZkD/3RHjnIr6ND9403dMN6Q9LccxW5cAjOLnXpd
         PkQdRg+TxoVe1VF4qw1SbZuIGGX7/gGEvXZqpnu/Rvy10oNdouP8o890fvXRuWvyIDdy
         KJbP066Smcq/EdnqZnqGLW/tL+15AICKXoGUEHf7CIvTLcQtLXkKTnhCHCycvI4VJ6yB
         Jf6HuWlWmgWV408VUP+5taSdyvkV7WXOe9425GoYnjS8SwOkxiGd/LiNltOh2yfquRcY
         Bc394wj7qMWWIvtWQEhQDdRZ6OFdXvg9f2nskar/sPqcCsA0XIP2hT546iT5twnzPy2v
         D1uA==
X-Gm-Message-State: AOAM532eqmGNNeQRO6ZCaVmDL444OO24cdOLyf1w1+mYUqJK45WnSSmp
        /UscpRMq1QlT9NHRDfjBGGYcYq/cFMJtovrsa28=
X-Google-Smtp-Source: ABdhPJxLxP4mx5T5dGuicXUkUITUd42ZxofjAWCDQCHI1oYQc/g/BnbJQn3DR+1muIuFeuFojqF51zkeQ62gko74vOI=
X-Received: by 2002:a92:c04e:: with SMTP id o14mr3828799ilf.289.1629243230206;
 Tue, 17 Aug 2021 16:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210806121521.124365-1-xianting.tian@linux.alibaba.com>
 <CABb+yY3i5aZQrimoWLTMQRY5WsOJ1FCGNxBN0Hz_=4qxUvoqSw@mail.gmail.com>
 <977740a4-c08d-663d-410e-3375d034d2e8@linux.alibaba.com> <26a45754-4227-5f20-8c7d-c320d3905b60@linux.alibaba.com>
In-Reply-To: <26a45754-4227-5f20-8c7d-c320d3905b60@linux.alibaba.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 17 Aug 2021 18:33:38 -0500
Message-ID: <CABb+yY337=BVjHygv7wurj9Hh8-dj2aMyMnh54WL0CovyMfi_w@mail.gmail.com>
Subject: Re: [PATCH] mailbox: fix a UAF bug in msg_submit()
To:     Xianting TIan <xianting.tian@linux.alibaba.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        guoren@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 3:01 AM Xianting TIan
<xianting.tian@linux.alibaba.com> wrote:
>
>
> =E5=9C=A8 2021/8/17 =E4=B8=8B=E5=8D=881:58, Xianting TIan =E5=86=99=E9=81=
=93:
> >
> > =E5=9C=A8 2021/8/17 =E4=B8=8B=E5=8D=8812:29, Jassi Brar =E5=86=99=E9=81=
=93:
> >> On Fri, Aug 6, 2021 at 7:15 AM Xianting Tian
> >> <xianting.tian@linux.alibaba.com> wrote:
> >>> We met a UAF issue during our mailbox testing.
> >>>
> >>> In synchronous mailbox, we use mbox_send_message() to send a message
> >>> and wait for completion. mbox_send_message() calls msg_submit() to
> >>> send the message for the first time, if timeout, it will send the
> >>> message in tx_tick() for the second time.
> >>>
> >> Seems like your controller's  .send_data() returns error. Can you
> >> please explain why it does so? Because
> >> send_data() only _accepts_ data for further transmission... which
> >> should seldom be a problem.
> >
> > Thanks for the comments,
> >
> > We developed virtio-mailbox for heterogeneous virtualization system.
> >
> > virtio-mailbox is based on the mialbox framework.
> >
> > In virtio framework, its send func 'virtqueue_add_outbuf()' may return
> > error, which caused .send_data() return error.  And also contains
> > other csenarios.
> >
> > But I think mailbox framework shouldn't depend on .send_data() always
> > return OK,  as .send_data() is implemented by mailbox hardware
> > manufacturer, which is not controlled by mailbox framework itself.
> >
As I said, send_data() is basically "accepted for transfer",  and not
"transferred fine".

> > You said 'seldom',  but it still possible we can meet such issue. sucn
> > as flexrm_send_data() of drivers/mailbox/bcm-flexrm-mailbox.c.
> >
The api is used not just in synchronous mode.
And the flexrm driver relies on ACK method, not the synchronous one.

> > I think mailbox framework should be work normaly no matter
> > .send_data() returns ok or not ok.  Do you think so? thanks
>
Normal is your controller driver should be ready after .startup() and
accepts the first message submitted to it.
If it does that, everything would work.

> Another solution is to ignore the return value of .send_data() in
> msg_submit(),
>
> change
>
>          err =3D chan->mbox->ops->send_data(chan, data);
>          if (!err) {
>                  chan->active_req =3D data;
>                  chan->msg_count--;
>          }
>
> to
>
>          chan->mbox->ops->send_data(chan, data);
>          chan->active_req =3D data;
>          chan->msg_count--;
>
Yes, I also have something like this in mind. Definitely not the hack
in your original post.

> But the side effect of the solution is obvious, as if send failed in the
> first time, it will have no chance to sent it in tx_tick() for the
> second time. That is to say, no retry.
>
The api doesn't retry.  The  .last_tx_done() is supposed to tell the
api when is it ok to send a message.

The following should work for you (though I believe your code needs
fixing), which anyway, should have been there.

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 3e7d4b20ab34..9824a51b82fa 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -75,10 +75,12 @@ static void msg_submit(struct mbox_chan *chan)
                chan->cl->tx_prepare(chan->cl, data);
        /* Try to submit a message to the MBOX controller */
        err =3D chan->mbox->ops->send_data(chan, data);
-       if (!err) {
+       if (!err)
                chan->active_req =3D data;
-               chan->msg_count--;
-       }
+
+       /* done with another message */
+       chan->msg_count--;
+
 exit:
        spin_unlock_irqrestore(&chan->lock, flags);
