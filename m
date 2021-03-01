Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4A0329FF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574994AbhCBDwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:52:18 -0500
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:54620 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238350AbhCAVyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:54:31 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 60027100E7B40;
        Mon,  1 Mar 2021 21:53:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3351:3622:3865:3867:3871:4321:5007:7514:7652:7903:10004:10400:11232:11658:11914:12043:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wind31_2101327276b7
X-Filterd-Recvd-Size: 1518
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon,  1 Mar 2021 21:53:38 +0000 (UTC)
Message-ID: <70877984ec78d837159dc643e3ae2b05fd91561c.camel@perches.com>
Subject: Re: [PATCH v8 0/3] checkpatch: add verbose mode
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>, mchehab@kernel.org
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date:   Mon, 01 Mar 2021 13:53:35 -0800
In-Reply-To: <87tupu36xi.fsf@meer.lwn.net>
References: <20210226093827.12700-1-dwaipayanray1@gmail.com>
         <87tupu36xi.fsf@meer.lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-01 at 14:22 -0700, Jonathan Corbet wrote:
> Dwaipayan Ray <dwaipayanray1@gmail.com> writes:
> 
> > Add a new verbose mode to checkpatch. The verbose test
> > descriptions are read from the new checkpatch documentation
> > file at `Documentation/dev-tools/checkpatch.rst`, which
> > is also added by this series.
> 
> So I can certainly take the doc change, as requested.  Remind me,
> though...should I apply the whole set, or will the checkpatch changes go
> via another path?

There's no dedicated upstream path for checkpatch.
So please take the checkpatch changes too.


