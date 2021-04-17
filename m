Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10FB3630E1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhDQPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 11:31:33 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59497 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236287AbhDQPbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 11:31:32 -0400
Received: (qmail 73758 invoked by uid 1000); 17 Apr 2021 11:31:04 -0400
Date:   Sat, 17 Apr 2021 11:31:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     liulongfang <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [RFC PATCH] USB:XHCI:skip hub registration
Message-ID: <20210417153104.GA73141@rowland.harvard.edu>
References: <1618489358-42283-1-git-send-email-liulongfang@huawei.com>
 <20210415144323.GC1530055@rowland.harvard.edu>
 <3dad6f4f-6386-427c-c36c-7d26b9a76fa4@huawei.com>
 <20210416152021.GA42403@rowland.harvard.edu>
 <547e07d6-ae62-1225-7483-754bf57ed1d2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547e07d6-ae62-1225-7483-754bf57ed1d2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 02:48:22PM +0800, liulongfang wrote:
> On 2021/4/16 23:20, Alan Stern wrote:
> > On Fri, Apr 16, 2021 at 10:03:21AM +0800, liulongfang wrote:
> >> The current method is an improved method of the above patch.
> >> This patch just make it skip registering USB-3 root hub if that hub has no ports,
> > 
> > No, that isn't what this patch does.
> > 
> > If the root hub wasn't registered, hub_probe wouldn't get called.  But 
> > with your patch, the system tries to register the root hub, and it does 
> > call hub_probe, and then that function fails with a warning message.
> > 
> > The way to _really_ akip registering the root hub is to change the 
> > xhci-hcd code.  Make it skip calling usb_add_hcd.
> > 
> 
> If you do not register in the root hub, this will return an error code,

What will return an error code?  Are you talking about xhci_pci_probe()?  
You oight to be able to figure out how to make it work.

> which will make all the XHCI drivers unregister, causing the USB2.0 controllers
> on the xhci to be unavailable.

Alan Stern
