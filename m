Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D03E4FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 01:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhHIXKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 19:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbhHIXKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 19:10:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CDBC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 16:09:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id by4so8420998edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3zFEfwSvu2lCFCDnTYZyC6wVPdpg5L3usB0NyuTAPM=;
        b=ofcFqG/XsKzr6mordKLjkSW568uPpGyt7ViMBd0W+9i5FVzj2z/NWmcYwIuXKk2myW
         FzQTKHMKyq19ViIOgZ7fSvyo5iSs8IvhFFMnPmViEEajXfqZ00E9bHu3cbaqATJOOorr
         /dG9Wryld0zNzWJvHPcpd9jXqZMO2DeYTQ0R/5No/uZ09W3hnlrityWkJqi1v0UrZyEv
         K8eHYFtBBJq78hzQ3wfkp1IzWSwOBEggdxLmw0HvSACGjRySLOOA7R7IUW6VJLpeKITH
         TXVKBBHgv0TY2mNOARD4U06P9jQdGvFnegNkYCa0I3FpseJIWD9OkpeO6KeAjDmd3LKp
         YPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3zFEfwSvu2lCFCDnTYZyC6wVPdpg5L3usB0NyuTAPM=;
        b=N8knwlZg/Srwp+n5znJ3pl3R6zu06Tl33Twj1ZEWwTucm4tjyAGWVn4YudiaRbkqkQ
         pfXMRRZKIFlma+OkHLn/RNGvo3nxyOlOrIMB4KxrYf78SRAYSWNKuD/E8L9sRFfxl/LN
         arS5rMQ6OBq6BHN1QjXplh0xp9k81jX77yDtxsSGAqWUsSwmwKlG2liCkptlyQ3VZGjU
         aSai7Ojco0FdQQsAtcjfEQ5NLiT6qyAPXu+AEkR+jx7X8DdleKVH51R56izKfCeGUbdL
         75Y8eMzlaRveowA+dRsUpCmcadElULH2BKz+vITmvrtIQRRugElWAftOlsqQ8NmLsOed
         GHCw==
X-Gm-Message-State: AOAM530zImEkTwAC4WnNlldTWsiWJgxygDhUlY2e9Cn43jl4oP2YqexN
        V/DC4P6bE/80YHopKjymTg5Gtf5ATx5jzMqY0hs=
X-Google-Smtp-Source: ABdhPJy/CMRTJAfOdtkU+EEdTvKZPaa/ebdH5NXqOStLIC0QCIxSTiBhhnKC/nsbV8PxtZW3M2nibADYjuvi/Z1qrFY=
X-Received: by 2002:a05:6402:28b0:: with SMTP id eg48mr902528edb.241.1628550581620;
 Mon, 09 Aug 2021 16:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
 <20210809143049.3531188-2-mudongliangabcd@gmail.com> <YRFKnvN+jUoOaCiA@kroah.com>
In-Reply-To: <YRFKnvN+jUoOaCiA@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 10 Aug 2021 07:09:15 +0800
Message-ID: <CAD-N9QXn3K9J+pXtTW08_ty0m9AbWWdWYppnbezBTRRtCNKGWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ipack: tpci200: fix memory leak in the tpci200_register
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 11:32 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 09, 2021 at 10:30:27PM +0800, Dongliang Mu wrote:
> > The error handling code in tpci200_register does not free interface_regs
> > allocated by ioremap and the current version of error handling code is
> > problematic.
> >
> > Fix this by refactoring the error handling code and free interface_regs
> > when necessary.
> >
> > Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > Fixes: 43986798fd50 ("ipack: add error handling for ioremap_nocache")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/ipack/carriers/tpci200.c | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
>
> Also for stable?

Yes, it should.
