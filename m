Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1C33E57F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbhHJKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbhHJKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:06:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8620DC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 03:06:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x14so6864386edr.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NI43gDB60J+hHIWn2wpRcQ4Y1SAABWtayYuScdI0xvY=;
        b=PBTQHuG5H7i5fq0usxFdSK7q/FRoT35VVvSoCAz0vlGvD2LY8wTC6JuD4VJPhMn0DG
         7Yi485m97djxDTVz/bVjTiPbVoqM6awETH7FPVPYrCQcTVzeyUwSX6GD110pA2ighG99
         /wLbBzo3g35axHdbDkcXQHkG1rKyEjoc8cZ3afockTrgcCEYKeJbiT99NLhUy1YKzr4V
         cvPWp0ziyCDecSSLeKaDUc+KhPG9WmvP05F6WDRKVdO1mz0AvYtxaVUPld6dd0gd72PM
         QqAIrfmWn/xtknCgxRd6otZc6NeXRrvgbGCMv8B1NleoY1bsA03ltPWxGc/ZgUO8ob8A
         Q/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NI43gDB60J+hHIWn2wpRcQ4Y1SAABWtayYuScdI0xvY=;
        b=AsF7+6NMTIQSNb+yDLk3isTfRtJg97ckrqBE8zHkdxyIioFBF+LAW0fg6ADOHnbFms
         lV6FieMnClaq3UC6xrSt36RniGb1KUnUOALyyUd6rqcSyFZ0sKbmTMv+AYPfN+2Mzej0
         AfiXaJeRqoHLWE15WPJCf/j6gzl4YFYpO/XEewJVmORza6zjsV7PSxQsvsE3lpzIvINw
         QoNHysvW6Xl9qUdKPGfb5Y9BkOOFoVn1xIkxZvAhyGmDeNFymYxJKHpS89kTo7D6riGf
         Q3aK4Xb42YptwoAov2kTVVw7i9+0/FSOviCnexpA/2nhokdq2a4MbWJW7kalNr6qNB8L
         pzgw==
X-Gm-Message-State: AOAM530rcqDPIKNYQxWf83re9wsFQx6XBA70PjA9CNy7s24HWxkkFKS0
        3nsdy6BDqELdV7/AJVteq3RNWb8qUwklGiW6+2A=
X-Google-Smtp-Source: ABdhPJzwQV91mh4Q/+ptmYv179euaM8lt/V2Cgz4w/LBwdDZdQqdbPmJ5DlPgfN1SLf5XyCGBKfrrKLRrWllXPA5TlI=
X-Received: by 2002:a05:6402:1648:: with SMTP id s8mr3897310edx.214.1628589978156;
 Tue, 10 Aug 2021 03:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210810074932.3934499-1-mudongliangabcd@gmail.com> <YRJMssKBFeToLvKi@kroah.com>
In-Reply-To: <YRJMssKBFeToLvKi@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 10 Aug 2021 18:05:51 +0800
Message-ID: <CAD-N9QWBm01QMWHX_onMdO6mi+9ROF_MJMmg1Juxa++4eJVeVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ipack: tpci200: fix many double free issues in tpci200_pci_probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 5:53 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 10, 2021 at 03:49:21PM +0800, Dongliang Mu wrote:
> > The function tpci200_register called by tpci200_install and
> > tpci200_unregister called by tpci200_uninstall are in pair. However,
> > tpci200_unregister has some cleanup operations not in the
> > tpci200_register. So the error handling code of tpci200_pci_probe has
> > many different double free issues.
> >
> > Fix this problem by moving those cleanup operations out of
> > tpci200_unregister, into tpci200_pci_remove and reverting
> > the previous commit 9272e5d0028d ("ipack/carriers/tpci200:
> > Fix a double free in tpci200_pci_probe").
> >
> > Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > Fixes: 9272e5d0028d ("ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
>
> No cc: stable markings on the patches?
>

I am sorry that I usually ignore that tag. I have sent a v4 patch with
the Cc tag.

Dongliang Mu

> :(
>
