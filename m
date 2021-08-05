Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478CE3E1B45
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbhHES2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:28:33 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:55362 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241221AbhHES2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:28:31 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 891DA1802EF2E;
        Thu,  5 Aug 2021 18:28:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 399661D42F7;
        Thu,  5 Aug 2021 18:28:15 +0000 (UTC)
Message-ID: <83ffab14de1c2af00d38d532ffecdda1f9e936ab.camel@perches.com>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Whitcroft <apw@canonical.com>,
        cocci <cocci@systeme.lip6.fr>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Thu, 05 Aug 2021 11:28:14 -0700
In-Reply-To: <alpine.DEB.2.22.394.2108052016220.16100@hadrien>
References: <20210805104353.GD26417@kili>
         <117021b44dc9ba570a0f48736d14a267a8701d0a.camel@perches.com>
         <e07845c0348f389756b76e34b4728a95aa48038a.camel@perches.com>
         <alpine.DEB.2.22.394.2108052016220.16100@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 399661D42F7
X-Spam-Status: No, score=1.32
X-Stat-Signature: 7rw1go6hi8mn6wqjk1fshxtz18ke3nac
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/ZNcsWtRe/4qfW85P24gjRbPtTDpFDiZc=
X-HE-Tag: 1628188095-557803
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-05 at 20:17 +0200, Julia Lawall wrote:
> On Thu, 5 Aug 2021, Joe Perches wrote:
> > On Thu, 2021-08-05 at 05:27 -0700, Joe Perches wrote:
> > > On Thu, 2021-08-05 at 13:43 +0300, Dan Carpenter wrote:
> > > > The "= {};" style empty struct initializer is preferred over = {0}.
> > > > It avoids the situation where the first struct member is a pointer and
> > > > that generates a Sparse warning about assigning using zero instead of
> > > > NULL.  Also it's just nicer to look at.
> > 
> > Perhaps a cocci script like the below could help too:
> > 
> > $ cat zero_init_struct.cocci
> > @@
> > identifier name;
> > identifier t;
> > @@
> > 
> > 	struct name t = {
> > -	       0
> > 	};
> > 
> > @@
> > identifier name;
> > identifier t;
> > identifier member;
> > @@
> > 
> > 	struct name t = {
> > 	       ...,
> > 		.member = {
> > -		0
> > 		},
> > 		...,
> > 	};
> 
> My test turns up over 1900 occurrences.  There is the question of whether
> {} or { } is preferred.  The above semantic patch replaces {0} by {} and
> ( 0 } by { }.

I saw that and I don't recall how to force one style or another
to be output.


