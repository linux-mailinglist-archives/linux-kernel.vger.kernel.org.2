Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6795C391A50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhEZOfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:35:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:55767 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234654AbhEZOfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:35:50 -0400
IronPort-SDR: kDmIkT1linDVZu9VXytLv08oHSJnyVZ7ovml/ZfxuYf25u7Kd7jp9rLCXyqmtmKI8me6xtJNoC
 vc6NmWVbcBWw==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202237222"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="202237222"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 07:34:19 -0700
IronPort-SDR: RhaMNxmy4Z0+41CmajKuQzy5L+Qz5M4ETm8NUsnfxBk4u2fj0WQxd8FhUzvUwkqoEbK7Jnyqmi
 dex+xM9m1c6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="547214622"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 26 May 2021 07:34:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 26 May 2021 17:34:16 +0300
Date:   Wed, 26 May 2021 17:34:16 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 24/24] usb: typec: ucsi: Fix copy/paste issue for
 'ucsi_set_drvdata()'
Message-ID: <YK5caP3nNiAsaC6e@kuha.fi.intel.com>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-25-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526130037.856068-25-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 02:00:37PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/usb/typec/ucsi/ucsi.c:1287: warning: expecting prototype for ucsi_get_drvdata(). Prototype was for ucsi_set_drvdata() instead
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index b433169ef6fa4..4e1973fbdf0dc 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1279,7 +1279,7 @@ void *ucsi_get_drvdata(struct ucsi *ucsi)
>  EXPORT_SYMBOL_GPL(ucsi_get_drvdata);
>  
>  /**
> - * ucsi_get_drvdata - Assign private driver data pointer
> + * ucsi_set_drvdata - Assign private driver data pointer
>   * @ucsi: UCSI interface
>   * @data: Private data pointer
>   */
> -- 
> 2.31.1

-- 
heikki
