Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2EF39FEF0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhFHSWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:22:34 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52861 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233062AbhFHSWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:22:32 -0400
Received: (qmail 1813769 invoked by uid 1000); 8 Jun 2021 14:20:38 -0400
Date:   Tue, 8 Jun 2021 14:20:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        ierturk@ieee.org
Subject: Re: Strange problem with USB device
Message-ID: <20210608182038.GA1812516@rowland.harvard.edu>
References: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 12:41:23PM -0500, Larry Finger wrote:
> Hi,
> 
> In https://bugzilla.suse.com/show_bug.cgi?id=1186889, a user is
> reporting that his Bluetooth component of a Realtek RTL8822CE is not

Is that a USB device?  That is, does it connect to the computer 
via a USB cable?  I'll assume it does...

> being found in openSUSE's kernel 5.3.18. His lsusb scan is as follows:
> 
> $ lsusb
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 003: ID 13d3:56c9 IMC Networks HP TrueVision HD Camera
> Bus 001 Device 002: ID 045e:07fd Microsoft Corp. Nano Transceiver 1.1
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> The Bluetooth device is found and works in Windows 10, where the Device
> Manager reports hardware ID's of 0bda:b00c. This combination is in
> driver btusb.
> 
> Is there a bug in the USB bus scan in kernel 5.3.18 that has since been
> fixed, or is there still a bug that misses this device?

Given only the information you have provided, it is impossible to 
answer that question.  Broadly speaking, lots of bugs in the USB 
subsystem have been fixed since kernel 5.3.18, but I don't know 
if any of them would affect detecting new devices on the bus like 
this.

One thing you might try is to turn on USB debugging before 
plugging in the device:

echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control

The additional information this adds to the dmesg log may be 
helpful.

Alan Stern
