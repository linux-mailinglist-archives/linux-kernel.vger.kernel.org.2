Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381F732FE49
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 02:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCGBPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 20:15:38 -0500
Received: from m12-16.163.com ([220.181.12.16]:52614 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhCGBPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 20:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=0PQOv
        2/hQx64gECYG05guj9Z2VJN6/F73EZBhLsxdYQ=; b=ma60aVLE7woVTmjlokm8V
        Usq2vijoW7yYkjAqyPaVvyNRHsoZ0wUuhaGyOto2SAV40b2sK66yfCIfCWBB5OuX
        vyg8pMrYBLbefbixCHhkirzvPuoCDrgslsmzbyhgJjbd1LT4wj2fj/msHWiDfaoU
        8yYYCmGr0n2EWtvkJGFETE=
Received: from [192.168.31.187] (unknown [36.170.36.204])
        by smtp12 (Coremail) with SMTP id EMCowAAnKk7yKERgk+T+fA--.43990S2;
        Sun, 07 Mar 2021 09:14:27 +0800 (CST)
Subject: Re: [PATCH] xhci: Remove unused value len from xhci_unmap_temp_buf
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Kun <zhangkun@cdjrlc.com>
References: <20210306120644.74406-1-zhangkun4jr@163.com>
 <YEOs5w8AYutM27/u@kroah.com>
From:   Zhangkun <zhangkun4jr@163.com>
Message-ID: <3ad81fd6-e88e-f55b-fe82-ac7804bc354c@163.com>
Date:   Sun, 7 Mar 2021 09:14:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEOs5w8AYutM27/u@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EMCowAAnKk7yKERgk+T+fA--.43990S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr48KFWUKryruFy3GF18AFb_yoW8Wr47pF
        s8Ka1YkFs5trZFkasrZanavFyrta1xJrykKrWIya45XFZxCFnIqF97WFyfKrnxWr4fGr1I
        vF4UXayrWw1Dua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bc4EiUUUUU=
X-Originating-IP: [36.170.36.204]
X-CM-SenderInfo: x2kd0whnxqkyru6rljoofrz/1tbirAVOtVr7sfJfFgAAs5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/21 12:25 AM, Greg Kroah-Hartman wrote:
> On Sat, Mar 06, 2021 at 08:06:44PM +0800, zhangkun4jr@163.com wrote:
>> From: Zhang Kun <zhangkun@cdjrlc.com>
>>
>> The value assigned to len by sg_pcopy_from_buffer() never used for
>> anything, so remove it.
>>
>> Signed-off-by: Zhang Kun <zhangkun@cdjrlc.com>
>> ---
>>  drivers/usb/host/xhci.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index bd27bd670104..6ebda89d476c 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -1335,7 +1335,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
>>  
>>  static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>>  {
>> -	unsigned int len;
>>  	unsigned int buf_len;
>>  	enum dma_data_direction dir;
>>  
>> @@ -1351,7 +1350,7 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
>>  				 dir);
>>  
>>  	if (usb_urb_dir_in(urb))
>> -		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
>> +		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
>>  					   urb->transfer_buffer,
>>  					   buf_len,
>>  					   0);
> 
> SHouldn't this be checked instead of ignored?
>

Hi, Greg.
Considering your tips I checked sg_pcopy_from_buffer(). it copys data
from urb->transfer_buffer to urb->sg, and only returns 0 or the 
'number of copied bytes', and seems to has no other exception branchs
that need to be checked. So I think it should be ingnored.

It may also be that I missed something, if that's the case, please
correct me.

Thanks,

Zhang

