Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB1B3097B8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 19:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhA3S5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 13:57:41 -0500
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:42118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230095AbhA3S5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 13:57:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B46EC182CED5B;
        Sat, 30 Jan 2021 18:56:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2903:3138:3139:3140:3141:3142:3353:3622:3865:3868:3874:4250:4321:5007:6119:7652:7903:10004:10400:11026:11232:11658:11914:12043:12296:12297:12438:12555:12740:12895:12986:13069:13311:13357:13439:13894:14181:14659:14721:21080:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: plane06_350769c275b3
X-Filterd-Recvd-Size: 2533
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jan 2021 18:56:55 +0000 (UTC)
Message-ID: <e65adfa0d8a74e06edda822ac42f7c62c8e0af90.camel@perches.com>
Subject: Re: [PATCH 05/29] ata: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 30 Jan 2021 10:56:54 -0800
In-Reply-To: <2a3979b0eab31224e53553ca01759eb072790a65.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
         <2a3979b0eab31224e53553ca01759eb072790a65.1598331148.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

ping?
 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/ata/pata_icside.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
> index 08543aeb0093..498383cb6e29 100644
> --- a/drivers/ata/pata_icside.c
> +++ b/drivers/ata/pata_icside.c
> @@ -202,14 +202,19 @@ static void pata_icside_set_dmamode(struct ata_port *ap, struct ata_device *adev
>  	 * Choose the IOMD cycle timing which ensure that the interface
>  	 * satisfies the measured active, recovery and cycle times.
>  	 */
> -	if (t.active <= 50 && t.recover <= 375 && t.cycle <= 425)
> -		iomd_type = 'D', cycle = 187;
> -	else if (t.active <= 125 && t.recover <= 375 && t.cycle <= 500)
> -		iomd_type = 'C', cycle = 250;
> -	else if (t.active <= 200 && t.recover <= 550 && t.cycle <= 750)
> -		iomd_type = 'B', cycle = 437;
> -	else
> -		iomd_type = 'A', cycle = 562;
> +	if (t.active <= 50 && t.recover <= 375 && t.cycle <= 425) {
> +		iomd_type = 'D';
> +		cycle = 187;
> +	} else if (t.active <= 125 && t.recover <= 375 && t.cycle <= 500) {
> +		iomd_type = 'C';
> +		cycle = 250;
> +	} else if (t.active <= 200 && t.recover <= 550 && t.cycle <= 750) {
> +		iomd_type = 'B';
> +		cycle = 437;
> +	} else {
> +		iomd_type = 'A';
> +		cycle = 562;
> +	}
>  
> 
>  	ata_dev_info(adev, "timings: act %dns rec %dns cyc %dns (%c)\n",
>  		     t.active, t.recover, t.cycle, iomd_type);


