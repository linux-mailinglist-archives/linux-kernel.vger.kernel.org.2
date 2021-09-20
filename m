Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF9B410F29
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 07:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhITFHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 01:07:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:50526 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhITFHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 01:07:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="210302825"
X-IronPort-AV: E=Sophos;i="5.85,307,1624345200"; 
   d="scan'208";a="210302825"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 22:06:05 -0700
X-IronPort-AV: E=Sophos;i="5.85,307,1624345200"; 
   d="scan'208";a="555971293"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 22:06:04 -0700
Date:   Sun, 19 Sep 2021 22:06:03 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86/mce: Get rid of the ->quirk_no_way_out()
 indirect call
Message-ID: <YUgWu14GqmjJ36+R@agluck-desk2.amr.corp.intel.com>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-5-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917105355.2368-5-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:53:55PM +0200, Borislav Petkov wrote:
> @@ -1793,7 +1791,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
>  			cfg->bootlog = 0;
>  
>  		if (c->x86 == 6 && c->x86_model == 45)
> -			quirk_no_way_out = quirk_sandybridge_ifu;
> +			mce_flags.snb_ifu_quirk = 1;
>  	}

Someday all these tests for random vendor/family/model/stepping could be
refactored into a x86_match_cpu() lookup table (now that x86_match_cpu
can handle steppings). But that's a topic for a different patch series.

-Tony
