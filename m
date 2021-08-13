Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75493EB68B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbhHMOJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:09:22 -0400
Received: from foss.arm.com ([217.140.110.172]:53946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235317AbhHMOJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:09:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1E261042;
        Fri, 13 Aug 2021 07:08:54 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA8AF3F718;
        Fri, 13 Aug 2021 07:08:53 -0700 (PDT)
Subject: Re: [PATCH v6] arm pl011 serial: support multi-irq request
To:     Greg KH <gregkh@linuxfoundation.org>, Bing Fan <hptsfb@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <quic_qiancai@quicinc.com>
References: <1628825490-18937-1-git-send-email-hptsfb@gmail.com>
 <YRYc9nCcpGOs4SaJ@kroah.com> <9c3a4336-b6c4-d96e-9a9d-8001dddcee20@gmail.com>
 <YRYqq5Cgqy3975e1@kroah.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f3d4ba49-0cf8-9e92-77c1-ea8964b4e6b9@arm.com>
Date:   Fri, 13 Aug 2021 15:08:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YRYqq5Cgqy3975e1@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2021-08-13 09:17, Greg KH wrote:
> On Fri, Aug 13, 2021 at 03:56:01PM +0800, Bing Fan wrote:
>>
>> 在 8/13/2021 15:19, Greg KH 写道:
>>> On Fri, Aug 13, 2021 at 11:31:30AM +0800, Bing Fan wrote:
>>>> From: Bing Fan <tombinfan@tencent.com>
>>>>
>>>> In order to make pl011 work better, multiple interrupts are
>>>> required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
>>>> at the same time, pl011 to GIC does not merge the interrupt
>>>> lines(each serial-interrupt corresponding to different GIC hardware
>>>> interrupt), so need to enable and request multiple gic interrupt
>>>> numbers in the driver.
>>>>
>>>> Signed-off-by: Bing Fan <tombinfan@tencent.com>
>>>> ---
>>>>    drivers/tty/serial/amba-pl011.c | 39 +++++++++++++++++++++++++++++++--
>>>>    1 file changed, 37 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>>>> index e14f3378b8a0..eaac3431459c 100644
>>>> --- a/drivers/tty/serial/amba-pl011.c
>>>> +++ b/drivers/tty/serial/amba-pl011.c
>>>> @@ -1701,6 +1701,41 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>>>>    	}
>>>>    }
>>>> +static void pl011_release_multi_irqs(struct uart_amba_port *uap, unsigned int max_cnt)
>>>> +{
>>>> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < max_cnt; i++)
>>>> +		if (amba_dev->irq[i])
>>>> +			free_irq(amba_dev->irq[i], uap);
>>>> +}
>>>> +
>>>> +static int pl011_allocate_multi_irqs(struct uart_amba_port *uap)
>>>> +{
>>>> +	int ret = 0;
>>>> +	int i;
>>>> +	unsigned int virq;
>>>> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
>>>> +
>>>> +	pl011_write(uap->im, uap, REG_IMSC);
>>>> +
>>>> +	for (i = 0; i < AMBA_NR_IRQS; i++) {
>>>> +		virq = amba_dev->irq[i];
>>>> +		if (virq == 0)
>>>> +			break;
>>>> +
>>>> +		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);
>>>> +		if (ret) {
>>>> +			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
>>>> +			pl011_release_multi_irqs(uap, i - 1);
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>> This function looks identical to pl011_allocate_irq(), so what is the
>>> difference here?  Why is this still needed at all?  What does it do that
>>> is different from pl011_allocate_irq()?
>>
>> The v6-patch is based on master of
>> git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git, not tty-next.
> 
> Always submit patches based on tty-next if you want them accepted into
> that tree.
> 
>> As below, the pl011_allocate_irq function supports single irq request only,
>> which different from pl011_allocate_multi_irqs.
>>
>> static int pl011_allocate_irq(struct uart_amba_port *uap)
>> {
>>      pl011_write(uap->im, uap, REG_IMSC);
>>
>>      return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011",
>> uap);
>> }
> 
> Ok, but that does not reflect what is in my tree to be merged for
> 5.15-rc1.  What is wrong with the code in there that is incorrect and
> needs to be changed?

As reported by Qian Cai, it blows up on ACPI-based systems by assuming 
port.dev is an amba_device when in fact in that situation it's a 
platform_device. If you're able to drop the current patch from your tree 
that would probably be the best thing to do for the moment.

Cheers,
Robin.
