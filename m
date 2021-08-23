Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAEE3F47AC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhHWJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:34:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:6662 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235980AbhHWJeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:34:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="204265295"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="204265295"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:33:26 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="443386575"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:33:24 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mI6KU-00CjMZ-Se; Mon, 23 Aug 2021 12:33:18 +0300
Date:   Mon, 23 Aug 2021 12:33:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Mark Gross <mgross@linux.intel.com>
Subject: Re: [RFT, PATCH v1 1/1] platform/x86: hp_accel: Convert to be a
 platform driver
Message-ID: <YSNrXkDpG0k3eTgd@smile.fi.intel.com>
References: <20210803200820.3259-1-andriy.shevchenko@linux.intel.com>
 <48332796-1b9a-c897-c695-e66b116386be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48332796-1b9a-c897-c695-e66b116386be@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 03:42:40PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/3/21 10:08 PM, Andy Shevchenko wrote:
> > ACPI core in conjunction with platform driver core provides
> > an infrastructure to enumerate ACPI devices. Use it in order
> > to remove a lot of boilerplate code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > 
> > Not sure what buys us to run _INI on PM calls. It's against the spec AFAICT.
> > In any case ACPICA runs _INI as per specification when devices are
> > instantiated.
> 
> _INI used to also be ran on resume for some reason, but that was recently
> changed.
> 
> You're right that calling it is no longer necessary now that we no longer
> do that.
> 
> But the changes related to this are really separate from the platform
> driver conversion, please split this into 2 patches.
> 
> Also for the next version please Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> and ask him to test, I think he has access to hardware to test this.

v2 has been sent.

-- 
With Best Regards,
Andy Shevchenko


