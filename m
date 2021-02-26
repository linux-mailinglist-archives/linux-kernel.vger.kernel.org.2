Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33DB326752
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBZTQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhBZTQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:16:17 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46853C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:15:37 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id x19so9983184ybe.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmNPihVYfoHDM3Z6zETchBPFQqTyDidGTwTaEWOkuxQ=;
        b=hnEtnl8Tz18q1Pms6/HbWvyKXM387au2eBsjS3MlO8e51EmZqW71Rw+xE3xtL9zZdm
         e3E4UWmHGKLED5x88gts3yc9id4jGA/I5H+Z6GRboxJTK2KXJhus2sJH1LCX4pI99Ypz
         0ULD1F6YRjcs3RxkgX43DJGsYE+2fLhz+0rY6ASAfspRMpy9M6jAUCoOI5GdMgBQ3DfI
         tPKWjP0Y8IxOh91iGhyMQqGASJJOSDFW3477y43CJF//+DmLZIIV3q8oImcNmf5RLUVK
         Vajp6CFqIgIC1nSRGXmbvLhD1rhrerVkOklhrDXChSplRLf5/X21gvZOhzLrplVGRb9m
         kl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmNPihVYfoHDM3Z6zETchBPFQqTyDidGTwTaEWOkuxQ=;
        b=Sgd9dqo4XOZmZCJ3yOPy5O9Mo+1ZLv5UlkntCr4U701dNeCn6KalUy4SzXYMSaWhbJ
         0Hklov9cK/ekNDuMew/ME9474Sih/Qb3k4LZACHoo7ltx7hERsZv1mOZwjSmnfaqIPEo
         oVd6dUvWsq+AR6zdYPXUcyVwLFA5mvQnF21iLQXY4FY6R5jVHzn0KJp+EH6O465ws0Uf
         UeXN2J21TKMdRM5b/E55j+8drMg9Le5Ki2o07oZGJ9zkQ/1p3KuhR623Oglm0vFmR0Ao
         n6gpATFirm9r1ehWA/yXymS7H3D6EA+wMKF8MqL/QOsKBdOHTUK9mPV4b1KivLnLrvAL
         krHg==
X-Gm-Message-State: AOAM5310MkpXnGdP7kK6a/124pMZcbq9KVKTbJxXmY+aPRSj4zxXsx/1
        gvjzuQ3X2LAifJAkMHX5Jd7D+b2wwCPe8je5QCh2zA==
X-Google-Smtp-Source: ABdhPJwGyUYN9fQQ5qT1ybP2TfMSmigM4iMawzKtDdjz8mYVhaStq7qHukjcUzSeHaMa2zFPGI+scsfDJeMq+pa95BE=
X-Received: by 2002:a25:2a04:: with SMTP id q4mr7129613ybq.412.1614366936409;
 Fri, 26 Feb 2021 11:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20210205013847.1736929-1-saravanak@google.com>
 <CAOMZO5DRjT4d8gzSZZX4itcOXO_pye-1aq658EX2vQJ5xhEi8A@mail.gmail.com>
 <CAGETcx9E+dw3HS+DHMhzbrQGcrT6z4kDH=ziS=1=i-7=0rLwgw@mail.gmail.com> <CAGETcx9r5=zZZ445ou3Vd0hWCfb_HH6bHnE_XMTAWwvr7bW=OA@mail.gmail.com>
In-Reply-To: <CAGETcx9r5=zZZ445ou3Vd0hWCfb_HH6bHnE_XMTAWwvr7bW=OA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 26 Feb 2021 11:15:00 -0800
Message-ID: <CAGETcx9VJjxej1TD3sX_u+U=CPiFfqxykqoy4tCeqhFkxyMOAw@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: avic: Convert to using IRQCHIP_DECLARE
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Android Kernel Team <kernel-team@android.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 6:33 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Feb 4, 2021 at 6:07 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Feb 4, 2021 at 5:54 PM Fabio Estevam <festevam@gmail.com> wrote:
> > >
> > > Hi Saravana,
> > >
> > > On Thu, Feb 4, 2021 at 10:39 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > Using IRQCHIP_DECLARE lets fw_devlink know that it should not wait for
> > > > these interrupt controllers to be populated as struct devices. Without
> > > > this change, fw_devlink=on will make the consumers of these interrupt
> > > > controllers wait for the struct device to be added and thereby block the
> > > > consumers' probes forever. Converting to IRQCHIP_DECLARE addresses boot
> > > > issues on imx25 with fw_devlink=on that were reported by Martin.
> > > >
> > > > This also removes a lot of boilerplate code.
> > > >
> > > > Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> > > > Reported-by: Martin Kaiser <martin@kaiser.cx>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > Tested-by: Martin Kaiser <martin@kaiser.cx>
> > >
> > > Thanks for the respin:
> > >
> > > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> >
> > Thanks for the quick review.
> >
>
> Maintainers,
>
> Is this getting picked up for 5.12?
>

Gentle reminder.

-Saravana
