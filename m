Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD0422128
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhJEIvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:51:36 -0400
Received: from first.geanix.com ([116.203.34.67]:37336 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233376AbhJEIvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:51:32 -0400
Received: from skn-laptop (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 7570EC24F2;
        Tue,  5 Oct 2021 08:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1633423779; bh=AUnXTubOTobfFxzBcRJ9H6QzFIiTxSYi3vnBtn38bE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ca4ypouvW1ZLkNzvJktUrFio8Kx3ez/L0TDZ04MxVnDZWsLpZps1HPPgy92L88FD3
         DOE+KYItMLf/YMYSsIKOsH6R3nAWf+dKcp60WubGprP6x3zGMiwxUPmqs8f+QYE2QP
         IOi9tSbHpqTHBm7zeiRbnZsE9VHEwCA0edl5jLc2v9NzXpd+U4f86DBtuVoh2fd1IB
         8BaXbDg8F2chpFewkSHSWA2Gk78MQNh8kDaZ9uvZwPbxWScL/EH6DMGHqaoNJYHZSX
         RDMFRTti1Fp7WVOUcEu6Safg+xRcPCOS66HlhBc4ZIblKCvWSTJm10iyteW4B3kl2g
         PkOX+oxqbq+Kw==
Date:   Tue, 5 Oct 2021 10:49:38 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: use mutex to protect access while in
 suspend
Message-ID: <20211005084938.jcbw24umhehoiirs@skn-laptop>
References: <20211004065608.3190348-1-sean@geanix.com>
 <20211004104147.579f3b01@collabora.com>
 <20211004085509.iikxtdvxpt6bri5c@skn-laptop>
 <20211004115817.18739936@collabora.com>
 <20211004101246.kagtezizympxupat@skn-laptop>
 <20211004134700.26327f6f@collabora.com>
 <20211005070930.epgxb5qzumk4awxq@skn-laptop>
 <20211005102300.5da6d480@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005102300.5da6d480@collabora.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 10:23:00AM +0200, Boris Brezillon wrote:
> On Tue, 5 Oct 2021 09:09:30 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:

[ ... ]

> > 
> > Have you seen the reproducer script?
> 
> How would I know about this script or your previous attempt (mentioned
> at the end of this email) given I was not Cc-ed on the previous
> discussion, and nothing mentions it in this RFC...
> 

That's why I shared it here ;)
Initially I thought this was a bug introduced by exec_op.

> > ---
> > root@iwg26-v1:/data/root# cat /data/crash.sh
> > #!/bin/sh -x
> > 
> > echo enabled > /sys/devices/platform/soc/2100000.bus/21f4000.serial/tty/ttymxc4/power/wakeup
> > 
> > rm /data/test50M
> > dd if=/dev/urandom of=/tmp/test50M bs=1M count=50
> > cp /tmp/test50M /data/ &
> > sleep 1
> > echo mem > /sys/power/state
> > ---
> > 
> > As seen in the log above disk is synced before suspend.
> > cp is continuing to copy data to ubifs.
> > And then user space processes are frozen.
> > At this point the kernel thread would have unwritten data.
> > 
> > We tried to solve this with:
> > https://lkml.org/lkml/2021/9/1/280
> 
> I see. It's still unclear to me when the write happens. Is it in the
> suspend path (before the system is actually suspended), or in the
> resume path (when the system is being resumed).
> 
> Anyway, let's admit writing to a storage device while it's suspended is
> a valid use case and requires the storage layer to put this request on
> old. This wait should not, IMHO, be handled at the NAND level, but at
> the MTD level (using a waitqueue, and an atomic to make
> suspended/resumed transitions safe). And abusing a mutex to implement
> that is certainly not a good idea.

I did't say this was the right solution ;) I actually asked in the RFC:
"Should we introduce a new mutex? Or maybe a spin_lock?"

What are you proposing, a waitqueue in mtd_info? That gets checked in
mtd_write()/mtd_read()?

/Sean
