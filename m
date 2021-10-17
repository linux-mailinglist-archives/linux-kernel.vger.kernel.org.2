Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1192C4306F6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 08:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244997AbhJQGT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 02:19:57 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:26822
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241454AbhJQGT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 02:19:56 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AFoPTaaEH1yAEJnI+pLqE78eALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6Oj/PxG8M5w6fawslcssRIb6LW90cu7IU80nKQdibX5f43SPzUO01?=
 =?us-ascii?q?HHEGgN1+ffKnHbak/D398Y5ONbf69yBMaYNzVHpMzxiTPWL+od?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="396145444"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 08:17:45 +0200
Date:   Sun, 17 Oct 2021 08:17:45 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Kushal-kothari <kushalkothari285@gmail.com>
cc:     linux-arm-kernel@lists.infradead.org, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com, outreachy-kernel@googlegroups.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [Outreachy kernel] [PATCH] staging: vc04_services: Fixed checkpatch
 warning: MSLEEP: msleep < 20ms can sleep for up to 20ms.
In-Reply-To: <20211016215527.119189-1-kushalkothari285@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110170813570.3026@hadrien>
References: <20211016215527.119189-1-kushalkothari285@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Oct 2021, Kushal-kothari wrote:

> Signed-off-by: Kushal-kothari <kushalkothari285@gmail.com>

You need a log message.  The whole thing should not be in the subject
line.  The description of the change should be written in the imperative,
that is Fix instead of Fixed.  But in any case Fix is not a good word to
use because it does not explain what you have done.  What fix have you
implemented.  The log message should explain what you have done and why.

Please carefully read the entire page:

https://kernelnewbies.org/PatchPhilosophy

Please check your patch against what is suggested.

julia


> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 6fbafdfe340f..80a7898c5331 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -857,7 +857,7 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
>  		if (status != VCHIQ_RETRY)
>  			break;
>
> -		msleep(1);
> +		usleep_range(1000, 2000);
>  	}
>
>  	return status;
> @@ -894,7 +894,7 @@ enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
>  		if (status != VCHIQ_RETRY)
>  			break;
>
> -		msleep(1);
> +		usleep_range(1000, 2000);
>  	}
>
>  	return status;
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20211016215527.119189-1-kushalkothari285%40gmail.com.
>
