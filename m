Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F808440840
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhJ3Jfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 05:35:32 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:44048 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhJ3Jfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 05:35:31 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 85CAD20EBD51
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <ec1960ae-1f81-48ae-f153-46e7fd08f3df@omp.ru>
Date:   Sat, 30 Oct 2021 12:32:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/3] Docs: usb: update err() to pr_err() and replace
 __FILE__
Content-Language: en-US
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-usb@vger.kernel.org>
References: <cover.1635533924.git.philipp.g.hortmann@gmail.com>
 <e2f2c5c6995a011494105484849776a856af5bcc.1635533924.git.philipp.g.hortmann@gmail.com>
 <49a766ec-014e-3667-828c-a4fd19c7c9e3@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <49a766ec-014e-3667-828c-a4fd19c7c9e3@omp.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.10.2021 23:33, Sergey Shtylyov wrote:

[...]
>> update err() to pr_err() and replace __FILE__
>>
>> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
>> ---
>>   Documentation/driver-api/usb/writing_usb_driver.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
>> index 2176297e5765..5c29e5bdbe88 100644
>> --- a/Documentation/driver-api/usb/writing_usb_driver.rst
>> +++ b/Documentation/driver-api/usb/writing_usb_driver.rst
>> @@ -91,8 +91,8 @@ usually in the driver's init function, as shown here::
>>   	    /* register this driver with the USB subsystem */
>>   	    result = usb_register(&skel_driver);
>>   	    if (result < 0) {
>> -		    err("usb_register failed for the "__FILE__ "driver."
>> -			"Error number %d", result);
>> +		    pr_err("usb_register failed for the %s driver. "
> 
>     Don't break up the kernel message like this. The current code is a bad example --
> high time to fix it. :-)
> 
>> +			   "Error number %d", skel_driver.name, result);

    Oh, and add `\n' at the end of message.

[...]

MBR, Sergey
