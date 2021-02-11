Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E3318C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhBKNcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:32:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:29897 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231567AbhBKNHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:07:40 -0500
IronPort-SDR: z1kKqnFwU+kN5dqt3YHaMVjSqF+1JQd4GQvCe4RcIG05asDY6EzesQyFNI0CR7TI14t+V0D1be
 t6fIWI++92ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161379339"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="161379339"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:06:13 -0800
IronPort-SDR: Mm5mJyui1VJd1BUeLJpYp2lb0DD7frreI4IRQpQMPENH4YeDra1ltGX/dwJKqVIRLrernDGMXL
 JWz2iXzsTmRA==
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="510846864"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:06:11 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lABfc-004E6i-FI; Thu, 11 Feb 2021 15:06:08 +0200
Date:   Thu, 11 Feb 2021 15:06:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linx.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-test-robot <lkp@intel.com>
Subject: Re: [PATCH v2] platform/surface: aggregator: Fix access of unaligned
 value
Message-ID: <YCUrwLsQEqUzr267@smile.fi.intel.com>
References: <20210211124149.2439007-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211124149.2439007-1-luzmaximilian@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 01:41:49PM +0100, Maximilian Luz wrote:
> The raw message frame length is unaligned and explicitly marked as
> little endian. It should not be accessed without the appropriate
> accessor functions. Fix this.
> 
> Note that payload.len already contains the correct length after parsing
> via sshp_parse_frame(), so we can simply use that instead.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: kernel-test-robot <lkp@intel.com>
> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> 
> Changes in v2:
>  - Use payload.len instead of getting the frame length directly. Note
>    that payload.len equals the frame length and is already correctly set
>    in sshp_parse_frame(), so they are exactly the same thing. Makes it
>    look a bit nicer though.
> 
>    I did drop the ACKs/Reveiewd-by in case you want to check that
>    yourselves and since that's essentially the whole change.
> 
> ---
>  drivers/platform/surface/aggregator/ssh_packet_layer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> index 583315db8b02..15d96eac6811 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -1774,7 +1774,7 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
>  		break;
>  	}
>  
> -	return aligned.ptr - source->ptr + SSH_MESSAGE_LENGTH(frame->len);
> +	return aligned.ptr - source->ptr + SSH_MESSAGE_LENGTH(payload.len);
>  }
>  
>  static int ssh_ptl_rx_threadfn(void *data)
> -- 
> 2.30.0
> 

-- 
With Best Regards,
Andy Shevchenko


