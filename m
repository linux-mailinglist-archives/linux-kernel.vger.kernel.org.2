Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE7F446938
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhKETmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:42:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:61164 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhKETml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:42:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="231814694"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="231814694"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 12:40:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="639910310"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2021 12:39:58 -0700
Subject: Re: [PATCH] xhci: Fix USB 3.1 enumeration issues by increasing
 roothub power-on-good delay
To:     "Walt Jr. Brake" <mr.yming81@gmail.com>
Cc:     chunfeng.yun@mediatek.com, matthias.bgg@gmail.com,
        nishadkamdar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, eddie.hung@mediatek.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20211105133050.GA1590803@rowland.harvard.edu>
 <20211105160036.549516-1-mathias.nyman@linux.intel.com>
 <96925c96-0f87-f110-e279-5b669337948a@linux.intel.com>
 <8301c7f7-4c63-5681-af53-9edc67d96d17@gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <5fc1dc0b-6fd0-2162-4e1d-9420ecabc337@linux.intel.com>
Date:   Fri, 5 Nov 2021 21:41:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8301c7f7-4c63-5681-af53-9edc67d96d17@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.11.2021 19.32, Walt Jr. Brake wrote:
> On 6/11/2021 00:09, Mathias Nyman wrote:
>> On 5.11.2021 18.00, Mathias Nyman wrote:
>>> Some USB 3.1 enumeration issues were reported after the hub driver removed
>>> the minimum 100ms limit for the power-on-good delay.
>>>
>>> Since commit 90d28fb53d4a ("usb: core: reduce power-on-good delay time of
>>> root hub") the hub driver sets the power-on-delay based on the
>>> bPwrOn2PwrGood value in the hub descriptor.
>>>
>>> xhci driver has a 20ms bPwrOn2PwrGood value for both roothubs based
>>> on xhci spec section 5.4.8, but it's clearly not enough for the
>>> USB 3.1 devices, causing enumeration issues.
>>>
>>> Tests indicate full 100ms delay is needed.
>>>
>>> Reported-by: Walt Jr. Brake <mr.yming81@gmail.com>
>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>
>> Walt Jr Brake, just to be sure could you test this one as well?
>>
>> As Alan suggested this sets 100ms for the USB 3 roothub but
>> keeps the 20ms for the USB 2 roothub.
>>
>> Thanks
>> -Mathias
> 
> Yes I tested, it works too.
> 

Thank you
-Mathias
