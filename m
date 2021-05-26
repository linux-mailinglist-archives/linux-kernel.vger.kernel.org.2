Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C793391A60
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhEZOhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:37:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:34045 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234810AbhEZOhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:37:22 -0400
IronPort-SDR: YbqxrKzf9EAfYCg9HDnoYGmqT7eb/i7mqlbEfVHxyWi3OQzMpgLSex2qm/Gf1ZiG/D7j1dsEXb
 smm+fTPRtHFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189599616"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="189599616"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 07:35:49 -0700
IronPort-SDR: prVRViGLE3U/Iz2MmVMKcKzyhEVIetiuMOV0ft0MCJSv7vSZWG056uTdSJAhOcv2923qlVZXNe
 G4uAoXTQFBmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="547215348"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 26 May 2021 07:35:46 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 26 May 2021 17:35:45 +0300
Date:   Wed, 26 May 2021 17:35:45 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 03/24] usb: common: ulpi: Add leading underscores for
 function name '__ulpi_register_driver()'
Message-ID: <YK5cwXE/23Kg7Lml@kuha.fi.intel.com>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526130037.856068-4-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 02:00:16PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/usb/common/ulpi.c:151: warning: expecting prototype for ulpi_register_driver(). Prototype was for __ulpi_register_driver() instead
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/common/ulpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index ce5e6f6711f79..7e13b74e60e5a 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -141,7 +141,7 @@ static const struct device_type ulpi_dev_type = {
>  /* -------------------------------------------------------------------------- */
>  
>  /**
> - * ulpi_register_driver - register a driver with the ULPI bus
> + * __ulpi_register_driver - register a driver with the ULPI bus
>   * @drv: driver being registered
>   * @module: ends up being THIS_MODULE
>   *
> -- 
> 2.31.1

-- 
heikki
