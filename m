Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFD03174C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhBJXxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:53:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:56544 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233150AbhBJXxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:53:08 -0500
IronPort-SDR: Adg0iXl8TCPD97UbHd2r0RWiWaNkZGOx3cwtWQBMIRz+5SpI514r8iAN3lbFwxGhHUCpsRReQy
 OvBeCXIWmYeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="178661576"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="178661576"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 15:51:21 -0800
IronPort-SDR: XqNM6ILgU45hzWfI+9ZPE8GsnstS2Zh7iuuHJl937w2n0UxXPn5sBu2Fhq6gr5T6SXi9A3nIq0
 bOvUpDXLzfPg==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="421249509"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 15:51:21 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 1792B6365;
        Wed, 10 Feb 2021 15:51:21 -0800 (PST)
Date:   Wed, 10 Feb 2021 15:51:21 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-test-robot <lkp@intel.com>
Subject: Re: [PATCH] platform/surface: aggregator: Fix access of unaligned
 value
Message-ID: <20210210235121.GC75203@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210210230411.1938660-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210230411.1938660-1-luzmaximilian@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Mark Gross <mgross@linx.intel.com>

On Thu, Feb 11, 2021 at 12:04:11AM +0100, Maximilian Luz wrote:
> The raw message frame length is unaligned and explicitly marked as
> little endian. It should not be accessed without the appropriatte
> accessor functions. Fix this.
> 
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
>  }
>  
>  static int ssh_ptl_rx_threadfn(void *data)
> -- 
> 2.30.0
> 
