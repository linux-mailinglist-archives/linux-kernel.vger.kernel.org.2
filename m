Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2744EACC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhKLPtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:49:11 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:22205 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhKLPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636731794;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0vT5kgb0MxcXDun4eKJ2zIKVmzNu0ETScGXN431MoQg=;
    b=KG2yFgQB9AY8gFUA3EkbHsJKxLdhqF6PVc8WcvRNRJ7Xa2ol26hagSCuese0d04mRU
    dZhIzGobWxRBbaes5VAM2zCGuYzVoRWHs9UrT6HvJlikcngdosrnpCguMNuBJHvsMO4z
    KqUZHPhxgRU66GoGe/W7toN15ebpZ0+HAJuzcOtyXNPN2voblnPxad+2O2vuNTHLuOyT
    ofUaydeT2bL1zVKdezdeGkMpIW8XtwjrOk7FHHpe9PmHXuc51t20xL+Q4SnzAIam6iGz
    8Wu6Dwp2Z1e/FTHKjLXNlEVi0FjPqx2+x/iRxfEOlKOWFr2Y1TilLQIlbdE7yismTICp
    X3Zg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhWL7n8tmuiQcLNMDVOHy3jXR+anA=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a02:8109:89c0:ebfc:5949:d784:5886:5d22]
    by smtp.strato.de (RZmta 47.34.5 AUTH)
    with ESMTPSA id N03801xACFhDU6S
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 12 Nov 2021 16:43:13 +0100 (CET)
Message-ID: <aae33774-a09b-9585-abc7-57cfee5c84af@xenosoft.de>
Date:   Fri, 12 Nov 2021 16:43:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] of/irq: Don't ignore interrupt-controller when
 interrupt-map failed
Content-Language: de-DE
To:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Matthew Leaman <matthew@a-eon.biz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>
References: <20211112150415.GA1401861@bhelgaas>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20211112150415.GA1401861@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 November 2021 at 04:04 pm, Bjorn Helgaas wrote:
> On Fri, Nov 12, 2021 at 02:36:44PM +0000, Marc Zyngier wrote:
>> Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
>> to an interrupt controller"), the irq code favors using an interrupt-map
>> over a interrupt-controller property if both are available, while the
>> earlier behaviour was to ignore the interrupt-map altogether.
>>
>> However, we now end-up with the opposite behaviour, which is to
>> ignore the interrupt-controller property even if the interrupt-map
>> fails to match its input. This new behaviour breaks the AmigaOne
>> X1000 machine, which ships with an extremely "creative" (read:
>> broken) device tree.
>>
>> Fix this by allowing the interrupt-controller property to be selected
>> when interrupt-map fails to match anything.
>>
>> Fixes: 041284181226 ("of/irq: Allow matching of an interrupt-map local to an interrupt controller")
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Link: https://lore.kernel.org/r/78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> I'm not qualified to review this, but since 041284181226 was merged
> via my tree along with the rest of the Apple stuff, let me know if
> you'd like me to merge this.
>
> I see Rob has a comment, so if you want to take care merging it
> yourself, that's certainly fine with me.
>
>> ---
>>   drivers/of/irq.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>> index 32be5a03951f..508fb1717de3 100644
>> --- a/drivers/of/irq.c
>> +++ b/drivers/of/irq.c
>> @@ -161,9 +161,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>>   		 * if it is then we are done, unless there is an
>>   		 * interrupt-map which takes precedence.
>>   		 */
>> +		bool intc = of_property_read_bool(ipar, "interrupt-controller");
>> +
>>   		imap = of_get_property(ipar, "interrupt-map", &imaplen);
>> -		if (imap == NULL &&
>> -		    of_property_read_bool(ipar, "interrupt-controller")) {
>> +		if (imap == NULL && intc) {
>>   			pr_debug(" -> got it !\n");
>>   			return 0;
>>   		}
>> @@ -244,8 +245,14 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>>   
>>   			pr_debug(" -> imaplen=%d\n", imaplen);
>>   		}
>> -		if (!match)
>> +		if (!match) {
>> +			if (intc) {
>> +				pr_debug("%pOF interrupt-map failed, using interrupt-controller\n", ipar);
>> +				return 0;
>> +			}
>> +
>>   			goto fail;
>> +		}
>>   
>>   		/*
>>   		 * Successfully parsed an interrrupt-map translation; copy new
>> -- 
>> 2.30.2
>>
Could you please merge it asap for the RC1? Then we can compile the RC1 
without these patches.

Thanks to all for your help and sorry for bother you with all these 
mails. I do this work alongside my main job and actually I don't have 
time for bisecting.

-- Christian
