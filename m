Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6319A31B79B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 11:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhBOKtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 05:49:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:45298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhBOKlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:41:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F854AC32;
        Mon, 15 Feb 2021 10:40:20 +0000 (UTC)
Date:   Mon, 15 Feb 2021 11:40:20 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 09:46:41AM +0100, Hannes Reinecke wrote:
> On 2/12/21 10:49 PM, Sagi Grimberg wrote:
> > 
> > > > > blk_mq_tag_to_rq() will always return a request if the command_id is
> > > > > in the valid range. Check if the request has been started. If we
> > > > > blindly process the request we might double complete a request which
> > > > > can be fatal.
> > > > 
> > > > How did you get to this one? did the controller send a completion for
> > > > a completed/bogus request?
> > > 
> > > If that is the case, then that must mean it's possible the driver could
> > > have started the command id just before the bogus completion check. Data
> > > iorruption, right?

'during TCP LIF toggles and aggr relocates' testing the host
crashes. TBH, I do not really know what is happening or what the test
does. Still trying to figure out what's going on. I was just very
surprised how much the code trusts the other side to behave correctly.

> > Yes, which is why I don't think this check is very useful..
> 
> I actually view that as a valid protection against spoofed frames.
> Without it it's easy to crash the machine by injecting fake completions with
> random command ids.

In this test scenario it's not even a spoofed frame; maybe just a
confused controller.
