Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30CE452CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhKPIhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:37:38 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:53124 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhKPIhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:37:06 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id EDB362012F6;
        Tue, 16 Nov 2021 08:34:07 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id A2B6980095; Tue, 16 Nov 2021 09:32:13 +0100 (CET)
Date:   Tue, 16 Nov 2021 09:32:13 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     cgel.zte@gmail.com
Cc:     ran.jianping@zte.com.cn, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] pcmcia: remvoe unneeded variable
Message-ID: <YZNsjf0fMjEblbtj@owl.dominikbrodowski.net>
References: <20211116023310.154283-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116023310.154283-1-ran.jianping@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, Nov 16, 2021 at 02:33:10AM +0000 schrieb cgel.zte@gmail.com:
> From: ran jianping <ran.jianping@zte.com.cn>
> 
> Fix the following coccicheck review:
> drivers/pcmcia/pcmcia_resource.c:396:5-8: Unneeded variable
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
> ---
>  drivers/pcmcia/pcmcia_resource.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
> index c1c197292111..d7e0f659d0a7 100644
> --- a/drivers/pcmcia/pcmcia_resource.c
> +++ b/drivers/pcmcia/pcmcia_resource.c
> @@ -393,7 +393,6 @@ int pcmcia_release_configuration(struct pcmcia_device *p_dev)
>  static int pcmcia_release_io(struct pcmcia_device *p_dev)
>  {
>  	struct pcmcia_socket *s = p_dev->socket;
> -	int ret = -EINVAL;
>  	config_t *c;
>  
>  	mutex_lock(&s->ops_mutex);
> @@ -413,7 +412,7 @@ static int pcmcia_release_io(struct pcmcia_device *p_dev)
>  out:
>  	mutex_unlock(&s->ops_mutex);
>  
> -	return ret;
> +	return -EINVAL;
>  } /* pcmcia_release_io */

Thanks for your patch. It truly points out that the return value is unused,
and in fact, the sole caller does not check it. Therefore, it seems better
to remove the return value altogether, and convert it to type void.

Thanks,
	Dominik
