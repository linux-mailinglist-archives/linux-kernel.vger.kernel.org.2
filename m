Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5C357E57
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhDHIoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:44:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:60631 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhDHIog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:44:36 -0400
IronPort-SDR: RLfh5bQt9xTmoriDiyddDW5YsEEEYqAxQI+Ui0CykapmmqnZISlyl2iK0JDGJeyO2pqpAW6RQ5
 CFQsC1tqSWPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="190287212"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="190287212"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 01:44:26 -0700
IronPort-SDR: vpbYYD3lKX7CgebOOV39Ht9OtFP8ZLa2kIO3zOr5n3Wd669bETZ23V5F4ETxQgUiDvTW1WaUl0
 aDlnbgxEwVHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="519771993"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Apr 2021 01:44:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Apr 2021 11:44:22 +0300
Date:   Thu, 8 Apr 2021 11:44:22 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/1] usb: typec: tcpm: remove unused static variable
 'tcpm_altmode_ops'
Message-ID: <YG7CZoTqB1P7VbY3@kuha.fi.intel.com>
References: <20210407091540.2815-1-thunder.leizhen@huawei.com>
 <YG6+mfqIc15rc9H1@kuha.fi.intel.com>
 <YG7A94eekRgvskUg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG7A94eekRgvskUg@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:38:15AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 08, 2021 at 11:28:09AM +0300, Heikki Krogerus wrote:
> > On Wed, Apr 07, 2021 at 05:15:40PM +0800, Zhen Lei wrote:
> > > Fixes the following W=1 kernel build warning:
> > > 
> > > drivers/usb/typec/tcpm/tcpm.c:2107:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
> > > 
> > > The reference to the variable 'tcpm_altmode_ops' is deleted by the
> > > commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config configuration
> > > mechanism").
> > > 
> > > By the way, the static functions referenced only by the variable
> > > 'tcpm_altmode_ops' are deleted accordingly.
> > > 
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > 
> > Oh, I thought this was already fixed. Should this go into the stable
> > trees as well?
> 
> We do not build kernels by default with "W=1" yet, so it's not needed
> in stable kernels.

Okay, got it.

thanks,

-- 
heikki
