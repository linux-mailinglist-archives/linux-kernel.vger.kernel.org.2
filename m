Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A018F31C024
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhBORIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:08:54 -0500
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:43762 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232138AbhBOP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:56:37 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A69D0180FAA81;
        Mon, 15 Feb 2021 15:55:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3870:3871:3872:3874:4321:5007:6119:6120:7652:7901:9010:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shelf27_160c8202763c
X-Filterd-Recvd-Size: 1433
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Feb 2021 15:55:51 +0000 (UTC)
Message-ID: <0db021ca12f6a25861ea941f7ad7c9b9be968076.camel@perches.com>
Subject: Re: [PATCH RFC v3 2/3] docs: add documentation for checkpatch
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Feb 2021 07:55:50 -0800
In-Reply-To: <CABJPP5As+68yMdX1CafXsam4rg56aCWUzsSNx6kHjtQnaJ_ofQ@mail.gmail.com>
References: <20210213131513.51386-1-dwaipayanray1@gmail.com>
         <20210213131513.51386-3-dwaipayanray1@gmail.com>
         <b2e25e683a3e2f31d4dc2d666e082634e30643b3.camel@perches.com>
         <CABJPP5As+68yMdX1CafXsam4rg56aCWUzsSNx6kHjtQnaJ_ofQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-02-15 at 21:20 +0530, Dwaipayan Ray wrote:

> Also someone pointed out in the list that some lines in the patch contained > 80
> columns. Checkpatch doesn't generate any warning for that. Is it something that
> could be added to checkpatch or was it decided against at some point?

decided against.
checkpatch isn't useful for .rst files.


