Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8ABB421EEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 08:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhJEGlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 02:41:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35482 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232261AbhJEGln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 02:41:43 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194KMJIA032451;
        Tue, 5 Oct 2021 08:39:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=VC2wmfkzeObu+iTVtoupwUnFL8jOkpIUViPHw13oW84=;
 b=kMRS9tzgtkFpQ7Hy7GJVBKnfD/+1hXL1fLVDLg2RerBXYSXQUx1ky793/+EyqMGh7dD/
 j0/UR+xTfNechxaHKC/H5SglNEYwjiFXeiO8zEhjL9ITiIl/p9kE5Wl0vRhZ0sHDgirv
 ufvSjk+LJxEbh8Z/TkinXVIiSdaYTrPheO8175MYRqBvCF9u7BiYwfBnkcIijvxqGP5R
 EU7O/y7vT7E1CXABMM+JkGOE0X8Tu6YYlHeDS5GbUF5VYWDlyjsnNA65adCwL+zTcJeT
 iK+yQUZ5dY76i1khWo2GIXzYu2tZcOp13VY2cOp7d7QB6MSgO4YQ65eR95ghRfRTyj/e wQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bg8kdtb4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 08:39:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9F8B6100034;
        Tue,  5 Oct 2021 08:39:39 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A3C95207557;
        Tue,  5 Oct 2021 08:39:39 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 08:39:38 +0200
Subject: Re: [PATCH] usb: typec: STUSB160X should select REGMAP_I2C
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
References: <20211004232103.23893-1-rdunlap@infradead.org>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <a9e54a79-470e-0d31-6d5d-73d28eeddb64@foss.st.com>
Date:   Tue, 5 Oct 2021 08:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211004232103.23893-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/21 1:21 AM, Randy Dunlap wrote:
> REGMAP_I2C is not a user visible kconfig symbol so driver configs
> should not "depend on" it. They should depend on I2C and then
> select REGMAP_I2C.
> 
> If this worked, it was only because some other driver had set/enabled
> REGMAP_I2C.
> 
> Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch.

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Amelie Delaunay <amelie.delaunay@st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> ---
>   drivers/usb/typec/Kconfig |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- lnx-515-rc4.orig/drivers/usb/typec/Kconfig
> +++ lnx-515-rc4/drivers/usb/typec/Kconfig
> @@ -65,9 +65,9 @@ config TYPEC_HD3SS3220
>   
>   config TYPEC_STUSB160X
>   	tristate "STMicroelectronics STUSB160x Type-C controller driver"
> -	depends on I2C
> -	depends on REGMAP_I2C
>   	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
> +	depends on I2C
> +	select REGMAP_I2C
>   	help
>   	  Say Y or M here if your system has STMicroelectronics STUSB160x
>   	  Type-C port controller.
> 
