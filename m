Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964F0311D58
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 14:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhBFNM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 08:12:27 -0500
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:56054 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229522AbhBFNMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 08:12:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C63C3181D3052;
        Sat,  6 Feb 2021 13:11:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3868:3871:3874:4321:5007:7652:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: teeth88_1d02dd8275ed
X-Filterd-Recvd-Size: 1186
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat,  6 Feb 2021 13:11:38 +0000 (UTC)
Message-ID: <834dd19b78470fd827e59ff9224aa50ca4c554fd.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Don't warn about colon termination in
 linker scripts
From:   Joe Perches <joe@perches.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Date:   Sat, 06 Feb 2021 05:11:37 -0800
In-Reply-To: <YB6T9Gf6oKu8R8e9@chrisdown.name>
References: <YBwhqsc2TIVeid3t@chrisdown.name>
         <90cf805f4be6ecf5887fe470af6db2d596dc46a3.camel@perches.com>
         <YB6T9Gf6oKu8R8e9@chrisdown.name>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-02-06 at 13:04 +0000, Chris Down wrote:
> Oh, apologies -- I was somehow operating under the mistaken memory that this 
> was under Andrew's purview and neglected to run get_maintainer.
> 
> I'll resend. :-)

No need really.  The patch is fine.

