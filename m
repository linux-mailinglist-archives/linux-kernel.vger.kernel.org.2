Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA9326DD7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 17:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhB0Q16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 11:27:58 -0500
Received: from netrider.rowland.org ([192.131.102.5]:55941 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230169AbhB0Q1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 11:27:46 -0500
Received: (qmail 1429364 invoked by uid 1000); 27 Feb 2021 11:27:03 -0500
Date:   Sat, 27 Feb 2021 11:27:03 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     liulongfang <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, yisen.zhuang@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] USB:XHCI:Modify XHCI driver for USB2.0 controller
Message-ID: <20210227162703.GA1429200@rowland.harvard.edu>
References: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
 <20210226163004.GB1392547@rowland.harvard.edu>
 <acfdf816-e295-df1d-4039-784fb0d417c4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acfdf816-e295-df1d-4039-784fb0d417c4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 11:38:08AM +0800, liulongfang wrote:
> On 2021/2/27 0:30, Alan Stern wrote:
> > On Fri, Feb 26, 2021 at 04:21:37PM +0800, Longfang Liu wrote:
> >> Our current XHCI hardware controller has been customized to only
> >> support USB 2.0 ports. When using the current xhci driver, an xhci
> >> controller device and an ehci controller device will be created
> >> automatically.
> > 
> > That sentence makes no sense at all.  An EHCI controller device is a 
> > piece of hardware.  How can an xHCI driver, which is a piece of 
> > software, create a piece of hardware?
> > 
> > Alan Stern
> > .
> > 
> The hardware device is a complete USB3.0 controller,
> but I hope to support a USB2.0-only mode through software configuration.

Even if it only supports USB-2.0 connections, an xHCI controller is 
still an xHCI controller.  It doesn't magically transform into an EHCI 
controller.

You are not creating an EHCI controller device.  Rather, you are trying 
to restrict an xHCI controller device to make it handle only USB-2.0 
connections.  If you run lsusb on a system that has an xHCI controller, 
you'll see that the controller is bound to two USB buses: a USB-2 bus 
and a USB-3 bus.  But for both buses, the controller is xHCI -- not 
EHCI.

Your patch description is inaccurate.

Alan Stern
