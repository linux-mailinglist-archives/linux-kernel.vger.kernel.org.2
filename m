Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1966945F158
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378236AbhKZQNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350849AbhKZQLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:11:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB3DC0613F8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 08:00:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63D19B82811
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AC1C93056;
        Fri, 26 Nov 2021 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637942444;
        bh=sh5Y1OU5oIIWp8xfzoyHNKbaEp5XLI12ojMxCu7QGaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsXGxA4njB2sDXx0XoQYp3rGyHOXQQUk8Yno+fh9ozvbBK4p6UBLBBR5ejMuiu1Wq
         7ZsncU5ceiy96v5CP5lPqBbxfmcTTpXzWCi2NOOZnsfrnIZ2ObWCm8ETESco56HTRP
         f+xlemGO8wRD3uJjTz45ZmR4H/ttg81igIv7pOPg=
Date:   Fri, 26 Nov 2021 17:00:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] w1: Misuse of get_user()/put_user() reported by sparse
Message-ID: <YaEEqeKyWPfUP7vM@kroah.com>
References: <2163689da6544c289254b3c69848acc36db998f5.1637313047.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2163689da6544c289254b3c69848acc36db998f5.1637313047.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:15:09AM +0100, Christophe Leroy wrote:
> sparse warnings: (new ones prefixed by >>)
> >> drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *_pu_addr @@     got char *buf @@
>    drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     expected char [noderef] __user *_pu_addr
>    drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     got char *buf
> >> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *_gu_addr @@     got char const *buf @@
>    drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected char const [noderef] __user *_gu_addr
>    drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf
> 
> The buffer buf is a failsafe buffer in kernel space, it's not user
> memory hence doesn't deserve the use of get_user() or put_user().
> 
> Access 'buf' content directly.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202111190526.K5vb7NWC-lkp@intel.com/T/
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/w1/slaves/w1_ds28e04.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
> index e4f336111edc..d75bb16fb7a1 100644
> --- a/drivers/w1/slaves/w1_ds28e04.c
> +++ b/drivers/w1/slaves/w1_ds28e04.c
> @@ -339,10 +339,7 @@ static BIN_ATTR_RW(pio, 1);
>  static ssize_t crccheck_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> -	if (put_user(w1_enable_crccheck + 0x30, buf))
> -		return -EFAULT;
> -
> -	return sizeof(w1_enable_crccheck);
> +	return sprintf(buf, "%d", w1_enable_crccheck);

This should be sysfs_emit(), right?

>  }
>  
>  static ssize_t crccheck_store(struct device *dev, struct device_attribute *attr,
> @@ -353,11 +350,8 @@ static ssize_t crccheck_store(struct device *dev, struct device_attribute *attr,
>  	if (count != 1 || !buf)
>  		return -EINVAL;
>  
> -	if (get_user(val, buf))
> -		return -EFAULT;
> -
>  	/* convert to decimal */
> -	val = val - 0x30;
> +	val = *buf - 0x30;

Why not use a proper function that can parse a string and turn it into a
number?

thanks,

greg k-h
