Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD42365C38
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhDTP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:29:25 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57767 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233033AbhDTP3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:29:20 -0400
Received: (qmail 174910 invoked by uid 1000); 20 Apr 2021 11:28:48 -0400
Date:   Tue, 20 Apr 2021 11:28:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, m.v.b@runbox.com,
        hadess@hadess.net, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] USB: Don't set USB_PORT_FEAT_SUSPEND on WD19's
 Realtek Hub
Message-ID: <20210420152848.GC170810@rowland.harvard.edu>
References: <20210415114856.4555-1-chris.chiu@canonical.com>
 <YHgyP8tGNM1Wi5dJ@kroah.com>
 <CABTNMG0MuaSkWZhiTwtWjPTg5WZ-Vdt9Ju9-RzBke9JjCBJo8Q@mail.gmail.com>
 <20210415184637.GA15445@rowland.harvard.edu>
 <CABTNMG3aweq43eQcONif2_M4JF3ARmBgOKE18v7vzHvaJnjrtA@mail.gmail.com>
 <20210416153932.GD42403@rowland.harvard.edu>
 <CABTNMG25qPvVu7+EsvEgaUsU_v6jKkSKCaU5VR8CiX3oLQ4VFg@mail.gmail.com>
 <20210419141921.GA133494@rowland.harvard.edu>
 <CABTNMG0hnfXH8yqd6Zbk3EiZtg4JUpJomn180NHUyAdgZjL7pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTNMG0hnfXH8yqd6Zbk3EiZtg4JUpJomn180NHUyAdgZjL7pA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 03:14:56PM +0800, Chris Chiu wrote:
> On Mon, Apr 19, 2021 at 10:19 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Mon, Apr 19, 2021 at 01:11:38AM -0400, Chris Chiu wrote:
> > > Sorry that I didn't make myself clear. I found that if I applied RESET_RESUME
> > > quirk on the problematic hub, the Set-Port-Feature(suspend) timeout error
> > > disappeared. SInce the timeout is not happening for each suspend by default,
> > > I suspect maybe reset-resume take everything back to clean state for the hub
> > > and the Set-Port-Feature(suspend) can be taken care of w/o problems.
> >
> > Okay, that's a good solution for system suspend.
> >
> > > I didn't like RESET_RESUME because runtime PM would not work on the quirked
> > > device.
> >
> > A more interesting question is whether it will work for devices plugged
> > into the hub.  Even though the hub won't be runtime suspended, the
> > things attached to it might be.
> >
> > >  But if the Set-Port-Feature(suspend) can't be handled and
> > > skipped, I can't
> > > expect the runtime PM to work for all devices connected to the hub either.
> > > Is that right? If what I proposed in the patch can not get better
> > > result than existing
> > > quirk, I think using the RESET_RESUME would be a better option. Any suggestions?
> >
> > Try the RESET_RESUME quirk and see how well it works with runtime
> > suspend.
> >
> > Alan Stern
> 
> [  453.064346] usb 3-4: finish reset-resume
> [  453.192387] usb 3-4: reset high-speed USB device number 2 using xhci_hcd
> [  453.339916] usb 3-4: USB quirks for this device: 2

Here 3-4 is problematic RealTek hub, right?

> Seems that even w/ the RESET_RESUME enabled, the connected device still
> can runtime suspend/resume. That's acceptable to me. I'll send the patch
> with the reset-resume quirk later.
> 
> [  626.081068] usb 3-4.3.1: usb auto-suspend, wakeup 0
> [  632.552071] usb 3-4.3.1: usb auto-resume
> [  632.617467] usb 3-4.3.1: Waited 0ms for CONNECT
> [  632.617471] usb 3-4.3.1: finish resume

Then 3-4.3 is another hub plugged into the Realtek hub, and 3-4.3.1 (the 
device being suspended and resumed) is plugged into that other hub.

I'm concerned about devices that are plugged directly into the Realtek 
hub.  For example, did you try allowing the 3-4.3 hub in the experiment 
above to suspend and resume?

Alan Stern
