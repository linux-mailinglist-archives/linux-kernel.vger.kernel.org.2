Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FAD423863
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbhJFG4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:56:47 -0400
Received: from smtpcmd0756.aruba.it ([62.149.156.56]:56546 "EHLO
        smtpcmd0756.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhJFG4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:56:45 -0400
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id Y0pHmV8ROVf6SY0pHmLmLl; Wed, 06 Oct 2021 08:54:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1633503292; bh=gNgKYvDSqWx2oWfY2ZYJeW7mWL6U1Oe4x0IGgv1Na+I=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=d2fhUdYB/iVzd7K4sPvrfFp7xIL1KJthDv3HeKa7GCLj6PcJOhu1WEixuStq+At37
         cF0W+TJ8GuaWaf6QW/AS9EXMBT1noM5EsqZt8tmUEzeKc7qFBGrbmrGE3VJ+KUUzO3
         2Rm6/4QGftrYMM1Y/wH70BZMIPEOfirnMU90rtctA215oJHD3iN8icUblXRiazp6L+
         VvPdmPrVVHCJ22A+H0KX6RULqOphLH6DXl3Fa1VTGomtVogYijZX6Uih97gmixDJgM
         NgxzBdfYxKWzVwWFM8sgVWkHLj7KXUFC+E/H1DpmZOtMRH2GBf4oKtokkaeEI9bvDo
         M9J49zxVyWX4A==
Subject: Re: [PATCH v2 1/1] pps: generators: pps_gen_parport: Switch to use
 module_parport_driver()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <lasaine@lvk.cs.msu.su>
References: <20211001150316.12545-1-andriy.shevchenko@linux.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <bd72ecdb-7d7c-726d-85a4-84ea1088eb70@enneenne.com>
Date:   Wed, 6 Oct 2021 08:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001150316.12545-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBop8+TNved2rhuKK4j1V+nFnvIsOVH3H3UlbNnvH6qdCEZTWpU+yH0KeeC8qZ1Regtm2qdIih3WjwwKonZP6Os7KFYwMf/DjidRXgQO6uF2+MKv2u+G
 4hQ8a108lrW79En2mmCu+zGrXYPI+mg2mgwTrMqxIvyB4zoLOLTPvo7GgfyN6SmoF0I5ir2K9RvpNzIZ9ArtIwghXWsJCe5wLn2KtgavJLTuaU8ibn9J6IE3
 6k67Jyr0TU6Yrrd1rx2WgI4kLUGhFN/RBKMPZHtJniA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/21 17:03, Andy Shevchenko wrote:
> Switch to use module_parport_driver() to reduce boilerplate code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
> v2: remove useless message (Greg), Cc to the original (hopefully) author
>  drivers/pps/generators/pps_gen_parport.c | 42 ++++--------------------
>  1 file changed, 7 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generators/pps_gen_parport.c
> index 6a1af7664f3b..fba6c490977c 100644
> --- a/drivers/pps/generators/pps_gen_parport.c
> +++ b/drivers/pps/generators/pps_gen_parport.c
> @@ -20,8 +20,6 @@
>  #include <linux/hrtimer.h>
>  #include <linux/parport.h>
>  
> -#define DRVDESC "parallel port PPS signal generator"
> -
>  #define SIGNAL		0
>  #define NO_SIGNAL	PARPORT_CONTROL_STROBE
>  
> @@ -180,6 +178,11 @@ static void parport_attach(struct parport *port)
>  {
>  	struct pardev_cb pps_cb;
>  
> +	if (send_delay > SEND_DELAY_MAX) {
> +		pr_err("delay value should be not greater then %d\n", SEND_DELAY_MAX);
> +		return -EINVAL;
> +	}
> +
>  	if (attached) {
>  		/* we already have a port */
>  		return;
> @@ -231,39 +234,8 @@ static struct parport_driver pps_gen_parport_driver = {
>  	.detach = parport_detach,
>  	.devmodel = true,
>  };
> -
> -/* module staff */
> -
> -static int __init pps_gen_parport_init(void)
> -{
> -	int ret;
> -
> -	pr_info(DRVDESC "\n");
> -
> -	if (send_delay > SEND_DELAY_MAX) {
> -		pr_err("delay value should be not greater"
> -				" then %d\n", SEND_DELAY_MAX);
> -		return -EINVAL;
> -	}
> -
> -	ret = parport_register_driver(&pps_gen_parport_driver);
> -	if (ret) {
> -		pr_err("unable to register with parport\n");
> -		return ret;
> -	}
> -
> -	return  0;
> -}
> -
> -static void __exit pps_gen_parport_exit(void)
> -{
> -	parport_unregister_driver(&pps_gen_parport_driver);
> -	pr_info("hrtimer avg error is %ldns\n", hrtimer_error);
> -}
> -
> -module_init(pps_gen_parport_init);
> -module_exit(pps_gen_parport_exit);
> +module_parport_driver(pps_gen_parport_driver);
>  
>  MODULE_AUTHOR("Alexander Gordeev <lasaine@lvk.cs.msu.su>");
> -MODULE_DESCRIPTION(DRVDESC);
> +MODULE_DESCRIPTION("parallel port PPS signal generator");
>  MODULE_LICENSE("GPL");
> 


-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
