Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1169D405B76
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhIIQzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:55:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:49056 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231316AbhIIQzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:55:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="220876382"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="220876382"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 09:54:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="696409561"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 09:54:01 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mONJG-001i9O-Io;
        Thu, 09 Sep 2021 19:53:58 +0300
Date:   Thu, 9 Sep 2021 19:53:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Use superio function pointers (v2)
Message-ID: <YTo8JnOAaF5W/Mr5@smile.fi.intel.com>
References: <08262b12-4345-76a9-87be-66d630af3a59@roeck-us.net>
 <20210908213605.9929-1-pauk.denis@gmail.com>
 <20210908213605.9929-2-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908213605.9929-2-pauk.denis@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:36:03AM +0300, Denis Pauk wrote:
> Use superio function pointers in nct6775_sio_data instead direct calls.
> 
> v2: split changes to separate patches

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>

Similar comments as per patch 1.

...

> +	void (*outb)(struct nct6775_sio_data *sio_data, int reg, int val);
> +	int (*inb)(struct nct6775_sio_data *sio_data, int reg);

This part should be split separately and actually be a part of patch 1.

...

> -static inline void
> +static void
>  superio_outb(struct nct6775_sio_data *sio_data, int reg, int val)

I guess it's one line and it should be a part of patch 1.

...

> -static inline int
> +static int
>  superio_inb(struct nct6775_sio_data *sio_data, int reg)

Ditto.

-- 
With Best Regards,
Andy Shevchenko


