Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC623E176B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbhHEO4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:56:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:30728 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233269AbhHEO4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:56:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="194444390"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="194444390"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 07:56:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="467537626"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 05 Aug 2021 07:56:32 -0700
Subject: Re: USB xhci crash under load on 5.14-rc3
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YQpJLk42b+0g7WFB@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <9bb1d58b-5c68-86b7-13df-2faa749880c5@linux.intel.com>
Date:   Thu, 5 Aug 2021 17:59:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YQpJLk42b+0g7WFB@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.8.2021 11.00, Greg KH wrote:
> Hi,
> 
> I was doing some filesystem backups from one USB device to another one
> this weekend and kept running into the problem of the xhci controller
> shutting down after an hour or so of high volume traffic.
> 
> I finally captured the problem in the kernel log as this would also take
> out my keyboard, making it hard to recover from :)
> 
> The log is below for when the problem happens, and then the devices are
> disconnected from the bus (ignore the filesystem errors, those are
> expected when i/o is in flight and we disconnect a device.
> 
> Any hint as to what the IO_PAGE_FAULT error messages are?
> 

No idea, unfortunately.

> I'll go back to 5.13.y now and see if I can reproduce it there or not,
> as my backups are not yet done...
> 
> thanks,
> 
> greg k-h
> 
> 
> [Aug 4 09:48] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff00000 flags=0x0000]
> [  +0.000012] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff00f80 flags=0x0000]
> [  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff01000 flags=0x0000]
> [  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff01f80 flags=0x0000]
> [  +0.000005] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff02000 flags=0x0000]
> [  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff02f80 flags=0x0000]
> [  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff03000 flags=0x0000]
> [  +0.000005] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff03f80 flags=0x0000]
> [  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff04000 flags=0x0000]
> [Aug 4 09:49] sd 3:0:0:0: [sdc] tag#21 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN 
> [  +0.000011] sd 3:0:0:0: [sdc] tag#21 CDB: Read(16) 88 00 00 00 00 01 8a 44 08 b0 00 00 00 08 00 00
> [  +5.106493] xhci_hcd 0000:47:00.1: xHCI host not responding to stop endpoint command.
> [  +0.000010] xhci_hcd 0000:47:00.1: USBSTS: HCHalted HSE


HSE "Host System Error" bit is set, meaning xHC hardware detected a serious error and stopped the host.
HSE was probably set 5-10 seconds earlier, but only discovered here.

Specs state:

xHC sets this bit to ‘1’ when a serious error
is detected, either internal to the xHC or during a host system access involving the xHC module.
(In a PCI system, conditions that set this bit to ‘1’ include PCI Parity error, PCI Master Abort, and
PCI Target Abort.)

-Mathias
