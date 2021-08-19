Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A521E3F1C40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhHSPKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:10:24 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52969 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232821AbhHSPKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:10:23 -0400
Received: (qmail 229553 invoked by uid 1000); 19 Aug 2021 11:09:46 -0400
Date:   Thu, 19 Aug 2021 11:09:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [QUERY] Cold plugged USB device to Inateck PCIE USB card is not
 detected
Message-ID: <20210819150946.GC228422@rowland.harvard.edu>
References: <772e4001-178e-4918-032c-6e625bdded24@ti.com>
 <970f741a-54ee-0fa7-46d9-51f77764c6bb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970f741a-54ee-0fa7-46d9-51f77764c6bb@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 04:18:12PM +0300, Mathias Nyman wrote:
> On 19.8.2021 10.54, Kishon Vijay Abraham I wrote:
> > Hi All,
> > 
> > I was trying to test PCIe USB card (Inateck) connected to AM64 EVM and
> > J7200 EVM. Inateck uses Renesas uPD720201 USB3 host controller.
> > 
> > So if I connect USB pendrive and then boot the board (cold plug), I
> > don't see the pendrive getting detected. But if I remove and plug it
> > again, it gets detected.
> > 
> > For the cold plug case, I see this message
> > 	"usb usb1-port3: couldn't allocate usb_device"
> > 
> > It actually fails in
> > xhci_alloc_dev()->xhci_queue_slot_control()->queue_command()->XHCI_STATE_HALTED
> > 
> > I'm not familiar with xhci but it looks like port event is invoked
> > before the controller is fully initialized (?).
> 
> Maybe this controller is capable of generating interrupts before it's running?

Mathias and Kishon:

Note that this issue has also been reported in Bugzilla:

	https://bugzilla.kernel.org/show_bug.cgi?id=214021

Alan Stern
