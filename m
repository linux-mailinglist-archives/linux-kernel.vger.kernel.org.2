Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0165440428
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 22:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhJ2Ufw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 16:35:52 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:55882 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhJ2Ufu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 16:35:50 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru E52BF208D528
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 1/3] Docs: usb: update err() to pr_err() and replace
 __FILE__
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-usb@vger.kernel.org>
References: <cover.1635533924.git.philipp.g.hortmann@gmail.com>
 <e2f2c5c6995a011494105484849776a856af5bcc.1635533924.git.philipp.g.hortmann@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <49a766ec-014e-3667-828c-a4fd19c7c9e3@omp.ru>
Date:   Fri, 29 Oct 2021 23:33:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e2f2c5c6995a011494105484849776a856af5bcc.1635533924.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/21 10:39 PM, Philipp Hortmann wrote:

> update err() to pr_err() and replace __FILE__
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  Documentation/driver-api/usb/writing_usb_driver.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
> index 2176297e5765..5c29e5bdbe88 100644
> --- a/Documentation/driver-api/usb/writing_usb_driver.rst
> +++ b/Documentation/driver-api/usb/writing_usb_driver.rst
> @@ -91,8 +91,8 @@ usually in the driver's init function, as shown here::
>  	    /* register this driver with the USB subsystem */
>  	    result = usb_register(&skel_driver);
>  	    if (result < 0) {
> -		    err("usb_register failed for the "__FILE__ "driver."
> -			"Error number %d", result);
> +		    pr_err("usb_register failed for the %s driver. "

   Don't break up the kernel message like this. The current code is a bad example --
high time to fix it. :-)

> +			   "Error number %d", skel_driver.name, result);
>  		    return -1;
>  	    }
>  

MBR, Sergey
