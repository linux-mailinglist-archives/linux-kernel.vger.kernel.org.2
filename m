Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F372320F81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 03:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhBVCpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 21:45:31 -0500
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:50452 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230080AbhBVCp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 21:45:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 53C008419;
        Mon, 22 Feb 2021 02:44:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3873:4321:5007:6119:7652:7903:9040:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21611:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tent34_450231a27674
X-Filterd-Recvd-Size: 1767
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Feb 2021 02:44:46 +0000 (UTC)
Message-ID: <7bd4520e2552e1a9ae7eccb812c197d6a955e85c.camel@perches.com>
Subject: Re: [PATCH v6 1/2] checkpatch: add verbose mode
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 21 Feb 2021 18:44:45 -0800
In-Reply-To: <CABJPP5CJKUeaxUqKzuJD5pd2HsHKcAx9x3iCm6W+Z8AuXiR5Rg@mail.gmail.com>
References: <20210221115802.19788-1-dwaipayanray1@gmail.com>
         <20210221115802.19788-2-dwaipayanray1@gmail.com>
         <46c3b16602f36858b194b22dfbdb2150e25f5d94.camel@perches.com>
         <CABJPP5CJKUeaxUqKzuJD5pd2HsHKcAx9x3iCm6W+Z8AuXiR5Rg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-02-22 at 00:05 +0530, Dwaipayan Ray wrote:
> On Sun, Feb 21, 2021 at 11:36 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Sun, 2021-02-21 at 17:28 +0530, Dwaipayan Ray wrote:
> > > Add a new verbose mode to checkpatch.pl to emit additional verbose
> > > test descriptions. The verbose mode is optional and can be enabled
> > > by the flag -v or --verbose.
> > 
> > OK, maybe add color coding to the list_types output.
> Okay, nice idea!
[]
> Sure, I will do something like this.
> Are there any other improvements you can see right now
> or will the coloring thing suffice?

A lot more descriptive output for the .rst file and
of course a lot more of the types documented...

