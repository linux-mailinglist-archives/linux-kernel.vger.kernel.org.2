Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A644231CCA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBPPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:09:16 -0500
Received: from mail.manjaro.org ([176.9.38.148]:37584 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBPPJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:09:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 414DC183325;
        Tue, 16 Feb 2021 16:08:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PpCXceh3Pb8D; Tue, 16 Feb 2021 16:08:31 +0100 (CET)
Subject: Re: [PATCH] Add CHARGE_NOW support to cw2015_battery.c
To:     Martin Ashby <martin@ashbysoft.com>,
        Sebastian Reichel <sre@kernel.org>
References: <20210126213928.136561-1-martin@ashbysoft.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        t.schramm@manjaro.org
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <10574fda-0a3b-a762-7795-f1fb609b0dde@manjaro.org>
Date:   Tue, 16 Feb 2021 16:08:24 +0100
MIME-Version: 1.0
In-Reply-To: <20210126213928.136561-1-martin@ashbysoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

thanks for the patch. Looks good and tests fine.

> CHARGE_NOW is expected by some user software (such as waybar)
> instead of 'CAPACITY', in order to correctly calculate
> remaining battery life.
> 
> ---
>   drivers/power/supply/cw2015_battery.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
> index 0146f1bfc..d11059774 100644
> --- a/drivers/power/supply/cw2015_battery.c
> +++ b/drivers/power/supply/cw2015_battery.c
> @@ -511,6 +511,11 @@ static int cw_battery_get_property(struct power_supply *psy,
>   			val->intval = 0;
>   		break;
>   
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		val->intval = cw_bat->battery.charge_full_design_uah;
> +		val->intval = val->intval * cw_bat->soc / 100;
> +		break;
> +
>   	case POWER_SUPPLY_PROP_CURRENT_NOW:
>   		if (cw_battery_valid_time_to_empty(cw_bat) &&
>   		    cw_bat->battery.charge_full_design_uah > 0) {
> @@ -542,6 +547,7 @@ static enum power_supply_property cw_battery_properties[] = {
>   	POWER_SUPPLY_PROP_CHARGE_COUNTER,
>   	POWER_SUPPLY_PROP_CHARGE_FULL,
>   	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
>   	POWER_SUPPLY_PROP_CURRENT_NOW,
>   };
>   
> 

Reviewed-by: Tobias Schramm <t.schramm@manjaro.org>
Tested-by: Tobias Schramm <t.schramm@manjaro.org>
