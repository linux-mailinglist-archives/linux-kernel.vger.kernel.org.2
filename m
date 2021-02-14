Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5457531AF8F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 08:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhBNHGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 02:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhBNHGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 02:06:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82839C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 23:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=5IjrQFMeVa5GMjRKu0TxSzNjjElmjJZTM0W7OnLRiyg=; b=eoAK9WsUeKYMPPKmS3fawrtlf6
        v4DUCCon+ZBvWapEjerX0kIVYxqihdYH1WaVTq7m1JFY3JtcsVC2qHjJzfAGO50D0IELMaOjdwdpX
        mmiRi96Y9y1XdTiYcfD4hPUWa9EoTdDh9Yu4NBRRwwxHMTBAiF+dMS7QJjWtYjSRVahBaAHvqhrGn
        DU03dAVi4NsKkeqHQ8ULQw6vSECyLrgR8blR9DKRnw37AHrSbIVLI/S93/KnQsQ6N+9Zdif+kWY92
        niI2HcfRiX77On8FGRhDwltRZApqu7qSGYakiA6UfsGCrWp0ITvDzSFgOdKzKqzykawoaGA8W1JRZ
        KGKAQ3Fw==;
Received: from [2601:1c0:6280:3f0::1d53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBBTj-0002XP-5S; Sun, 14 Feb 2021 07:05:59 +0000
Subject: Re: [PATCH] Fix typo in f_printer.c
To:     AristoChen <jj251510319013@gmail.com>, linux-kernel@vger.kernel.org
References: <20210214065354.5490-1-jj251510319013@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8d5e7e34-b9ff-c1fa-1447-112bdbf6f2c7@infradead.org>
Date:   Sat, 13 Feb 2021 23:05:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210214065354.5490-1-jj251510319013@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/21 10:53 PM, AristoChen wrote:
> In line 824, it is trying to open `out_ep`, so
> I believe in line 826, it should print `out_ep`
> instead of `in_ep`
> 
> Signed-off-by: AristoChen <jj251510319013@gmail.com>
> ---
>   drivers/usb/gadget/function/f_printer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
> index 2f1eb2e81d30..a3b17ec00bf0 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -823,7 +823,7 @@ set_printer_interface(struct printer_dev *dev)
>   
>   	result = usb_ep_enable(dev->out_ep);
>   	if (result != 0) {
> -		DBG(dev, "enable %s --> %d\n", dev->in_ep->name, result);
> +		DBG(dev, "enable %s --> %d\n", dev->out_ep->name, result);
>   		goto done;
>   	}
>   
> 

Hi,
The patch makes sense.
You should Cc: the USB gadget maintainer and the linux-usb mailing list.

Thanks.
