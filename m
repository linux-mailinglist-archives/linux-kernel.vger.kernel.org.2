Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5233F571
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhCQQ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:26:37 -0400
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:46016 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232006AbhCQQZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:25:57 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id C4BE018091592
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:59:03 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D3071182CF668;
        Wed, 17 Mar 2021 14:58:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:4321:5007:7652:10004:10400:11026:11232:11658:11914:12048:12297:12438:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: top41_5206c062773f
X-Filterd-Recvd-Size: 1942
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 17 Mar 2021 14:58:00 +0000 (UTC)
Message-ID: <eae7016a8cd8f426987dd5c4a2a56c4ec6d28a6e.camel@perches.com>
Subject: Re: [PATCH 2/3] drivers/perf: convert sysfs scnprintf family to
 sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     Qi Liu <liuqi115@huawei.com>, john.garry@huawei.com,
        zhangshaokun@hisilicon.com, will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org
Date:   Wed, 17 Mar 2021 07:57:59 -0700
In-Reply-To: <1615974111-45601-3-git-send-email-liuqi115@huawei.com>
References: <1615974111-45601-1-git-send-email-liuqi115@huawei.com>
         <1615974111-45601-3-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-17 at 17:41 +0800, Qi Liu wrote:
> Use the generic sysfs_emit_at() function take place of scnprintf()
[]
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
[]
> @@ -328,41 +328,37 @@ static ssize_t arm_ccn_pmu_event_show(struct device *dev,
>  			struct arm_ccn_pmu_event, attr);
>  	ssize_t res;
>  
> 
> -	res = scnprintf(buf, PAGE_SIZE, "type=0x%x", event->type);
> +	res = sysfs_emit(buf, "type=0x%x", event->type);
>  	if (event->event)
> -		res += scnprintf(buf + res, PAGE_SIZE - res, ",event=0x%x",
> +		res += sysfs_emit_at(buf + res, res, ",event=0x%x",
>  				event->event);

sysfs_emit_at should always use buf, not buf + offset.
res should be int and is the offset from buf for the output

so the form should be similar to

	int len;

	len = sysfs_emit(buf, "type=0x%x", event->type);
	if (event->event) {
		len += sysfs_emit_at(buf, len, ",event=0x%x", event->event);

		etc...


