Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8B37C2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhELPPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:15:05 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43535 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230497AbhELPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:05:35 -0400
Received: (qmail 935403 invoked by uid 1000); 12 May 2021 11:04:24 -0400
Date:   Wed, 12 May 2021 11:04:24 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, m.v.b@runbox.com,
        hadess@hadess.net, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] USB: reset-resume the device when PORT_SUSPEND is
 set but timeout
Message-ID: <20210512150424.GA934575@rowland.harvard.edu>
References: <20210510145030.1495-1-chris.chiu@canonical.com>
 <20210510145030.1495-2-chris.chiu@canonical.com>
 <20210510150203.GD863718@rowland.harvard.edu>
 <CABTNMG24BOS_+uGEYFLJrmEW10eTGjrOowwS7Zb_U+AvkZWTyQ@mail.gmail.com>
 <20210511163026.GA901897@rowland.harvard.edu>
 <CABTNMG2OiEFzMwMaUaVL9B6Om87e9qQMFBXRKej7G6zuvBXW=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTNMG2OiEFzMwMaUaVL9B6Om87e9qQMFBXRKej7G6zuvBXW=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 12:17:12PM +0800, Chris Chiu wrote:
> On Wed, May 12, 2021 at 12:30 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, May 11, 2021 at 01:04:36PM +0800, Chris Chiu wrote:
> > > On Mon, May 10, 2021 at 11:02 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Mon, May 10, 2021 at 10:50:29PM +0800, chris.chiu@canonical.com wrote:
> > > > > From: Chris Chiu <chris.chiu@canonical.com>
> > > > >
> > > > > On the Realtek high-speed Hub(0bda:5487), the port which has wakeup
> > > > > enabled_descendants will sometimes timeout when setting PORT_SUSPEND
> > > > > feature. After checking the PORT_SUSPEND bit in wPortStatus, it is
> > > > > already set. However, the hub will fail to activate because the
> > > > > PORT_SUSPEND feature of that port is not cleared during resume. All
> > > > > connected devices are lost after resume.
> > > > >
> > > > > This commit force reset-resume the device connected to the timeout
> > > > > but suspended port so that the hub will have chance to clear the
> > > > > PORT_SUSPEND feature during resume.
> > > >
> > > > Are you certain that the reset-resume is needed?  What happens if you
> > > > leave out the line that sets udev->reset_resume?  The rest of the patch
> > > > will cause the kernel to realize that the port really is suspended, so
> > > > maybe the suspend feature will get cleared properly during resume.
> > > >
> > > > It's worthwhile to try the experiement and see what happens.
> > > >
> > > > Alan Stern
> > > >
> > >
> > > If I leave out the udev->reset_resume set, the resume will fail. Please refer
> > > to the following kernel log. The usb 1-1 is the hub which has wakeup enabled
> > > descendants.
> > >
> > > [   57.210472] usb 1-1: kworker/u32:7 timed out on ep0out len=0/0
> > > [   57.211022] usb 1-1-port3: suspend timeout, status 0507
> > > [   57.211130] hub 1-1:1.0: hub_suspend
> > > [   57.230500] usb 1-1: usb suspend, wakeup 0
> > >
> > > The timeout happens at 57.210472 and you can see the PORT_SUSPEND
> > > bit is actually set in the "status 0507". The following shows the resume log.
> > >
> > > [   58.046556] usb 1-1: usb resume
> > > [   58.114515] usb 1-1: Waited 0ms for CONNECT
> > > [   58.114524] usb 1-1: finish resume
> > > [   58.114928] hub 1-1:1.0: hub_resume
> > > [   58.116035] usb 1-1-port3: status 0507 change 0000
> > > [   58.116720] usb 1-1-port5: status 0503 change 0000
> > > [   58.116778] hub 1-1.3:1.0: hub_resume
> > > [   58.116908] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
> > > [   58.116952] usb 1-1.5: Waited 0ms for CONNECT
> > > [   58.116955] usb 1-1.5: finish resume
> > > [   58.117157] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
> > > [   58.117397] usb 1-1.3-port5: can't resume, status -71
> > > [   58.117782] hub 1-1.3:1.0: hub_ext_port_status failed (err = -71)
> > > [   58.118147] usb 1-1.3-port2: can't resume, status -71
> > > [   58.118149] usb 1-1.3.2: Waited 0ms for CONNECT
> > > [   58.118151] usb 1-1.3-port2: status 07eb.906e after resume, -19
> > > [   58.118153] usb 1-1.3.2: can't resume, status -19
> > > [   58.118154] usb 1-1.3-port2: logical disconnect
> > > [   58.118526] usb 1-1.3-port2: cannot disable (err = -71)
> > >
> > > As you see in the 58.116035, the hub_resume and activate is OK for the
> > > usb 1-1. The "usb 1-1.3: finish resume" is not in the log because it's not
> > > considered suspended and no chance to ClearPortFeature.
> >
> > Wait -- why isn't it considered suspended?  We saw at 57.211022 that
> > 1-1-port3's Suspend feature really was set, and thanks to your patch,
> > the kernel should now believe that the port is suspended.
> >
> But it's still in the `if (status)` branch so it will not get
> usb_set_device_state
> to USB_STATE_SUSPENDED, then usb_resume_both will not do the resume
> process for it.

Ah, yes.  I was mis-reading the patch.

> My original thought is, we still take this as an abnormal status
> because we don't
> really know the reason for the timeout. Set reset_resume for the udev
> will make the
> kernel to reset_resume it. Or  I have to create a new `goto` name in
> the `else` branch
> to force it back to the successful suspended process. And should I
> clean the status to
> zero for pm_runtime_put_sync()? What's your suggestion?

For testing purposes, set status to 0 and jump to a new goto label in 
the "else" branch.  In other words, treat it as if the suspend really 
had worked and go back to the successful pathway.  Try this out and see 
if it fixes the problem.

If it does then the reset-resume isn't needed.  If it doesn't, post your 
patch again, and mention in the patch description that testing shows the 
reset-resume really is necessary.

Alan Stern
