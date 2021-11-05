Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAFB44695A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhKET6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:58:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:8884 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232926AbhKET6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:58:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="212714977"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="212714977"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 12:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="639913030"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2021 12:55:33 -0700
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, mr.yming81@gmail.com,
        chunfeng.yun@mediatek.com, matthias.bgg@gmail.com,
        nishadkamdar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, eddie.hung@mediatek.com
References: <20211105133050.GA1590803@rowland.harvard.edu>
 <20211105160036.549516-1-mathias.nyman@linux.intel.com>
 <YYVYrksU5/aCB3Fd@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: Fix USB 3.1 enumeration issues by increasing
 roothub power-on-good delay
Message-ID: <b5b59fb7-40ce-929e-479a-d0605994cb53@linux.intel.com>
Date:   Fri, 5 Nov 2021 21:56:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YYVYrksU5/aCB3Fd@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.11.2021 18.15, Greg KH wrote:
> On Fri, Nov 05, 2021 at 06:00:36PM +0200, Mathias Nyman wrote:
>> Some USB 3.1 enumeration issues were reported after the hub driver removed
>> the minimum 100ms limit for the power-on-good delay.
>>
>> Since commit 90d28fb53d4a ("usb: core: reduce power-on-good delay time of
>> root hub") the hub driver sets the power-on-delay based on the
>> bPwrOn2PwrGood value in the hub descriptor.
>>
>> xhci driver has a 20ms bPwrOn2PwrGood value for both roothubs based
>> on xhci spec section 5.4.8, but it's clearly not enough for the
>> USB 3.1 devices, causing enumeration issues.
>>
>> Tests indicate full 100ms delay is needed.
>>
>> Reported-by: Walt Jr. Brake <mr.yming81@gmail.com>
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> So this needs:
> 	Fixes: 90d28fb53d4a ("usb: core: reduce power-on-good delay time of root hub")
> right?

I guess so, not sure on "Fixes" policy here.

This patch fixes an xhci issue revealed by ("usb: core: reduce power-on-good delay time of root hub")
That original patch itself looks correct, but these two patches should really go together to
avoid any enumeration issues.  

Thanks
-Mathias
