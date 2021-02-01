Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2130A8DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhBANg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:36:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:37916 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231788AbhBANgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:36:13 -0500
IronPort-SDR: Q7iOt39kQtfJDwTWr3iDKvcB+d/C86HtqYb7+5KVS2OFqfWecV4Eo1/2p+/fkT+YdqtFtRSLHs
 GsPmkuEZtyJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="177175909"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="177175909"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:34:27 -0800
IronPort-SDR: 7djqYBFT3il0+5o73I1DkiNMCL9mRxWwzYfvtp+L+rWTzPtSOwN1RGmFCE2ABLoJTvQDOvbf4u
 aOy+YKM+anfg==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="353990774"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:34:24 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6ZLP-0018pC-N0; Mon, 01 Feb 2021 15:34:19 +0200
Date:   Mon, 1 Feb 2021 15:34:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, vbabka@suse.cz,
        linmiaohe@huawei.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <YBgDW6dbdT7AvCXE@smile.fi.intel.com>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
 <20210201115610.87808-4-laoar.shao@gmail.com>
 <66784ea1-29c7-6bed-ca7f-cd3e7ea9155b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66784ea1-29c7-6bed-ca7f-cd3e7ea9155b@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 02:23:33PM +0100, David Hildenbrand wrote:
> On 01.02.21 12:56, Yafang Shao wrote:
> > Currently the pGp only shows the names of page flags, rather than
> > the full information including section, node, zone, last cpupid and
> > kasan tag. While it is not easy to parse these information manually
> > because there're so many flavors. Let's interpret them in pGp as well.
> > 
> > - Before the patch,
> > [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> > 
> > - After the patch,
> > [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)
> 
> For debugging purposes, it might be helpful to have the actual zone name
> (and to know if the value is sane). You could obtain it (without other
> modifications) via
> 
> const char zname = "Invalid";
> 
> if (zone < MAX_NR_ZONES)
> 	zname = first_online_pgdat()->node_zones[zone].name;
> 
> 
> Similarly, it might also be helpful to indicate if a node is
> online/offline/invalid/.
> 
> const char nstate = "Invalid";
> 
> if (node_online(nid))
> 	nstate = "Online";
> else if (node_possible(nid))
> 	nstate = "Offline";
> 
> 
> Printing that in addition to the raw value could be helpful. Just some
> thoughts.

printf() buffer is not a black hole, esp. when you get it messed with critical
messages (Oops). I suggest to reduce a burden as much as possible. If you wish
to get this, make it caller-configurable, i.e. adding another letter to the
specifier.

-- 
With Best Regards,
Andy Shevchenko


