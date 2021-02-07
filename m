Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546F7312348
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBGJuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:50:35 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1109FC06174A;
        Sun,  7 Feb 2021 01:49:53 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id t63so11599011qkc.1;
        Sun, 07 Feb 2021 01:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYzO838l1olFuso01/LKL9EKMqYrX52CmTrPsMkBDNA=;
        b=PH/nShvusjxGG+pD98o6NOty7igDMLoVCNcNMmmjFvvckGRm0oVqX1c7mx4J+ayJWh
         PCIX7g4Xc+nZmsDqDERSkx7dzoHKAYcxNT61mIYdBwx1hNy5ilCwTdXXMmpzge2a7KDK
         /xi3ULiq5Msm+qvMpLhHXO57vX/3f1spJxrUgaN85rDrp1w1sEvYzsGlrcd6+YucJMIy
         xpjwb12qxSbsE5rw/WD7sQZxYc1mDD1QGoIma/VOnbQFQvTBcXaa5G0spS8BW5vttuJ0
         3jcB9pb5TAKYjnK2JM/uBfQzOfoWGRZxdExX+a70dnbh3NnbAcVXlKL9exdZ+2Bb8IVh
         24EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYzO838l1olFuso01/LKL9EKMqYrX52CmTrPsMkBDNA=;
        b=QOxlIBKVxZMnT/VPGfpsr7havxV5axs4/scDjfu3/erq2HSE6PdGgnOefTKCLQZKKk
         PEJ1hl3Coespv/VvA+aWEw/84k+8mvj14ibxsPa5Gbh+VLr2D38n9UMm4Lj4tE13wTiR
         FNEbmin81+h6Mt7GQlBBJHYIeZ/8gDem8bmB/83HUNh1cUBE1CEp8d+dSZERZbVt/1Tx
         QjK2+cqoENWFVwiMtU8cC0uEsyr8ggQT+LU9qigrHciVdgml3jHY7yQGE0br/rcFz9hy
         yxvf9/vR15EMyuRRjY6+LiaWGKxhwXYpsA7OKxmr00wvfb4EQLcA/CU7t7wuNgN+Qjwn
         aj1A==
X-Gm-Message-State: AOAM531Ym5thH9kUsxGDPeJAgO+0+GLIx2PmNNLR2xceaLNXodw8GYPN
        3/taTzUdb4L3qUnYzFenJp3R8U9IDwk4hSXUyAk=
X-Google-Smtp-Source: ABdhPJwBFvr9P32/Q0z9GRaRw15XheT3/2z/Vbq8+UOXhCI06iB1wVa/pcAviEiXyvpKDJQ/NID21lMi+PuAC/mGLuk=
X-Received: by 2002:a05:620a:14a6:: with SMTP id x6mr11806815qkj.152.1612691392406;
 Sun, 07 Feb 2021 01:49:52 -0800 (PST)
MIME-Version: 1.0
References: <1612508250-10586-1-git-send-email-shengjiu.wang@nxp.com>
 <1612508250-10586-5-git-send-email-shengjiu.wang@nxp.com> <20210205142516.GC4720@sirena.org.uk>
In-Reply-To: <20210205142516.GC4720@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sun, 7 Feb 2021 17:49:41 +0800
Message-ID: <CAA+D8APye40DiiYtQbsaM0X5vt4-4z+=YAvf-aSHxzvBk=aBfA@mail.gmail.com>
Subject: Re: [PATCH 4/7] ASoC: imx-audio-rpmsg: Add rpmsg_driver for audio channel
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 10:27 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Feb 05, 2021 at 02:57:27PM +0800, Shengjiu Wang wrote:
>
> > +     /* TYPE C is notification from M core */
> > +     if (r_msg->header.type == MSG_TYPE_C) {
> > +             if (r_msg->header.cmd == TX_PERIOD_DONE) {
>
> > +             } else if (r_msg->header.cmd == RX_PERIOD_DONE) {
>
> A switch statement would be clearer and more extensible...
>
> > +     /* TYPE B is response msg */
> > +     if (r_msg->header.type == MSG_TYPE_B) {
> > +             memcpy(&info->r_msg, r_msg, sizeof(struct rpmsg_r_msg));
> > +             complete(&info->cmd_complete);
> > +     }
>
> ...and make this flow clearer for example.  Do we need to warn on
> unknown messages?

Thanks for reviewing. I will update them.

Best regards
wang shengjiu
