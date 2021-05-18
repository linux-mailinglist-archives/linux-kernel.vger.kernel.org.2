Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7753879FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349623AbhERNa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:30:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:58079 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245242AbhERNa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:30:56 -0400
IronPort-SDR: mPWJg2rYG53a6F+2A1sAmuGaLSQc1RcmotBcy/60KUYxG0C0ogFRVQ+QINN/Eqj1bl/b84UgjN
 0RDCJwmtgYIA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="188120824"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="188120824"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 06:29:37 -0700
IronPort-SDR: u33XeXgwcBSspCFgCb9VQsgkLoJs5iposoeyDXK6WNqlnw8S9HnlCdaG1KfmLpC5uOvv4A0i5c
 gKAKZc7vYE/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="541972367"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 18 May 2021 06:29:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 18 May 2021 16:29:34 +0300
Date:   Tue, 18 May 2021 16:29:34 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Clear pending after acking connector
 change
Message-ID: <YKPBPqZ6zHBsCnsO@kuha.fi.intel.com>
References: <20210516040953.622409-1-bjorn.andersson@linaro.org>
 <YKI/XT8qpZDjDuqs@kuha.fi.intel.com>
 <YKJeYzIgvL/soGgw@kuha.fi.intel.com>
 <cd62e9a6d317e106db5e5d6b5f36170524ed7ad9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd62e9a6d317e106db5e5d6b5f36170524ed7ad9.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 02:57:28PM +0200, Benjamin Berg wrote:
> Hi Heikki,
> 
> 
> On Mon, 2021-05-17 at 15:15 +0300, Heikki Krogerus wrote:
> > On Mon, May 17, 2021 at 01:03:12PM +0300, Heikki Krogerus wrote:
> > > On Sat, May 15, 2021 at 09:09:53PM -0700, Bjorn Andersson wrote:
> > > > It's possible that the interrupt handler for the UCSI driver
> > > > signals a
> > > > connector changes after the handler clears the PENDING bit, but
> > > > before
> > > > it has sent the acknowledge request. The result is that the handler
> > > > is
> > > > invoked yet again, to ack the same connector change.
> > > > 
> > > > At least some versions of the Qualcomm UCSI firmware will not
> > > > handle the
> > > > second - "spurious" - acknowledgment gracefully. So make sure to
> > > > not
> > > > clear the pending flag until the change is acknowledged.
> > > > 
> > > > Any connector changes coming in after the acknowledgment, that
> > > > would
> > > > have the pending flag incorrectly cleared, would afaict be covered
> > > > by
> > > > the subsequent connector status check.
> > > > 
> > > > Fixes: 217504a05532 ("usb: typec: ucsi: Work around PPM losing
> > > > change information")
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > 
> > > I'm OK with this if Bejamin does not see any problems with it. I'll
> > > wait for his comments before giving my reviewed-by tag.
> > > 
> > > That workaround (commit 217504a05532) is unfortunately too fragile.
> > > I'm going to now separate the processing of the connector state from
> > > the event handler (interrupt handler). That way we should be fairly
> > > sure we don't loose any of the connector states even if an event is
> > > generated while we are still in the middle of processing the previous
> > > one(s), and at the same time be sure that we also don't confuse the
> > > firmware.
> > > 
> > > So the event handler shall after that only read the connector status,
> > > schedule the unique job where it's processed and ACK the event.
> > > Nothing else.
> > 
> > Seems to be straightforward to implement. I'm attaching the patch I
> > made for that. I think it should actually also remove the problem you
> > are seeing. Can you test it?
> 
> Hmm, I am happy to try the patch tomorrow in the scenario where I
> observed my race condition.
> 
> Unfortunately, I don't feel it'll work. The problem that I was seeing
> looked like a race condition in the PPM itself, where the window is the
> time between the UCSI_GET_CONNECTOR_STATUS command and the subsequent
> ACK.
> For such a firmware level bug in the PPM, we need a way to detect the
> race condition when it happens (or get a fix for the firmware).

OK. Let me know does the patch bring the issue back for you.

> Note that there was also some code to always sent a
> UCSI_GET_CAM_SUPPORTED command "to ensure the PPM does not get stuck in
> case it assumes we do". I have no idea where this came from or what
> PPMs might require this workaround. But I doubt it is a good idea to
> drop it.

Sure.

thanks,

-- 
heikki
