Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A263E1B99
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbhHESox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:44:53 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:22754 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241592AbhHESou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:44:50 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ayn/lL6Ff6gNM5rP5pLqE+ceALOsnbusQ8zAX?=
 =?us-ascii?q?PidKOHlom62j5qKTdZsgvyMc5Ax9ZJhCo6HiBEDjexLhHPdOiOF7AV7FZmXbUQ?=
 =?us-ascii?q?CTQr2Kg7GM/9StIU3DytI=3D?=
X-IronPort-AV: E=Sophos;i="5.84,296,1620684000"; 
   d="scan'208";a="522913201"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 20:44:34 +0200
Date:   Thu, 5 Aug 2021 20:44:34 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Whitcroft <apw@canonical.com>,
        cocci <cocci@systeme.lip6.fr>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
In-Reply-To: <83ffab14de1c2af00d38d532ffecdda1f9e936ab.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2108052043260.16100@hadrien>
References: <20210805104353.GD26417@kili>  <117021b44dc9ba570a0f48736d14a267a8701d0a.camel@perches.com>  <e07845c0348f389756b76e34b4728a95aa48038a.camel@perches.com>  <alpine.DEB.2.22.394.2108052016220.16100@hadrien>
 <83ffab14de1c2af00d38d532ffecdda1f9e936ab.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Aug 2021, Joe Perches wrote:

> On Thu, 2021-08-05 at 20:17 +0200, Julia Lawall wrote:
> > On Thu, 5 Aug 2021, Joe Perches wrote:
> > > On Thu, 2021-08-05 at 05:27 -0700, Joe Perches wrote:
> > > > On Thu, 2021-08-05 at 13:43 +0300, Dan Carpenter wrote:
> > > > > The "= {};" style empty struct initializer is preferred over = {0}.
> > > > > It avoids the situation where the first struct member is a pointer and
> > > > > that generates a Sparse warning about assigning using zero instead of
> > > > > NULL.  Also it's just nicer to look at.
> > >
> > > Perhaps a cocci script like the below could help too:
> > >
> > > $ cat zero_init_struct.cocci
> > > @@
> > > identifier name;
> > > identifier t;
> > > @@
> > >
> > > 	struct name t = {
> > > -	       0
> > > 	};
> > >
> > > @@
> > > identifier name;
> > > identifier t;
> > > identifier member;
> > > @@
> > >
> > > 	struct name t = {
> > > 	       ...,
> > > 		.member = {
> > > -		0
> > > 		},
> > > 		...,
> > > 	};
> >
> > My test turns up over 1900 occurrences.  There is the question of whether
> > {} or { } is preferred.  The above semantic patch replaces {0} by {} and
> > ( 0 } by { }.
>
> I saw that and I don't recall how to force one style or another
> to be output.

If you remove something and put it back, then Coccinelle takes care of
pretty printing it.  So the following produces {} everywhere.  Fortunately
Dan seems to prefer that...

@@
identifier name;
identifier t;
@@

        struct name t =
-              {0}
+              {}
        ;

@@
identifier name;
identifier t;
identifier member;
@@

        struct name t = {
               ...,
                .member =
-               {0}
+               {}
                ,
                ...,
        };

julia
