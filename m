Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED313CD542
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbhGSMQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:16:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:37178 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236935AbhGSMQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:16:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="191328838"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="191328838"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 05:57:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="656832866"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 05:57:10 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m5SpT-00FWIJ-VE; Mon, 19 Jul 2021 15:57:03 +0300
Date:   Mon, 19 Jul 2021 15:57:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] mm/util: Rephrase documentation for kmemdup_nul()
 to clarify input
Message-ID: <YPV2n6g0j1tkxF7M@smile.fi.intel.com>
References: <20210719122002.41334-1-andriy.shevchenko@linux.intel.com>
 <YPVzptA7JYMyWszg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPVzptA7JYMyWszg@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 01:44:22PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 19, 2021 at 03:20:02PM +0300, Andy Shevchenko wrote:
> > kmemdup_nul() strictly speaking is not related to the string API,
> > while being quite useful for it. Rephrase documentation to make it
> > clear that input data can be anything (any data, which may contain
> > any bytes, including 0x00).
> 
> That's not a useful thing to do, though.  This rephrasing you've
> done is more confusing than the original.

Okay, then drop it. Sorry for the noise.

-- 
With Best Regards,
Andy Shevchenko


