Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3460C3ED2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhHPLPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:15:06 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:41686 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231652AbhHPLPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:15:05 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A08A6204BB;
        Mon, 16 Aug 2021 11:14:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 64611315D7A;
        Mon, 16 Aug 2021 11:14:32 +0000 (UTC)
Message-ID: <5ec326711eaf178754a02816f20510a7d860b378.camel@perches.com>
Subject: Re: [PATCH 1/4] staging: r8188eu: refactor
 rtw_is_cckrates_included()
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Aug 2021 04:14:31 -0700
In-Reply-To: <20210816095840.24259-1-straube.linux@gmail.com>
References: <20210816095840.24259-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.60
X-Stat-Signature: 9n77txsehf73xemcak6m3t9stehd8pqc
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 64611315D7A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19csrqDwimCnRbpgGA5vCtdn7wIwrapD00=
X-HE-Tag: 1629112472-559648
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-16 at 11:58 +0200, Michael Straube wrote:
> Refactor function rtw_is_cckrates_included(). Improves readability
> and slightly reduces object file size.
[]
> diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
[]
> @@ -70,13 +70,12 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
>  
> 
>  uint	rtw_is_cckrates_included(u8 *rate)
>  {
> -	u32	i = 0;
> +	while (*rate) {
> +		u8 r = *rate & 0x7f;
> 
> -	while (rate[i] != 0) {
> -		if  ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
> -		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
> +		if (r == 2 || r == 4 || r == 11 || r == 22)
>  			return true;
> -		i++;
> +		rate++;
>  	}
>  	return false;
>  }

Bikeshed:

More compact code with only 1 reference of rate not 3 is more
readable to at least me.

	u8 r;

	while ((r = *rate++ & 0x7f)) {
		if (r == 2 || r == 4 || r == 11 || r == 22)
			return true;
	}

	return false;

And you might make a static inline for the test of r so it could
be reused in the rtw_is_cckratesonly_included function

static inline bool is_cckrate(u8 rate)
{
	return rate == 2 || rate == 4 || rate == 11 || rate == 22;
}

so this could be:

	u8 r;

	while ((r = *rate++ & 0x7f)) {
		if (is_cckrate(r))
			return true;
	}

	return false;


