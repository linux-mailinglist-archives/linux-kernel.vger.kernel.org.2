Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6F9388D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353379AbhESMLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:11:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:37407 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353361AbhESMLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:11:50 -0400
IronPort-SDR: tZe0v/4vavTcLm0xjPXAgWvmrLqPbcvktR62Wkih0if+0KuFzmf/ZLl90rFHw348s44cpUEo3T
 at5dT+pwoJYQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="199008294"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="199008294"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 05:10:25 -0700
IronPort-SDR: GxXz847buYkGc9JtP3p53oNCc9n8X0wNNMCPRnMawn50byeFQoAlAPQ996NT6vmpNsne+d9iq/
 Ijm1WBMmNdeg==
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="474382059"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 05:10:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ljL1o-00DDVt-Ey; Wed, 19 May 2021 15:10:20 +0300
Date:   Wed, 19 May 2021 15:10:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH v1 1/1] usb: typec: wcove: Use LE to CPU conversion when
 accessing msg->header
Message-ID: <YKUALLRFqx6VP0rR@smile.fi.intel.com>
References: <20210519100212.54630-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519100212.54630-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 01:02:12PM +0300, Andy Shevchenko wrote:
> Sparse is not happy about strict type handling:
>   .../typec/tcpm/tcpm.c:2720:27: warning: restricted __le16 degrades to integer
>   .../typec/tcpm/tcpm.c:2814:32: warning: restricted __le16 degrades to integer

This has wrong subject prefix, fixed in v2.

-- 
With Best Regards,
Andy Shevchenko


