Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A8731CD06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhBPPcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:32:51 -0500
Received: from netrider.rowland.org ([192.131.102.5]:60709 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230261AbhBPPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:32:09 -0500
Received: (qmail 992341 invoked by uid 1000); 16 Feb 2021 10:31:26 -0500
Date:   Tue, 16 Feb 2021 10:31:26 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     eg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wesley Cheng <wcheng@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: usb: dwc3: gadget: Change runtime pm function for DWC3 runtime
 suspend
Message-ID: <20210216153126.GA991262@rowland.harvard.edu>
References: <CGME20210215025057epcas2p205c3c283a8806d818d71f90c872c6e51@epcas2p2.samsung.com>
 <1613356739-91734-1-git-send-email-dh10.jung@samsung.com>
 <20210215174145.GA960831@rowland.harvard.edu>
 <20210216013052.GA37172@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216013052.GA37172@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 10:30:52AM +0900, Jung Daehwan wrote:
> Hello, Alan
> 
> On Mon, Feb 15, 2021 at 12:41:45PM -0500, Alan Stern wrote:
> > On Mon, Feb 15, 2021 at 11:38:58AM +0900, Daehwan Jung wrote:
> > > It seems pm_runtime_put calls runtime_idle callback not runtime_suspend callback.
> > 
> > How is this fact related to your patch?
> 
> I think we should cause dwc3_runtime_suspend at the time.

Why do you think so?

> That's why I use pm_runtime_put_sync_suspend.
> 
> > 
> > > It's better to use pm_runtime_put_sync_suspend to allow DWC3 runtime suspend.
> > 
> > Why do you think it is better?  The advantage of pm_runtime_put is that 
> > it allows the suspend to occur at a later time in a workqueue thread, so 
> > the caller doesn't have to wait for the device to go into suspend.
> > 
> 
> We can assume DWC3 was already in suspend state if pm_runtime_get_sync
> returns 0. DWC3 resumes due to pm_rumtime_get_sync but it doesn't
> re-enter runtime_suspend but runtime_idle. pm_runtime_put decreases
> usage_count but doesn't cause runtime_suspend.
> 
> 1. USB disconnected
> 2. UDC unbinded
> 3. DWC3 runtime suspend
> 4. UDC binded unexpectedly
> 5. DWC3 runtime resume (pm_runtime_get_sync)
> 6. DWC3 runtime idle (pm_runtime_put)
>    -> DWC3 runtime suspend again (pm_runtime_put_sync_suspend)

That's what happens with your patch.  Now look at what happens without 
the patch:

1. USB disconnected
2. UDC unbound
3. DWC3 suspend request is added to waitqueue
4. UDC bound unexpectedly
5. DWC3 suspend request is removed from waitqueue
6. DWC3 runtime idle
7. DWC3 runtime suspend

The difference is that this way, we avoid doing an unnecessary suspend 
and resume, and we save the time they would have required.

> I've talked with Wesley in other patch.
> 
> usbb: dwc3: gadget: skip pullup and set_speed after suspend
> patchwork.kernel.org/project/linux-usb/patch/1611113968-102424-1-git-send-email-dh10.jung@samsung.com
> 
> @ Wesley
> 
> I think We should guarantee DWC3 enters suspend again at the time.

Why do you think we should guarantee this?

Alan Stern
