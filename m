Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C24039E50F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFGRQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:16:45 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:39548 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGRQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:16:43 -0400
Received: by mail-yb1-f175.google.com with SMTP id n133so26073216ybf.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2sWRLPG/DuNEAApAcldlJg7iaLltjLRByHQl8QTub4=;
        b=axEtG15SmqLs7cRNPDLxPP0ciJMdYGvPisyOVlNwdgBchw8u7c9ZLFQF8q9XZAXoVe
         fSawLJJMvid3wqDthM8MS+dv+N16Q8Q1NCqu9twv7JgSEKSNAn6T4fic9im8N11+LqNJ
         zmUEHLkSSiFVUbSyObu4y2pqLoEAPCFW9QSt2NEbzreKnPbV996Vg95fVGUYbuBJkjYj
         4Q3TbZCJ8Cpk/Ny1jgKI4BPFw6jxmQgeB9af2njqnoPapJTq2BP4+6KdvTwrEavFFKs/
         FkOWHsxfPb8gYdnmITfIYEPtAPmcaSg3LQtFgyto+9LwZq3NnxxkYWHeSksL39NGv459
         vOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2sWRLPG/DuNEAApAcldlJg7iaLltjLRByHQl8QTub4=;
        b=gZrE3GNhWBImDKpNT+l8ggWjqR029zjlfsmgPRoJcSAoU4cLsXoACwwIGbr+xlNBJH
         FkPS2dWzy4u2OnCUDX/A5a6+17TxiVE+kn8kt1G7pW9RxxcOEQ0CzF5MuJ4mv2wvC/mo
         s4x6DSMgRBSgtTqGPbbD6n56GfyfoGcxivPsPHfrzRuyVHcb95AgjTbktf4wjQ8ZiYrr
         CKVtXz1Jb4Xht7DhHYqodYZLyeo82OUnal6KyRY6QmoLUC4vFWqVZHsJfs+eknirLWQP
         nrijVt4KV64+fsB3MApPdv9R0V+Q5657mvFSBEY/GVV9UkDscoGkeUczeyZZWVgI5y0I
         7fuQ==
X-Gm-Message-State: AOAM532hYJss+rY3sTxaRdVqa9dM7jCKZeCJQKILalmiQpw1EpRxdghb
        oVuD/RGN/2ilBCk1KrAvDArLKyLBOMBWJPIC/bWJYA==
X-Google-Smtp-Source: ABdhPJwdmdD7lKRRq8k5XA8hFlIx/dEaUtuNmHO6Lre9fhKf0b+w+tgKMfisGp4de674sb5QMAE3GO/pM514c6iWKLc=
X-Received: by 2002:a25:cbc9:: with SMTP id b192mr26086185ybg.96.1623086031875;
 Mon, 07 Jun 2021 10:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210607085836.2827429-1-megous@megous.com> <20210607114146.ohiqf4ousibfu4wm@gilmour>
In-Reply-To: <20210607114146.ohiqf4ousibfu4wm@gilmour>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 7 Jun 2021 10:13:15 -0700
Message-ID: <CAGETcx-ZH2egh4kNpAL8CTGTVo21nP8aYpU_W+UHZ_GLJDeLaw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/sun4i: dw-hdmi: Make HDMI PHY into a platform device
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Ondrej Jirman <megous@megous.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR ALLWINNER DE2 AND DE3 ENGINE" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 4:41 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Jun 07, 2021 at 10:58:36AM +0200, Ondrej Jirman wrote:
> > From: Saravana Kannan <saravanak@google.com>
> >
> > On sunxi boards that use HDMI output, HDMI device probe keeps being
> > avoided indefinitely with these repeated messages in dmesg:
> >
> >   platform 1ee0000.hdmi: probe deferral - supplier 1ef0000.hdmi-phy
> >     not ready
> >
> > There's a fwnode_link being created with fw_devlink=on between hdmi
> > and hdmi-phy nodes, because both nodes have 'compatible' property set.
> >
> > Fw_devlink code assumes that nodes that have compatible property
> > set will also have a device associated with them by some driver
> > eventually. This is not the case with the current sun8i-hdmi
> > driver.
> >
> > This commit makes sun8i-hdmi-phy into a proper platform device
> > and fixes the display pipeline probe on sunxi boards that use HDMI.
> >
> > More context: https://lkml.org/lkml/2021/5/16/203
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
>
> Applied, thanks
> Maxime

Thanks everyone! And thanks for following up on this Ondrej!

-Saravana
