Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B9E3075A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhA1MNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:13:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:60572 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231140AbhA1MNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:13:32 -0500
IronPort-SDR: KQIsxC6qVn1epKINX0oSYHeNswnC3vLgAQLF++Z0xBUVjxL5TMWSec1TNEBxTmd0yjfD45tp9d
 el4eFuosvdSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="177659408"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="177659408"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 04:11:46 -0800
IronPort-SDR: NRqnpaZs94Xm3cujH/NE9gw1GH+XGQjSV20xB4tNWEun0KolGuhZUcsDT4D7p9erKY9u4+5HAD
 JS9W9saPI1Hw==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="394393288"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 04:11:43 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l569E-0002OU-0x; Thu, 28 Jan 2021 14:11:40 +0200
Date:   Thu, 28 Jan 2021 14:11:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@redhat.com, vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] printk: dump full information of page flags in pGp
Message-ID: <YBKp/NHanaN4e0im@smile.fi.intel.com>
References: <20210128021947.22877-1-laoar.shao@gmail.com>
 <20210128021947.22877-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128021947.22877-4-laoar.shao@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:19:47AM +0800, Yafang Shao wrote:
> Currently the pGp only shows the names of page flags, rather than
> the full information including section, node, zone, last cpupid and
> kasan tag. While it is not easy to parse these information manually
> because there're so many flavors. Let's interpret them in pGp as well.
> 
> - Before the patch,
> [ 6312.639698] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(slab|head)
> 
> - After the patch,
> [ 6315.235783] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(Node 0x0,Zone 0x2,Lastcpupid 0x1fffff,slab|head)

> +	int i;
> +
> +	for (i = 0; i < sizeof(pfl) / sizeof(struct page_flags_layout) && buf < end; i++) {

'buf < end' is redundant.

> +		if (pfl[i].width == 0)
> +			continue;
> +
> +		buf = string(buf, end, pfl[i].name, default_str_spec);

> +		if (buf >= end)
> +			break;

Can you rather use usual patter, i.e.

	if (buf < end) {
		...do something...
	}
	buf++; // or whatever increase should be done

Moreover, number() and string() IIRC have the proper checks embedded into them.

> +		buf = number(buf, end, (flags >> pfl[i].shift) & pfl[i].mask,
> +			     default_flag_spec);

> +		if (buf >= end)
> +			break;
> +		*buf = ',';
> +		buf++;

Here is a very standard pattern can be used, see code around

		if (buf < end)
			*buf = ',';
		buf++;

> +	}

-- 
With Best Regards,
Andy Shevchenko


