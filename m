Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6102B38CD61
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhEUS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:27:35 -0400
Received: from foss.arm.com ([217.140.110.172]:53366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229762AbhEUS1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:27:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE76F1424;
        Fri, 21 May 2021 11:26:10 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 272F03F73D;
        Fri, 21 May 2021 11:26:10 -0700 (PDT)
Date:   Fri, 21 May 2021 19:26:02 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: scmi: Fix off-by-one for linear regulators
 .n_voltages setting
Message-ID: <20210521182602.GM28060@e120937-lin>
References: <20210521073020.1944981-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521073020.1944981-1-axel.lin@ingics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 21, 2021 at 03:30:20PM +0800, Axel Lin wrote:
> For linear regulators, the .n_voltages is (max_uv - min_uv) / uv_step + 1.
> 
> Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Right. Good catch.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

>  drivers/regulator/scmi-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
> index bbadf72b94e8..1f02f60ad136 100644
> --- a/drivers/regulator/scmi-regulator.c
> +++ b/drivers/regulator/scmi-regulator.c
> @@ -173,7 +173,7 @@ scmi_config_linear_regulator_mappings(struct scmi_regulator *sreg,
>  		sreg->desc.uV_step =
>  			vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_STEP];
>  		sreg->desc.linear_min_sel = 0;
> -		sreg->desc.n_voltages = delta_uV / sreg->desc.uV_step;
> +		sreg->desc.n_voltages = (delta_uV / sreg->desc.uV_step) + 1;
>  		sreg->desc.ops = &scmi_reg_linear_ops;
>  	}
>  
> -- 
> 2.25.1
> 
