Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281B9456CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhKSJts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 04:49:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:9567 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhKSJts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 04:49:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="214418843"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="214418843"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 01:46:46 -0800
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="473489603"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 01:46:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mo0Tb-008UhS-My;
        Fri, 19 Nov 2021 11:46:35 +0200
Date:   Fri, 19 Nov 2021 11:46:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peiwei Hu <jlu.hpw@foxmail.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        aneesh.kumar@linux.ibm.com, ardb@kernel.org,
        rafael.j.wysocki@intel.com, masahiroy@kernel.org,
        npiggin@gmail.com, adobriyan@gmail.com, clg@kaod.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] powerpc/prom_init: fix the improper check of prom_getprop
Message-ID: <YZdye4k/5a8bUXU7@smile.fi.intel.com>
References: <tencent_BA28CC6897B7C95A92EB8C580B5D18589105@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_BA28CC6897B7C95A92EB8C580B5D18589105@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 05:12:18PM +0800, Peiwei Hu wrote:
> prom_getprop() can return PROM_ERROR. Binary operator can not identify it.

Fixes: 94d2dde738a5 ("[POWERPC] Efika: prune fixups and make them more carefull")

?

P.S. Try to use my script [1] to send patches, it should be smart enough to not
include my name, for example.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


