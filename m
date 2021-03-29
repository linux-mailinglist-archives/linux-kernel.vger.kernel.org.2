Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382E134D3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhC2P0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:26:18 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52361 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231320AbhC2PZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:25:45 -0400
Received: (qmail 936534 invoked by uid 1000); 29 Mar 2021 11:25:44 -0400
Date:   Mon, 29 Mar 2021 11:25:44 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     liulongfang <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, yisen.zhuang@huawei.com,
        tanxiaofei@huawei.com, liudongdong3@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] USB:ohci:fix ohci interruption problem
Message-ID: <20210329152544.GB933773@rowland.harvard.edu>
References: <1616748896-9415-1-git-send-email-liulongfang@huawei.com>
 <20210326152821.GA832251@rowland.harvard.edu>
 <e8d6fb1c-5a9b-426a-4844-add67aac768f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d6fb1c-5a9b-426a-4844-add67aac768f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 04:38:10PM +0800, liulongfang wrote:
> On 2021/3/26 23:28, Alan Stern wrote:
> > On Fri, Mar 26, 2021 at 04:54:56PM +0800, Longfang Liu wrote:
> >> When OHCI enters the S4 sleep state, the USB sleep process will call
> >> check_root_hub_suspend() and ohci_bus_suspend() instead of
> >> ohci_suspend() and ohci_bus_suspend(), this causes the OHCI interrupt
> >> to not be closed.
> > 
> > What on earth are you talking about?  This isn't true at all.
> > 
> > Can you provide more information about your system?  Are you using a 
> > PCI-based OHCI controller or a platform device (and if so, which one)?  
> > Can you post system logs to back up your statements?
> > The system is UOS, the kernel version is kernel4.19, and the driver
> used is ohci-pci.c based on PCI.
> 
> By adding the log in ohci_suspend, and then viewing the dmesg after sleep,
> I can confirm that the system does not call ohci_suspend in S4 sleep mode.

Then your job is to figure out why not.  Doesn't entry into S4 sleep
call hcd_pci_suspend() in core/hcd-pci.c, and doesn't that call
suspend_common(), and doesn't that call hcd->driver->pci_suspend(),
and isn't that routine ohci_suspend()?

Alan Stern
