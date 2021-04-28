Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2736D4F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbhD1JrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:47:09 -0400
Received: from foss.arm.com ([217.140.110.172]:38252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhD1JrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:47:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34CF6ED1;
        Wed, 28 Apr 2021 02:46:24 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68F7A3F70D;
        Wed, 28 Apr 2021 02:46:23 -0700 (PDT)
Date:   Wed, 28 Apr 2021 10:46:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] firmware: psci: Remove unneeded semicolon
Message-ID: <20210428094621.GB6543@lpieralisi>
References: <20210428030324.37998-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428030324.37998-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 11:03:24AM +0800, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/firmware/psci/psci.c:141:2-3: Unneeded semicolon
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/firmware/psci/psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixed by a previous posting:

https://lore.kernel.org/lkml/1612247872-32603-1-git-send-email-yang.lee@linux.alibaba.com

Thank you anyway.

Lorenzo

> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 64344e84bd63..6e7bac61ba93 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -138,7 +138,7 @@ static int psci_to_linux_errno(int errno)
>  		return -EINVAL;
>  	case PSCI_RET_DENIED:
>  		return -EPERM;
> -	};
> +	}
>  
>  	return -EINVAL;
>  }
> -- 
> 2.25.1
> 
