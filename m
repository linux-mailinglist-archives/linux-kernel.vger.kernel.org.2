Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2413F87DC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242201AbhHZMqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:46:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:32383 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233687AbhHZMqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:46:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="217767734"
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="217767734"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 05:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="474190879"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2021 05:45:24 -0700
Subject: Re: [PATCH v2 2/3] usb: core: hcd: Add support for deferring roothub
 registration
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com, lokeshvutla@ti.com
References: <20210826111426.751-1-kishon@ti.com>
 <20210826111426.751-3-kishon@ti.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <1c49d091-cb9d-6c5c-eb34-5a5bc7b8c25e@linux.intel.com>
Date:   Thu, 26 Aug 2021 15:47:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210826111426.751-3-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.8.2021 14.14, Kishon Vijay Abraham I wrote:
> It has been observed with certain PCIe USB cards (like Inateck connected
> to AM64 EVM or J7200 EVM) that as soon as the primary roothub is
> registered, port status change is handled even before xHC is running
> leading to cold plug USB devices not detected. For such cases, registering
> both the root hubs along with the second HCD is required. Add support for
> deferring roothub registration in usb_add_hcd(), so that both primary and
> secondary roothubs are registered along with the second HCD.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Tested-by: Chris Chiu <chris.chiu@canonical.com>

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
