Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F103E1B19
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbhHESSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:18:13 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:8798 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241085AbhHESSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:18:12 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ABEs77KNyV830xsBcT63255DYdb4zR+YMi2TD?=
 =?us-ascii?q?iHoBLiC9I/bo8/xGws5rsCMc0AxhJk3I6urwSZVoIEmsqqKdhLNhW4tKMzOWxF?=
 =?us-ascii?q?dARrsO0WLd+Uy/J8STzJ8B6U4CSdkyNDSTNykEsS+g2njjLz9I+rDum8zG9IWu?=
 =?us-ascii?q?tgYUcexzUdAC0+4eMHfGLqRYfngWOXNTLuvE2iMznUvcRZ1hVLXAOpBqZZm5mz?=
 =?us-ascii?q?UL/KiWOSIuNloC0k2jnDmo4Ln1H1yzxREFSQ5Cxr8k7CzsjxH5zr/LiYD19jbs?=
 =?us-ascii?q?k0voq7hGktrozdVOQOaWjNIOFznqggG0IKx8Rry5uiwvqu3H0idlrDCMmWZhAy?=
 =?us-ascii?q?w/g0mhP11dkyGdmTUI4wxerkMK/GXowkcK+aTCNXYH4oR69MVkm1DimjodVZlH?=
 =?us-ascii?q?odF29lPck5JWCBfJm2DU/sHSUQ5nmw6dvBMZ4KguZ/M2a/pEVFY9l+YiFQVuYd?=
 =?us-ascii?q?s9NRO/16wdLclFJOSZxM8TSU+TdHjfo2lpzJiNcx0IcCuucww8lvep8xJ/uTRY?=
 =?us-ascii?q?9g8j7uQ5uVssnahdd7B0o9vpCZlJvplqCu8uKZhlDONEe8GwEWCle3Lx2U+pUC?=
 =?us-ascii?q?La/Zs8Sjvwgo+y5K9w6PCheZQOwpd3kJPdUElAvWp3f071E8WB0JBC7xiIGQyG?=
 =?us-ascii?q?LH/Q49Ab44I8tqz3RbLtPyHGQFcyk9G4q/FaBsHAQf68NJ9fHvemJ2rzHoRC2R?=
 =?us-ascii?q?H4RvBpWDEjueguy5wGsn6107b2w9fRx5nmmd7oVc3Q+RZNYBKMPkc+?=
X-IronPort-AV: E=Sophos;i="5.84,296,1620684000"; 
   d="scan'208";a="522911521"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 20:17:56 +0200
Date:   Thu, 5 Aug 2021 20:17:56 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Whitcroft <apw@canonical.com>,
        cocci <cocci@systeme.lip6.fr>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
In-Reply-To: <e07845c0348f389756b76e34b4728a95aa48038a.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2108052016220.16100@hadrien>
References: <20210805104353.GD26417@kili>         <117021b44dc9ba570a0f48736d14a267a8701d0a.camel@perches.com> <e07845c0348f389756b76e34b4728a95aa48038a.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Aug 2021, Joe Perches wrote:

> On Thu, 2021-08-05 at 05:27 -0700, Joe Perches wrote:
> > On Thu, 2021-08-05 at 13:43 +0300, Dan Carpenter wrote:
> > > The "= {};" style empty struct initializer is preferred over = {0}.
> > > It avoids the situation where the first struct member is a pointer and
> > > that generates a Sparse warning about assigning using zero instead of
> > > NULL.  Also it's just nicer to look at.
>
> Perhaps a cocci script like the below could help too:
>
> $ cat zero_init_struct.cocci
> @@
> identifier name;
> identifier t;
> @@
>
> 	struct name t = {
> -	       0
> 	};
>
> @@
> identifier name;
> identifier t;
> identifier member;
> @@
>
> 	struct name t = {
> 	       ...,
> 		.member = {
> -		0
> 		},
> 		...,
> 	};

My test turns up over 1900 occurrences.  There is the question of whether
{} or { } is preferred.  The above semantic patch replaces {0} by {} and
( 0 } by { }.

julia
