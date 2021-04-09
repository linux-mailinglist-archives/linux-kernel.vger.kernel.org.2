Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F2035995B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhDIJiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:38:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:58561 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhDIJh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:37:59 -0400
IronPort-SDR: 7f20YZ6AWrg78hPOov0/mlUHuD8sg/gZGgn49Ig83z5/9PihX8orfzTqfaIG4pIxtL1Ha3/otz
 8EnvnQvR912A==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="257709731"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="257709731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 02:37:46 -0700
IronPort-SDR: viJi2FMgAKpEzwXS3F+Zo1hnRC/2BUdswjDg0fN2069m6b+/XnJ8JDyuBCyeAH2SmpevwuqVej
 PmOXbay9Jm8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="520224671"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Apr 2021 02:37:44 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 09 Apr 2021 12:37:43 +0300
Date:   Fri, 9 Apr 2021 12:37:43 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: typec: tcpm: remove unused static variable
 'tcpm_altmode_ops'
Message-ID: <YHAgZwKS+YiPDREn@kuha.fi.intel.com>
References: <20210407091540.2815-1-thunder.leizhen@huawei.com>
 <YG6+mfqIc15rc9H1@kuha.fi.intel.com>
 <aa30675b-a487-a605-7dae-4b9c18ad11e0@roeck-us.net>
 <8e3ae637-dc52-3285-2862-bee36e1dca14@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e3ae637-dc52-3285-2862-bee36e1dca14@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 07:14:01PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 4/8/21 3:55 PM, Guenter Roeck wrote:
> > On 4/8/21 1:28 AM, Heikki Krogerus wrote:
> >> On Wed, Apr 07, 2021 at 05:15:40PM +0800, Zhen Lei wrote:
> >>> Fixes the following W=1 kernel build warning:
> >>>
> >>> drivers/usb/typec/tcpm/tcpm.c:2107:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
> >>>
> >>> The reference to the variable 'tcpm_altmode_ops' is deleted by the
> >>> commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config configuration
> >>> mechanism").
> >>>
> >>> By the way, the static functions referenced only by the variable
> >>> 'tcpm_altmode_ops' are deleted accordingly.
> >>>
> >>> Reported-by: Hulk Robot <hulkci@huawei.com>
> >>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>
> >> Oh, I thought this was already fixed. Should this go into the stable
> >> trees as well?
> >>
> > 
> > I thought there was some code supposed to be coming which would make use of it,
> > but my memory may defeat me.
> 
> There is code coming which uses this; and this is necessary to make
> DP altmode work on some devices.
> 
> I have dropped the ball a bit on posting a v2 of my series using this.
> 
> I'll prepare a v2 of my series, addressing Heikki's review comments
> to my v1 right away. I'll post a v2 at the latest tomorrow.
> 
> This is something which is on my TODO list anyways and this way we will
> save some churn with these functions going away only to be re-introduced
> again relatively soon after they were removed.

Cool. Greg, I think we can skip this patch then.

thanks,

-- 
heikki
