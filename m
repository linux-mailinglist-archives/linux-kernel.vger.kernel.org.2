Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CB131882E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBKK2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:28:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:32681 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230155AbhBKKY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:24:56 -0500
IronPort-SDR: SSzWNTIZR04xofEdIGbYaaXgL+9pG0WdMk+rOkQ+GDgjulEGP+2Yf0s7nILNuPGqu+RxacYh5B
 BpgdMaPphH6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161363831"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="161363831"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 02:23:01 -0800
IronPort-SDR: /+tBbN4uqbJAfvAU8e92x72ZX33qR7m3gpoEidH2oLX39AD5xoV50ZECA+Kt5yO7dTRd1aHQx+
 E+c+4yIN1KTA==
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="375794713"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 02:22:59 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lA97g-004CLK-Py; Thu, 11 Feb 2021 12:22:56 +0200
Date:   Thu, 11 Feb 2021 12:22:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-test-robot <lkp@intel.com>
Subject: Re: [PATCH] platform/surface: aggregator: Fix access of unaligned
 value
Message-ID: <YCUFgF9gmyeO+796@smile.fi.intel.com>
References: <20210210230411.1938660-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210230411.1938660-1-luzmaximilian@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:04:11AM +0100, Maximilian Luz wrote:
> The raw message frame length is unaligned and explicitly marked as
> little endian. It should not be accessed without the appropriatte
> accessor functions. Fix this.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Though a few nit-picks below.

> Reported-by: kernel-test-robot <lkp@intel.com>
> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>  drivers/platform/surface/aggregator/ssh_packet_layer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> index 583315db8b02..9a78188d8d1c 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -1774,7 +1774,8 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
>  		break;
>  	}
>  
> -	return aligned.ptr - source->ptr + SSH_MESSAGE_LENGTH(frame->len);
> +	return aligned.ptr - source->ptr
> +		+ SSH_MESSAGE_LENGTH(get_unaligned_le16(&frame->len));

I would leave + on previous line.
Also it's possible to annotate temporary variable and use it, but it seems not
worth to do.

Side question: Do you think the below is correct (& operator)?

        sp.len = get_unaligned_le16(&((struct ssh_frame *)sf.ptr)->len);

To me seems like you take an address to len member rather its value.

>  }
>  
>  static int ssh_ptl_rx_threadfn(void *data)

-- 
With Best Regards,
Andy Shevchenko


