Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A3C39D9E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFGKnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhFGKnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:43:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C759C610A2;
        Mon,  7 Jun 2021 10:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623062471;
        bh=RvCE1NevIKsTueP7A+FGWPnBFH81BXVCV3Y+zXw8HPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEnlUtxiM3Y1pRllAkTQE9RR7M0PgTxlBVbr5YBwmIEycKGWpoRqHfqMurjix03SW
         ZqAuOzxOzAXXBKxRJW8SM03J1cGkx1LmorVDPJe4V6FdjgL+NuLkmzFTDpcdhjBb2E
         5P/5Yco0jbSj0KpVHb/XVV0OgEzr3O+bcR+WliwM=
Date:   Mon, 7 Jun 2021 12:41:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH wq/for-next 2/2] workqueue: let device core create the
 WQ_UNBOUND attributes
Message-ID: <YL33xPXWlaLkWFne@kroah.com>
References: <20210607094420.2054403-1-jwi@linux.ibm.com>
 <20210607094420.2054403-2-jwi@linux.ibm.com>
 <YL30jJsS+xWMjGVa@kroah.com>
 <7b9366c0-13d9-a5ef-1a29-dd3510a831c0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9366c0-13d9-a5ef-1a29-dd3510a831c0@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 01:34:49PM +0300, Julian Wiedmann wrote:
> On 07.06.21 13:27, Greg Kroah-Hartman wrote:
> > On Mon, Jun 07, 2021 at 11:44:20AM +0200, Julian Wiedmann wrote:
> >> Wrap the attributes for a WQ_UNBOUND workqueue in ATTRIBUTE_GROUPS(),
> >> and wire them up in dev->groups so that the device core can manage them
> >> for us.
> >>
> >> As device_add() will add such attributes _prior_ to raising the KOBJ_ADD
> >> uevent, this also makes the initial uevent suppression unnecessary.
> >>
> >> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> >> ---
> >>  kernel/workqueue.c | 51 ++++++++++++++++++++--------------------------
> >>  1 file changed, 22 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> >> index 817dc2d7438a..629859ac5262 100644
> >> --- a/kernel/workqueue.c
> >> +++ b/kernel/workqueue.c
> >> @@ -5449,6 +5449,9 @@ static ssize_t wq_pool_ids_show(struct device *dev,
> >>  	return written;
> >>  }
> >>  
> >> +static struct device_attribute wq_sysfs_unbound_attr_pool_ids =
> >> +	__ATTR(pool_ids, 0444, wq_pool_ids_show, NULL);
> > 
> > __ATTR_RO() please.
> > 
> 
> I did consider using DEVICE_ATTR_*(), yes. But renaming all the _show and _store
> functions added too much unrelated churn for my taste. So let's maybe do this
> as a follow-on?

Wait, oops, yes, do NOT use __ATTR() for a device attribute, use
DEVICE_ATTR_RO() please.

And yes, if you want to do it as a pater patch in this series that is
fine, just say you are moving the attribute definitions closer to the
callbacks in this patch.

thanks,

greg k-h
