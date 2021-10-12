Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4E242AC75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhJLSxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:53:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:6554 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235168AbhJLSxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:53:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="227526678"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="227526678"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:51:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="570550930"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:51:39 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1maMsD-0003J3-33;
        Tue, 12 Oct 2021 21:51:37 +0300
Date:   Tue, 12 Oct 2021 21:51:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Oliver Urbann <oliver.urbann@gmail.com>
Cc:     oliver.sang@intel.com, linux-kernel@vger.kernel.org, lkp@intel.com,
        lkp@lists.01.org, vkoul@kernel.org
Subject: Re: [dmaengine] fe364a7d95:
 UBSAN:array-index-out-of-bounds_in_drivers/acpi/acpica/dswexec.c
Message-ID: <YWXZOdYYuQA/Ddq4@smile.fi.intel.com>
References: <20210918150130.GA30982@xsang-OptiPlex-9020>
 <246a5a73-6b85-98b3-3830-cfc46030c044@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <246a5a73-6b85-98b3-3830-cfc46030c044@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 11:56:20PM +0200, Oliver Urbann wrote:
> Hi all,
> 
> this actually crashes s2idle e.g. on Surface Book 1 and Surface Pro 4:

You mean the mentioned patch?

It's impossible. Surface Book 1 (at least) has no such devices, which that
patch touches, at all!

-- 
With Best Regards,
Andy Shevchenko


