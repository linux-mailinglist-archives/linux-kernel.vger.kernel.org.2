Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499923F284F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhHTIZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:25:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:4395 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhHTIZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:25:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203932489"
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="203932489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 01:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="472231598"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 20 Aug 2021 01:24:21 -0700
Subject: Re: [QUERY] Cold plugged USB device to Inateck PCIE USB card is not
 detected
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <772e4001-178e-4918-032c-6e625bdded24@ti.com>
 <970f741a-54ee-0fa7-46d9-51f77764c6bb@linux.intel.com>
 <20210819150946.GC228422@rowland.harvard.edu>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <a0d077d1-b337-858f-135c-66ae7420bf9b@linux.intel.com>
Date:   Fri, 20 Aug 2021 11:26:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210819150946.GC228422@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.8.2021 18.09, Alan Stern wrote:
> On Thu, Aug 19, 2021 at 04:18:12PM +0300, Mathias Nyman wrote:
>> On 19.8.2021 10.54, Kishon Vijay Abraham I wrote:
>>> Hi All,
>>>
>>> I was trying to test PCIe USB card (Inateck) connected to AM64 EVM and
>>> J7200 EVM. Inateck uses Renesas uPD720201 USB3 host controller.
>>>
>>> So if I connect USB pendrive and then boot the board (cold plug), I
>>> don't see the pendrive getting detected. But if I remove and plug it
>>> again, it gets detected.
>>>
>>> For the cold plug case, I see this message
>>> 	"usb usb1-port3: couldn't allocate usb_device"
>>>
>>> It actually fails in
>>> xhci_alloc_dev()->xhci_queue_slot_control()->queue_command()->XHCI_STATE_HALTED
>>>
>>> I'm not familiar with xhci but it looks like port event is invoked
>>> before the controller is fully initialized (?).
>>
>> Maybe this controller is capable of generating interrupts before it's running?
> 
> Mathias and Kishon:
> 
> Note that this issue has also been reported in Bugzilla:
> 
> 	https://bugzilla.kernel.org/show_bug.cgi?id=214021
> 

Thanks, 

I'll follow up on that one.

-Mathias
