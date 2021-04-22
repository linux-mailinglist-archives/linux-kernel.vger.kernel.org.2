Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAEC368108
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhDVNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:02:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35507 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbhDVNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:02:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lZYxc-0000cU-Js; Thu, 22 Apr 2021 13:01:36 +0000
Subject: Re: [PATCH][next] tty: serial: jsm: remove redundant assignments of
 several variables
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210422121115.246625-1-colin.king@canonical.com>
 <YIFxfH4MXc1ekn4f@hovoldconsulting.com>
 <c9497e47-cdfb-7be0-ad35-648ea5d68268@canonical.com>
 <YIFydeoE/WRfPcvA@hovoldconsulting.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <0b9086b4-8da8-c18e-ad22-1f52d6ed0686@canonical.com>
Date:   Thu, 22 Apr 2021 14:01:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIFydeoE/WRfPcvA@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2021 13:56, Johan Hovold wrote:
> On Thu, Apr 22, 2021 at 01:53:03PM +0100, Colin Ian King wrote:
>> On 22/04/2021 13:52, Johan Hovold wrote:
>>> On Thu, Apr 22, 2021 at 01:11:15PM +0100, Colin King wrote:
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> Several variables are being assigned with values that are never
>>>> read and being updated later with a new value. The initializations
>>>> are redundant and can be removed.
>>>>
>>>> Addresses-Coverity: ("Unused value")
>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>> ---
>>>>  drivers/tty/serial/jsm/jsm_cls.c | 6 ++----
>>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
>>>> index b507a2cec926..b58ea4344aaf 100644
>>>> --- a/drivers/tty/serial/jsm/jsm_cls.c
>>>> +++ b/drivers/tty/serial/jsm/jsm_cls.c
>>>> @@ -349,8 +349,8 @@ static void cls_assert_modem_signals(struct jsm_channel *ch)
>>>>  
>>>>  static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
>>>>  {
>>>> -	int qleft = 0;
>>>> -	u8 linestatus = 0;
>>>> +	int qleft;
>>>> +	u8 linestatus;
>>>>  	u8 error_mask = 0;
>>>>  	u16 head;
>>>>  	u16 tail;
>>>> @@ -365,8 +365,6 @@ static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
>>>>  	head = ch->ch_r_head & RQUEUEMASK;
>>>>  	tail = ch->ch_r_tail & RQUEUEMASK;
>>>>  
>>>> -	/* Get our cached LSR */
>>>> -	linestatus = ch->ch_cached_lsr;
>>>>  	ch->ch_cached_lsr = 0;
>>>
>>> Why leave this assignment in? Looks like this was all copy-pasta, but
>>> this assignment makes even less sense now that you remove the comment
>>> and load.
>>
>> Which assignment are you referring to?
> 
> The one just above my comment: 
> 
> 	ch->ch_cached_lsr = 0;

that cached value is being used in jsm_neo.c, so removing the zero'ing
may cause some issues.

> 
> Johan
> 

