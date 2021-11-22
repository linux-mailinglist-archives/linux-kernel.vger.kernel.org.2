Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77C6459650
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 21:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbhKVU6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 15:58:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:52772 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhKVU6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:58:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="235115091"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="235115091"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 12:55:30 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="552646519"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 12:55:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpGLU-009a5F-9z;
        Mon, 22 Nov 2021 22:55:24 +0200
Date:   Mon, 22 Nov 2021 22:55:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 1/1] ARM: pxa/lubbock: Replace custom ->cs_control()
 by GPIO lookup table
Message-ID: <YZwDu6CY8/hxFqne@smile.fi.intel.com>
References: <20211122203247.11665-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122203247.11665-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 10:32:47PM +0200, Andy Shevchenko wrote:
> SPI PXA2xx driver supports GPIO chipselect by querying for known
> GPIO connection ID. Replace custom ->cs_control() by GPIO table,
> so the driver will use generic approach on this platform.

Okay, I think it would be first patch in a series of getting rid of cs_control.
So, please give your Acks, etc here, and I will appreciate any testing in case
you are in possession of such platform.

-- 
With Best Regards,
Andy Shevchenko


