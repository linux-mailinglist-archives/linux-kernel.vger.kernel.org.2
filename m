Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E8B398EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhFBPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:44:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:62234 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232322AbhFBPoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:44:13 -0400
IronPort-SDR: WzV71W42nQqsNCUQiyiaILLbMjF1iGg/R32AHTQnwOFxnIYE8ArmJNI/O8scDZ2+9TprcH2VqT
 k0iNgjw6y1Lw==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="201959308"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="201959308"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 08:42:30 -0700
IronPort-SDR: rrWGxOBaLHWIaSmC+W+ABp9UDGCW6LOenQjVMWN1ij5zcS8JoxdokqmCnn14CfTra9RlrqiUpV
 O+2q7rc8WPuw==
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="447450704"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 08:42:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1loT0i-00Gk1l-Mc; Wed, 02 Jun 2021 18:42:24 +0300
Date:   Wed, 2 Jun 2021 18:42:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, jonathan.cameron@huawei.com,
        song.bao.hua@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] use bin_attribute to avoid buff overflow
Message-ID: <YLem4MMvxvS9+B3V@smile.fi.intel.com>
References: <1622641734-22538-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622641734-22538-1-git-send-email-tiantao6@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 09:48:51PM +0800, Tian Tao wrote:
> patch #1 adds a new function cpumap_print_to_buf and patch #2 uses
> this function in drivers/base/topology.c, and patch #3 uses this new
> function in drivers/base/node.c.

Somehow you missed to include BITMAP maintainers / reviewers.

-- 
With Best Regards,
Andy Shevchenko


