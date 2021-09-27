Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8340241A03C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhI0UjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235925AbhI0UjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:39:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C6EB610FC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 20:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632775057;
        bh=NeUUzwH/N8Mxr/MptmnO1QpXNuxBYMSvWijcnRAB0rs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dM7a5n6bKskDFm+rcd423iRtrg5HlMw5RYVivLUvqi2jbLSmcL+mOVQXMdd/Qd0C8
         tlgYFY6w0DR9YZVjij4dWFj258tIDdI8NN0eZIJqLpDs35C4+TygQGLcUkOFYvxv4g
         u8yCP/FG/vMBxWCbSv05voHX52ygh8V2EJJZ8rYXV56/YGnCXQUp6J4uTiqJd+NFYJ
         IjU8p2KZ/0ebKvc0M7PptMKv89TOpIuBhfTfBnOfy0XdcXzYeCtiEMheMDRG1yN2vk
         cSJhlzSz7WgN6eQxB/WzgOhO48d/m7ufBt88PYvtDOlplgxL3sSESwBAXOPWRT67Ce
         iO4qUs9sTVBbA==
Received: by mail-wr1-f53.google.com with SMTP id g16so54115966wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:37:37 -0700 (PDT)
X-Gm-Message-State: AOAM530VtM3+p/xseS2Fm2ZoQ50kUkvlfwRb8avdSULgmGD80a/+Hpn/
        6RrlZ3pd4D1c1Uq1ZGdLrr1ow0TFUTrVL1YS4d4=
X-Google-Smtp-Source: ABdhPJyUjAenq8joWGQ+N3TX7sXIr6eIaAVJ4XnFudXXN00YfpEG4fWYLlCkpjLBJK0bxVz4FkbyqI3WSSR4KdJleDM=
X-Received: by 2002:adf:f481:: with SMTP id l1mr2122067wro.411.1632775056188;
 Mon, 27 Sep 2021 13:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210927113702.3866843-1-arnd@kernel.org> <20210927122658.GF2048@kadam>
 <011c53e6-d628-02b7-fc18-ca3165a45f98@raspberrypi.com>
In-Reply-To: <011c53e6-d628-02b7-fc18-ca3165a45f98@raspberrypi.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 27 Sep 2021 22:37:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0_RBc6dCzzGcxzC=g5ODDia-9nQcKROWSPm4jVAJgEnA@mail.gmail.com>
Message-ID: <CAK8P3a0_RBc6dCzzGcxzC=g5ODDia-9nQcKROWSPm4jVAJgEnA@mail.gmail.com>
Subject: Re: [PATCH] staging: vc04_services: shut up out-of-range warning
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 3:22 PM Phil Elwell <phil@raspberrypi.com> wrote:
> On 27/09/2021 13:26, Dan Carpenter wrote:
> > On Mon, Sep 27, 2021 at 01:36:56PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> -    if (num_pages > (SIZE_MAX - sizeof(struct pagelist) -
> >> +    if ((size_t)num_pages > (SIZE_MAX - sizeof(struct pagelist) -
> >>                       sizeof(struct vchiq_pagelist_info)) /
> >>                      (sizeof(u32) + sizeof(pages[0]) +
> >>                       sizeof(struct scatterlist)))
> >
> > The temptation would be to declare "num_pages" as size_t instead of
> > adding this cost.  But then something will complain about the
> > "pagelistinfo->num_pages = num_pages;" assignment because
> > "pagelistinfo->num_pages" is a u32.
> >
> > The next temptation is to change the SIZE_MAX to UINT_MAX.  I didn't
> > do that originally because I can't test this and I was trying not to
> > break things...  We probably still don't want to break things, but maybe
> > there is someone who is more familiar with this who knows if UINT_MAX is
> > okay?
>
> The VPU can't address more than 1GB directly, so UINT_MAX is more than sufficient.

Is there a macro that already defines that 1GB size, or maybe an even smaller
value that makes sense as an upper bound?

         Arnd
