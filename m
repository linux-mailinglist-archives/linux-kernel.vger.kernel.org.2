Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E09C35C2EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbhDLJxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243966AbhDLJnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40196611AD;
        Mon, 12 Apr 2021 09:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618220586;
        bh=WsiNqKTdYhZHLWI0ixdu86RNc49vtM155yUiz3ZveTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhKxHYqB4zdIGW991QXkB/gNj9Zf+zhvVKr6EM7AQHnx32mMHyXOS5F/i1/utUORd
         YpYqn4nqdIan2yPcOclvUZpr5jIUUQCS7PCk5TBESbEnS7voZ8f6/4ryN1I1ZJw0uO
         3FD25bGNDPi3O2+zNNYCFnuj9+2kyxWn8KIRwoD4=
Date:   Mon, 12 Apr 2021 11:43:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8192u: Remove variable
 set but not used
Message-ID: <YHQWKMu/KuhZ9Oxs@kroah.com>
References: <20210411183634.18385-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411183634.18385-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 08:36:34PM +0200, Fabio M. De Francesco wrote:
> Remove variable "int ret", declared but not used.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> Changes from v1: Change the text of the subject and log.
> 
>  drivers/staging/rtl8192u/r8192U_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index f48186a89fa1..30055de66239 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -902,7 +902,6 @@ static void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
>  				   int rate)
>  {
>  	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> -	int ret;
>  	unsigned long flags;
>  	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
>  	u8 queue_index = tcb_desc->queue_index;
> -- 
> 2.31.1
> 

Breaks the build, why did you not test this patch?

thanks,

greg k-h
