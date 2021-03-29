Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0498634D2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhC2On7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:43:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:60768 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhC2Ona (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:43:30 -0400
IronPort-SDR: KcD8Msw3GBeBqLU5g5r9yH3OJ1mdmfd9uMOx7+7Tf/IOvp2EB4dImGlF4xI5hWzqJGdmKf5b0s
 MCRsUceKsCnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="276724965"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="276724965"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 07:43:29 -0700
IronPort-SDR: +PId8aDUZNp8xopfL7BA0bUBq7fEZjfUW7Ng/zhdueK+OC2cESX5k+9Ez3HpY3ap/9W5YClMsI
 AyvF8W74OMsg==
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="417696964"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 07:43:25 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 29 Mar 2021 17:43:23 +0300
Date:   Mon, 29 Mar 2021 17:43:23 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Kranthi Kuntala <kranthi.kuntala@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] thunderbolt: Fix a leak in tb_retimer_add()
Message-ID: <20210329144323.GI2542@lahna.fi.intel.com>
References: <YGFulvAa5Kz6HTsd@mwanda>
 <20210329130220.GY2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329130220.GY2356281@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 29, 2021 at 10:02:20AM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 29, 2021 at 09:07:18AM +0300, Dan Carpenter wrote:
> > After the device_register() succeeds, then the correct way to clean up
> > is to call device_unregister().  The unregister calls both device_del()
> > and device_put().  Since this code was only device_del() it results in
> > a memory leak.
> > 
> > Fixes: dacb12877d92 ("thunderbolt: Add support for on-board retimers")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > This is from a new static checker warning.  Not tested.  With new
> > warnings it's also possible that I have misunderstood something
> > fundamental so review carefully etc.
> 
> It looks OK to me

I agree too.

> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks for the review!

> This also highlights the code has an ordering issue too, it calls
> device_register() then goes to do tb_retimer_nvm_add() however
> device_register() makes sysfs attributes visible before the rt->nvm is
> initialized and this:
> 
> static ssize_t nvm_authenticate_store(struct device *dev,
> 	struct device_attribute *attr, const char *buf, size_t count)
> {
> 	if (!rt->nvm) {
> 
> Isn't strong enough to close the potential racing. The nvm should be
> setup before device_register and all the above tests in the sysfs
> deleted so we can rely on the CPU barriers built into
> device_register() for correctness.
> 
> [which is a general tip, be very suspicious if device_register() is
> being error unwound]

The nvm is a separate (physical Linux) device that gets added under this
one. It cannot be added before AFAICT.

The code you refer actually looks like this:

static ssize_t nvm_authenticate_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
{
	...
        if (!mutex_trylock(&rt->tb->lock)) {
                ret = restart_syscall();
                goto exit_rpm;
        }

        if (!rt->nvm) {
                ret = -EAGAIN;
                goto exit_unlock;
        }


Idea here is that if the NVMem (nvm) is not yet registered the attribute is
there but we return -EAGAIN to the userspace.
