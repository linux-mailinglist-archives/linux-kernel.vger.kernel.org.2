Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBD241508C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbhIVTjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:39:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:49181 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhIVTjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:39:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="223725785"
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; 
   d="scan'208";a="223725785"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 12:37:44 -0700
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; 
   d="scan'208";a="702385665"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 12:37:44 -0700
Date:   Wed, 22 Sep 2021 12:37:43 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, osalvador@suse.de, tdmackey@twitter.com,
        david@redhat.com, willy@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
Message-ID: <YUuGB6pJZRlE4yPb@agluck-desk2.amr.corp.intel.com>
References: <20210819054116.266126-1-shy828301@gmail.com>
 <20210819054116.266126-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819054116.266126-3-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:41:16PM -0700, Yang Shi wrote:
> Currently just very simple message is shown for unhandlable page, e.g.
> non-LRU page, like:
> soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()
> 
> It is not very helpful for further debug, calling dump_page() could show
> more useful information.

Looks like your code already caught something. An error injection
test may have injected into a shared library. Though I'm not sure that
the refcount/mapcount in the dump agrees with that diagnosis from the
author of this test.

Here's what appeared on the console:

[ 4817.622254] mce: Uncorrected hardware memory error in user-access at cef2747000
[ 4817.630520] page:000000003ab9dca4 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xcef2747
[ 4817.638651] mce: Uncorrected hardware memory error in user-access at cef2747000
[ 4817.646860] flags: 0x57ffffc0801000(reserved|hwpoison|node=1|zone=2|lastcpupid=0x1fffff)
[ 4818.025515] mce: Uncorrected hardware memory error in user-access at cef2747000
[ 4818.033689] raw: 0057ffffc0801000 ffd400033bc9d1c8 ffd400033bc9d1c8 0000000000000000
[ 4818.272435] mce: Uncorrected hardware memory error in user-access at cef2747000
[ 4818.280640] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[ 4818.280658] mce: Uncorrected hardware memory error in user-access at cef2747000
[ 4818.313606] mce: Uncorrected hardware memory error in user-access at cef2747000
[ 4818.321804] page dumped because: hwpoison: unhandlable page
[ 4818.564802] mce: Uncorrected hardware memory error in user-access at cef2747000
[ 4818.573043] Memory failure: 0xcef2747: recovery action for unknown page: Ignored
[ 4818.595837] Memory failure: 0xcef2747: already hardware poisoned
[ 4818.603245] Memory failure: 0xcef2747: Sending SIGBUS to multichase:67460 due to hardware memory corruption
[ 4818.614297] Memory failure: 0xcef2747: already hardware poisoned

-Tony
