Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F9D42347F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhJEXfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:35:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:52060 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhJEXfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:35:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="249152724"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="249152724"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 16:33:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="656787478"
Received: from pwali-mobl1.amr.corp.intel.com (HELO ldmartin-desk2) ([10.213.170.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 16:33:40 -0700
Date:   Tue, 5 Oct 2021 16:33:39 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] lib/string_helpers: add linux/string.h for strlen()
Message-ID: <20211005233339.luuyt2spalfirqzt@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20211005212634.3223113-1-lucas.demarchi@intel.com>
 <20211005162121.a9eb9b1af38f56566a4bafdb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211005162121.a9eb9b1af38f56566a4bafdb@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 04:21:21PM -0700, Andrew Morton wrote:
>On Tue,  5 Oct 2021 14:26:34 -0700 Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
>> linux/string_helpers.h uses strlen(), so include the correpondent
>> header. Otherwise we get a compilation error if it's not also included
>> by whoever included the helper.
>
>Is such a compilation error demonstrable in the current mainline kernel?

No, not with the current mainline. I was just starting to implement some
more helpers there and noticed the issue when including this header from
i915. Then I noticed  Andy and Jani already had similar patches to what
I was doing:

https://lore.kernel.org/all/20210215142137.64476-1-andriy.shevchenko@linux.intel.com/
and https://lore.kernel.org/all/20191023131308.9420-1-jani.nikula@intel.com/

So I'm following up on the first thread abovee to figure out what would
be the proper header to implement this. Meanwhile, we can have this
quick harmless fix.

thanks,
Lucas De Marchi
