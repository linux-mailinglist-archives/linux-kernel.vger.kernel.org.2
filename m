Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3517327F16
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhCANLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:11:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235453AbhCANJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:09:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59EBE64E2E;
        Mon,  1 Mar 2021 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614604157;
        bh=T+hhysKQC9LROCAdI8japk0NWNbd5NQFRpUTk664/YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHe+pYngJUi587avuPg2AS3QqWdziewtFu613R/rXvkpUZnWMMp0hsQlGEFW6nWOB
         NGnwCydGH5wnBavXxlP7GvMlY5aZZwFojo1LM4x/4pEqLZ7dQnVc2CP4iKqHtSAZLX
         S6qoEVLrSqBBpFf4VqDRDymQ5b3BtJ6AoUkIxnOo=
Date:   Mon, 1 Mar 2021 14:09:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     zbr@ioremap.net, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: ds2708 and ds2781 use the new API kobj_to_dev()
Message-ID: <YDzne3KtnGJD1J0E@kroah.com>
References: <1614603535-24046-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614603535-24046-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 08:58:55PM +0800, Tian Tao wrote:
> fix the below warnning:
> /drivers/w1/slaves/w1_ds2780.c:93:60-61: WARNING opportunity for
> kobj_to_dev()

What creates that warning?

> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/w1/slaves/w1_ds2780.c | 3 ++-
>  drivers/w1/slaves/w1_ds2781.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_ds2780.c b/drivers/w1/slaves/w1_ds2780.c
> index c281fe5..3cde1bb 100644
> --- a/drivers/w1/slaves/w1_ds2780.c
> +++ b/drivers/w1/slaves/w1_ds2780.c
> @@ -90,7 +90,8 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
>  			     struct bin_attribute *bin_attr, char *buf,
>  			     loff_t off, size_t count)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
> +

Why the extra line here, but not in the other chunk?

Consistancy is key :)

Please fix up.

thanks,

greg k-h
