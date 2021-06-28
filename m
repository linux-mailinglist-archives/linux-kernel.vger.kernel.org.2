Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1453B66D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhF1QhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:37:02 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51335 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhF1Qg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:36:58 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id ECDD7240003;
        Mon, 28 Jun 2021 16:34:30 +0000 (UTC)
Date:   Mon, 28 Jun 2021 18:34:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Werner Zeh <werner.zeh@siemens.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date and
 time
Message-ID: <YNn6FqAfLwQ/Wwnu@piout.net>
References: <20210614110946.15587-1-werner.zeh@siemens.com>
 <20210624081507.15602-1-werner.zeh@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624081507.15602-1-werner.zeh@siemens.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 24/06/2021 10:15:07+0200, Werner Zeh wrote:
> The timekeeper is synchronized with the CMOS RTC when it is initialized.
> If the RTC buffering is bad (not buffered at all, empty battery) the RTC
> registers can contain random data. In order to avoid date and time
> being completely rubbish check the sanity of the registers before
> calling mktime64. If the values are not valid, set tv_sec to 0 so that
> at least the starting time is valid.
> 
> Signed-off-by: Werner Zeh <werner.zeh@siemens.com>
> ---
> [resent due to wrong lkml address]
> [added RTC maintainers to the recipients]
> This change introduces the same validity check that is already done in
> drivers/rtc/interface.c. If it is not done here, the timekeeper can be
> set up wrongly in the first run and won't be corrected once the RTC driver
> is started because the validity check in the RTC driver drops the time and
> date due to invalid entries.
> 
>  arch/x86/kernel/rtc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
> index 586f718b8e95..f4af7b18c6c0 100644
> --- a/arch/x86/kernel/rtc.c
> +++ b/arch/x86/kernel/rtc.c
> @@ -9,6 +9,7 @@
>  #include <linux/export.h>
>  #include <linux/pnp.h>
>  #include <linux/of.h>
> +#include <linux/rtc.h>
>  
>  #include <asm/vsyscall.h>
>  #include <asm/x86_init.h>
> @@ -64,6 +65,7 @@ void mach_get_cmos_time(struct timespec64 *now)
>  {
>  	unsigned int status, year, mon, day, hour, min, sec, century = 0;
>  	unsigned long flags;
> +	struct rtc_time tm = {0};
>  
>  	/*
>  	 * If pm_trace abused the RTC as storage, set the timespec to 0,
> @@ -118,7 +120,15 @@ void mach_get_cmos_time(struct timespec64 *now)
>  	} else
>  		year += CMOS_YEARS_OFFS;
>  
> -	now->tv_sec = mktime64(year, mon, day, hour, min, sec);
> +	tm.tm_sec = sec;
> +	tm.tm_min = min;
> +	tm.tm_hour = hour;
> +	tm.tm_mday = day;
> +	tm.tm_mon = mon;
> +	tm.tm_year = year;
> +	now->tv_sec = 0;
> +	if (rtc_valid_tm(&tm) == 0)

Doesn't that make the x86 architecture depend on CONFIG_RTC_LIB?


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
