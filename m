Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EBF3075B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhA1MO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:14:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:32481 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhA1MOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:14:31 -0500
IronPort-SDR: pIiWj2pV30Foq1FukymwGh4ZxWqSszd8fCIBRP1PxSCAyRAoSYs3lxAa1M72igBU52GGvyZv1C
 FNPa6Z5AXx4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="167319667"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="167319667"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 04:12:43 -0800
IronPort-SDR: zC4DqtbfJXQL7uE2Y+YHcv1o7qkYdztaHURyMsgDzrEDrmsLDBpzSh2OKVe45UfEbMwaFgRIeh
 UssRdfIYGi5A==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="403469617"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 04:12:39 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l56A8-0002Pd-4M; Thu, 28 Jan 2021 14:12:36 +0200
Date:   Thu, 28 Jan 2021 14:12:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@redhat.com, vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm, printk: dump full information of page flags in
 pGp
Message-ID: <YBKqNLL2MVHhRjtU@smile.fi.intel.com>
References: <20210128021947.22877-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128021947.22877-1-laoar.shao@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:19:44AM +0800, Yafang Shao wrote:
> Currently the pGp only shows the names of page flags, rather than
> the full information including section, node, zone, last cpupid and
> kasan tag. While it is not easy to parse these information manually
> because there're so many flavors. Let's interpret them in pGp as well.
> 
> This patchset also includes some code cleanup in mm/slub.c.
> 
> Below is the example of the output in mm/slub.c.
> - Before the patchset
> [ 6155.716018] INFO: Slab 0x000000004027dd4f objects=33 used=3 fp=0x000000008cd1579c flags=0x17ffffc0010200
> 
> - After the patchset
> [ 6315.235783] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(Node 0x0,Zone 0x2,Lastcpupid 0x1fffff,slab|head)


Please, add a corresponding test cases to test_printf.c. W/o test cases NAK.

-- 
With Best Regards,
Andy Shevchenko


