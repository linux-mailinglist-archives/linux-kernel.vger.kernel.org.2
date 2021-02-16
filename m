Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4647631CCB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBPPLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:11:25 -0500
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:60700 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229970AbhBPPLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:11:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2F45D18025887;
        Tue, 16 Feb 2021 15:10:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3867:3868:3870:3871:4321:4605:5007:7652:8604:9393:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: music54_260346527644
X-Filterd-Recvd-Size: 1747
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Feb 2021 15:10:23 +0000 (UTC)
Message-ID: <bff39ad847650483ba2a14ccc1c0d8032bdfa3df.camel@perches.com>
Subject: Re: [PATCH 02/29] alpha: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Robert Richter <rric@kernel.org>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net
Date:   Tue, 16 Feb 2021 07:10:22 -0800
In-Reply-To: <YCvZGuKvtPi6ktNV@rric.localdomain>
References: <cover.1598331148.git.joe@perches.com>
         <4facd57f80c70437f085ba3a1bcf13ae0b63c3bc.1598331148.git.joe@perches.com>
         <52f038d9ff547deee4e5b5628507e61ec8d056b7.camel@perches.com>
         <YCvZGuKvtPi6ktNV@rric.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-16 at 15:39 +0100, Robert Richter wrote:
> On 30.01.21 10:54:42, Joe Perches wrote:
> > On Mon, 2020-08-24 at 21:55 -0700, Joe Perches wrote:
> > > Use semicolons and braces.
> > 
> > ping?
> > 
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > >  arch/alpha/kernel/pci_iommu.c      |  8 +++++---
> > >  arch/alpha/oprofile/op_model_ev4.c | 22 ++++++++++++++--------
> > >  arch/alpha/oprofile/op_model_ev5.c |  8 +++++---
> 
> This patch should be rebased as oprofile is going to be removed in
> 5.12. A branch is in linux-next.

git am --include=arch/alpha/kernel/pci_iommu.c

