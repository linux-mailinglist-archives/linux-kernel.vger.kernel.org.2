Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795BE3EB72D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbhHMO6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:58:52 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39999 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S240983AbhHMO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:58:51 -0400
Received: (qmail 39765 invoked by uid 1000); 13 Aug 2021 10:58:23 -0400
Date:   Fri, 13 Aug 2021 10:58:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        ruslan.bilovol@gmail.com, mika.westerberg@linux.intel.com,
        maze@google.com, jj251510319013@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: optional SETUP/SET_REPORT mode
Message-ID: <20210813145823.GA38198@rowland.harvard.edu>
References: <20210813114551.72898-1-mdevaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813114551.72898-1-mdevaev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 02:45:51PM +0300, Maxim Devaev wrote:
> f_hid provides the OUT Endpoint for receiving reports from the host.
> The USB HID standard describes the OUT Endpoint support as optional,
> and hosts can ignore it if they don't support it.

No.  The HID standard (version 1.11 -- I may be out of date) actually 
says this (section 4.4):

	The Interrupt Out pipe is optional. If a device declares an 
	Interrupt Out endpoint then Output reports are transmitted by 
	the host to the device through the Interrupt Out endpoint. If 
	no Interrupt Out endpoint is declared then Output reports are
	transmitted to a device through the Control endpoint, using 
	Set_Report(Output) requests.

In other words, a device does not need to have an interrupt-OUT 
endpoint, but if it does have one then the host must use it.

> However, this raises several problems.
> 
> (1) Some host OS drivers without OUT Endpoint support can't receive

Can't _transmit_ output reports.  This is understandable, since such 
hosts aren't compliant with the standard.

>     reports at all. In the case of the keyboard, it becomes impossible
>     to get the status of the LEDs from the host OS.
> 
> (2) Some BIOSes and UEFIs not only don't support the OUT Endpoint,
>     they cannot work with HID with this configuration at all.

What configuration, exactly?  Do you mean that they can't work with 
HID interfaces that include an interrupt-OUT endpoint?

>     For example, absolutely all Apple UEFIs in all Macs can't handle
>     the OUT Endpoint in accordance with the HID standard so it makes
>     impossible to enter the Boot Menu using the hotkey at boot.

These hosts simply give up when they see an HID interface with an 
interrupt-OUT endpoint?  They don't just ignore it and continue on?

>     This problem also occurs on HP and DELL BIOSes and in some dumb
>     devices with primitive embedded firmware like KVM switches.
> 
> This patch adds option no_out_endpoint=1 to disable the OUT Endpoint
> and allow f_hid to receive reports from the host via SETUP/SET_REPORT.

Why not always allow f_hid to receive reports over ep0?  The HID 
standard doesn't forbid this.

> Previously, there was such a feature in f_hid, but it was replaced
> by the OUT Endpoint ("usb: gadget: hidg: register OUT INT endpoint
> for SET_REPORT").

Missing the SHA value of the commit.

Alan Stern

>  It seems that no one knew at the time that it would
> cause problems with BIOS. So this patch actually returns the removed
> functionality making it optional. For backward compatibility reasons,
> the OUT Endpoint mode remains the default behaviour.
> 
> If the SETUP/SET_REPORT mode is used, there is no event processing queue,
> so the user will only read the last report. For classic HID devices
> like keyboard this is not a problem, since it is intended to transmit
> the status of the LEDs and only the last report is important.
> 
> Both modes pass USBCV tests. Checking with the USB protocol analyzer
> also confirms that everything is working as it should and the new mode
> ensures operability in all of the described cases.

