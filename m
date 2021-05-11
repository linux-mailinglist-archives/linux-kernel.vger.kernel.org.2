Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870D737A06C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhEKHNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:13:13 -0400
Received: from smtpcmd04132.aruba.it ([62.149.158.132]:50155 "EHLO
        smtpcmd04132.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhEKHNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:13:11 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2021 03:13:11 EDT
Received: from [192.168.1.128] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id gMRwlAtSu8ee9gMRxliGkB; Tue, 11 May 2021 09:05:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1620716704; bh=c/Km+mdUICAL7NmRB1mqs9sU9/yeFUfBCQg6JYdl0R8=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=aLhpRX+ySwqOn2uJHCL3ntlqQ3rUrk+y6EjiTB0uuUZjVvOQqHs6ZZJ4XNXlpDJeN
         QJGJrDUBlWbZc7L0+10tXNEhBPtXU4UT6gw31QtNa4mKTsFBAqGXnF2lXD325V9lcm
         O9odkeqwIAoVOJbMSYtDWDf2Oifj970kKoiF3RqV/lqCLIWgZkfq5n9xzLCwOHYMXA
         TEqOwjeySBVJfEJ9WK3h1/g849pw0osFtvbE1vBXanqGI+0UYCqoC+jD68KlPsf+7O
         TjqcLdoogPsfS+FVNYFQHuSDudVGCQwEQzaBeQTrIStF/bTYiKsRjQdElXJJRoRMDX
         k957OpthJWACA==
Subject: Re: [PATCH v1 1/1] pps: clients: parport: Switch to use
 module_parport_driver()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
References: <20210510141302.56654-1-andriy.shevchenko@linux.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <77c821e1-adc7-4088-0dcb-da65ba7a39a2@enneenne.com>
Date:   Tue, 11 May 2021 09:05:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210510141302.56654-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMRIVLhQEkv5QOCWXRTcfb/hiKOZx+nfEeQCZBN9R8WCuSJ+0TNtD6CstuIiM6VC/WNUFD7pDyUtGha+beRaJ5MbMax1xA+/xWBw8CBNOM0BjXGIx3yy
 Fr+d/Q2OhG1ObFy56/NXETWlPL8BxSzWVRsCBTVNYoQrultNpHAR2YZEfD5Iad7cgG5iHj+V3E7qcjtG2jdbiAsseeeOkCNgStf6O19rkel/yXqucoKkO4gL
 mabAbvu0W1Ftl0uUH96OeLUSriL45vZ28KY5O89DVbo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/21 16:13, Andy Shevchenko wrote:
> Switch to use module_parport_driver() to reduce boilerplate code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pps/clients/pps_parport.c | 42 ++++++-------------------------
>  1 file changed, 8 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
> index 7a41fb7b0dec..42f93d4c6ee3 100644
> --- a/drivers/pps/clients/pps_parport.c
> +++ b/drivers/pps/clients/pps_parport.c
> @@ -22,8 +22,6 @@
>  #include <linux/parport.h>
>  #include <linux/pps_kernel.h>
>  
> -#define DRVDESC "parallel port PPS client"
> -
>  /* module parameters */
>  
>  #define CLEAR_WAIT_MAX		100
> @@ -138,6 +136,12 @@ static void parport_attach(struct parport *port)
>  		.dev		= NULL
>  	};
>  
> +	if (clear_wait > CLEAR_WAIT_MAX) {
> +		pr_err("clear_wait value should be not greater then %d\n",
> +		       CLEAR_WAIT_MAX);
> +		return;
> +	}
> +

Why do you need to do so? Maybe a comment would be welcomed.

>  	device = kzalloc(sizeof(struct pps_client_pp), GFP_KERNEL);
>  	if (!device) {
>  		pr_err("memory allocation failed, not attaching\n");
> @@ -214,38 +218,8 @@ static struct parport_driver pps_parport_driver = {
>  	.detach = parport_detach,
>  	.devmodel = true,
>  };
> -
> -/* module staff */
> -
> -static int __init pps_parport_init(void)
> -{
> -	int ret;
> -
> -	pr_info(DRVDESC "\n");
> -
> -	if (clear_wait > CLEAR_WAIT_MAX) {
> -		pr_err("clear_wait value should be not greater"
> -				" then %d\n", CLEAR_WAIT_MAX);
> -		return -EINVAL;
> -	}
> -
> -	ret = parport_register_driver(&pps_parport_driver);
> -	if (ret) {
> -		pr_err("unable to register with parport\n");
> -		return ret;
> -	}
> -
> -	return  0;
> -}
> -
> -static void __exit pps_parport_exit(void)
> -{
> -	parport_unregister_driver(&pps_parport_driver);
> -}
> -
> -module_init(pps_parport_init);
> -module_exit(pps_parport_exit);
> +module_parport_driver(pps_parport_driver);
>  
>  MODULE_AUTHOR("Alexander Gordeev <lasaine@lvk.cs.msu.su>");
> -MODULE_DESCRIPTION(DRVDESC);
> +MODULE_DESCRIPTION("parallel port PPS client");
>  MODULE_LICENSE("GPL");
> 

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
