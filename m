Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38564223AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhJEKjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:39:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:34741 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhJEKjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:39:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="206521299"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="206521299"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:37:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="623348719"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 05 Oct 2021 03:37:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 05 Oct 2021 13:37:15 +0300
Date:   Tue, 5 Oct 2021 13:37:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: STUSB160X should select REGMAP_I2C
Message-ID: <YVwq26BIm9/cUUu4@kuha.fi.intel.com>
References: <20211004232103.23893-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004232103.23893-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:21:03PM -0700, Randy Dunlap wrote:
> REGMAP_I2C is not a user visible kconfig symbol so driver configs
> should not "depend on" it. They should depend on I2C and then
> select REGMAP_I2C.
> 
> If this worked, it was only because some other driver had set/enabled
> REGMAP_I2C.
> 
> Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Amelie Delaunay <amelie.delaunay@st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- lnx-515-rc4.orig/drivers/usb/typec/Kconfig
> +++ lnx-515-rc4/drivers/usb/typec/Kconfig
> @@ -65,9 +65,9 @@ config TYPEC_HD3SS3220
>  
>  config TYPEC_STUSB160X
>  	tristate "STMicroelectronics STUSB160x Type-C controller driver"
> -	depends on I2C
> -	depends on REGMAP_I2C
>  	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
> +	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  Say Y or M here if your system has STMicroelectronics STUSB160x
>  	  Type-C port controller.

-- 
heikki
