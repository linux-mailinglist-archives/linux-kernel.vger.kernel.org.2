Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4093234D034
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhC2Mhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:37:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:14562 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231358AbhC2Mh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:37:29 -0400
IronPort-SDR: XREZLtT3BB/3fRrkpdZvrwpakCT/QtdzxgjQJHfFeDn3AhH71bwicLP63jehyjKPRzrEw0bKdX
 FQaxlKEBtjnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191004499"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191004499"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 05:37:24 -0700
IronPort-SDR: /+J6HvRxBQxW4sZsyEngjxUIX+Ql8DZXBF/uW6BtUVFU0v3tjJUH7H25mR18WZCrJAANo6yLnX
 51S96F37XMhg==
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="454541595"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 05:37:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lQr8y-00H12o-LN; Mon, 29 Mar 2021 15:37:20 +0300
Date:   Mon, 29 Mar 2021 15:37:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v1 1/3] mux: gpio: Use bitmap API instead of direct
 assignment
Message-ID: <YGHKACcDvMVRchFJ@smile.fi.intel.com>
References: <20210326172401.33685-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326172401.33685-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 07:23:59PM +0200, Andy Shevchenko wrote:
> Assigning bitmaps like it's done in the driver might be error prone.
> Fix this by using bitmap API.

Peter, are you okay with the patches?
Should I reroute them to Greg?

-- 
With Best Regards,
Andy Shevchenko


