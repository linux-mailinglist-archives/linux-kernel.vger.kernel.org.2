Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C0F3A2B19
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFJMJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:09:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:25024 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhFJMJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:09:34 -0400
IronPort-SDR: GfL2YwfCIgCBLbmdJc5NL4Ivj3pQ678Z+Psgd4yjveXfcFExWgvjlbUvSfIfuIxipfyXEwj5Ej
 UB6ANpV8WMGw==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192599704"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="192599704"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 05:07:38 -0700
IronPort-SDR: +wOVCgWo6QMRCUZl/vz1ixHeCTfdjqX7IVzlMy5+2xqf7VkB1ARy//upM1I8E/gx/jBXPMbljm
 xM1NKTnjVp8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="553043320"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Jun 2021 05:07:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Jun 2021 15:07:35 +0300
Date:   Thu, 10 Jun 2021 15:07:35 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] usb: typec: ucsi: Polling the alt modes and PDOs
Message-ID: <YMIAh1uDgeglJYNN@kuha.fi.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
 <4a76d2152f016b58298bec16aa2003a6ec55f8a8.camel@redhat.com>
 <YL8RPiVsEFOM9PBo@kuha.fi.intel.com>
 <YL8UD+nlBSSQGIMO@kuha.fi.intel.com>
 <f9e1640d4d1a2acbaacf83dee021cd4aa55f233f.camel@redhat.com>
 <YMClRTC8wW82IrDT@kuha.fi.intel.com>
 <YMCxfC+S9EJNEiwq@kuha.fi.intel.com>
 <YMC6fgoWiAe1C3uZ@kuha.fi.intel.com>
 <0bf4d8fc6d64ac553a319b8c5af49a3d7705842d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf4d8fc6d64ac553a319b8c5af49a3d7705842d.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 07:39:41PM +0200, Benjamin Berg wrote:
> My thought when I first ran into the issue was that the PPM simply
> resets the change bitfield on ACK, effectively discarding any changes
> that happened after the last GET_CONNECTOR_STATUS call. I believed to
> have confirmed this by inserting an msleep in between.
> However, I have to admit that I have never really looked for
> alternative explanations.

Thanks a lot for testing these. I now have pretty good idea about the
problem. The problem is not what you though it is, but the driver is
also not too slow like I suspected.

I'm quite certain now that the PPM simply does not create the event at
all in this case, regardless of what the driver does. We do need to
workaround that problem, but I think we can do it in a better way. I
have an idea for that.

thanks,

-- 
heikki
