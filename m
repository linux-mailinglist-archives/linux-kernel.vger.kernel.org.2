Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F56310A9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhBELtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:49:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:24544 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhBELo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:44:28 -0500
IronPort-SDR: PrhTMBByXsJKyj+XgV7/24vB5Smre3qJ7G562bgwoB4+GJOh5uxHiesNPgtVkHBu9FHTiL0cai
 4Xk+y2/JgZOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="178859630"
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="178859630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 03:42:37 -0800
IronPort-SDR: Uue4XEHUmBnkESacLps3AFN5v4NEmkGfMu4v41c9saOAerT1MEAXzEiUAU5nttPq1+yfKM74at
 YcH7hdXFsnlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="484104587"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 05 Feb 2021 03:42:34 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Feb 2021 13:42:34 +0200
Date:   Fri, 5 Feb 2021 13:42:34 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/7] common SVDM version and VDO from dt
Message-ID: <20210205114234.GB2476581@kuha.fi.intel.com>
References: <20210205033415.3320439-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205033415.3320439-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:34:08AM +0800, Kyle Tso wrote:
> v5 is here:
> https://patchwork.kernel.org/project/linux-usb/cover/20210202161733.932215-1-kyletso@google.com/
> 
> Changes since v5:
> =================
> usb: typec: Manage SVDM version
> - !! most changes are from Heikki
> - location of the negotiated SVDM version is changed. Now the variable
>   resides in typec_partner
> - The setter and getter functions were modified according to the above
>   changes
> - the default SVDM version is stored upon calling to
>   typec_register_partner
> 
> usb: pd: Make SVDM Version configurable in VDM header
> - no change
> 
> usb: typec: tcpm: Determine common SVDM Version
> - follow the changes of "usb: typec: Manage SVDM version"
> - remove the "reset to default". Now the default SVDM version will be
>   set when calling to typec_register_partner
> 
> usb: typec: ucsi: Determine common SVDM Version
> - follow the changes of "usb: typec: Manage SVDM version"
> - remove the "reset to default". Now the default SVDM version will be
>   set when calling to typec_register_partner
> 
> usb: typec: displayport: Fill the negotiated SVDM Version in the header
> - follow the changes of "usb: typec: Manage SVDM version"
> 
> dt-bindings: connector: Add SVDM VDO properties
> - no change
> 
> usb: typec: tcpm: Get Sink VDO from fwnode
> - no change
> 
> Kyle Tso (7):
>   usb: typec: Manage SVDM version
>   usb: pd: Make SVDM Version configurable in VDM header
>   usb: typec: tcpm: Determine common SVDM Version
>   usb: typec: ucsi: Determine common SVDM Version
>   usb: typec: displayport: Fill the negotiated SVDM Version in the header
>   dt-bindings: connector: Add SVDM VDO properties
>   usb: typec: tcpm: Get Sink VDO from fwnode

These are OK by me, but I think it would be great if Guenter could
give them the once-over, as usual. I hope he has time. FWIW, for all
of these:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
