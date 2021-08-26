Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0513F87D1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242430AbhHZMoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:44:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:47418 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233687AbhHZMoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:44:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="278745894"
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="278745894"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 05:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="474190370"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2021 05:43:12 -0700
Subject: Re: [PATCH v2 3/3] xhci: Set HCD flag to defer primary roothub
 registration
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com, lokeshvutla@ti.com
References: <20210826111426.751-1-kishon@ti.com>
 <20210826111426.751-4-kishon@ti.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <1632d10f-1bbd-751b-f925-dd7b12a8846f@linux.intel.com>
Date:   Thu, 26 Aug 2021 15:45:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210826111426.751-4-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.8.2021 14.14, Kishon Vijay Abraham I wrote:
> Set "HCD_FLAG_DEFER_RH_REGISTER" to hcd->flags in xhci_run() to defer
> registering primary roothub in usb_add_hcd(). This will make sure both
> primary roothub and secondary roothub will be registered along with the
> second HCD. This is required for cold plugged USB devices to be detected
> in certain PCIe USB cards (like Inateck USB card connected to AM64 EVM
> or J7200 EVM).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Tested-by: Chris Chiu <chris.chiu@canonical.com>
> ---

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>


