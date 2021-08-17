Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D663EEB46
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbhHQKzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:55:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:56076 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231515AbhHQKzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:55:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="216073268"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="216073268"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 03:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="593311540"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Aug 2021 03:55:11 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Aug 2021 13:55:10 +0300
Date:   Tue, 17 Aug 2021 13:55:10 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Raise vdm_sm_running flag only when
 VDM SM is running
Message-ID: <YRuVjkcbT5058ulV@kuha.fi.intel.com>
References: <20210816075449.2236547-1-kyletso@google.com>
 <YRuD4HDNuWOx3Xrv@kuha.fi.intel.com>
 <CAGZ6i=0=shyW-Y7G+SrySi7Sum8qnjhpOwp=vC+SUmwHkbQMrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ6i=0=shyW-Y7G+SrySi7Sum8qnjhpOwp=vC+SUmwHkbQMrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 06:32:55PM +0800, Kyle Tso wrote:
> On Tue, Aug 17, 2021 at 5:39 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Mon, Aug 16, 2021 at 03:54:49PM +0800, Kyle Tso wrote:
> > > If the port is going to send Discover_Identity Message, vdm_sm_running
> > > flag was intentionally set before entering Ready States in order to
> > > avoid the conflict because the port and the port partner might start
> > > AMS at almost the same time after entering Ready States.
> > >
> > > However, the original design has a problem. When the port is doing
> > > DR_SWAP from Device to Host, it raises the flag. Later in the
> > > tcpm_send_discover_work, the flag blocks the procedure of sending the
> > > Discover_Identity and it might never be cleared until disconnection.
> >
> > This is a bit off-topic, but I just asked this in another thread: Why
> > do we have to do discovery with data role swap?
> >
> > thanks,
> >
> 
> This can be separated into two cases:
> 
> 1. in PD2: If the port is originally UFP, it cannot send
> Discover_Identity Message according to the Spec. And then DR_SWAP
> happens. The port becomes DFP, and now it can do that.
> 
> 2. in PD3: DFP and UFP are allowed to send Discover_Identity Message
> and the responses may differ based on which roles they are active on.
> 
> Quote from the PD3 Spec:
> ```
> The Discover Identity Command Shall be used to determine the identity
> and/or capabilities of the Port Partner. The following products Shall
> return a Discover Identity Command ACK in response to a Discover
> Identity Command request sent to SOP:
> 
> • A PD-Capable UFP that supports Modal Operation.
> • A PD-Capable product that has multiple DFPs.
> • A PD-Capable [USB4] product.
> ```

Got it. Thanks for the explanation.

> > > Since there exists another flag send_discover representing that the port
> > > is going to send Discover_Identity or not, it is enough to use that flag
> > > to prevent the conflict. Also change the timing of the set/clear of
> > > vdm_sm_running to indicate whether the VDM SM is actually running or
> > > not.
> > >
> > > Fixes: c34e85fa69b9 ("usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work")
> > > Cc: Badhri Jagan Sridharan <badhri@google.com>
> > > Signed-off-by: Kyle Tso <kyletso@google.com>

FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


thanks,

-- 
heikki
