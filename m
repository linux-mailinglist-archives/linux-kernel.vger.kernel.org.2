Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F64B3A14FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhFIM6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:58:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:1387 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233695AbhFIM6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:58:31 -0400
IronPort-SDR: 0mRr7MCMWslOPEDSGTuxA2J7b1YWusGhGfewSl5J5z9nWRvCeUCMHW16zhX6DflUd6trMVBVDN
 zBSDgrJ4eOSw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="290695607"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208,223";a="290695607"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 05:56:34 -0700
IronPort-SDR: j/xqj6JXOtVwlECxTMAqiXS5Vh9eCFx7EWvOmpAClhaaBOT9yQDTBmG3/6M/KrKN7bsc4FLgig
 FsZ/mexenffw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208,223";a="552664927"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Jun 2021 05:56:31 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Jun 2021 15:56:30 +0300
Date:   Wed, 9 Jun 2021 15:56:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] usb: typec: ucsi: Polling the alt modes and PDOs
Message-ID: <YMC6fgoWiAe1C3uZ@kuha.fi.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
 <4a76d2152f016b58298bec16aa2003a6ec55f8a8.camel@redhat.com>
 <YL8RPiVsEFOM9PBo@kuha.fi.intel.com>
 <YL8UD+nlBSSQGIMO@kuha.fi.intel.com>
 <f9e1640d4d1a2acbaacf83dee021cd4aa55f233f.camel@redhat.com>
 <YMClRTC8wW82IrDT@kuha.fi.intel.com>
 <YMCxfC+S9EJNEiwq@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/TeB+Hja9PywstF5"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YMCxfC+S9EJNEiwq@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/TeB+Hja9PywstF5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 09, 2021 at 03:18:04PM +0300, Heikki Krogerus wrote:
> On Wed, Jun 09, 2021 at 02:26:00PM +0300, Heikki Krogerus wrote:
> > On Tue, Jun 08, 2021 at 09:32:01PM +0200, Benjamin Berg wrote:
> > > On Tue, 2021-06-08 at 09:54 +0300, Heikki Krogerus wrote:
> > > > On Tue, Jun 08, 2021 at 09:42:09AM +0300, Heikki Krogerus wrote:
> > > > > Please check does the partner device get removed. What do you have
> > > > > under /sys/class/typec after that happens?
> > > > 
> > > > Oh yes. Could you also share the trace output when that happens?
> > > > 
> > > >         cd /sys/kernel/debug/tracing
> > > >         echo 1 > events/ucsi/enable
> > > >         # now reproduce the issue
> > > >         cat trace > ucsi.trace
> > > 
> > > So, the partner device is still there when this happens (see below). I
> > > also only see a single event in the trace for the fast plug/unplug
> > > case:
> > >    kworker/u16:8-1771    [003] .... 18848.872145: ucsi_connector_change: port1 status: change=4a04, opmode=5, connected=1, sourcing=0, partner_flags=1, partner_type=1, request_data_obj=1304b12c, BC status=1
> > 
> > OK. Sorry I had to double check because you were only talking about
> > the psy online state.
> > 
> > Can you now try this HACK on top of these patches:
> > 
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > index bd39fe2cb1d0b..99f072700ce7f 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -843,7 +843,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
> >  
> >         if (!status.change) {
> >                 dev_dbg(con->ucsi->dev, "con%d: spurious event\n", con->num);
> > -               goto out_ack;
> > +               /* XXX Force connection check. */
> > +               status.change = UCSI_CONSTAT_CONNECT_CHANGE;
> >         }
> >  
> >         event = kzalloc(sizeof(*event), GFP_KERNEL);
> 
> No, that's not enough. Sorry.
> 
> I'm trying to get a confirmation on my suspecion that we do always
> actually get an event from the EC firmware, but we just end up
> filtering it out in this case because we are too slow in the driver. I
> have an idea what could be done about that, but I need to test if that
> really is the case.
> 
> I'll prepare a new version out of this entire series.

Actually, it's easier if you could just test this attached patch on
top of this series. It makes sure the every single event is
considered. I'm sorry about the hassle.

thanks,

-- 
heikki

--/TeB+Hja9PywstF5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-usb-typec-ucsi-Test-patch-for-confirming-events.patch"

From 9a5fc7d8e22ca5d0077a97345b8f079957a465b5 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Wed, 9 Jun 2021 15:48:23 +0300
Subject: [PATCH] usb: typec: ucsi: Test patch for confirming events

NOT-Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 80 ++++++++++++-----------------------
 1 file changed, 27 insertions(+), 53 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index bd39fe2cb1d0b..53718e655edbf 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -748,16 +748,34 @@ static void ucsi_connector_work(struct work_struct *work)
 {
 	struct ucsi_con_event *event = container_of(work, struct ucsi_con_event, work);
 	struct ucsi_connector *con = event->con;
+	struct ucsi_connector_status status;
 	struct ucsi *ucsi = con->ucsi;
 	enum typec_role role;
 	enum usb_role u_role = USB_ROLE_NONE;
+	u64 command;
 	int ret;
 
+	kfree(event);
+
+	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
+	ret = ucsi_send_command(ucsi, command, &status, sizeof(status));
+	if (ret < 0)
+		dev_err(ucsi->dev, "GET_CONNECTOR_STATUS failed (%d)\n", ret);
+
+	if (!status.change) {
+		dev_dbg(ucsi->dev, "con%d: spurious event\n", con->num);
+		/* XXX: Force connection check. */
+		status.change = UCSI_CONSTAT_CONNECT_CHANGE;
+	}
+
+	ret = ucsi_acknowledge_connector_change(ucsi);
+	if (ret)
+		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
+
 	mutex_lock(&con->lock);
 
-	trace_ucsi_connector_change(con->num, &event->status);
-	con->status = event->status;
-	kfree(event);
+	trace_ucsi_connector_change(con->num, &status);
+	con->status = status;
 
 	role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
 
@@ -816,53 +834,6 @@ static void ucsi_connector_work(struct work_struct *work)
 	mutex_unlock(&con->lock);
 }
 
-/*
- * We can not read the connector status in ucsi_connector_change() function
- * below because there may be already a command pending. This work is scheduled
- * separately only because of that.
- *
- * This function must finish fast so we do not loose the next events. Every
- * event will have a separate job queued for it in the connector specific
- * workqueue. That way the next event can be generated safely before the
- * previous ones are fully processed.
- */
-static void ucsi_handle_connector_change(struct work_struct *work)
-{
-	struct ucsi_connector *con = container_of(work, struct ucsi_connector, work);
-	struct ucsi_connector_status status;
-	struct ucsi_con_event *event;
-	u64 command;
-	int ret;
-
-	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
-	ret = ucsi_send_command(con->ucsi, command, &status, sizeof(status));
-	if (ret < 0) {
-		dev_err(con->ucsi->dev, "GET_CONNECTOR_STATUS failed (%d)\n", ret);
-		goto out_ack;
-	}
-
-	if (!status.change) {
-		dev_dbg(con->ucsi->dev, "con%d: spurious event\n", con->num);
-		goto out_ack;
-	}
-
-	event = kzalloc(sizeof(*event), GFP_KERNEL);
-	if (!event)
-		goto out_ack;
-
-	INIT_WORK(&event->work, ucsi_connector_work);
-	event->status = status;
-	event->con = con;
-	queue_work(con->wq, &event->work);
-
-out_ack:
-	clear_bit(EVENT_PENDING, &con->ucsi->flags);
-
-	ret = ucsi_acknowledge_connector_change(con->ucsi);
-	if (ret)
-		dev_err(con->ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
-}
-
 /**
  * ucsi_connector_change - Process Connector Change Event
  * @ucsi: UCSI Interface
@@ -871,16 +842,20 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 void ucsi_connector_change(struct ucsi *ucsi, u8 num)
 {
 	struct ucsi_connector *con = &ucsi->connector[num - 1];
+	struct ucsi_con_event *event;
 
 	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
 		dev_dbg(ucsi->dev, "Bogus connector change event\n");
 		return;
 	}
 
-	if (test_and_set_bit(EVENT_PENDING, &ucsi->flags))
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event)
 		return;
 
-	schedule_work(&con->work);
+	INIT_WORK(&event->work, ucsi_connector_work);
+	event->con = con;
+	queue_work(con->wq, &event->work);
 }
 EXPORT_SYMBOL_GPL(ucsi_connector_change);
 
@@ -1078,7 +1053,6 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	if (!con->wq)
 		return -ENOMEM;
 
-	INIT_WORK(&con->work, ucsi_handle_connector_change);
 	init_completion(&con->complete);
 	mutex_init(&con->lock);
 	con->num = index + 1;
-- 
2.30.2


--/TeB+Hja9PywstF5--
