Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F11F4415F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhKAJTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:19:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:27777 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhKAJTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:19:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="211745161"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="211745161"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 02:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="637726765"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2021 02:17:14 -0700
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1635751025-25906-1-git-send-email-zhuyinbo@loongson.cn>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v1] usb: xhci: add LPM quirk for ensuring uPD720201 into
 D3 state after S5
Message-ID: <f7cfa6bc-a0f6-aaa6-aafa-b4fe2714ca40@linux.intel.com>
Date:   Mon, 1 Nov 2021 11:18:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1635751025-25906-1-git-send-email-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 1.11.2021 9.17, Yinbo Zhu wrote:
> After S5, any pci device should into D3 state that if supported, but the
> uPD720201 was not and it may be the cause of xhci firmware and cause
> OSPM power consumption is more higher that S5 than S4. I think xhci HCD
> can add a quirk ensure it into D3 state after S5 that is appropriate
> and this patch was to add LPM quirk and set PCI_D3hot to uPD720201 pmsc
> register in xhci_pci_shutdown to fix xhci power consumption issue.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

I think we need a better understanding of the underlying issue before
adding a quirk like this.

Is this a known issue with the uPD720201 controller firmware? or is it
an issue with ACPI table entries not supporting the proper D state in BIOS
on the tested platform, or something completely different?

Also, LPM usually refers to "Link Power Management" in the xHCI spec.
This is about the U1 and U2 link states for the connected USB device.

If we end up needing a new xhci quirk it will need a new name.

Thanks
-Mathias
