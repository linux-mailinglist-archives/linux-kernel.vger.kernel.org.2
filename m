Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F62A36EEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbhD2RRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhD2RRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:17:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 733E46144B;
        Thu, 29 Apr 2021 17:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619716583;
        bh=xCE9kiuLbHXwsZ1KM6w/Tl3VqKcpO4AP4M7f6sN//EQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtxMrFqA9p7JcfQiuEV1zxzYYkLtjwQ8IrfXzjheChjOdPze0WwnoNsisQwllBRnu
         mzrV77uJ39oHAL90UPCgmwI+qy+EQOdywuNtNSZne1YykrslESVV92jDtQhzSABAM2
         zL+E9K9BVm13BmTnZdu+M7Iw0RXyS6M3UhQV801M=
Date:   Thu, 29 Apr 2021 19:16:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tariq Toukan <ttoukan.linux@gmail.com>,
        Atul Gopinathan <atulgopinathan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 046/190] Revert "net/mlx4_core: fix a memory leak bug."
Message-ID: <YIrp5CMmMugYg4Zk@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-47-gregkh@linuxfoundation.org>
 <1027d8d1-5cea-0a04-4974-3f9672ff7d4e@gmail.com>
 <YIgK2Hbnmxz2dPCe@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIgK2Hbnmxz2dPCe@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 03:00:08PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 26, 2021 at 02:18:37PM +0300, Tariq Toukan wrote:
> > 
> > 
> > On 4/21/2021 3:58 PM, Greg Kroah-Hartman wrote:
> > > This reverts commit febfd9d3c7f74063e8e630b15413ca91b567f963.
> > > 
> > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > faith" to try to test the kernel community's ability to review "known
> > > malicious" changes.  The result of these submissions can be found in a
> > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > 
> > > Because of this, all submissions from this group must be reverted from
> > > the kernel tree and will need to be re-reviewed again to determine if
> > > they actually are a valid fix.  Until that work is complete, remove this
> > > change to ensure that no problems are being introduced into the
> > > codebase.
> > > 
> > > Cc: Qiushi Wu <wu000273@umn.edu>
> > > Cc: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >   drivers/net/ethernet/mellanox/mlx4/fw.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
> > > index f6cfec81ccc3..380e027ba5df 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx4/fw.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
> > > @@ -2734,7 +2734,7 @@ void mlx4_opreq_action(struct work_struct *work)
> > >   		if (err) {
> > >   			mlx4_err(dev, "Failed to retrieve required operation: %d\n",
> > >   				 err);
> > > -			goto out;
> > > +			return;
> > >   		}
> > >   		MLX4_GET(modifier, outbox, GET_OP_REQ_MODIFIER_OFFSET);
> > >   		MLX4_GET(token, outbox, GET_OP_REQ_TOKEN_OFFSET);
> > > 
> > 
> > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> > 
> > The original commit febfd9d3c7f74063e8e630b15413ca91b567f963 is a bad
> > commit. Not to be re-submitted.
> 
> Thanks for the review, will keep!

In looking closer (well, Atul looked closer after I asked them too), it
seems that the original commit is ok, so I'm going to drop this revert
from my tree.

Tariq, unless you can point out the problem you see here?

thanks,

greg k-h
