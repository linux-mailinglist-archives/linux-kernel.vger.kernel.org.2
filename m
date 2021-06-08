Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B383A0267
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhFHTDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:03:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60965 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236736AbhFHSzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:55:08 -0400
Received: (qmail 1814829 invoked by uid 1000); 8 Jun 2021 14:53:14 -0400
Date:   Tue, 8 Jun 2021 14:53:14 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        ierturk@ieee.org
Subject: Re: Strange problem with USB device
Message-ID: <20210608185314.GB1812516@rowland.harvard.edu>
References: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
 <20210608182038.GA1812516@rowland.harvard.edu>
 <a7c7ba62-a74f-d7db-bfd9-4f6c8e25e0b8@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7c7ba62-a74f-d7db-bfd9-4f6c8e25e0b8@lwfinger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 01:37:07PM -0500, Larry Finger wrote:
> On 6/8/21 1:20 PM, Alan Stern wrote:
> > One thing you might try is to turn on USB debugging before
> > plugging in the device:
> > 
> > echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control
> > 
> > The additional information this adds to the dmesg log may be
> > helpful.
> 
> The BT device is part of the same card as the PCIe wifi device, thus
> there is no "plugging" it in a conventional sense.

I don't get it.  If this is a PCIe device, why should it appear 
on a USB bus?  Wouldn't you expect it to show up as a PCI device 
on a PCI bus instead?

>  Is there some way to
> add the usbcore debugging statement to the kernel options line at boot
> time?

Yes.  Use the kernel boot-line parameter:

	usbcore.dyndbg="=p"

FYI, how to use dynamic debugging is explained at length in the 
kernel source file 
Documentation/admin-guide/dynamic-debug-howto.rst.

Alan Stern

> As I told GregKH, I am having the person with the problem try a rescue
> system with a 5.12 kernel.
> 
> Larry
> 
