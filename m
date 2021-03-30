Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E55434F509
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 01:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhC3X2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 19:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232661AbhC3X2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 19:28:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 320D1619C5;
        Tue, 30 Mar 2021 23:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617146895;
        bh=JKd1VbmOyIxeYYnhoR9PcFkCGIARvQmU3qkgyQeXv8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oVnxqmExzEUKexrN+MwPe7c5hHq04spz3fIULCOflsuql5m/Ri/Egsjj28bhJo9yI
         No5R3/f3rMxkMIPWhPaavTIAAXUCnEOq10zJQfmc09jexwwNzPYtQEing32+03PiDW
         CtxmKCkALSsLn0/3ERWxqFWRjhNcayjSjOul0kApt7odjU7YbyzSyJ96Ok1dr4smxM
         zk3miGcMU+Q2KwtgEC7QinlIEOHRrsThNf6m72kvZ7DCoZDJ2ts4ypib73/P3I6dAs
         oZ6yDTxzJEfVyt9e92cYbRWKPV7fZ0WW7+ABr1b1OFbX8wE+0q4zqaK0V74Xp89hBb
         Y6KCvZx+O26Xw==
Date:   Tue, 30 Mar 2021 16:28:13 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:34:25AM -0700, Sagi Grimberg wrote:
> 
> > > It is, but in this situation, the controller is sending a second
> > > completion that results in a use-after-free, which makes the
> > > transport irrelevant. Unless there is some other flow (which is
> > > unclear
> > > to me) that causes this which is a bug that needs to be fixed rather
> > > than hidden with a safeguard.
> > > 
> > 
> > The kernel should not crash regardless of any network traffic that is
> > sent to the system.  It should not be possible to either intentionally
> > of mistakenly contruct packets that will deny service in this way.
> 
> This is not specific to nvme-tcp. I can build an rdma or pci controller
> that can trigger the same crash... I saw a similar patch from Hannes
> implemented in the scsi level, and not the individual scsi transports..

If scsi wants this too, this could be made generic at the blk-mq level.
We just need to make something like blk_mq_tag_to_rq(), but return NULL
if the request isn't started.
 
> I would also mention, that a crash is not even the scariest issue that
> we can see here, because if the request happened to be reused we are
> in the silent data corruption realm...

If this does happen, I think we have to come up with some way to
mitigate it. We're not utilizing the full 16 bits of the command_id, so
maybe we can append something like a generation sequence number that can
be checked for validity.
