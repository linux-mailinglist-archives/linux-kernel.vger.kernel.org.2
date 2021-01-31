Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0880E309B23
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 09:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhAaISO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 03:18:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43443 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhAaIRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 03:17:14 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1l67rh-0005up-Mh; Sun, 31 Jan 2021 09:13:49 +0100
Subject: Re: [PATCH] tee: optee: remove need_resched() before cond_resched()
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210125095445.1524477-1-jens.wiklander@linaro.org>
 <0100017738faac80-87e5cf40-6a5a-4727-9c36-382fb909c8ff-000000@email.amazonses.com>
 <CAHUa44GsbxO=wJ_o-AZsxNvKOhn=y=dexkrN17zCy=7+0=1ZQg@mail.gmail.com>
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
Message-ID: <42ff3eaa-d561-93ae-b5c4-28b675bdea4f@pengutronix.de>
Date:   Sun, 31 Jan 2021 09:13:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHUa44GsbxO=wJ_o-AZsxNvKOhn=y=dexkrN17zCy=7+0=1ZQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On 29.01.21 14:29, Jens Wiklander wrote:
> Hi Rouven and Sumit,
> 
> On Mon, Jan 25, 2021 at 10:58 AM Jens Wiklander via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
>>
>> Hi Rouven and Sumit,
>>
>> On Mon, Jan 25, 2021 at 10:55 AM Jens Wiklander
>> <jens.wiklander@linaro.org> wrote:
>>>
>>> Testing need_resched() before cond_resched() is not needed as an
>>> equivalent test is done internally in cond_resched(). So drop the
>>> need_resched() test.
>>>
>>> Fixes: dcb3b06d9c34 ("tee: optee: replace might_sleep with cond_resched")
>>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>>> ---
>>>   drivers/tee/optee/call.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> Can you please test to see that this works in your setups too?
> 
> Does this work for you? I'd like to get this patch ready for v5.12.

Yes it does. I also looked at it right after Arnds mail, so for future 
reference:


cond_resched()

   _cond_resched() (ifndef CONFIG_PREEMPTION)

     should_resched(0)

       tif_need_resched() (+ preempt_count == 0 for current thread)



while:



need_resched()

   tif_need_resched()


You can add my
Reviewed-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

I also retested on the STM32-DK2 and the problem remains fixed:

Tested-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Regrads and thanks for the patch,
Rouven
