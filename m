Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C175131DA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 14:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhBQNb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 08:31:59 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:17818 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhBQNaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1613568621;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bp3fBtBumnQYDuMT4p4O4vegfrz8kk/nF90ppoE+EIQ=;
  b=LD8wHbTgeEH8lvrxKWZgn0dWL5OoUb7HGoRuBhlG4gR8rkT2miZHCG0N
   bIgGa/k8QFFzuqyJ6TU4XuVoPCpuiK2uUn6zTHpB82umeX5QpJgUqBBWx
   PQ6/ugS2Yo+Z1U57HJU9Y5ctocjGgNidEy3XJ2+vUdP5ALnwO1RL9jQ+0
   g=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: o7LaJcbQT5QuBw1xPwkFm1kmmIpHK9sbb9lZj5IyJs4mA6AKdPwwmE6rjsZVBkmNqq+f1rg7v9
 LhPjd42AWS+GmnJwjqQu2oMcrOsirvyJVxH5cCnpbZzFpjLStPB9qB5/CJH5wL2kyX3hIiHH41
 BiJdvO1WYeF49G5IAxgFWe2Doce5WdQcFnPhB0gMWpqLGNUyZ04XS+fO43Jds6xWB/x8VdXjLc
 TVqBAY/waBGvsB5Nt+Gp+8G4G7JcUyHaEeserRUmk28EhENWIwM7fRM4ds93N++2/jeX9TnB7a
 ItU=
X-SBRS: 5.1
X-MesageID: 37785213
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.81,184,1610427600"; 
   d="scan'208";a="37785213"
Subject: Re: [PATCH v2 8/8] xen/evtchn: use READ/WRITE_ONCE() for accessing
 ring indices
To:     Juergen Gross <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20210211101616.13788-1-jgross@suse.com>
 <20210211101616.13788-9-jgross@suse.com>
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <6818fcde-abab-1250-119c-d0ccb8c80488@citrix.com>
Date:   Wed, 17 Feb 2021 13:29:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210211101616.13788-9-jgross@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-11 10:16, Juergen Gross wrote:
> For avoiding read- and write-tearing by the compiler use READ_ONCE()
> and WRITE_ONCE() for accessing the ring indices in evtchn.c.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - modify all accesses (Julien Grall)
> ---
>  drivers/xen/evtchn.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
> index 421382c73d88..620008f89dbe 100644
> --- a/drivers/xen/evtchn.c
> +++ b/drivers/xen/evtchn.c
> @@ -162,6 +162,7 @@ static irqreturn_t evtchn_interrupt(int irq, void *data)
>  {
>  	struct user_evtchn *evtchn = data;
>  	struct per_user_data *u = evtchn->user;
> +	unsigned int prod, cons;
>  
>  	WARN(!evtchn->enabled,
>  	     "Interrupt for port %u, but apparently not enabled; per-user %p\n",
> @@ -171,10 +172,14 @@ static irqreturn_t evtchn_interrupt(int irq, void *data)
>  
>  	spin_lock(&u->ring_prod_lock);
>  
> -	if ((u->ring_prod - u->ring_cons) < u->ring_size) {
> -		*evtchn_ring_entry(u, u->ring_prod) = evtchn->port;
> +	prod = READ_ONCE(u->ring_prod);
> +	cons = READ_ONCE(u->ring_cons);
> +
> +	if ((prod - cons) < u->ring_size) {
> +		*evtchn_ring_entry(u, prod) = evtchn->port;
>  		smp_wmb(); /* Ensure ring contents visible */
> -		if (u->ring_cons == u->ring_prod++) {
> +		if (cons == prod++) {
> +			WRITE_ONCE(u->ring_prod, prod);
>  			wake_up_interruptible(&u->evtchn_wait);
>  			kill_fasync(&u->evtchn_async_queue,
>  				    SIGIO, POLL_IN);

This doesn't work correctly since now u->ring_prod is only updated if cons == prod++.

Ross
