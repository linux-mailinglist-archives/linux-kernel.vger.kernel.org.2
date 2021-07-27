Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA13A3D6C06
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 04:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhG0CAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 22:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbhG0CAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 22:00:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35600C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 19:40:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jg2so14806326ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ga6EP0dN9km7dxNecAl4PtCHmGp173gIeL5w4bdLB4=;
        b=gJnzI/97SVmBuzkUIGxT3A3JZKB6W042yoLsuWCSWLcspd2R2XppOHdF8Kaghqt+iV
         AwEPLQ4jR1hmio8AKR6VFsSNuFyOK+pJ5y5xF9+anBmokjKFelGNG2mjViJSBdbeTTSY
         WQK58AlUbC6Iz76QweAVpA/VyqHaN7Wq+EtpuJ4N/33e8BglsthTCHr0+xI718ZLZK5G
         duGUMeZ8hRuR87h2BlZVgy8RHYxp1UPlqnf0VcJroOJrpjYnklMFITvFI109wJ1p6JqJ
         16p6d9Bg/HHQXkU84TqzoxtSyhdz9ArQI1oIRklIg6XE1EJXxrlvou6X050IgdRt92Wi
         YV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ga6EP0dN9km7dxNecAl4PtCHmGp173gIeL5w4bdLB4=;
        b=UT0apJVrWZNAx+Q7IhjPP1kW2j2htBlNkTwPDvWsED6tm/W01Aoe3JLqAIzCQRfwwD
         k76FyIrCd4WMx0OgcZ0M0AzXUaI8EmhGc/iL9fdZMrOYtD7ufekCq32dIYIZoJ90FD1z
         4HHqzcpLP2+47Ajxw8XoPMi0UEdqKXJ8R1T1VmI62rJYmaT77yNAHxvVW2NAB049bF95
         ZKBMc6VNutvyPKTVxrTeHQyubbB6mI5svyCOZHrxH8IEb1szf1dd8J05D3okEp3ujJT+
         vRSLM1jz5hdBfOQLxOMaIgGC+b6Y8m8PNuB5vBKJ7kcDmkPpt9vqtAETIWHktM4hMFpq
         yrGA==
X-Gm-Message-State: AOAM5331lkN8ZpsBYpWADzhCZsCjQzyrV8tZYhciP6QpjUzEYCtKDf/1
        3nQhsBHlZL5SmeMkx2kKUFM++FsrRrS8X8ob90fF
X-Google-Smtp-Source: ABdhPJxmCswOKQhLsdjLkMVZ7ZPq4+vWeLlea82jss4KKS5/ylmNXT5nBANkzQKsxXD0JbrLeeLz4UT2En5SFdO3uwQ=
X-Received: by 2002:a17:906:3915:: with SMTP id f21mr13752605eje.178.1627353638765;
 Mon, 26 Jul 2021 19:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625900431.git.paskripkin@gmail.com> <53de0ccd1aa3fffa6bce2a2ae7a5ca07e0af6d3a.1625900431.git.paskripkin@gmail.com>
 <20210726141140.24e8db78@gmail.com>
In-Reply-To: <20210726141140.24e8db78@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Jul 2021 22:40:27 -0400
Message-ID: <CAHC9VhSyahhK3Hk4vUkWzshfwX22MsHTd6SWULy7OxQ2HvwNLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: cipso: fix warnings in netlbl_cipsov4_add_std
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+cdd51ee2e6b0b2e18c0d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 7:11 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
> On Sat, 10 Jul 2021 10:03:13 +0300
> Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> > Syzbot reported warning in netlbl_cipsov4_add(). The
> > problem was in too big doi_def->map.std->lvl.local_size
> > passed to kcalloc(). Since this value comes from userpace there is
> > no need to warn if value is not correct.
> >
> > The same problem may occur with other kcalloc() calls in
> > this function, so, I've added __GFP_NOWARN flag to all
> > kcalloc() calls there.
> >
> > Reported-and-tested-by:
> > syzbot+cdd51ee2e6b0b2e18c0d@syzkaller.appspotmail.com Fixes:
> > 96cb8e3313c7 ("[NetLabel]: CIPSOv4 and Unlabeled packet integration")
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com> ---
> >  net/netlabel/netlabel_cipso_v4.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Hi, net developers!
>
> Is this patch merged somewhere? I've checked net tree and Paul Moore
> tree on https://git.kernel.org/, but didn't find it. Did I miss it
> somewhere? If not, it's just a gentle ping :)
>
> Btw: maybe I should send it as separete patch, since 2/2 in this
> series is invalid as already in-tree?

I'm not sure why this hasn't been picked up yet, but I suppose
resubmitting just this patch couldn't hurt.  Don't forget to include
my ACK if you do.

-- 
paul moore
www.paul-moore.com
