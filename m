Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317F0422B98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhJEO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:58:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41293 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233705AbhJEO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:58:46 -0400
Received: (qmail 623870 invoked by uid 1000); 5 Oct 2021 10:56:55 -0400
Date:   Tue, 5 Oct 2021 10:56:55 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rajat Jain <rajatja@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dtor@google.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        levinale@google.com, bleung@google.com, rajatxjain@gmail.com,
        jsbarnes@google.com, pmalani@google.com
Subject: Re: [PATCH 2/2] usb: hub: Mark devices downstream a removable hub,
 as removable
Message-ID: <20211005145655.GJ621017@rowland.harvard.edu>
References: <20210929224823.556943-1-rajatja@google.com>
 <20210929224823.556943-2-rajatja@google.com>
 <YVVLxi/on9x6nfCZ@kroah.com>
 <CACK8Z6EamamgYExt629gyNrYKpvnu2Gh0eGOOvOa5LH-jnOmaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6EamamgYExt629gyNrYKpvnu2Gh0eGOOvOa5LH-jnOmaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 03:42:46PM -0700, Rajat Jain wrote:
> +Dmitry Torokhov
> 
> Hi Greg, Oliver,
> 
> Thanks for taking a look.
> 
> On Wed, Sep 29, 2021 at 10:31 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Sep 29, 2021 at 03:48:23PM -0700, Rajat Jain wrote:
> > > If a usb device sits below a removable hub, mark the device also as
> > > removable. This helps with devices inserted on a standard removable hub or
> > > also thunderbold docks, to be shown as removable.
> > >
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > ---
> > >  drivers/usb/core/hub.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> >
> > Combined with the previous patch, you are now marking all devices that
> > happen to be attached to a root hub that is on a thunderbolt controller
> > as removable.  So all USB devices inside of a docking station are now
> > removable?
> 
> With this patch, yes that was my intent. I think what we are debating
> here is should the "removable" attribute imply possibility of removal
> from "the system" or just the "local immediate box" (e.g. thunderbolt
> dock). In my mind, the removable property was analogous to imply an
> "external device", i.e a device that may be removed from the system,
> perhaps as a result of its parent devices being removed from the
> system. I guess this definition doesn't match what you believe it
> should be?

As I understand it, the "removable" property refers specifically to 
the device's upstream link, not to whether _any_ of the links leading 
from the device to the computer could be removed.

This is probably what Oliver meant when he complained about losing 
information.  With the knowledge of whether each individual link is 
removable, you can easily tell whether there's some way to remove a 
device from the system.  But if you only know whether the device is 
removable from the system overall, you generally can't tell whether 
the link to the device's parent is removable.

Alan Stern
