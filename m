Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8183F2020
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhHSStM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhHSStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:49:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45685C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:48:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i22so10213002edq.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjbE8dDIaIUgzdZaz+RPCI/Kf8NJbpFvZVoKah4zvi8=;
        b=JhBy1tV0enTZ9Rmy8mKzNbO0mto+GTLyhSdC4UEDTypY5GhZCKt+AkWt4JHbvLHdYv
         DXbJG4gOA7bY6pwVD6GyxTVR4GqNW9Ow9i4CBzZVeyBrlbMmDUQvIK5+IidCWMxSdIRZ
         2jV53BIQyqmuawgi+L6w/vaHM/2wCYRQux32H1qNB+ZcwVnm6yNcNZF8vqYiy2sw5dpx
         0kta7hKPPbNLwutTKSwcGYBngkQl0R0bnpcpueu64jmR8X/4N/K7QU4TAqPq9AvUI8b4
         8WMM9KXWkautuUJlfRBmr7vAzW4aWkRDYFAeaGDRlu65Y/NdRi2xnFXPQawFQP1Z5sOd
         S2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjbE8dDIaIUgzdZaz+RPCI/Kf8NJbpFvZVoKah4zvi8=;
        b=jy2HjMoO7gBpYecYzG7GE6dXbx3KPpr4YchTqLnPbtIa4OTRiFwaHrd/l+WkwhtA1h
         ZqKAfygov9GJc1hrDHsVfUDBUFE0jYJh56kcEA6pdSpTVyXWn7AAJcCXkOJ7Ij4K7UMH
         rqUaWUE3VaGQoGv8xvrw/JjiJL/3iuScuiBGzELXz3tIt412QN1lXqpuTwdu2BRf2D1J
         uyAwBe0esOp4cUB1qeb7L6HD4nKyn1VlamjZQxv8kWS9srclpxSyGYp+GswgBg/aiIxZ
         i35O5a/os3b63rSBSfcF5ZjZ7qFe6/IhFjqb7VkbtTfc4fbXeC7HXfKEITxDZ3U/Pg8C
         ELGA==
X-Gm-Message-State: AOAM531RQE93aP5G7PPNLVsH31gg/EoEfBTjQUZsTfcqnFcEKWFKHUJl
        7kaBmWWgy3U0WFX5prPlr0MMBQSvYkNWBnbLmJY=
X-Google-Smtp-Source: ABdhPJyGdssXcKgQ8dfScHyGkqmVxpfCizczWCR1KUyAyH0VFuLXWqtJDr5bWoGBXFr2Kxp9MEQuZ/x9bh8UEITa7lU=
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr18154945ede.78.1629398909839;
 Thu, 19 Aug 2021 11:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210819110209.GA115485@ogabbay-vm2.habana-labs.com> <YR6PIvwYbYG20ZY0@kroah.com>
In-Reply-To: <YR6PIvwYbYG20ZY0@kroah.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 20 Aug 2021 04:48:18 +1000
Message-ID: <CAPM=9tyT_iouVE2v8J0SMJOLV=pr=QJOm88ud=bht4=5Ms2Y2A@mail.gmail.com>
Subject: Re: [git pull] habanalabs pull request for kernel 5.15
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 at 03:07, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 19, 2021 at 02:02:09PM +0300, Oded Gabbay wrote:
> > Hi Greg,
> >
> > This is habanalabs pull request for the merge window of kernel 5.15.
> > The commits divide roughly 50/50 between adding new features, such
> > as peer-to-peer support with DMA-BUF or signaling from within a graph,
> > and fixing various bugs, small improvements, etc.
>
> Pulled and pushed out, thanks!

NAK for adding dma-buf or p2p support to this driver in the upstream
kernel. There needs to be a hard line between
"I-can't-believe-its-not-a-drm-driver" drivers which bypass our
userspace requirements, and I consider this the line.

This driver was merged into misc on the grounds it wasn't really a
drm/gpu driver and so didn't have to accept our userspace rules.

Adding dma-buf/p2p support to this driver is showing it really fits
the gpu driver model and should be under the drivers/gpu rules since
what are most GPUs except accelerators.

We are opening a major can of worms (some would say merging habanalabs
driver opened it), but this places us in the situation that if a GPU
vendor just claims their hw is a "vector" accelerator they can use
Greg to bypass all the work that been done to ensure we have
maintainability long term. I don't want drivers in the tree using
dma-buf to interact with other drivers when we don't have access to a
userspace project to validate the kernel driver assumptions.

Dave.
