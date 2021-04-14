Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7609035F9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350948AbhDNReD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350349AbhDNReC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38E6361166;
        Wed, 14 Apr 2021 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618421620;
        bh=PJUmT8WDN96jpWmlRACj+k3ZBdDsEkZBPFuL4PHT6dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qn0/r+tButd2tzkPURJUKQIaV9FEKjkqF53JS7Zwqy9vbSQ8Bqn+Kd6LzkPizYY9w
         qON8pHGnGjPv5lmJAkfNnDJ60erG0NvTyOeFmRD6Gu5Y5gE6LQJNhTzqoYW0ypbd6x
         CicKhLzgAjmXDcP6AEFR90c5DRI2xyL/CQoECX24=
Date:   Wed, 14 Apr 2021 19:33:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/7] stm class: Replace uuid_t with plain u8 uuid[16]
Message-ID: <YHcnckePpKDujCU+@kroah.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
 <20210414171251.14672-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414171251.14672-3-alexander.shishkin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:12:46PM +0300, Alexander Shishkin wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> It appears that uuid_t use in STM code abuses UUID API.

How is it being abused?

Moreover,
> this type is only useful when we parse user input. Due to above
> replace uuid_t with u8 uuid[16] and use uuid_t only when parse
> user input.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  drivers/hwtracing/stm/p_sys-t.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
> index 360b5c03df95..04d13b3785d3 100644
> --- a/drivers/hwtracing/stm/p_sys-t.c
> +++ b/drivers/hwtracing/stm/p_sys-t.c
> @@ -76,7 +76,7 @@ enum sys_t_message_string_subtype {
>  				 MIPI_SYST_SEVERITY(MAX))
>  
>  struct sys_t_policy_node {
> -	uuid_t		uuid;
> +	u8		uuid[UUID_SIZE];

This feels wrong, what is wrong with the uuid_t type usage here?

>  	bool		do_len;
>  	unsigned long	ts_interval;
>  	unsigned long	clocksync_interval;
> @@ -92,7 +92,7 @@ static void sys_t_policy_node_init(void *priv)
>  {
>  	struct sys_t_policy_node *pn = priv;
>  
> -	generate_random_uuid(pn->uuid.b);

Ok, that's not good, but that looks to be a flaw in the
generate_random_uuid() api, not this driver implementation.

I don't understand why this change is needed?

thanks,

greg k-h
