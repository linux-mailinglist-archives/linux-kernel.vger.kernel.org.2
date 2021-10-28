Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796E343E402
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhJ1OnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:43:05 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42926 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230451AbhJ1OnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:43:04 -0400
IronPort-Data: =?us-ascii?q?A9a23=3Aga/KPqB0g3RQ3BVW/37iw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fU1HrgGkr3mdRn2AfWz2GP/vfYGrzeNggO4q0909V7Z+Ax9UxeLYW3SE0HigS8?=
 =?us-ascii?q?aIpJvzAcxyuZ3vKRiH7ofMOA/w2MrEsF+hpCC+DzvuRGuK59yAljfvYHuCU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+6UzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8tA9+?=
 =?us-ascii?q?/k7v9GqEIau6Pe1bezCMMAu773UMqSi8ai87XMNIedENWgnONls94zNFltJqqS?=
 =?us-ascii?q?A5vMLekdOE1AkgFSX8hVUFB0PqdSZSliuSQxlfBd3rqyvl0C0swPI4w9eN+AGU?=
 =?us-ascii?q?I/vsdQBgDaxyOifi/xrm2UeJrrssmJcjveogYvxlIyizFF/svSpDSBqbH/9lV2?=
 =?us-ascii?q?B8/gcdBGfvRfc0EcSEpZxPFCzVAIFoYC5IWmOaum2nxdCBepFuJpK0xpW/Jw2R?=
 =?us-ascii?q?Z3r/3PcHJUtWORNlJmkuEoWXf4mX0HlccOcD34T6E9G+8w/TTlCz6Xo06ELyj6?=
 =?us-ascii?q?uUshFyV23xVBBAIPXO/oP+kmgu9VshZJkg85CUjt+4x+VatQ927WAe3yENoFDZ?=
 =?us-ascii?q?0t8F4SrJhrljXk+yKs0DJWy4eQyAHc9I88sk7WVQXOpayt4uBLVRSXHe9ExpxL?=
 =?us-ascii?q?oupkA4=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Aw+FPzaOMK6uACMBcTsCjsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TETdfU7SKelfqyV9sjzkCWatN9zYhEdcLK7VJVoKEm0naKdo7N+AV7IZmjbUR?=
 =?us-ascii?q?6TXeZfBPzZslnd8kPFm9K1rZ0QFpSWX+eAb2RHsQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,190,1631570400"; 
   d="scan'208";a="995267"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 16:40:36 +0200
Date:   Thu, 28 Oct 2021 16:40:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 4/7] staging: vt6655: Introduce `data`
 temporary variable
In-Reply-To: <186358f460f2093dc8a60a8120be3dc6f830c81f.camel@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110281639360.9518@hadrien>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>  <2039159.k92FijXA2m@localhost.localdomain>  <alpine.DEB.2.22.394.2110281332040.9518@hadrien>  <39890856.3BBMun7449@localhost.localdomain>
 <186358f460f2093dc8a60a8120be3dc6f830c81f.camel@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2021-10-28 at 13:32 +0200, Julia Lawall wrote:
> > Would it be better as data[i] ?
> >
> > Could there be a better name than "data"?  Perhaps "table"?
>
> Hmm, now when I'm thinking about, it indeed looks like a better option.
> I would even say that `data` (or `table`/`init_table`) can be only used
> in the AL7320 case and we can go with `al2230_init_table` for AL2230.
> The line would be 61 characters long, way below the limit.
>
> What do you think?

That would amount to dropping patch 4?  That seems fine.  It is better to
avoid creating aliases.

julia
