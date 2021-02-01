Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA9130AC59
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhBAQL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:11:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:9911 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhBAQLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:11:20 -0500
IronPort-SDR: NUU3aRSqGkxpgU1H6AXf3qip81nUsyYRoschso7FMwi06NulteDkN5ybiKuJA+jCpsX9s6JNJx
 ZJy/pZFbPfpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180785402"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="180785402"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:09:50 -0800
IronPort-SDR: TPSlBngfVN7Lv0pGUgQXv96sHZokfvdn8I6e7X+l8L1XJueVQ0fv+ae8D/DBt+u9bC+u5mZPC2
 bxvINMvQABHw==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="371598681"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:09:48 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6blp-001Ac3-93; Mon, 01 Feb 2021 18:09:45 +0200
Date:   Mon, 1 Feb 2021 18:09:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     mojha@codeaurora.org, jkosina@suse.cz, cezary.rojewski@intel.com,
        neilb@suse.com, b00073877@aus.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list: add more extensive double add check
Message-ID: <YBgnyWrp16WB1JGQ@smile.fi.intel.com>
References: <20210201135251.1884-1-christian.koenig@amd.com>
 <YBgnY8FXpHJdoDos@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YBgnY8FXpHJdoDos@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 06:08:03PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 01, 2021 at 02:52:51PM +0100, Christian König wrote:
> > Adding the same element to a linked list multiple times
> > seems to be a rather common programming mistake. To debug
> > those I've more than once written some code to check a
> > linked list for duplicates.
> > 
> > Since re-inventing the wheel over and over again is a bad
> > idea this patch tries to add some common code which allows
> > to check linked lists for duplicates while adding new
> > elements.
> > 
> > When list debugging is enabled we currently already check
> > the previous and next element if they are identical to the
> > new one. This patch now adds a configuration option to
> > check N elements before and after the desired position.
> > 
> > By default we still only test one item since testing more
> > means quite a large CPU overhead. This can be overwritten
> > on a per C file bases by defining DEBUG_LIST_DOUBLE_ADD
> > before including list.h.
> 
> I'm not sure it is a good idea. Currently the implementation is *generic*.
> You are customizing it w/o letting caller know.
> 
> Create a derivative implementation and name it exlist (exclusive list) and use
> whenever it makes sense.

And make depth is a runtime parameter available for user.

> And I think if you are still pushing to modify generic one the default must be
> 0 in order not altering current behaviour.
> 
> > A new kunit test is also added to the existing list tests
> > which intentionally triggers the debug functionality.

-- 
With Best Regards,
Andy Shevchenko


