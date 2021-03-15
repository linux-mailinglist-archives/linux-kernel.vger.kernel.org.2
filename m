Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A333733BF0E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbhCOOxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:53:31 -0400
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:60914 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237292AbhCOOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:43:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 42245182CF66F;
        Mon, 15 Mar 2021 14:43:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3173:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6678:7652:8985:9025:10004:10400:11232:11658:11783:11914:12043:12297:12555:12740:12895:12986:13069:13156:13228:13311:13357:13439:13845:13894:14040:14181:14659:14721:21080:21433:21451:21627:21990:30012:30054:30064:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: spot91_0904ad72772d
X-Filterd-Recvd-Size: 2406
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Mar 2021 14:43:03 +0000 (UTC)
Message-ID: <fb1bb7be6fad2dfb4bb3d311fddb39b13966311d.camel@perches.com>
Subject: Re: [PATCH v2 5/5] mtd: spi-nor: swp: Drop 'else' after 'return'
From:   Joe Perches <joe@perches.com>
To:     Tudor.Ambarus@microchip.com, p.yadav@ti.com
Cc:     vigneshr@ti.com, michael@walle.cc, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-kernel@vger.kernel.org
Date:   Mon, 15 Mar 2021 07:43:01 -0700
In-Reply-To: <3ed8da81-55cc-4fbc-cb01-9405ac9709d7@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
         <20210306095002.22983-6-tudor.ambarus@microchip.com>
         <20210308062821.wn4uqfxcg6vo3gcb@ti.com>
         <5723fabcc03455ee6624a7d223186e5fad2bf2e9.camel@perches.com>
         <3ed8da81-55cc-4fbc-cb01-9405ac9709d7@microchip.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-15 at 11:24 +0000, Tudor.Ambarus@microchip.com wrote:
> On 3/15/21 8:53 AM, Joe Perches wrote:
> > On Mon, 2021-03-08 at 11:58 +0530, Pratyush Yadav wrote:
> > > On 06/03/21 11:50AM, Tudor Ambarus wrote:
> > > > else is not generally useful after a break or return.
> > > > 
> > > > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > > 
> > > Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> > > 
> > 
> > I don't think this improves the code.
> > 
> > Generally, checkpatch is a stupid little script.
> > 
> > This code uses a form like:
> >         if (foo)
> >                 return bar;
> >         else
> >                 return baz;
> 
> Isn't else redundant? What are the benefits of keeping the else?

Visual consistency and it's a widely used style.

A long time ago Al Viro wrote:

https://lore.kernel.org/lkml/20140925032215.GK7996@ZenIV.linux.org.uk/

which resulted in the patch to checkpatch that tries to ignore that style.

https://lore.kernel.org/lkml/1411621434.4026.9.camel@joe-AO725/

> > I think better would be to change the code to use temporaries
> > and convert the functions to bool.

> returning one is wrong indeed, would you submit a patch for the conversion
> of the functions to bool?

Just a suggestion...

