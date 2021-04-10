Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB835AA35
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 04:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhDJCH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 22:07:26 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:41116 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229665AbhDJCHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:07:25 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A36711812FAA6;
        Sat, 10 Apr 2021 02:07:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 91FCC27DD18;
        Sat, 10 Apr 2021 02:07:10 +0000 (UTC)
Message-ID: <f5fe04d62b22eb5e09c299e769d9b9d8917f119c.camel@perches.com>
Subject: Re: [PATCH 4/6] staging: rtl8192e: matched alignment with open
 parenthesis
From:   Joe Perches <joe@perches.com>
To:     Mitali Borkar <mitaliborkar810@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Date:   Fri, 09 Apr 2021 19:07:09 -0700
In-Reply-To: <YHEA2Te3Hik5J39t@kali>
References: <YHEA2Te3Hik5J39t@kali>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 91FCC27DD18
X-Spam-Status: No, score=0.10
X-Stat-Signature: mkpzxbsbmfazgbhd1k69skk37sdefyeh
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX187jCxClcn3J4yFzx2u4t0xldxYR15e8j0=
X-HE-Tag: 1618020430-317341
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-04-10 at 07:05 +0530, Mitali Borkar wrote:
> Matched the alignment with open parenthesis to meet linux kernel coding
> style.
> Reported by checkpatch.
[]
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
[]
> @@ -154,7 +154,7 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
>  	    (net->ralink_cap_exist))
>  		retValue = true;
>  	else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
> -		!memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
> +		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
>  		!memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
>  		(net->broadcom_cap_exist))

checkpatch is a stupid script.
Look further at the code not just at what checkpatch reports.
Align all the contination lines, not just the first one.

It might be sensible to add a generic function like

static inline bool ether_oui_equal(const u8 *addr, const u8 *oui)
{
	return addr[0] == oui[0] && addr[1] == oui[1] && addr[2] == oui[2];
}	

to include/linux/etherdevice.h

(Maybe use & instead of && if it's speed sensitive)

so this would read

	else if (ether_oui_equal(net->bssid, UNKNOWN_BORADCOM) ||
		 ether_oui_equal(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM) ||
		 ether_oui_equal(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM) ||
		 net->broacom_cap_exist)

and it'd also be good to correct the typo of UNKNOWN_BORADCOM globally.

> @@ -654,13 +654,13 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
>  	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
>  
> 
>  	memset((void *)(&(pHTInfo->SelfHTCap)), 0,
> -		sizeof(pHTInfo->SelfHTCap));
> +	       sizeof(pHTInfo->SelfHTCap));

Doesn't need casts or parentheses.

	memset(&pHTInfo->SelfHTCap, 0, sizeof(pHTInfo->SelfHCap));

>  	memset((void *)(&(pHTInfo->SelfHTInfo)), 0,
> -		sizeof(pHTInfo->SelfHTInfo));
> +	       sizeof(pHTInfo->SelfHTInfo));

etc...

> @@ -815,7 +815,7 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
>  		HTFilterMCSRate(ieee, ieee->Regdot11TxHTOperationalRateSet,
>  				ieee->dot11HTOperationalRateSet);
>  		ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
> -					   ieee->dot11HTOperationalRateSet,
> +							       ieee->dot11HTOperationalRateSet,
>  					   MCS_FILTER_ALL);

multi line statement alignment etc...


