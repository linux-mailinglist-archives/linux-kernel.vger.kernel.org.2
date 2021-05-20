Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBC38A121
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhETJ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:28:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:43441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231648AbhETJ1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:27:25 -0400
IronPort-SDR: qFn9r5uHlA2LdLKtBLNfQ1+ujghqo+ZfoclH/A3bRUWtCxgiXR9msjUnQDhC/dBZRw1yEiVC4v
 PV/lx8NQ/9nA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="200885070"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="200885070"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 02:26:03 -0700
IronPort-SDR: cCZAFIu2rgz/EYcxfkVd8lB+nZ8HsI6GSOtoKuvZmDZBUWPMmgZb4JGoHODGHHCCzJOwBL/cRN
 vCOtQ68U5CKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543393954"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 20 May 2021 02:25:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 20 May 2021 12:25:50 +0300
Date:   Thu, 20 May 2021 12:25:50 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] usb: typec: wcove: Fx wrong kernel doc format
Message-ID: <YKYrHlupU1C3S3YW@kuha.fi.intel.com>
References: <20210519085527.48657-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519085527.48657-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 11:55:27AM +0300, Andy Shevchenko wrote:
> The top comment in the file wrongly uses kernel doc format:
> 
> .../typec/tcpm/wcove.c:17: warning: expecting prototype for typec_wcove.c - WhiskeyCove PMIC USB Type(). Prototype was for WCOVE_CHGRIRQ0() instead
> 
> Fix this by converting it to plain comment.
> 
> Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/wcove.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
> index 5d125339687a..20917d85d6f4 100644
> --- a/drivers/usb/typec/tcpm/wcove.c
> +++ b/drivers/usb/typec/tcpm/wcove.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * typec_wcove.c - WhiskeyCove PMIC USB Type-C PHY driver
>   *
>   * Copyright (C) 2017 Intel Corporation
> -- 
> 2.30.2

-- 
heikki
