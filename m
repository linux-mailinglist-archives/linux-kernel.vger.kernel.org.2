Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E324045AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352634AbhIIGgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:36:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35748 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbhIIGgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:36:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1896ZXkt054558;
        Thu, 9 Sep 2021 01:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631169333;
        bh=4s7HGcdGS0K/ERh3FxmOpmro+p6ktKpCtpb6ApiFdwc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=g842Wuf/+xYGujU3LKrZ+xN5LklgpNbwLTmmIl1rKpRAFyUO8WATb5ALKlsafijlG
         L/g248vbGCvoNMmpe/mTWdJhV/BYT4aCSXuthoCedIqI1yIoni0G//Y4OYH/sTL2UT
         gijCv/yZo0u1EoL9mDdZKVxC1uqatOuI7iSDgnY4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1896ZX5F120167
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Sep 2021 01:35:33 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 9
 Sep 2021 01:35:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 9 Sep 2021 01:35:33 -0500
Received: from [10.250.233.194] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1896ZTdN062694;
        Thu, 9 Sep 2021 01:35:30 -0500
Subject: Re: [PATCH v3 1/3] usb: core: hcd: Add support for deferring roothub
 registration
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, <lokeshvutla@ti.com>
References: <20210908095312.985-1-kishon@ti.com>
 <20210908095312.985-2-kishon@ti.com>
 <20210908145146.GB603644@rowland.harvard.edu>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f690d3a1-9b7e-9c82-d3aa-09e249fbd69d@ti.com>
Date:   Thu, 9 Sep 2021 12:05:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908145146.GB603644@rowland.harvard.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 08/09/21 8:21 pm, Alan Stern wrote:
> On Wed, Sep 08, 2021 at 03:23:10PM +0530, Kishon Vijay Abraham I wrote:
>> It has been observed with certain PCIe USB cards (like Inateck connected
>> to AM64 EVM or J7200 EVM) that as soon as the primary roothub is
>> registered, port status change is handled even before xHC is running
>> leading to cold plug USB devices not detected. For such cases, registering
>> both the root hubs along with the second HCD is required. Add support for
>> deferring roothub registration in usb_add_hcd(), so that both primary and
>> secondary roothubs are registered along with the second HCD.
>>
>> CC: stable@vger.kernel.org # 5.4+
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> Tested-by: Chris Chiu <chris.chiu@canonical.com>
>> ---
>>  drivers/usb/core/hcd.c  | 30 ++++++++++++++++++++++++------
>>  include/linux/usb/hcd.h |  2 ++
>>  2 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index 0f8b7c93310e..30bbf4ac4284 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -2775,6 +2775,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>>  {
>>  	int retval;
>>  	struct usb_device *rhdev;
>> +	struct usb_hcd *shared_hcd;
>>  
>>  	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
>>  		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
>> @@ -2935,13 +2936,26 @@ int usb_add_hcd(struct usb_hcd *hcd,
>>  		goto err_hcd_driver_start;
>>  	}
>>  
>> +	/* starting here, usbcore will pay attention to the shared HCD roothub */
>> +	shared_hcd = hcd->shared_hcd;
>> +	if (!usb_hcd_is_primary_hcd(hcd) && shared_hcd && HCD_DEFER_RH_REGISTER(shared_hcd)) {
>> +		retval = register_root_hub(shared_hcd);
>> +		if (retval != 0)
>> +			goto err_register_root_hub;
>> +
>> +		if (shared_hcd->uses_new_polling && HCD_POLL_RH(shared_hcd))
>> +			usb_hcd_poll_rh_status(shared_hcd);
>> +	}
>> +
>>  	/* starting here, usbcore will pay attention to this root hub */
>> -	retval = register_root_hub(hcd);
>> -	if (retval != 0)
>> -		goto err_register_root_hub;
>> +	if (!HCD_DEFER_RH_REGISTER(hcd)) {
>> +		retval = register_root_hub(hcd);
>> +		if (retval != 0)
>> +			goto err_register_root_hub;
>>  
>> -	if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
>> -		usb_hcd_poll_rh_status(hcd);
>> +		if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
>> +			usb_hcd_poll_rh_status(hcd);
>> +	}
>>  
>>  	return retval;
>>  
>> @@ -2985,6 +2999,7 @@ EXPORT_SYMBOL_GPL(usb_add_hcd);
>>  void usb_remove_hcd(struct usb_hcd *hcd)
>>  {
>>  	struct usb_device *rhdev = hcd->self.root_hub;
>> +	unsigned rh_registered;
> 
> This really should be a bool, not an unsigned.  (Relatively unimportant.)
> 
>>  	dev_info(hcd->self.controller, "remove, state %x\n", hcd->state);
>>  
>> @@ -2995,6 +3010,8 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>>  
>>  	dev_dbg(hcd->self.controller, "roothub graceful disconnect\n");
>>  	spin_lock_irq (&hcd_root_hub_lock);
>> +	if (hcd->rh_registered == 1)
>> +		rh_registered = 1;
> 
> Just say: rh_registered = hcd->rh_registered
> 
>>  	hcd->rh_registered = 0;
>>  	spin_unlock_irq (&hcd_root_hub_lock);
>>  
>> @@ -3004,7 +3021,8 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>>  	cancel_work_sync(&hcd->died_work);
>>  
>>  	mutex_lock(&usb_bus_idr_lock);
>> -	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
>> +	if (rh_registered == 1)
> 
> Just say: if (rh_registered)
> 
>> +		usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
> 
> Didn't the compiler warn about using a possibly uninitialized variable?

I didn't see any. Possibly the warning levels are not correctly set in my setup.
Will address your comment and send the patch.

Thank You,
Kishon

> 
> The overall logic looks okay, apart from this one point.
> 
> Alan Stern
> 
>>  	mutex_unlock(&usb_bus_idr_lock);
>>  
>>  	/*
>> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
>> index 548a028f2dab..2c1fc9212cf2 100644
>> --- a/include/linux/usb/hcd.h
>> +++ b/include/linux/usb/hcd.h
>> @@ -124,6 +124,7 @@ struct usb_hcd {
>>  #define HCD_FLAG_RH_RUNNING		5	/* root hub is running? */
>>  #define HCD_FLAG_DEAD			6	/* controller has died? */
>>  #define HCD_FLAG_INTF_AUTHORIZED	7	/* authorize interfaces? */
>> +#define HCD_FLAG_DEFER_RH_REGISTER	8	/* Defer roothub registration */
>>  
>>  	/* The flags can be tested using these macros; they are likely to
>>  	 * be slightly faster than test_bit().
>> @@ -134,6 +135,7 @@ struct usb_hcd {
>>  #define HCD_WAKEUP_PENDING(hcd)	((hcd)->flags & (1U << HCD_FLAG_WAKEUP_PENDING))
>>  #define HCD_RH_RUNNING(hcd)	((hcd)->flags & (1U << HCD_FLAG_RH_RUNNING))
>>  #define HCD_DEAD(hcd)		((hcd)->flags & (1U << HCD_FLAG_DEAD))
>> +#define HCD_DEFER_RH_REGISTER(hcd) ((hcd)->flags & (1U << HCD_FLAG_DEFER_RH_REGISTER))
>>  
>>  	/*
>>  	 * Specifies if interfaces are authorized by default
>> -- 
>> 2.17.1
>>
