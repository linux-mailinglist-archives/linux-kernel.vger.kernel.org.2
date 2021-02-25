Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F4A324FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhBYMFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:05:17 -0500
Received: from foss.arm.com ([217.140.110.172]:56418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhBYMFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:05:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAE91D6E;
        Thu, 25 Feb 2021 04:04:25 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E3493F73D;
        Thu, 25 Feb 2021 04:04:24 -0800 (PST)
Date:   Thu, 25 Feb 2021 12:04:14 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     sudeep.holla@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: add missing call to of_node_put()
Message-ID: <20210225120414.GD29356@e120937-lin>
References: <1614244046-57560-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614244046-57560-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for reporting this, you're right but you've missed the braces
around the if block in your patch, because we really want to exit
only on -ENOMEM. Something like:

  	if (ret == -ENOMEM) {
		of_node_put(child);
		return ret;
	}

Regards,

Cristian

On Thu, Feb 25, 2021 at 05:07:26PM +0800, Yang Li wrote:
> In one of the error paths of the for_each_child_of_node() loop,
> add missing call to of_node_put().
> 
> Fix the following coccicheck warning:
> ./drivers/regulator/scmi-regulator.c:343:1-23: WARNING: Function
> "for_each_child_of_node" should have of_node_put() before return around
> line 347.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/regulator/scmi-regulator.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
> index 0e8b3ca..a41bb06 100644
> --- a/drivers/regulator/scmi-regulator.c
> +++ b/drivers/regulator/scmi-regulator.c
> @@ -344,6 +344,7 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
>  		ret = process_scmi_regulator_of_node(sdev, child, rinfo);
>  		/* abort on any mem issue */
>  		if (ret == -ENOMEM)
> +			of_node_put(child);
>  			return ret;
>  	}
>  
> -- 
> 1.8.3.1
> 
