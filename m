Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C702E3689A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbhDWAHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbhDWAHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:07:53 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DCBC06174A;
        Thu, 22 Apr 2021 17:07:17 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id dp18so18372366qvb.5;
        Thu, 22 Apr 2021 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfM3d7LOiLS9qmGDziTRg1PSfPwhJZSu7g8WxAmeWYU=;
        b=CPLFUXiNh4B93n9Xa5TPQoafBuJO+Xzvo6rwK5wfYF3Lpx9T05KuYCVSKj9fJcrIJG
         QwBAnHWwPqlV2hBpDeOEawH0udkeNH6RtSJb4e89xjKokYFgoFRYLVkoio1Rg52snfp0
         3b2R+eu7uryyY++tta636sg60TtoVc1+IKtRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfM3d7LOiLS9qmGDziTRg1PSfPwhJZSu7g8WxAmeWYU=;
        b=DnL8qseHJ68Mc8GZktbMoV0eoY5PURw0cH8/1simvNWvHe78O/v5D2nJUEalU/LEJ/
         Ki5g3wAAoHRnryi1KN0/gI78x6hQbYRpLBSK2cBQXvij7SLS6rg05xJQKuU4YTe3/Ale
         ZoPpGB/KqOH6zm6qjQOvgF15W+RTdvsIpALgd6TF+LWuqqoD7AkUJc/WrAnY+WVB2V/G
         VfIk2fd7mZIHwf5TXhQtDvVw1XGeYwJncPfBO3Xs9Jdr4pFz/Nnn3xQ2pxXFeUnfq/XO
         RboAPqrbyHDJjFxTWNw98cwpRClRogEv0+Ib4XD3jp1kUFkVZ9DX84qHQpo5yNW1n/jG
         QcmQ==
X-Gm-Message-State: AOAM531SiH2IwyfWtMaNX+WP5ntCaLeI+OorWAK2YX8MnibdgS2nDuui
        MQRaIilUepUM0SOx14jcpC4VDM8OeJtY6IzEHkQ=
X-Google-Smtp-Source: ABdhPJwzrmIHJN3KSKdUfPi114SsARBXFjKZOnUsANQ2c4AII3cxjV1HF1foJ0rKi1mBguFhLOW4GX9GnFoT5okPR5s=
X-Received: by 2002:a0c:eb06:: with SMTP id j6mr1253747qvp.10.1619136436827;
 Thu, 22 Apr 2021 17:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <YIE90PSXsMTa2Y8n@mwanda> <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
In-Reply-To: <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 23 Apr 2021 00:07:04 +0000
Message-ID: <CACPK8XcOkQms8UpRZiansyRfmh4HmrrGN178x7sOEAarNM4u1w@mail.gmail.com>
Subject: Re: [PATCH] soc: aspeed: fix a ternary sign expansion bug
To:     David Laight <David.Laight@aculab.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        John Wang <wangzhiqiang.bj@bytedance.com>,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Patrick Venture <venture@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Lippert <rlippert@google.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 at 16:21, David Laight <David.Laight@aculab.com> wrote:
>
> From: Dan Carpenter
> > Sent: 22 April 2021 10:12
> >
> > The intent here was to return negative error codes but it actually
> > returns positive values.  The problem is that type promotion with
> > ternary operations is quite complicated.
> >
> > "ret" is an int.  "copied" is a u32.  And the snoop_file_read() function
> > returns long.  What happens is that "ret" is cast to u32 and becomes
> > positive then it's cast to long and it's still positive.
> >
> > Fix this by removing the ternary so that "ret" is type promoted directly
> > to long.
> >
> > Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > index 210455efb321..eceeaf8dfbeb 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -94,8 +94,10 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
> >                       return -EINTR;
> >       }
> >       ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
> > +     if (ret)
> > +             return ret;
> >
> > -     return ret ? ret : copied;
> > +     return copied;
>
> I wonder if changing it to:
>         return ret ? ret + 0L : copied;
>
> Might make people think in the future and not convert it back
> as an 'optimisation'.

I think the change that Dan posted is clear.

Thanks Dan! I'll get it queued up.

Cheers,

Joel
