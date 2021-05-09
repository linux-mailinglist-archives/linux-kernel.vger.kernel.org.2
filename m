Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF0537764B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 13:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhEILPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 07:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhEILPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 07:15:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9E8D613EE;
        Sun,  9 May 2021 11:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620558882;
        bh=4uq89s1mxYTua+FW57+pxlcR8+sY01pbkMIGEyn/7mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViNu1YZGDPkwgnJ/GGi9ibldY8KNZe3XyBmal06ew6nFNrCxcLGmYzVloj99VXniH
         u0t+juvFuz6ekkAM4aectBqyAlJcUs0K5tVBM2ZzBPxyQsmVMKSJb3KT+fQeAaU3yj
         Q4N3kPfdztdb77u3z2IZww/tmo3DvGD3yaI09A0o=
Date:   Sun, 9 May 2021 13:14:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tariq Toukan <ttoukan.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 046/190] Revert "net/mlx4_core: fix a memory leak bug."
Message-ID: <YJfEH3Etcxk+e5yC@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-47-gregkh@linuxfoundation.org>
 <1027d8d1-5cea-0a04-4974-3f9672ff7d4e@gmail.com>
 <YIgK2Hbnmxz2dPCe@kroah.com>
 <fb1d28e2-f715-9053-7c77-d618a92fa729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb1d28e2-f715-9053-7c77-d618a92fa729@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 01:19:37PM +0300, Tariq Toukan wrote:
> 
> 
> On 4/27/2021 4:00 PM, Greg Kroah-Hartman wrote:
> > On Mon, Apr 26, 2021 at 02:18:37PM +0300, Tariq Toukan wrote:
> > > 
> > > 
> > > On 4/21/2021 3:58 PM, Greg Kroah-Hartman wrote:
> > > > This reverts commit febfd9d3c7f74063e8e630b15413ca91b567f963.
> > > > 
> > > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > > faith" to try to test the kernel community's ability to review "known
> > > > malicious" changes.  The result of these submissions can be found in a
> > > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > > 
> > > > Because of this, all submissions from this group must be reverted from
> > > > the kernel tree and will need to be re-reviewed again to determine if
> > > > they actually are a valid fix.  Until that work is complete, remove this
> > > > change to ensure that no problems are being introduced into the
> > > > codebase.
> > > > 
> > > > Cc: Qiushi Wu <wu000273@umn.edu>
> > > > Cc: David S. Miller <davem@davemloft.net>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >    drivers/net/ethernet/mellanox/mlx4/fw.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
> > > > index f6cfec81ccc3..380e027ba5df 100644
> > > > --- a/drivers/net/ethernet/mellanox/mlx4/fw.c
> > > > +++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
> > > > @@ -2734,7 +2734,7 @@ void mlx4_opreq_action(struct work_struct *work)
> > > >    		if (err) {
> > > >    			mlx4_err(dev, "Failed to retrieve required operation: %d\n",
> > > >    				 err);
> > > > -			goto out;
> > > > +			return;
> > > >    		}
> > > >    		MLX4_GET(modifier, outbox, GET_OP_REQ_MODIFIER_OFFSET);
> > > >    		MLX4_GET(token, outbox, GET_OP_REQ_TOKEN_OFFSET);
> > > > 
> > > 
> > > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> > > 
> > > The original commit febfd9d3c7f74063e8e630b15413ca91b567f963 is a bad
> > > commit. Not to be re-submitted.
> > 
> > Thanks for the review, will keep!
> > 
> > greg k-h
> > 
> 
> Hi Greg,
> 
> I got confused with another error handling code in same function.
> 
> After a second look, original commit
> febfd9d3c7f74063e8e630b15413ca91b567f963 looks fine to me.

Thanks for the information, and the re-review.

greg k-h
