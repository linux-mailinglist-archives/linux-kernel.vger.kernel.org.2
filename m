Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639793623CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbhDPPVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:21:55 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48199 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S245435AbhDPPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:20:48 -0400
Received: (qmail 43577 invoked by uid 1000); 16 Apr 2021 11:20:21 -0400
Date:   Fri, 16 Apr 2021 11:20:21 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     liulongfang <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [RFC PATCH] USB:XHCI:skip hub registration
Message-ID: <20210416152021.GA42403@rowland.harvard.edu>
References: <1618489358-42283-1-git-send-email-liulongfang@huawei.com>
 <20210415144323.GC1530055@rowland.harvard.edu>
 <3dad6f4f-6386-427c-c36c-7d26b9a76fa4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dad6f4f-6386-427c-c36c-7d26b9a76fa4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:03:21AM +0800, liulongfang wrote:
> On 2021/4/15 22:43, Alan Stern wrote:
> > On Thu, Apr 15, 2021 at 08:22:38PM +0800, Longfang Liu wrote:
> >> When the number of ports on the USB hub is 0, skip the registration
> >> operation of the USB hub.
> >>
> >> The current Kunpeng930's XHCI hardware controller is defective. The number
> >> of ports on its USB3.0 bus controller is 0, and the number of ports on
> >> the USB2.0 bus controller is 1.
> >>
> >> In order to solve this problem that the USB3.0 controller does not have
> >> a port which causes the registration of the hub to fail, this patch passes
> >> the defect information by adding flags in the quirks of xhci and usb_hcd,
> >> and finally skips the registration process of the hub directly according
> >> to the results of these flags when the hub is initialized.
> >>
> >> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> > 
> > The objections that Greg raised are all good ones.
> > 
> > But even aside from them, this patch doesn't actually do what the 
> > description says.  The patch doesn't remove the call to usb_add_hcd 
> > for the USB-3 bus.  If you simply skipped that call (and the 
> > corresponding call to usb_remove_hcd) when there are no 
> > ports on the root hub, none of the stuff in this patch would be needed.
> > 
> > Alan Stern
> > 
> 
> "[RFC PATCH] USB:XHCI:Adjust the log level of hub"

I don't understand.  What patch is that?  Do you have a URL for it?

> The current method is an improved method of the above patch.
> This patch just make it skip registering USB-3 root hub if that hub has no ports,

No, that isn't what this patch does.

If the root hub wasn't registered, hub_probe wouldn't get called.  But 
with your patch, the system tries to register the root hub, and it does 
call hub_probe, and then that function fails with a warning message.

The way to _really_ akip registering the root hub is to change the 
xhci-hcd code.  Make it skip calling usb_add_hcd.

> after skipping registering, no port will not report error log,the goal of this
> patch is reached without error log output.

Why do you want to get rid of the error log output?  There really _is_ 
an error, because the USB-3 hardware on your controller is defective.  
Since the hardware is buggy, we _should_ print an error message in the 
kernel log.

Alan Stern
