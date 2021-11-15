Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C59451C33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349823AbhKPAOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:14:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:46514 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240317AbhKOWmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 17:42:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="232269578"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="232269578"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 14:35:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="645046000"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2021 14:35:45 -0800
Subject: Re: [5.12 - 5.15] xHCI controller dead - not renesas but intel
To:     Norbert Preining <norbert@preining.info>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <YY3RIdKBbIL3Dw/q@bulldog.preining.info>
Cc:     Norbert Preining <norbert@preining.info>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <8f752efb-e38e-b012-de98-e4b938dde7b7@linux.intel.com>
Date:   Tue, 16 Nov 2021 00:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YY3RIdKBbIL3Dw/q@bulldog.preining.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.2021 4.27, Norbert Preining wrote:
> Dear all,
> 
> (please Cc)
> 
> I see quite some discussion here about hanging USB controls from
> Renesas. Interestingly, I see the very same behaviour with my Intel USB
> controller:
> 00:14.0 USB controller: Intel Corporation 100 Series/C230 Series Chipset Family USB 3.0 xHCI Controller (rev 31)
> 
> It happens again and again that:
> Nov 12 10:57:58 bulldog kernel: xhci_hcd 0000:00:14.0: Abort failed to stop command ring: -110
> Nov 12 10:57:58 bulldog kernel: xhci_hcd 0000:00:14.0: xHCI host controller not responding, assume dead
> Nov 12 10:57:58 bulldog kernel: xhci_hcd 0000:00:14.0: HC died; cleaning up
> Nov 12 10:57:58 bulldog kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
> 
> and I loose all mouse/kbd access.
> 
> I have the feeling that it happens more often/at all when I redirect my
> USB webcam to a virtual machine using virt-manager.
> Before the above happened, the log showed
> Nov 12 10:57:06 bulldog kernel: usb 1-12: reset high-speed USB device number 47 using xhci_hcd
> Nov 12 10:57:11 bulldog kernel: usb 1-12: device descriptor read/64, error -110
> Nov 12 10:57:27 bulldog kernel: usb 1-12: device descriptor read/64, error -110
> Nov 12 10:57:27 bulldog kernel: usb 1-12: reset high-speed USB device number 47 using xhci_hcd
> Nov 12 10:57:32 bulldog kernel: usb 1-12: device descriptor read/64, error -110
> Nov 12 10:57:48 bulldog kernel: usb 1-12: device descriptor read/64, error -110
> Nov 12 10:57:48 bulldog kernel: usb 1-12: reset high-speed USB device number 47 using xhci_hcd
> 
> where 
> HD Pro Webcam C920 as /devices/pci0000:00/0000:00:14.0/usb1/1-12/1-12:1.0/input/input40
> 
> I am currently running 5.15.1.
> 
> Is there anything (besides ssh-ing into the machine and unbind/bind the
> pci device) I can provide or do?

Patch in link below resolved another case with similar log. 
Does it help in your case?

https://lore.kernel.org/linux-usb/20211115221630.871204-1-mathias.nyman@linux.intel.com/T/#u

-Mathias
