Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536243DA322
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 14:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbhG2M3C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jul 2021 08:29:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:3060 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237163AbhG2M3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 08:29:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="209757533"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="209757533"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 05:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="476374217"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jul 2021 05:28:58 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 29 Jul 2021 05:28:57 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX602.ger.corp.intel.com (10.184.107.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 29 Jul 2021 15:28:55 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.2242.010;
 Thu, 29 Jul 2021 15:28:55 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: RE: [PATCH] mei: constify passed buffers and structures
Thread-Topic: [PATCH] mei: constify passed buffers and structures
Thread-Index: AQHXhGRx9NxxichEQkCmnvTG9cR/oatZ4aBA
Date:   Thu, 29 Jul 2021 12:28:55 +0000
Message-ID: <037bb77223bc4622b1df2ab2679a4492@intel.com>
References: <20210729102803.46289-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210729102803.46289-1-krzysztof.kozlowski@canonical.com>
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



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Sent: Thursday, July 29, 2021 13:28
> To: Winkler, Tomas <tomas.winkler@intel.com>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> linux-kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Subject: [PATCH] mei: constify passed buffers and structures
> 
> Buffers and structures passed to MEI bus and client API can be made const
> for safer code and clear indication that it is not modified.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Tomas Winkler <tomas.winkler@intel.com> 

> ---
>  drivers/misc/mei/bus.c     | 18 +++++++++---------
>  drivers/misc/mei/client.h  |  2 +-
>  drivers/misc/mei/mei_dev.h |  2 +-
>  include/linux/mei_cl_bus.h |  9 +++++----
>  4 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c index
> 935acc6bbf3c..09188d9afc06 100644
> --- a/drivers/misc/mei/bus.c
> +++ b/drivers/misc/mei/bus.c
> @@ -31,7 +31,7 @@
>   *
>   * Return: written size bytes or < 0 on error
>   */
> -ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length, u8 vtag,
> +ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length,
> +u8 vtag,
>  		      unsigned int mode)
>  {
>  	struct mei_device *bus;
> @@ -232,8 +232,8 @@ ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf,
> size_t length, u8 *vtag,
>   *  * < 0 on error
>   */
> 
> -ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, u8 *buf, size_t
> length,
> -			    u8 vtag)
> +ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, const u8 *buf,
> +			    size_t length, u8 vtag)
>  {
>  	struct mei_cl *cl = cldev->cl;
> 
> @@ -296,7 +296,7 @@
> EXPORT_SYMBOL_GPL(mei_cldev_recv_nonblock_vtag);
>   *  * written size in bytes
>   *  * < 0 on error
>   */
> -ssize_t mei_cldev_send(struct mei_cl_device *cldev, u8 *buf, size_t length)
> +ssize_t mei_cldev_send(struct mei_cl_device *cldev, const u8 *buf,
> +size_t length)
>  {
>  	return mei_cldev_send_vtag(cldev, buf, length, 0);  } @@ -552,7
> +552,7 @@ EXPORT_SYMBOL_GPL(mei_cldev_ver);
>   *
>   * Return: true if me client is initialized and connected
>   */
> -bool mei_cldev_enabled(struct mei_cl_device *cldev)
> +bool mei_cldev_enabled(const struct mei_cl_device *cldev)
>  {
>  	return mei_cl_is_connected(cldev->cl);  } @@ -771,8 +771,8 @@
> EXPORT_SYMBOL_GPL(mei_cldev_disable);
>   * Return: id on success; NULL if no id is matching
>   */
>  static const
> -struct mei_cl_device_id *mei_cl_device_find(struct mei_cl_device *cldev,
> -					    struct mei_cl_driver *cldrv)
> +struct mei_cl_device_id *mei_cl_device_find(const struct mei_cl_device
> *cldev,
> +					    const struct mei_cl_driver *cldrv)
>  {
>  	const struct mei_cl_device_id *id;
>  	const uuid_le *uuid;
> @@ -815,8 +815,8 @@ struct mei_cl_device_id *mei_cl_device_find(struct
> mei_cl_device *cldev,
>   */
>  static int mei_cl_device_match(struct device *dev, struct device_driver
> *drv)  {
> -	struct mei_cl_device *cldev = to_mei_cl_device(dev);
> -	struct mei_cl_driver *cldrv = to_mei_cl_driver(drv);
> +	const struct mei_cl_device *cldev = to_mei_cl_device(dev);
> +	const struct mei_cl_driver *cldrv = to_mei_cl_driver(drv);
>  	const struct mei_cl_device_id *found_id;
> 
>  	if (!cldev)
> diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h index
> b12cdcde9436..418056fb1489 100644
> --- a/drivers/misc/mei/client.h
> +++ b/drivers/misc/mei/client.h
> @@ -160,7 +160,7 @@ int mei_cl_vt_support_check(const struct mei_cl
> *cl);
>   *
>   * Return: true if the host client is connected
>   */
> -static inline bool mei_cl_is_connected(struct mei_cl *cl)
> +static inline bool mei_cl_is_connected(const struct mei_cl *cl)
>  {
>  	return  cl->state == MEI_FILE_CONNECTED;  } diff --git
> a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h index
> b7b6ef344e80..694f866f87ef 100644
> --- a/drivers/misc/mei/mei_dev.h
> +++ b/drivers/misc/mei/mei_dev.h
> @@ -356,7 +356,7 @@ struct mei_hw_ops {
>  /* MEI bus API*/
>  void mei_cl_bus_rescan_work(struct work_struct *work);  void
> mei_cl_bus_dev_fixup(struct mei_cl_device *dev); -ssize_t
> __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length, u8 vtag,
> +ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length,
> +u8 vtag,
>  		      unsigned int mode);
>  ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length, u8 *vtag,
>  		      unsigned int mode, unsigned long timeout); diff --git
> a/include/linux/mei_cl_bus.h b/include/linux/mei_cl_bus.h index
> 07f5ef8fc456..c6786c12b207 100644
> --- a/include/linux/mei_cl_bus.h
> +++ b/include/linux/mei_cl_bus.h
> @@ -91,12 +91,13 @@ void mei_cldev_driver_unregister(struct
> mei_cl_driver *cldrv);
>  		      mei_cldev_driver_register,\
>  		      mei_cldev_driver_unregister)
> 
> -ssize_t mei_cldev_send(struct mei_cl_device *cldev, u8 *buf, size_t length);
> +ssize_t mei_cldev_send(struct mei_cl_device *cldev, const u8 *buf,
> +		       size_t length);
>  ssize_t mei_cldev_recv(struct mei_cl_device *cldev, u8 *buf, size_t length);
> ssize_t mei_cldev_recv_nonblock(struct mei_cl_device *cldev, u8 *buf,
>  				size_t length);
> -ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, u8 *buf, size_t
> length,
> -			    u8 vtag);
> +ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, const u8 *buf,
> +			    size_t length, u8 vtag);
>  ssize_t mei_cldev_recv_vtag(struct mei_cl_device *cldev, u8 *buf, size_t
> length,
>  			    u8 *vtag);
>  ssize_t mei_cldev_recv_nonblock_vtag(struct mei_cl_device *cldev, u8
> *buf, @@ -114,6 +115,6 @@ void mei_cldev_set_drvdata(struct
> mei_cl_device *cldev, void *data);
> 
>  int mei_cldev_enable(struct mei_cl_device *cldev);  int
> mei_cldev_disable(struct mei_cl_device *cldev); -bool
> mei_cldev_enabled(struct mei_cl_device *cldev);
> +bool mei_cldev_enabled(const struct mei_cl_device *cldev);
> 
>  #endif /* _LINUX_MEI_CL_BUS_H */
> --
> 2.27.0

