Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9280E39D99F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFGK3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhFGK31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:29:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91E336108E;
        Mon,  7 Jun 2021 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623061647;
        bh=MPZlRiKAtlsCjP63x3SsG8YH8KEQoq/z47yCAdSjJXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P42VOUdoR/SMofHlgXAvqJGhZ04Yq/FoJRBDDT33sCVLhcGqWnuJyhla0iVmjA0zF
         vloCvR6wytQQFnp0VOpOKYCerDRhhCGmy4GzTpcz5ODoXQvFKEyMQP9zbyDrSpS48J
         8o+18C0IE/pWimNBCFOq1OOTDPLvGbyorOXtKx7w=
Date:   Mon, 7 Jun 2021 12:27:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH wq/for-next 2/2] workqueue: let device core create the
 WQ_UNBOUND attributes
Message-ID: <YL30jJsS+xWMjGVa@kroah.com>
References: <20210607094420.2054403-1-jwi@linux.ibm.com>
 <20210607094420.2054403-2-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607094420.2054403-2-jwi@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:44:20AM +0200, Julian Wiedmann wrote:
> Wrap the attributes for a WQ_UNBOUND workqueue in ATTRIBUTE_GROUPS(),
> and wire them up in dev->groups so that the device core can manage them
> for us.
> 
> As device_add() will add such attributes _prior_ to raising the KOBJ_ADD
> uevent, this also makes the initial uevent suppression unnecessary.
> 
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> ---
>  kernel/workqueue.c | 51 ++++++++++++++++++++--------------------------
>  1 file changed, 22 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 817dc2d7438a..629859ac5262 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5449,6 +5449,9 @@ static ssize_t wq_pool_ids_show(struct device *dev,
>  	return written;
>  }
>  
> +static struct device_attribute wq_sysfs_unbound_attr_pool_ids =
> +	__ATTR(pool_ids, 0444, wq_pool_ids_show, NULL);

__ATTR_RO() please.

> +
>  static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> @@ -5502,6 +5505,9 @@ static ssize_t wq_nice_store(struct device *dev, struct device_attribute *attr,
>  	return ret ?: count;
>  }
>  
> +static struct device_attribute wq_sysfs_unbound_attr_nice =
> +	__ATTR(nice, 0644, wq_nice_show, wq_nice_store);

__ATTR_RW()

> +
>  static ssize_t wq_cpumask_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> @@ -5539,6 +5545,9 @@ static ssize_t wq_cpumask_store(struct device *dev,
>  	return ret ?: count;
>  }
>  
> +static struct device_attribute wq_sysfs_unbound_attr_cpumask =
> +	__ATTR(cpumask, 0644, wq_cpumask_show, wq_cpumask_store);

__ATTR_RW()

thanks,

greg k-h
