Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E873D5A84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhGZNBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:01:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:41932 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233849AbhGZNAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:00:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="273322127"
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="273322127"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 06:40:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="416553000"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 06:40:40 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 26 Jul 2021 16:40:37 +0300
Date:   Mon, 26 Jul 2021 16:40:37 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkelshb@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rajatxjain@gmail.com
Subject: Re: [PATCH v2] thunderbolt: For dev authorization changes, include
 the actual event in udev change notification
Message-ID: <YP67VTcyFhro9wyX@lahna>
References: <20210724004043.2075819-1-rajatja@google.com>
 <CACK8Z6GsNi9FVUdqdfj0vUFj0mJtMQ_pm4aPH8d3ozsa5Zswhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6GsNi9FVUdqdfj0vUFj0mJtMQ_pm4aPH8d3ozsa5Zswhg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

On Fri, Jul 23, 2021 at 05:41:58PM -0700, Rajat Jain wrote:
> (fixing the typo in the email ID for Greg).
> 
> On Fri, Jul 23, 2021 at 5:40 PM Rajat Jain <rajatja@google.com> wrote:
> >
> > For security, we would like to monitor and track when the thunderbolt
> > devices are authorized and deauthorized (i.e. when the thunderbolt sysfs
> > "authorized" attribute changes). Currently the userspace gets a udev
> > change notification when there is a change, but the state may have
> > changed (again) by the time we look at the authorized attribute in
> > sysfs. So an authorization event may go unnoticed. Thus make it easier
> > by informing the actual change (new value of authorized attribute) in
> > the udev change notification.
> >
> > The change is included as a key value "authorized=<val>" where <val>
> > is the new value of sysfs attribute "authorized", and is described at
> > Documentation/ABI/testing/sysfs-bus-thunderbolt under
> > /sys/bus/thunderbolt/devices/.../authorized

Looking good, a couple of minor nits below.

> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/thunderbolt/switch.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> > index 83b1ef3d5d03..382128dfbdee 100644
> > --- a/drivers/thunderbolt/switch.c
> > +++ b/drivers/thunderbolt/switch.c
> > @@ -1499,6 +1499,7 @@ static ssize_t authorized_show(struct device *dev,
> >  static int disapprove_switch(struct device *dev, void *not_used)
> >  {
> >         struct tb_switch *sw;
> > +       char *envp[] = { "AUTHORIZED=0", NULL };

Can you move arrange this to be before sw, like:

	char *envp[] = { "AUTHORIZED=0", NULL };
	struct tb_switch *sw;

> >
> >         sw = tb_to_switch(dev);
> >         if (sw && sw->authorized) {
> > @@ -1514,7 +1515,7 @@ static int disapprove_switch(struct device *dev, void *not_used)
> >                         return ret;
> >
> >                 sw->authorized = 0;
> > -               kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> > +               kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
> >         }
> >
> >         return 0;
> > @@ -1523,6 +1524,8 @@ static int disapprove_switch(struct device *dev, void *not_used)
> >  static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
> >  {
> >         int ret = -EINVAL;
> > +       char envp_string[13];
> > +       char *envp[] = { envp_string, NULL };

Ditto.

> >
> >         if (!mutex_trylock(&sw->tb->lock))
> >                 return restart_syscall();
> > @@ -1560,7 +1563,8 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
> >         if (!ret) {
> >                 sw->authorized = val;
> >                 /* Notify status change to the userspace */
> > -               kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> > +               sprintf(envp_string, "AUTHORIZED=%u", sw->authorized);
> > +               kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
> >         }
> >
> >  unlock:
> > --
> > 2.32.0.432.gabb21c7263-goog
> >
