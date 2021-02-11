Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B161319485
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhBKUbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:31:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhBKUbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:31:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF73064E15;
        Thu, 11 Feb 2021 20:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613075444;
        bh=T9SdAcek07M4Q+L/hvZW7D1xM6V0Avozed8OyLbtOZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fr9pqJUj++Sg4xY6BfN8HkVe9bkUmxFqpcpvVydK5zEkwwBidT3Fcu7AuIpDy83kq
         D1a2ire6EoCr6q+FP5h2/KFw3BoCJqU8KzmRmx1CdSPYwnqljxgJzU+5RQiQs3REoy
         sRMvuWzxQWiW2JiiuqYSRQkqhdDgrsD5aNc30ZT0=
Date:   Thu, 11 Feb 2021 21:30:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
Cc:     lee.jones@linaro.org, johannes@sipsolutions.net, kuba@kernel.org,
        arnd@arndb.de, mail@anirudhrb.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax: Fix some coding style problems
Message-ID: <YCWT8Gr7huhXTkn4@kroah.com>
References: <20210211171320.141928-1-hemanshagnihotri27@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211171320.141928-1-hemanshagnihotri27@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 10:43:20PM +0530, Hemansh Agnihotri wrote:
> This fixes checkpatch errors :- "else should follow close brace '}'",
> "space required before the open parenthesis '('" and "spaces required
> around that '?' (ctx:VxW)" in drivers/staging/wimax/i2400m/rx.c file.
> 
> Signed-off-by: Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
> ---
>  drivers/staging/wimax/i2400m/rx.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/wimax/i2400m/rx.c b/drivers/staging/wimax/i2400m/rx.c
> index 5b3a85035f6a..8ea0bd039ed7 100644
> --- a/drivers/staging/wimax/i2400m/rx.c
> +++ b/drivers/staging/wimax/i2400m/rx.c
> @@ -485,8 +485,7 @@ struct i2400m_roq_data {
>   * store the sequence number (sn) and the cs (packet type) coming from
>   * the RX payload header from the device.
>   */
> -struct i2400m_roq
> -{
> +struct i2400m_roq {
>  	unsigned ws;
>  	struct sk_buff_head queue;
>  	struct i2400m_roq_log *log;
> @@ -556,7 +555,7 @@ void i2400m_roq_log_entry_print(struct i2400m *i2400m, unsigned index,
>  {
>  	struct device *dev = i2400m_dev(i2400m);
>  
> -	switch(e->type) {
> +	switch (e->type) {
>  	case I2400M_RO_TYPE_RESET:
>  		dev_err(dev, "q#%d reset           ws %u cnt %u sn %u/%u"
>  			" - new nws %u\n",
> @@ -1046,7 +1045,7 @@ void i2400m_rx_edata(struct i2400m *i2400m, struct sk_buff *skb_rx,
>  			 ro_type, ro_cin, roq->ws, ro_sn,
>  			 __i2400m_roq_nsn(roq, ro_sn), size);
>  		d_dump(2, dev, payload, size);
> -		switch(ro_type) {
> +		switch (ro_type) {
>  		case I2400M_RO_TYPE_RESET:
>  			i2400m_roq_reset(i2400m, roq);
>  			kfree_skb(skb);	/* no data here */
> @@ -1346,7 +1345,7 @@ int i2400m_rx_setup(struct i2400m *i2400m)
>  {
>  	int result = 0;
>  
> -	i2400m->rx_reorder = i2400m_rx_reorder_disabled? 0 : 1;
> +	i2400m->rx_reorder = i2400m_rx_reorder_disabled ? 0 : 1;
>  	if (i2400m->rx_reorder) {
>  		unsigned itr;
>  		struct i2400m_roq_log *rd;
> @@ -1365,7 +1364,7 @@ int i2400m_rx_setup(struct i2400m *i2400m)
>  			goto error_roq_log_alloc;
>  		}
>  
> -		for(itr = 0; itr < I2400M_RO_CIN + 1; itr++) {
> +		for (itr = 0; itr < I2400M_RO_CIN + 1; itr++) {
>  			__i2400m_roq_init(&i2400m->rx_roq[itr]);
>  			i2400m->rx_roq[itr].log = &rd[itr];
>  		}
> -- 
> 2.30.0
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
