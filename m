Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2A36695D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhDUKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:41:13 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:36818 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230259AbhDUKlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:41:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UWI2uRW_1619001634;
Received: from 30.0.161.206(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UWI2uRW_1619001634)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Apr 2021 18:40:35 +0800
Subject: Re: [PATCH] xhci: remove unused variable
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1617272235-62515-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <YGWj9KKtEd+sAdtH@kroah.com>
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Message-ID: <1bf6144c-9385-d7ff-a30c-f0bb17f9c2e6@linux.alibaba.com>
Date:   Wed, 21 Apr 2021 18:39:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YGWj9KKtEd+sAdtH@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/1 18:44, Greg KH wrote:
> On Thu, Apr 01, 2021 at 06:17:15PM +0800, Jiapeng Chong wrote:
>> Fix the following clang warning:
>>
>> drivers/usb/host/xhci.c:1346:15: warning: variable ‘len’ set but not
>> used [-Wunused-but-set-variable].
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>> ---
>>   drivers/usb/host/xhci.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index 1975016..0ead09c 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -1343,7 +1343,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
>>   
>>   static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>>   {
>> -	unsigned int len;
>>   	unsigned int buf_len;
>>   	enum dma_data_direction dir;
>>   
>> @@ -1359,10 +1358,9 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>>   				 dir);
>>   
>>   	if (usb_urb_dir_in(urb))
>> -		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
>> -					   urb->transfer_buffer,
>> -					   buf_len,
>> -					   0);
>> +		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
>> +				     urb->transfer_buffer,
>> +				     buf_len, 0);
>>   
>>   	urb->transfer_flags &= ~URB_DMA_MAP_SINGLE;
>>   	kfree(urb->transfer_buffer);
>> -- 
>> 1.8.3.1
>>
> 
> Why resubmit this same change when I rejected it in the past?
> 
> {sigh}
> 
> greg k-h
> 

Thanks for reminding us. We'll pay more attention next time.

