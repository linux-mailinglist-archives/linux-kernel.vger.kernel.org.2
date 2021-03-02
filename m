Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BCE32A487
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383220AbhCBKvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:51:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41702 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1379949AbhCBKWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:22:05 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122AHmce015298;
        Tue, 2 Mar 2021 11:20:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=AHNRA07W/8XeOi1fcP+UwN+hE9l5HeWlAvjNP7Od2XQ=;
 b=K44Nf8dxpJTK46y0qHK1yIq2djKmoAPatyObmNxYQPiIHtUDRntpEEGxwmjemolYJOln
 TwbbG4a5qd9k9WdP1v6bqkilm8txSV4YWh2FMjdeyLo0GsgGF4KSKVWDkXaI3jzl75y+
 x84hXPiJBBmoociIaR/6Cv4F1QVmeyaMRocSFDuzJ7i0ljHCHU0VoSRtZyMIprqvkHEP
 Gsq7KBRJwOD0nOLLa0NZI6Q1MTY1hjGfS1xcN/CMXD4DTnGW0mdvpZNxSbwWD3l50Yfj
 r6gBbq9PjvdEQl60wr1Shi3WdX2iPAmaoNBZQ8kSJnLQpKWrnkDlvCnxz13uddjcsCbQ 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36yf9q1dun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 11:20:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 93F86100034;
        Tue,  2 Mar 2021 11:20:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 717022C38D2;
        Tue,  2 Mar 2021 11:20:09 +0100 (CET)
Received: from [10.211.13.170] (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Mar
 2021 11:20:08 +0100
Subject: Re: [PATCH v2 1/2] tty/serial: Add rx-tx-swap OF option to
 stm32-usart
To:     Martin DEVERA <devik@eaxlabs.cz>, <linux-kernel@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-serial@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Le Ray <erwan.leray@st.com>
References: <CAL_JsqK8+M=Vg0PiDXP2f1LrEp4hSVea6piAASMGu1H=pxme6Q@mail.gmail.com>
 <20210227164157.30971-1-devik@eaxlabs.cz>
 <439a0d7a-cc0e-764b-7ed8-668b5a85f4a7@foss.st.com>
 <fbdce86c-a17f-7626-51e4-9e48ea25001e@eaxlabs.cz>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <019b62e9-ec9b-d366-ee77-59c980d66a07@foss.st.com>
Date:   Tue, 2 Mar 2021 11:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fbdce86c-a17f-7626-51e4-9e48ea25001e@eaxlabs.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_03:2021-03-01,2021-03-02 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 11:40 PM, Martin DEVERA wrote:
> On 3/1/21 11:28 AM, Fabrice Gasnier wrote:
>> On 2/27/21 5:41 PM, Martin Devera wrote:
>>> STM32 F7/H7 usarts supports RX & TX pin swapping.
>>> Add option to turn it on.
>>> Tested on STM32MP157.
>>>
>>> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
>>> ---
>>>   drivers/tty/serial/stm32-usart.c | 3 ++-
>>>   drivers/tty/serial/stm32-usart.h | 1 +
>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/stm32-usart.c
>>> b/drivers/tty/serial/stm32-usart.c
>>> index b3675cf25a69..3650c8798061 100644
>>> --- a/drivers/tty/serial/stm32-usart.c
>>> +++ b/drivers/tty/serial/stm32-usart.c
>>> @@ -758,7 +758,7 @@ static void stm32_usart_set_termios(struct
>>> uart_port *port,
>>>       cr1 = USART_CR1_TE | USART_CR1_RE;
>>>       if (stm32_port->fifoen)
>>>           cr1 |= USART_CR1_FIFOEN;
>>> -    cr2 = 0;
>>> +    cr2 = stm32_port->swap ? USART_CR2_SWAP : 0;
>> Hi Martin,
>>
>> Same could be done in the startup routine, that enables the port for
>> reception (as described in Documentation/driver-api/serial/driver.rst)
> Hello Fabrice,
> 
> I already incorporated all your comments but I'm struggling with the one
> above.
> The code must be in stm32_usart_set_termios too, because CR2 is modified.

Hi Martin,

Yes, sure,

> What is the reason to have it in startup() ?

RX is enabled at both places. So the swap setting should be there too.

> Is it because USART can be started without calling set_termios at all ?

Yes, that's what the driver API expects: "startup(port)" ... "Enable the
port for reception."

Best Regards,
Fabrice

> Like
> to reuse bootloader's last settings ?
> 
> Thanks, Martin
> 
