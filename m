Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2634399226
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFBSHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:07:41 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:48374 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229541AbhFBSHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:07:40 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6A4E618224D63;
        Wed,  2 Jun 2021 18:05:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 87A622448C2;
        Wed,  2 Jun 2021 18:05:55 +0000 (UTC)
Message-ID: <ef68a1ece1a2db3dca73c326f65304fd640c6a7e.camel@perches.com>
Subject: Re: [PATCH v2] kernel/time: Improve performance of time64_to_tm.
 Add tests.
From:   Joe Perches <joe@perches.com>
To:     Cassio Neri <cassio.neri@gmail.com>, john.stultz@linaro.org,
        tglx@linutronix.de
Cc:     sboyd@kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Jun 2021 11:05:54 -0700
In-Reply-To: <20210602174651.37874-1-cassio.neri@gmail.com>
References: <20210602174651.37874-1-cassio.neri@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.35
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 87A622448C2
X-Stat-Signature: 4c58457tdrg68zsn9csgyczrimgbd7e4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/s5kfWtyTAB33qPzDHWJUT64S+55llffo=
X-HE-Tag: 1622657155-651289
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-02 at 18:46 +0100, Cassio Neri wrote:
> The current implementation of time64_to_tm contains unnecessary loops,
> branches and look-up tables. The new one uses an arithmetic-based algorithm
> appeared in [1] and is ~3.2 times faster (YMMV).

trivia:

> diff --git a/kernel/time/timeconv.c b/kernel/time/timeconv.c
[]
>  void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
>  {
> -	long days, rem, y;
> +	long days, rem;
>  	int remainder;
> -	const unsigned short *ip;
> +
> +	u64 u64tmp, udays, century, year;
> +	u32 u32tmp, day_of_century, year_of_century, day_of_year, month,
> +		day, janOrFeb, is_leap;

janOrFeb is an odd name choice and it and is_leap could be bool
which _might_ improve performance in some memory access cases.

> +	year_of_century = (u32) (u64tmp >> 32);

Perhaps
	year_of_century = upper_32_bits(u64tmp);

> +	day_of_year     = ((u32) u64tmp) / 2939745 / 4;

and
	day_of_year = lower_32_bits(u64tmp) / 2939745 / 4;

> +	is_leap         = year_of_century != 0 ?
> +		year_of_century % 4 == 0 : century % 4 == 0;
> +
> +	u32tmp          = 2141 * day_of_year + 132377;
> +	month           = u32tmp >> 16;
> +	day             = ((u16) u32tmp) / 2141;
> +
> +	/* Recall that January 01 is the 306-th day of the year in the
> +	 * computational (not Gregorian) calendar.
> +	 */
> +	janOrFeb        = day_of_year >= 306;
> +
> +	/* Converts to the Gregorian calendar and adjusts to Unix time. */
> +	year            = year + janOrFeb - 6313183731940000ULL;
> +	month           = janOrFeb ? month - 12 : month;
> +	day             = day + 1;
> +	day_of_year     = janOrFeb ?
> +		day_of_year - 306 : day_of_year + 31 + 28 + is_leap;

I believe the extended naming improves readability, thanks.

