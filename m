Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4852B32663A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhBZRTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhBZRTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:19:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AF0564F0E;
        Fri, 26 Feb 2021 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614359947;
        bh=Bd65XOTrei5fxTOedo0AjEPLzm2AKptX7w7syoIfjEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYoJwosyELFYEIXxbJxq635ucCVg8L5ywVQfRZgrvXD9USOPC4lIPoxyKBWODEavg
         NC/BDaTzdzxp50/0ApeNMHmUwxCn+9LiVdH0ZKXiKSmgcAkQiQRChpjRGz5Wan3RSs
         HBm3VjFhjRWnMxKI8S/qg8kLTu73Xu4j7ItUb0kMHHXSrsJD2Us9wT0x2CvuYtJO4/
         SQOjOKacJSaL7DeE0LYVOml5Po7RN5Yje9B0sX8lBaxp3xOoAgE+XolwX6Rg25iPRK
         7NGQU1HqAftCl9CgzWt43+g8M6x84ISJP9+wOz20/I8oqqKvQl0sS6/plHSKcSA8OS
         ojq8uq2FYoVOA==
Date:   Sat, 27 Feb 2021 02:19:01 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
References: <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
 <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 05:42:46PM +0100, Hannes Reinecke wrote:
> On 2/26/21 5:13 PM, Keith Busch wrote:
> > 
> > That's just addressing a symptom. You can't fully verify the request is
> > valid this way because the host could have started the same command ID
> > the very moment before the code checks it, incorrectly completing an
> > in-flight command and getting data corruption.
> > 
> Oh, I am fully aware.
> 
> Bad frames are just that, bad frames.
> We can only fully validate that when digests are enabled, but I gather that
> controllers sending out bad frames wouldn't want to enable digests, either.
> So relying on that is possibly not an option.
> 
> So really what I'm trying to avoid is the host crashing on a bad frame.
> That kind of thing always resonates bad with customers.
> And tripping over an uninitialized command is just too stupid IMO.

Crashing is bad, silent data corruption is worse. Is there truly no
defense against that? If not, why should anyone rely on this?
