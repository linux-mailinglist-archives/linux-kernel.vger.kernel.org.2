Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA293F616C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhHXPTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:19:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50138 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhHXPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:19:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17OFInsV091917;
        Tue, 24 Aug 2021 10:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629818329;
        bh=j3XMLlAbv8jvRZRGebZCW9vjlGEE2W/cyFJ8sIZGRKk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NNTbAAtVvFjFdlsUH2wxV6zCZ7DLU2/KJA8zx0Xb9f70bnk0Q9NpMikE++qj0NxkR
         WfNt0Q1iUlJgknt6GNAnJxU1Jb7LLFrVqGBe7F1r9IPrKc7jfJgDtnEiq/x7oJf/1q
         Mat/FVUr5g5BhQGwqmjdC06qt8fvJu0gzBKs+4G0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17OFInxa035318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Aug 2021 10:18:49 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 24
 Aug 2021 10:18:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 24 Aug 2021 10:18:49 -0500
Received: from [10.250.235.193] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17OFIjq0060561;
        Tue, 24 Aug 2021 10:18:46 -0500
Subject: Re: [RFC PATCH 1/5] usb: core: hcd: Modularize HCD stop configuration
 in usb_stop_hcd()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>
References: <20210824105302.25382-1-kishon@ti.com>
 <20210824105302.25382-2-kishon@ti.com> <YSTu5KCQV242XuXV@kroah.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <bb64fbf9-4342-7d36-de4f-0ab719b8f479@ti.com>
Date:   Tue, 24 Aug 2021 20:48:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSTu5KCQV242XuXV@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 24/08/21 6:36 pm, Greg Kroah-Hartman wrote:
> On Tue, Aug 24, 2021 at 04:22:58PM +0530, Kishon Vijay Abraham I wrote:
>> No functional change. Since configuration to stop HCD is invoked from
>> multiple places, group all of them in usb_stop_hcd().
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/usb/core/hcd.c | 42 +++++++++++++++++++++++++-----------------
>>  1 file changed, 25 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index 0f8b7c93310e..c036ba5311b3 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -2760,6 +2760,29 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
>>  	usb_put_dev(rhdev);
>>  }
>>  
>> +/**
>> + * usb_stop_hcd - Halt the HCD
>> + * @hcd: the usb_hcd that has to be halted
>> + *
>> + * Stop the timer and invoke ->stop() callback on the HCD
>> + */
>> +static void usb_stop_hcd(struct usb_hcd *hcd)
>> +{
>> +	if (!hcd)
>> +		return;
> 
> That's impossible to hit, so no need to check for it, right?

Patch 3 of this series adds support for registering roothub of shared
HCD. So after that patch there can be a case where shared_hcd is NULL.
The other option would be to check for non-null value in hcd and then
invoke usb_stop_hcd().

Thanks
Kishon
