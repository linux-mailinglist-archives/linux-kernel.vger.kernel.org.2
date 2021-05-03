Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C409E372164
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhECUex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:34:53 -0400
Received: from mail1.perex.cz ([77.48.224.245]:39850 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhECUew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:34:52 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9CEEEA003F;
        Mon,  3 May 2021 22:33:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9CEEEA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1620074035; bh=8B/hXSsdCeQAK5Pn0YQhDqrUt0G3NOhFpSpgc3YmhhM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wV3/zQnraEpTLxf1GiaaSa4McMl2/5evxCBmw8rvpH1q1vKwpuSyRbo+HNqM2CR2P
         CdMOfFfnuUwBqHKBBtmtSvR7/FDry9iKdLMHTGyLlaYQPDnO91+q6hjxqcdyzkq724
         nS02jMkLdeZdgfJVXUkeov0G/xG7Ep6vlb74kFwU=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon,  3 May 2021 22:33:52 +0200 (CEST)
Subject: Re: [PATCH 37/69] ALSA: usx2y: check for failure of usb_alloc_urb()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
 <20210503115736.2104747-38-gregkh@linuxfoundation.org>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <aa185e3d-981f-ca5a-ea40-d266e62b82fe@perex.cz>
Date:   Mon, 3 May 2021 22:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503115736.2104747-38-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 03. 05. 21 v 13:57 Greg Kroah-Hartman napsal(a):
> While it is almost impossible to hit an error calling usb_alloc_urb(),
> to make systems like syzbot which does error injection, and some static
> analysis tools happy, properly handle errors on this path by unwinding
> the previously allocated urbs and freeing them.

Perhaps, I miss something, but this revert and add the cleanup to the wrong
place makes things worse:

The usb_stream_free() is called when init_urbs() fails (returns an error), so
all urbs are freed there and pointers are reset to NULL. Your code frees urbs
twice on an allocation error.

The reverted code does the job better.

						Jaroslav

> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  sound/usb/usx2y/usb_stream.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
> index 6bba17bf689a..1091ea96a29a 100644
> --- a/sound/usb/usx2y/usb_stream.c
> +++ b/sound/usb/usx2y/usb_stream.c
> @@ -88,18 +88,35 @@ static int init_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
>  					sizeof(struct usb_stream_packet) *
>  					s->inpackets;
>  	int			u;
> +	int			i;
> +	int			err = -ENOMEM;
>  
>  	for (u = 0; u < USB_STREAM_NURBS; ++u) {
> +		sk->outurb[u] = NULL;
>  		sk->inurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
> +		if (!sk->inurb[u])
> +			goto error;
>  		sk->outurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
> +		if (!sk->outurb[u])
> +			goto error;
>  	}
> +	u--;
>  
>  	if (init_pipe_urbs(sk, use_packsize, sk->inurb, indata, dev, in_pipe) ||
>  	    init_pipe_urbs(sk, use_packsize, sk->outurb, sk->write_page, dev,
> -			   out_pipe))
> -		return -EINVAL;
> +			   out_pipe)) {
> +		err = -EINVAL;
> +		goto error;
> +	}
>  
>  	return 0;
> +
> +error:
> +	for (i = 0; i <= u; ++i) {
> +		usb_free_urb(sk->inurb[i]);
> +		usb_free_urb(sk->outurb[i]);
> +	}
> +	return err;
>  

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
