Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB9144EB52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhKLQ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbhKLQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:28:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6293AC061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:25:53 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b15so39620504edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zc6/D8A6OoLGTLG3Ag9ZYYK98oobJ6U25ZjJVPaE7hk=;
        b=ym7pDYzINzPaw+6DFwJNWPgLAwRziuTF2jyD/pXq+pSaRrfvDmz0G6i24u2a+UV3ue
         S6au1GsDBK5IVcb8AMfTMBu73SIVvhfnAXtppqaGP/9/+fBRqCRwt2CA5AwjnOwjUu2t
         6iyKmY6YkS4EOiFH3SNjSWaRNe6PjUrFJnIau2DVOIpRh2eJRaK/nD+NZ+6Qr1edRJGQ
         McskVpqt+TS1VXLreJQ7DjlEM0ob5LbxY70a3j/MHX+bPiChoQD4BMlb2ATwyG8QbShj
         Iledyiik0aSffP/fa+oWhNgD5IEJ7VRZVEbv5Sozr9LQjEjOJxnnhsxxw0XCkAz/quRu
         Nb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zc6/D8A6OoLGTLG3Ag9ZYYK98oobJ6U25ZjJVPaE7hk=;
        b=QdlnPqmCe/NqUWBILB+pQf3b0xbFHfC3eW/uOizyrHjEICVXHSRVBtZxB6Yds6rH60
         vE+ZNBn9wv908TYnm9GVOorohq/0IC1txQ4Crhr/gbTQIkWqWoXvfte9URKTRf8iS2fq
         wm41ZjqSyndDkPw4zUSdrqJzF/Y2ra9IsGR+V17pJ2AElcqkkjneNBrBTFcdx5VzbyPM
         kxkZL2Rw5tycLB5ACBfwpgqKIaKpxbZp9w3n4yjlbaRZz3zSkh/nmmCqXnpXt0XVD2RH
         GuiCpP4EAc8IL//xuY0PVaENiVGCbmhaamNIliEkW9UdfBcE7QkpHB9MSDprSoU0Gl4e
         b4mw==
X-Gm-Message-State: AOAM532yHG4/eKxRHP5P4UxKCcZLEBQBUCr9+Rmyky9LQbVPWdDp9y7I
        rKOXFxRmZHl4jo8QyUy0Zfogxuy1B26PGfpCGHmqj5+vahaeEQ==
X-Google-Smtp-Source: ABdhPJwmu3YcoRsdUIppax2O91mtfKxqppW0ZPZAUeXLuXIkM5iVXwX2MhmgOplDi9CK4zgmpKO41DsXZ0SIePRTWZs=
X-Received: by 2002:a17:906:3056:: with SMTP id d22mr14297972ejd.548.1636734351915;
 Fri, 12 Nov 2021 08:25:51 -0800 (PST)
MIME-Version: 1.0
References: <CANLsYkyLgvMDx-CMLZPEdJ8rUuGX-=QgB++5fz_h_ordm_q1aA@mail.gmail.com>
 <20211112021310.19493-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20211112021310.19493-1-mark-pk.tsai@mediatek.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 12 Nov 2021 09:25:40 -0700
Message-ID: <CANLsYkzsoXw8vCC-OBqHyQv216Rbjf9ZR7FuFK-zxC7gMzt9Kg@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: use %pe format string to print return
 error code
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, matthias.bgg@gmail.com,
        ohad@wizery.com, yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2021 at 19:13, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
>
> > Hi Mark,
> >
> >
> > >
> > > Use %pe format string to print return error code which
> > > make the error message easier to understand.
> > >
> > > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index 502b6604b757..2242da320368 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -575,8 +575,8 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> > >                                            dma_get_mask(rproc->dev.parent));
> > >         if (ret) {
> > >                 dev_warn(dev,
> > > -                        "Failed to set DMA mask %llx. Trying to continue... %x\n",
> > > -                        dma_get_mask(rproc->dev.parent), ret);
> > > +                        "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> > > +                        dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
> >
> > Macro ERR_PTR() is used to convert error codes to pointer type when
> > returning from a function - I fail to see how doing so in a dev_warn()
> > context can make the message easier to understand.  Can you provide an
> > example?
>
> Hi,
>
> When dma_coerce_mask_and_coherent() fail, the output log will be as following.
>
> format          log
> %x              Trying to continue... fffffffb
> %d              Trying to continue... -5
> %pe             Trying to continue... -5        (if CONFIG_SYMBOLIC_ERRNAME is not set)
> %pe             Trying to continue... -EIO      (if CONFIG_SYMBOLIC_ERRNAME=y)

When failing, functions dma_coerce_mask_and_coherent() returns -EIO.
Casting that to a (void *) with ERR_PTR() does not change that value.
Since variable @ret is already declared as "int" the real fix is to
change "%x" to "%d".
