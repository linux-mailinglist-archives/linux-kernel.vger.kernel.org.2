Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E43433554
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhJSMFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:05:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:13872 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhJSMFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:05:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="208591048"
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="208591048"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 05:02:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="718249838"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 05:02:39 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mcnoy-000TIG-N0;
        Tue, 19 Oct 2021 15:02:20 +0300
Date:   Tue, 19 Oct 2021 15:02:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v2 1/1] auxdisplay: panel: Switch to use
 module_parport_driver()
Message-ID: <YW6zzCE5yKqngvD6@smile.fi.intel.com>
References: <20211001161705.13361-1-andriy.shevchenko@linux.intel.com>
 <YV8jtBpZhlO6LOcX@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV8jtBpZhlO6LOcX@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 07:43:32PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 01, 2021 at 07:17:05PM +0300, Andy Shevchenko wrote:
> > Switch to use module_parport_driver() to reduce boilerplate code.
> 
> Miguel, any comments on this?

Another ping.
Are we going to lose this for a few cycles like my previous experience?

-- 
With Best Regards,
Andy Shevchenko


