Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D3730764C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhA1MoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:44:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231509AbhA1Mn4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:43:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7086764DDC;
        Thu, 28 Jan 2021 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611837794;
        bh=Z9RiUVOtB3jwJR1AntTuD9fRQCElWZXgQymUcqtsToo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwdETjJ3m8WBcwSbvBaK5U7pHk3BMJrSl4+hddDLki3imxug/QbXqJpKqx5XEh1AB
         rjwlHB2T+ojJ3XoW7vKuvhek4g5xDNGa0vXs5x8x4V9PSSpey06oFg+fhmK7EbsGKI
         94Qfx+Lkh9o67YApm8FKKz4E865D3q+YFq2AGMq8m39iBALz8/+WqA3rDzO+NQqU5x
         Kz1/ifvL51pLtEyfE0dh6IHq2sVAaW51XgFfTdSHVNn+0RY103rd/ggqTHrza8eCmS
         c7Uo5pG4lTFJyJeyomASFeWyp/vJ/FJlFCRNdA4yjx1I+FsiksBx2sYFjdN7r6mhuk
         /rSXfWrMhmbrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5498040513; Thu, 28 Jan 2021 09:43:10 -0300 (-03)
Date:   Thu, 28 Jan 2021 09:43:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH 1/2] perf script: Support filtering by hex address
Message-ID: <20210128124310.GC775562@kernel.org>
References: <20210124232750.19170-1-yao.jin@linux.intel.com>
 <20210127222905.GD284633@krava>
 <60d102fa-d98a-6182-0a1d-b78122fed574@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d102fa-d98a-6182-0a1d-b78122fed574@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 28, 2021 at 11:31:26AM +0800, Jin, Yao escreveu:
> On 1/28/2021 7:13 AM, Jiri Olsa wrote:
> > > @@ -709,6 +725,26 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
> > >   			ret = strlist__has_entry(symbol_conf.sym_list, al_addr_str);
> > >   		}
> > > +		if (!ret && al->map) {
> > > +			snprintf(al_addr_str, sz, "0x%"PRIx64,
> > > +				al->map->unmap_ip(al->map, al->addr));
> > > +			ret = strlist__has_entry(symbol_conf.sym_list,
> > > +						 al_addr_str);
> > > +			if (!ret) {
> > > +				/* Check for hex without "0x" prefix */
> > > +				snprintf(al_addr_str, sz, "%"PRIx64,
> > > +					al->map->unmap_ip(al->map, al->addr));
> > > +				ret = strlist__has_entry(symbol_conf.sym_list,
> > > +							 al_addr_str);
> > > +			}
> > that seems tricky.. what if user specify more leading zeros,
> > I think it'd be better to search intlist instead

> > we could move all 'address' entries from sym_list to
> > new intlist (in symbol__init) and use it for this search

> intlist now only supports 'int' type.

> I'm considering to use 'long' to replace original 'int' in struct int_node.

> struct int_node {
> 	struct rb_node rb_node;
> -	int i;
> +	long i;
> 	void *priv;
> };

> On 32 bits platform, sizeof(long) is 4, and on 64 bits platform,
> sizeof(long) is 8. So that should be OK for storing the values such as
> pid/tid and address.

> I'm not very clear why currently it uses 'int' for i in struct int_node,
> maybe something I don't understand correctly. Please correct me if my
> understanding is wrong.

I think its ok to make it a long, it won't even enlarge the struct
because:

[acme@quaco pahole]$ pahole -C int_node ~/bin/perf
struct int_node {
	struct rb_node             rb_node __attribute__((__aligned__(8))); /*     0    24 */
	int                        i;                                       /*    24     4 */

	/* XXX 4 bytes hole, try to pack */

	void *                     priv;                                    /*    32     8 */

	/* size: 40, cachelines: 1, members: 3 */
	/* sum members: 36, holes: 1, sum holes: 4 */
	/* forced alignments: 1 */
	/* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));
[acme@quaco pahole]$

:-)

- Arnaldo
