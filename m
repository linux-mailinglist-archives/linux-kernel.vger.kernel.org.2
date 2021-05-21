Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C224138CD09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbhEUSQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236001AbhEUSP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:15:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2950A613CB;
        Fri, 21 May 2021 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621620875;
        bh=3NXKf3VGTX9654EmU8d059WEgGJigpEZhXp3cpqBdTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJwFiXDqfuQB1p4OCL6C/cAPQI8sXFc0tg3qi/NGD3rBvXidg0Mh1vs8VwtktYPOl
         URoyH4H8SDujR71h/4vUGyK/fa+oYeQoXctqjRREekyoE2L4CCScXh1T0wIuLS6JMT
         6xNpsu1kQ/57+SvOseEtDYbkMQlqysZk9psIKkXo=
Date:   Fri, 21 May 2021 20:14:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] comedi: Make ni_mio_common a standalone module
Message-ID: <YKf4iUkA+QzfoN0e@kroah.com>
References: <20210521172749.579900-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521172749.579900-1-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 07:27:50PM +0200, Uwe Kleine-König wrote:
> This allows to get rid of the ugly
> 
> 	#include "ni_mio_common.c"
> 
> in three modules.
> 
> For an amd64 allmodconfig this changed the size for the following object
> files:
>                                        |  before |  after
> drivers/comedi/drivers/ni_atmio.o      |  323944 |  20752
> drivers/comedi/drivers/ni_mio_cs.o     |  318376 |  14920
> drivers/comedi/drivers/ni_mio_common.o |       - | 324872
> drivers/comedi/drivers/ni_pcimio.o     |  389344 |  48168
> ---------------------------------------+---------+-------
>  sum                                   | 1031664 | 408712
> 
> So this results in a considerable decrease in binary size of more than
> 600 KiB.

Very nice!

One tiny nit that I can see that might matter later on (not now):

> @@ -168,6 +173,7 @@ static const struct comedi_lrange range_ni_E_ao_ext = {
>  		RANGE_ext(0, 1)
>  	}
>  };
> +EXPORT_SYMBOL_GPL(range_ni_E_ao_ext);

not the nicest global symbol, ideally these would all start with:
	comedi_ni_...

Oh wait, use the module namespace here!  Make a namespace for the NI
comedi drivers to use and then we don't care so much about the names
(within reason, 'allyesconfig' builds still will care).

But that's an add-on patch, not needed here.

thanks,

greg k-h
