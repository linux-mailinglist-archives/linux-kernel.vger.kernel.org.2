Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3754B3A25F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFJH7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:59:50 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59644 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhFJH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:59:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 2493B2BB40;
        Thu, 10 Jun 2021 03:57:30 -0400 (EDT)
Date:   Thu, 10 Jun 2021 17:57:48 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Joshua Thompson <funaho@jurai.org>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Richard Zidlicky <rz@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v3 0/2] Use libata platform drivers to replace deprecated
 m68k IDE drivers
In-Reply-To: <CAMuHMdWLJWBH5uz=PLL7pt2uEHz9uSO2Gh7twCDUTz3NDfhdEQ@mail.gmail.com>
Message-ID: <417a2d12-6085-e796-a8a5-605a58f131f@linux-m68k.org>
References: <cover.1623287706.git.fthain@linux-m68k.org> <CAMuHMdWLJWBH5uz=PLL7pt2uEHz9uSO2Gh7twCDUTz3NDfhdEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021, Geert Uytterhoeven wrote:

> On Thu, Jun 10, 2021 at 3:34 AM Finn Thain <fthain@linux-m68k.org> wrote:
> > This patch series allows m68k platforms to switch from deprecated IDE
> > drivers to libata drivers.
> >
> > Changed since v1:
> >  - Added reviewed-by and tested-by tags.
> >  - Improved commit log.
> >
> > Changed since v2:
> >  - Added #ifdef guards to prevent build failure when CONFIG_ATARI=n.
> 
> Thanks for the update!
> 
> Note that Jens has already applied v2 to block/for-next.
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=9658506fbf8c1b629ca8a660862bc1ee57400506
> 

Thanks for the tip. I gather that Jens' tree can't be rebased, so I'll 
have to send another patch...
