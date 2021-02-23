Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9863224FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 05:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhBWEsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 23:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhBWEsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 23:48:01 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 20:47:21 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u4so16134352lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 20:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TR1Ebr28GfdgahufOQrB/drWR7HsROYX0I7LCagN07A=;
        b=HvMaDXFPpr3Xx75I2KZJKnYltR2SiDXIuL/Fr0kaKq1wdehMELe48z3jWrXhcgDILq
         m0uotVbBuXtFGJ/rUIqvXFg99fzyb0va7FoUYYTbVory9X6wRlmzNqKwcTnfu2Y69AR+
         KAuYyqwEg7l8V95CNC6yyF4iUaSCDzH2euasfg9J//bfumJIENtaPLTiI6G6JeYL95HB
         v1gDIzuKn+bAYW5917kNpaqevoxHRVODTJqJSRl6mHTn7La7WQFINN9q2RKuPiQAZWPS
         Jka11pZoQFP2yqM4XG7c0mjofFQHtJcL4H1ubDMLXHbzilRJyJk9vbCRnocM7YPGEDUX
         5zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TR1Ebr28GfdgahufOQrB/drWR7HsROYX0I7LCagN07A=;
        b=EIZFuF2UqqfpDpwm70MtcVwad6dKh53ju5x8C28bbHCDOF6JNHC/nyrr4xoS9eA88J
         Yru6qQo6F5zfKRUMyO8EunyUkmcjqOwbQeUGEi6vhGVOwpLICEgVYm3dLulo5qD6lqrS
         NAzYhsTvSaTSWFXKS+PQv2Eb86KEeW/1ohv5RxvYljTlpS0KOym68lD0Q27lRv54M9Ah
         NTlc0KoWMO/DDb2fX+Lmw1zPcMU7+WLMyy/MJI6Wp5a2qVbWyLK4RrXK9EkVs+uafIy6
         +AJmOVAjBcMYhCal1CTdGpdksTSoCK2QPWpQtDioF0Je4qkXqG0Tw9T1yw4Hg7PaNMbK
         jWXQ==
X-Gm-Message-State: AOAM530+wm4M6JEijg4/xO8SBVi0CSGtB0ziA1cK4QQLB54/YSlUvo9n
        CDWWyZYkbp9WBsBv3aFZ9fw36uwBJZBw7v+sTHDxtA==
X-Google-Smtp-Source: ABdhPJx2ccmhLjrENwH72Hhc5VHcnpOc/ikOKl0+q+jP/9K0dgnJ7EP1SfhI7EKgdLIRF2SFwZAVBJQjq/yqpe4dJPQ=
X-Received: by 2002:a2e:99cb:: with SMTP id l11mr7060738ljj.343.1614055636766;
 Mon, 22 Feb 2021 20:47:16 -0800 (PST)
MIME-Version: 1.0
References: <1613650198-27437-1-git-send-email-sumit.garg@linaro.org>
 <20210222120502.phazkmskgqvpe4yy@maple.lan> <CAFA6WYNiaeyFHrcTSp6x4ur5VjZAoJ=NfMPsa__dH2VK9ze7vQ@mail.gmail.com>
 <20210222134750.zc473zz42bz4teu3@maple.lan>
In-Reply-To: <20210222134750.zc473zz42bz4teu3@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 23 Feb 2021 10:17:04 +0530
Message-ID: <CAFA6WYPzds7qHMoeG-mLk0r9o3ba+dXCf_zjLNmoVQRdxedscQ@mail.gmail.com>
Subject: Re: [PATCH v4] kdb: Simplify kdb commands registration
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 at 19:17, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Feb 22, 2021 at 06:33:18PM +0530, Sumit Garg wrote:
> > On Mon, 22 Feb 2021 at 17:35, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Thu, Feb 18, 2021 at 05:39:58PM +0530, Sumit Garg wrote:
> > > > Simplify kdb commands registration via using linked list instead of
> > > > static array for commands storage.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >
> > > > Changes in v4:
> > > > - Fix kdb commands memory allocation issue prior to slab being available
> > > >   with an array of statically allocated commands. Now it works fine with
> > > >   kgdbwait.
> > >
> > > I'm not sure this is the right approach. It's still faking dynamic usage
> > > when none of the callers at this stage of the boot actually are dynamic.
> > >
> >
> > Okay, as an alternative I came across dbg_kmalloc()/dbg_kfree() as well but ...
>
> Last time I traced these functions I concluded that this heap can be
> removed if the symbol handling code is refactored a little.

Yeah, I also observed symbol handing code being the only user. So, I
will try to rework that code and see if we can get rid of this custom
heap.

> I'd be
> *seriously* reluctant to add any new callers... which I assume from your
> later comments you can live with ;-) .
>

Yes that's fine with me.

-Sumit

>
> Daniel.
