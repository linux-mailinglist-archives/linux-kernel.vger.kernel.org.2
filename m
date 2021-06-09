Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916253A12A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbhFIL14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:27:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:22014 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239057AbhFIL1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:27:55 -0400
IronPort-SDR: mAM37eUPQgoX8Jxzj8zLXDb9Yzy1lUUR7KuYDB7eOiFHjY4Zg+bXBJ/0zNDDXfrEdRXWqrbKiw
 kl7lWBFIifDQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="202028741"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="202028741"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 04:26:00 -0700
IronPort-SDR: dZEKBJhI74Ef4xMKb71rzCQINR0E6fZ8nlQ9ijauWzDSJ266mMWgJ62E0rjbiCIfsN13bCaVZ2
 R2r23ogX6M2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="552645489"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Jun 2021 04:25:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Jun 2021 14:25:57 +0300
Date:   Wed, 9 Jun 2021 14:25:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] usb: typec: ucsi: Polling the alt modes and PDOs
Message-ID: <YMClRTC8wW82IrDT@kuha.fi.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
 <4a76d2152f016b58298bec16aa2003a6ec55f8a8.camel@redhat.com>
 <YL8RPiVsEFOM9PBo@kuha.fi.intel.com>
 <YL8UD+nlBSSQGIMO@kuha.fi.intel.com>
 <f9e1640d4d1a2acbaacf83dee021cd4aa55f233f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9e1640d4d1a2acbaacf83dee021cd4aa55f233f.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 09:32:01PM +0200, Benjamin Berg wrote:
> On Tue, 2021-06-08 at 09:54 +0300, Heikki Krogerus wrote:
> > On Tue, Jun 08, 2021 at 09:42:09AM +0300, Heikki Krogerus wrote:
> > > Please check does the partner device get removed. What do you have
> > > under /sys/class/typec after that happens?
> > 
> > Oh yes. Could you also share the trace output when that happens?
> > 
> >         cd /sys/kernel/debug/tracing
> >         echo 1 > events/ucsi/enable
> >         # now reproduce the issue
> >         cat trace > ucsi.trace
> 
> So, the partner device is still there when this happens (see below). I
> also only see a single event in the trace for the fast plug/unplug
> case:
>    kworker/u16:8-1771    [003] .... 18848.872145: ucsi_connector_change: port1 status: change=4a04, opmode=5, connected=1, sourcing=0, partner_flags=1, partner_type=1, request_data_obj=1304b12c, BC status=1

OK. Sorry I had to double check because you were only talking about
the psy online state.

Can you now try this HACK on top of these patches:

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index bd39fe2cb1d0b..99f072700ce7f 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -843,7 +843,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
        if (!status.change) {
                dev_dbg(con->ucsi->dev, "con%d: spurious event\n", con->num);
-               goto out_ack;
+               /* XXX Force connection check. */
+               status.change = UCSI_CONSTAT_CONNECT_CHANGE;
        }
 
        event = kzalloc(sizeof(*event), GFP_KERNEL);

thanks,

-- 
heikki
