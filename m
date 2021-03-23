Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6EF345F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhCWN14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231360AbhCWN1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:27:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5417F61974;
        Tue, 23 Mar 2021 13:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616506049;
        bh=rQBfDYMFEiJw4DHlR6zQMYTJlg5EjzC1/boylnQBBY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACuICoesxC8oqVeQxm540X8VSv6hCE3GXz9YJ/hh8+UDCFYJTWEHpOy6wMUvdNW0d
         9oQa0TkxoBGlF4H/uogolCAG1TytUpi2zwjZL2ZQB+9PYrmexfRyP9VhyJr6SloSpN
         2TkgvpcvzZXjf+AZrn8moD+ZjA0ekwQh8TmwLlXajpXkWb9aK6QxwweVDeEQNavYqe
         +TXxx+o+WWSZ8qkGK8QbLEBSTplpIfhPVUv7uSFTL851pIOQuknnIP7z7ATjGBt9nk
         Ks/2hNEtrQtNWe1vXiqt2G01Nvoj3fGiY7AizFxSpwALH/6+dDWZW5G/qdmvj1chrq
         9yzGIXh6FJGjQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOh4U-0003Q4-10; Tue, 23 Mar 2021 14:27:46 +0100
Date:   Tue, 23 Mar 2021 14:27:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     caizhichao <tomstomsczc@163.com>
Cc:     perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Zhichao Cai <caizhichao@yulong.com>
Subject: Re: [PATCH] sound/i2c: Simplify the return expression of
 snd_i2c_bit_sendbyte()
Message-ID: <YFns0gJzu4iN8x5F@hovoldconsulting.com>
References: <20210323121443.1276-1-tomstomsczc@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323121443.1276-1-tomstomsczc@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 08:14:43PM +0800, caizhichao wrote:
> From: Zhichao Cai <caizhichao@yulong.com>
> 
> Simplify the return expression.
> 
> Signed-off-by: Zhichao Cai <caizhichao@yulong.com>
> ---
>  sound/i2c/i2c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/i2c/i2c.c b/sound/i2c/i2c.c
> index 847e3b6..dfcc87e 100644
> --- a/sound/i2c/i2c.c
> +++ b/sound/i2c/i2c.c
> @@ -235,9 +235,7 @@ static int snd_i2c_bit_sendbyte(struct snd_i2c_bus *bus, unsigned char data)
>  	for (i = 7; i >= 0; i--)
>  		snd_i2c_bit_send(bus, !!(data & (1 << i)));
>  	err = snd_i2c_bit_ack(bus);
> -	if (err < 0)
> -		return err;
> -	return 0;
> +	return err < 0 ? err : 0;

This isn't a simplification, you're just making the code harder to read
for no good reason.

>  }
>  
>  static int snd_i2c_bit_readbyte(struct snd_i2c_bus *bus, int last)

Johan
