Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7950032BA84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357838AbhCCLYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:24:42 -0500
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:46190 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232490AbhCCCtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 21:49:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 42E2418225631;
        Wed,  3 Mar 2021 02:47:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3870:3871:3872:4031:4321:4605:5007:6119:7652:7903:8603:10004:10400:11026:11232:11658:11914:12043:12295:12297:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21433:21611:21627:21740:21741:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tin16_1602863276c1
X-Filterd-Recvd-Size: 2532
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Mar 2021 02:47:52 +0000 (UTC)
Message-ID: <6b8b250a06a98ce42120a14824531a8641f5e8aa.camel@perches.com>
Subject: Re: [Cocci] linux-kernel janitorial RFP: Mark static arrays as const
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 02 Mar 2021 18:47:51 -0800
In-Reply-To: <alpine.DEB.2.22.394.2103022241050.2906@hadrien>
References: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
         <alpine.DEB.2.22.394.2103022241050.2906@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-02 at 22:41 +0100, Julia Lawall wrote:
> 
> On Tue, 2 Mar 2021, Joe Perches wrote:
> 
> > Here is a possible opportunity to reduce data usage in the kernel.
> 
> Does it actually reduce data usage?

Yes, at least for gcc.  For instance:

$ gcc --version
gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0

And with the diff below (x86-64 defconfig with hwmon/pmbus and max20730)

$ diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index 9dd3dd79bc18..b824eab95456 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -434,7 +434,7 @@ static long direct_to_val(u16 w, enum pmbus_sensor_classes >
        return d;
 }
 
-static u32 max_current[][5] = {
+static const u32 max_current[][5] = {
        [max20710] = { 6200, 8000, 9700, 11600 },
        [max20730] = { 13000, 16600, 20100, 23600 },
        [max20734] = { 21000, 27000, 32000, 38000 },

$ size drivers/hwmon/pmbus/max20730.o*
   text	   data	    bss	    dec	    hex	filename
   9245	    256	      0	   9501	   251d	drivers/hwmon/pmbus/max20730.o.gcc.new
   9149	    352	      0	   9501	   251d	drivers/hwmon/pmbus/max20730.o.gcc.old

with clang-11 it doesn't seem to make a difference:

$ /usr/bin/clang --version
Ubuntu clang version 11.0.0-2

$ size drivers/hwmon/pmbus/max20730.o*
   text	   data	    bss	    dec	    hex	filename
   9166	    256	      1	   9423	   24cf	drivers/hwmon/pmbus/max20730.o.clang-11.new
   9166	    256	      1	   9423	   24cf	drivers/hwmon/pmbus/max20730.o.clang-11.old


