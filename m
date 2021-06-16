Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F6D3A9C47
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhFPNnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:43:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:60516 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232692AbhFPNn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:43:29 -0400
IronPort-SDR: 5nHsB4ZNwOi4OtK/Mv6ZZb42bNhIIw9NyYRwUxrmQLPFIO4p4sx6qYeOS9iNgtJDJb98pdH+Kj
 Gdfg3aIGAMMg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="185867791"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="185867791"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 06:41:23 -0700
IronPort-SDR: 4ifLwTPG2xbTZHbYoF5hGsNUnevWj1VkQxVOk+X1SePuSzEovjT2+CXsbMddFTEXYggTKtDwwP
 DUhZOdShrpDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="554810049"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 16 Jun 2021 06:41:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Jun 2021 16:41:20 +0300
Date:   Wed, 16 Jun 2021 16:41:20 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Ignore Vsafe0v in
 PR_SWAP_SNK_SRC_SOURCE_ON state
Message-ID: <YMn/gIwB3noYWuHA@kuha.fi.intel.com>
References: <20210615173206.1646477-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615173206.1646477-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 01:32:06AM +0800, Kyle Tso wrote:
> In PR_SWAP_SNK_SRC_SOURCE_ON state, Vsafe0v is expected as well so do
> nothing here to avoid state machine going into SNK_UNATTACHED.
> 
> Fixes: 28b43d3d746b ("usb: typec: tcpm: Introduce vsafe0v for vbus")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 197556038ba4..e11e9227107d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5212,6 +5212,7 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
>  		}
>  		break;
>  	case PR_SWAP_SNK_SRC_SINK_OFF:
> +	case PR_SWAP_SNK_SRC_SOURCE_ON:
>  		/* Do nothing, vsafe0v is expected during transition */
>  		break;
>  	default:
> -- 
> 2.32.0.272.g935e593368-goog

-- 
heikki
