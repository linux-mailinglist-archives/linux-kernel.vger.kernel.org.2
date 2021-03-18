Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E026E3406E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCRNds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:33:48 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:37576 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230010AbhCRNd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:33:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9A5FE18016676;
        Thu, 18 Mar 2021 13:33:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2375:2393:2553:2559:2562:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:7652:10004:10400:10848:11026:11232:11658:11783:11914:12048:12297:12438:12679:12740:12895:13069:13161:13229:13255:13311:13357:13894:14180:14659:14721:21060:21080:21433:21451:21627:21990:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: light50_061599227747
X-Filterd-Recvd-Size: 2864
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Mar 2021 13:33:27 +0000 (UTC)
Message-ID: <50b9ca002b7ce6c34a9c5d32126f667ec2c714b0.camel@perches.com>
Subject: Re: [Linuxarm] Re: [PATCH 2/3] drivers/perf: convert sysfs
 scnprintf family to sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     "liuqi (BA)" <liuqi115@huawei.com>, john.garry@huawei.com,
        zhangshaokun@hisilicon.com, will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org
Date:   Thu, 18 Mar 2021 06:33:25 -0700
In-Reply-To: <a2ccfc0f-5790-ef03-d357-ab606f40b3c5@huawei.com>
References: <1615974111-45601-1-git-send-email-liuqi115@huawei.com>
         <1615974111-45601-3-git-send-email-liuqi115@huawei.com>
         <eae7016a8cd8f426987dd5c4a2a56c4ec6d28a6e.camel@perches.com>
         <a2ccfc0f-5790-ef03-d357-ab606f40b3c5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-03-18 at 17:33 +0800, liuqi (BA) wrote:
> On 2021/3/17 22:57, Joe Perches wrote:
> > On Wed, 2021-03-17 at 17:41 +0800, Qi Liu wrote:
> > > Use the generic sysfs_emit_at() function take place of scnprintf()
> > []
> > > diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> > []
> > > @@ -328,41 +328,37 @@ static ssize_t arm_ccn_pmu_event_show(struct device *dev,
> > >   			struct arm_ccn_pmu_event, attr);
> > >   	ssize_t res;
> > >   
> > > 
> > > 
> > > -	res = scnprintf(buf, PAGE_SIZE, "type=0x%x", event->type);
> > > +	res = sysfs_emit(buf, "type=0x%x", event->type);
> > >   	if (event->event)
> > > -		res += scnprintf(buf + res, PAGE_SIZE - res, ",event=0x%x",
> > > +		res += sysfs_emit_at(buf + res, res, ",event=0x%x",
> > >   				event->event);
> > 
> > sysfs_emit_at should always use buf, not buf + offset.
> > res should be int and is the offset from buf for the output
> > 
> > so the form should be similar to
> > 
> > 	int len;
> > 
> > 	len = sysfs_emit(buf, "type=0x%x", event->type);
> > 	if (event->event) {
> > 		len += sysfs_emit_at(buf, len, ",event=0x%x", event->event);
> > 
> > 		etc...
> > 
> Hi Joe,
> 
> I'll fix the use of sysfs_emit_at in next version, thanks.
> But I think it's better to keep the res as ssize_t, as the return value 
> of this function is ssize_t.

The 2nd arg of sysfs_emit_at is int.
On 64 bit platforms, ssize_t is 64 bit while int is 32.

If res (or len) is ssize_t, there could be a lot of -Wconversion warnings
like this produced when using make W=

warning: conversion from ‘ssize_t’ {aka ‘long int’} to ‘int’ may change value [-Wconversion]
  262 |  len += sysfs_emit_at(buf, len, "\n");


