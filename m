Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60B357F15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhDHJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:26:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:59134 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhDHJ0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:26:01 -0400
IronPort-SDR: 2FmBwaNonASUGSPlk5c1LrldDNcbqEVebWZyR/VdIg8PgEBcaQr0zblgHqOztxrtTvKqyGMjlR
 P3ip/ekOUd6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="278769636"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="278769636"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 02:25:50 -0700
IronPort-SDR: tDJZXqF5IHHMgCoJtA0Qj7X1TGJqBh7/6uaeZNO//dZgoWRkOHvuYtWkeITznzI/TyQaKeWlhO
 Ub8stqs13zAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="519781454"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Apr 2021 02:25:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Apr 2021 12:25:47 +0300
Date:   Thu, 8 Apr 2021 12:25:47 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: typec: tcpm: remove unused static variable
 'tcpm_altmode_ops'
Message-ID: <YG7MG2yZbRlSJg9E@kuha.fi.intel.com>
References: <20210407091540.2815-1-thunder.leizhen@huawei.com>
 <7e2797f7-0ba7-0362-ae34-a1d4fb265cd7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e2797f7-0ba7-0362-ae34-a1d4fb265cd7@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 11:10:38AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 4/7/21 11:15 AM, Zhen Lei wrote:
> > Fixes the following W=1 kernel build warning:
> > 
> > drivers/usb/typec/tcpm/tcpm.c:2107:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
> > 
> > The reference to the variable 'tcpm_altmode_ops' is deleted by the
> > commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config configuration
> > mechanism").
> > 
> > By the way, the static functions referenced only by the variable
> > 'tcpm_altmode_ops' are deleted accordingly.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> I have a patch pending:
> 
> https://www.spinics.net/lists/linux-usb/msg197684.html
> 
> Which actually uses this. I really need to (and plan to) brush the dust of
> this one soon and submit a new version.
> 
> As such I would prefer for these ops to not get removed. But I guess I
> can always include a patch in my series reverting the removal...

Well, can we then just leave the ops there? If we're going to
re-introduce them back soon in any case, then why drop them in the
first place.

thanks,

-- 
heikki
