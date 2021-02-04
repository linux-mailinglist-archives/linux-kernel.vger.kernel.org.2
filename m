Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4919230ECF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhBDHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:06:10 -0500
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:43824 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229998AbhBDHGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:06:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 45834180A911F;
        Thu,  4 Feb 2021 07:05:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:4321:5007:7652:7875:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21451:21611:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: tank64_5c15dea275da
X-Filterd-Recvd-Size: 1662
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Feb 2021 07:05:23 +0000 (UTC)
Message-ID: <d4c12ffbfca8a66ddaa3224296e964ecf9aa0705.camel@perches.com>
Subject: Re: [PATCH] firewire: convert sysfs sprintf/snprintf family to
 sysfs_emit
From:   Joe Perches <joe@perches.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date:   Wed, 03 Feb 2021 23:05:22 -0800
In-Reply-To: <1612421432-39124-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1612421432-39124-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-02-04 at 14:50 +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/firewire/core-device.c:375:8-16: WARNING: use scnprintf or
> sprintf.
[]
> diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
[]
> @@ -372,8 +372,7 @@ static ssize_t rom_index_show(struct device *dev,
>  	struct fw_device *device = fw_device(dev->parent);
>  	struct fw_unit *unit = fw_unit(dev);
>  
> 
> -	return snprintf(buf, PAGE_SIZE, "%d\n",
> -			(int)(unit->directory - device->config_rom));
> +	return sysfs_emit(buf, "%d\n", (int)(unit->directory - device->config_rom));

Perhaps this should use the ptrdiff_t qualifier '%td' instead:

	return sysfs_emit(buf, "%td\n", unit->directory - device->config_rom);


