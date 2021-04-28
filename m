Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA2B36D4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbhD1JmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:42:22 -0400
Received: from foss.arm.com ([217.140.110.172]:38136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhD1JmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:42:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8EDAED1;
        Wed, 28 Apr 2021 02:41:36 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF3223F70D;
        Wed, 28 Apr 2021 02:41:35 -0700 (PDT)
Date:   Wed, 28 Apr 2021 10:41:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arm@kernel.org
Subject: Re: [PATCH] psci: remove unneeded semicolon
Message-ID: <20210428094121.GA6543@lpieralisi>
References: <1612247872-32603-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612247872-32603-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 02:37:52PM +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/firmware/psci/psci.c:141:2-3: Unneeded semicolon

Nit: subject should read "psci: Remove unneeded semicolon"

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/firmware/psci/psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please send a v2 and address it to Mark, me and arm@kernel.org so
that they can pick it up.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index f5fc429..35b355e 100644
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
> 1.8.3.1
> 
