Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EB1356937
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350829AbhDGKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:16:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:61750 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350819AbhDGKQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:16:29 -0400
IronPort-SDR: 0wosulp7Gq9Ftd7fAlCMEbHV8XARvwJj1kyrVnfhW8S395ibTf8GHcUsbZoEU4r9zOojrTtGuQ
 qQE+M2J+GlHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172750010"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="172750010"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 03:16:20 -0700
IronPort-SDR: ZmEYnuC+XqnTLJ7+ce4ABQD5Isy8TtgYMj10RKD6wF88GDUG4Bh/kHCjwqrencwHapGfQ0qng5
 /TP/ykNoR9wA==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="415206068"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 03:16:18 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lU5EM-001z1n-5V; Wed, 07 Apr 2021 13:16:14 +0300
Date:   Wed, 7 Apr 2021 13:16:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/1] serial: sh-sci: Respect deferred probe when
 getting IRQ
Message-ID: <YG2GbjJDI0VAvZAx@smile.fi.intel.com>
References: <20210407100556.12321-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407100556.12321-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:05:56PM +0300, Andy Shevchenko wrote:
> With platform_get_irq() and its optional variant it's possible to get
> a deferred probe error code. Since the commit ed7027fdf4ec ("driver core:
> platform: Make platform_get_irq_optional() optional") the error code
> can be distinguished from no IRQ case. With this, rewrite IRQ resource
> handling in sh-sci driver to follow above and allow to respect deferred
> probe.


It has a typo, i'll send a v2.

-- 
With Best Regards,
Andy Shevchenko


