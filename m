Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D60379F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhEKFRx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 May 2021 01:17:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:28216 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhEKFRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:17:51 -0400
IronPort-SDR: eYDM7yZN8vfYRIwg697Tha/N3pMh8/n8epDDu8OTxC+ZuDPvY7vyia2v9CKz2UgjwqcAifMJvd
 Ql3Ii+4J+Tmw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="284844780"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="284844780"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:16:45 -0700
IronPort-SDR: RZyI3NqDyiLi8q2VUwWMZEZvwDk4gq3uFE3eY95VmnEM1S6ryfZAzq4MvxZvKjzFm/e6ZZYy50
 guf7gc/3R4hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="434178590"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 10 May 2021 22:16:44 -0700
Received: from lcsmsx603.ger.corp.intel.com (10.109.210.12) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 10 May 2021 22:16:43 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX603.ger.corp.intel.com (10.109.210.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 08:16:41 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.2106.013;
 Tue, 11 May 2021 08:16:41 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: Drop unnecessary NULL check after container_of
Thread-Topic: [PATCH] mei: Drop unnecessary NULL check after container_of
Thread-Index: AQHXRiHYJEv7njgv4kuJ2lTX3NAWS6rdvT9A
Date:   Tue, 11 May 2021 05:16:41 +0000
Message-ID: <42c7b18dae6648d69346cc6b77e92178@intel.com>
References: <20210511045512.2376580-1-linux@roeck-us.net>
In-Reply-To: <20210511045512.2376580-1-linux@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> The result of container_of() operations is never NULL unless the embedded
> element is the first element of the data structure, which is not the case here.
> The NULL check is therefore unnecessary and misleading. Remove it.
> 
> This change was made automatically with the following Coccinelle script.
> 
> @@
> type t;
> identifier v;
> statement s;
> @@
> 
> <+...
> (
>   t v = container_of(...);
> |
>   v = container_of(...);
> )
>   ...
>   when != v
> - if (\( !v \| v == NULL \) ) s
> ...+>
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c index
> 28937b6e7e0c..9001c45f6fc4 100644
> --- a/drivers/misc/mei/main.c
> +++ b/drivers/misc/mei/main.c
> @@ -50,8 +50,6 @@ static int mei_open(struct inode *inode, struct file *file)
>  	int err;
> 
>  	dev = container_of(inode->i_cdev, struct mei_device, cdev);
> -	if (!dev)
> -		return -ENODEV;
> 
>  	mutex_lock(&dev->device_lock);
> 
> --
> 2.25.1

