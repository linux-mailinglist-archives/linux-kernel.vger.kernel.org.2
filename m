Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F974600D6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 19:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355954AbhK0SKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 13:10:36 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:39340 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245402AbhK0SI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 13:08:29 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AKQ4CGKIYk43WKmrUFE+Rm5QlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHCw0T90hGYFzWsfXD+CM6mOM2SgL9kiPtznpEhQ75KAnYNqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjRHOWkUoY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssItO?=
 =?us-ascii?q?snqz6f0tirrz6bVXI1CoQAvL7xEEd/UTe0Y5iXBYYQUVKjzSA2dR419xJsbSxT?=
 =?us-ascii?q?x0oN+vCgozxVjEGTn0gbfwZkFPACT3l2SCJ9GXZcn/o0t1vCk8sNIEV8+oxBnt?=
 =?us-ascii?q?BndQTJz0JKAKfisq5xbu6Tq9ngcFLBMDoJIY3vnBm0CGcA/E7R5zKX6TN45lfx?=
 =?us-ascii?q?jhYrsRPG+vOIs8cQTlxZR/DJRpVNT8/DJM4gffthXTldTBcgEyaqLBx4GXJygF?=
 =?us-ascii?q?1lr/3P7L9cdyLA8BUmEmYr2Xu7Xj0RBodMZqUz1Kt4H+lguTOtTHnVcQZE7j+/?=
 =?us-ascii?q?fgCqF+Owm0aThkfSlK/pdG9i1bgHdxFQ2QR/yM0oKsa71GwQ5/2WBjQnZIulnb?=
 =?us-ascii?q?wQPIJTLZ8sVvUjPSEpVbEQHIJUHhaZsZgssIqLQHGH2Shx7vBbQGDepXMIZ5Fy?=
 =?us-ascii?q?oqpkA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AeUwEzKouzd589RMvc5uyz0QaV5rYeYIsimQD?=
 =?us-ascii?q?101hICG9Ffbo6/xG/c5rqCMc7Qx7NU3I9urwQ5VoPkmsjKKdjbN8AV7AZnidhI?=
 =?us-ascii?q?LXFvAb0WKK+VSJcUPDH4hmpMJdmsNFZ+EYY2IK7/rS0U2cE9EjxdmB/rrtrerS?=
 =?us-ascii?q?1Ht2Vw1nApsA0y5JTiOaFU9yRA5JH94YE5Wbj/A3xAaISDAzbsO4A3kDUfKGnd?=
 =?us-ascii?q?HNmZ78CCRnO/ZngjP+6w9AH4SKd2n+4isj?=
X-IronPort-AV: E=Sophos;i="5.87,269,1631570400"; 
   d="scan'208";a="6546897"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 19:05:14 +0100
Date:   Sat, 27 Nov 2021 19:05:13 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Matthew Wilcox <willy@infradead.org>
cc:     cgel.zte@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] mm: Use BUG_ON instead of if condition followed by BUG
In-Reply-To: <YZ7SJ8sXtXF4lZ4L@casper.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2111271905050.2864@hadrien>
References: <20211124030849.34998-1-chi.minghao@zte.com.cn> <YZ483gwnwTysPt0G@casper.infradead.org> <YZ7SJ8sXtXF4lZ4L@casper.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Nov 2021, Matthew Wilcox wrote:

> On Wed, Nov 24, 2021 at 01:23:42PM +0000, Matthew Wilcox wrote:
> > On Wed, Nov 24, 2021 at 03:08:49AM +0000, cgel.zte@gmail.com wrote:
> > > From: chiminghao <chi.minghao@zte.com.cn>
> > >
> > > Fix the following coccinelle report:
> > > ./mm/memory_hotplug.c:2210:2-5:
> > > WARNING  Use BUG_ON instead of if condition followed by BUG.
> >
> > What coccinelle script is reporting this?
>
> Maybe I found it?
>
> scripts/coccinelle/misc/bugon.cocci:msg="WARNING: Use BUG_ON instead of if condition followed by BUG.\nPlease make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)"
>
> Julia, Michal, can we delete this script, please?  It's being abused.

OK

julia

>
> > > -	if (try_remove_memory(start, size))
> > > -		BUG();
> > > +	BUG_ON(try_remove_memory(start, size));
> >
> > I really, really, really do not like this.  For functions with
> > side-effects, this is bad style.  If it's a pure predicate, then
> > sure, but this is bad.
> >
>
