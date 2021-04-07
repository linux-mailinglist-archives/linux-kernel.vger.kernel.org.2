Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D7835647E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbhDGGts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:49:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:65509 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231460AbhDGGtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:49:46 -0400
IronPort-SDR: mJsml631sbqS1T35stQzeP407bnRaBwrpE0UzQAZpQSA5xuI9It3CQIUTItPn02R7Xd7CYKy53
 wc0WYxwyxeFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="254576096"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="254576096"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 23:49:36 -0700
IronPort-SDR: ZElkPJICbsUDF5iy0LNtI0eaFL9wURz5V714Han+3z/FHGf060ixCJmQDKGbQK7CdgXLWldb19
 hfh7Dfu4kuyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="519325179"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 06 Apr 2021 23:49:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 07 Apr 2021 09:49:31 +0300
Date:   Wed, 7 Apr 2021 09:49:31 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] usb: typec: Port mapping utility
Message-ID: <YG1V+zQXWPOXKuDo@kuha.fi.intel.com>
References: <20210401105847.13026-1-heikki.krogerus@linux.intel.com>
 <20210401105847.13026-4-heikki.krogerus@linux.intel.com>
 <YGq3jBGj3Yv3/ZiB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGq3jBGj3Yv3/ZiB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 09:09:00AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 01, 2021 at 01:58:44PM +0300, Heikki Krogerus wrote:
> > Adding functions that can be used to link/unlink ports -
> > USB ports, TBT3/USB4 ports, DisplayPorts and so on - to
> > the USB Type-C connectors they are attached to inside a
> > system. The symlink that is created for the port device is
> > named "connector".
> > 
> > Initially only ACPI is supported. ACPI port object shares
> > the _PLD (Physical Location of Device) with the USB Type-C
> > connector that it's attached to.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/usb/typec/Makefile      |   2 +-
> >  drivers/usb/typec/class.c       |   7 +-
> >  drivers/usb/typec/class.h       |   9 ++
> >  drivers/usb/typec/port-mapper.c | 219 ++++++++++++++++++++++++++++++++
> >  include/linux/usb/typec.h       |  13 ++
> >  5 files changed, 248 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/usb/typec/port-mapper.c
> 
> This patch failed to apply to my usb-next branch, so I stopped applying
> the patches here.  Can you rebase the rest when you resend?

Okay.

thanks,

-- 
heikki
