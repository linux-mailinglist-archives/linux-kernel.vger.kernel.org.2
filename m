Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918AA35DE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbhDMMBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:01:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:46892 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240873AbhDMMBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:01:17 -0400
IronPort-SDR: SUzVxof2TkpIbHR+xh5rfLjxGOrjTxPA6e9tOwmflE+huJINzhT4/HIKaStng861fj2X6/pCF/
 f10BI4dGzH1Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="255718302"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="255718302"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 05:00:57 -0700
IronPort-SDR: YWugUactZdN64YNoV7u9Q9QEpGcgoiHGZD59BbP8wbGDO5wQ/BpBYooK4mkFoR8PpB6+z63109
 waUHMLw9BoiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="521575683"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Apr 2021 05:00:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 13 Apr 2021 15:00:52 +0300
Date:   Tue, 13 Apr 2021 15:00:52 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/1] devres: Enable trace events
Message-ID: <YHWH9KWrh2kkoAvU@kuha.fi.intel.com>
References: <20210413113801.18245-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413113801.18245-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:38:01PM +0300, Andy Shevchenko wrote:
> In some cases the printf() mechanism is too heavy and can't be used.
> For example, when debugging a race condition involving devres API.
> When CONFIG_DEBUG_DEVRES is enabled I can't reproduce an issue, and
> otherwise it's quite visible with a useful information being collected.
> 
> Enable trace events for devres part of the driver core.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: fixed compilation error (lkp), elaborate commit message (Greg)
>  drivers/base/Makefile |  3 +++
>  drivers/base/devres.c | 23 +++++++++++-------
>  drivers/base/trace.c  | 10 ++++++++
>  drivers/base/trace.h  | 56 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/base/trace.c
>  create mode 100644 drivers/base/trace.h
> 
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 8b93a7f291ec..ef8e44a7d288 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -30,3 +30,6 @@ obj-y			+= test/
>  
>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
>  
> +# define_trace.h needs to know how to find our header
> +CFLAGS_trace.o		:= -I$(src)
> +obj-$(CONFIG_TRACING)	+= trace.o
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index db1f3137fc81..a0850bd1eab7 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -14,14 +14,13 @@
>  #include <asm/sections.h>
>  
>  #include "base.h"
> +#include "trace.h"
>  
>  struct devres_node {
>  	struct list_head		entry;
>  	dr_release_t			release;
> -#ifdef CONFIG_DEBUG_DEVRES
>  	const char			*name;
>  	size_t				size;
> -#endif

Those ifdefs are still required.

>  };

thanks,

-- 
heikki
