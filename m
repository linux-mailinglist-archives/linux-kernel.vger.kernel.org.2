Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6564F3683F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbhDVPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:43:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39280 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbhDVPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:42:46 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619106130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlPW80ZD1S7l4GGiUYfpnDcgBS6YV2GnyPaBBzf4Ybs=;
        b=opKPnWROLG6bMR0stYFDgk1fQftfqthvrIubpCxW1tflDjDIF32LMsSFgV7tovinvT/NJF
        f7ZVijRxQe0ZBXiKV71gNku+yPsYWIRgxo0tjja8WXWXTUT6Sohi4lfV51r++AFCDwIUcl
        Jckns4q99s4cEy7UQe44wVezAVINPdzUYV02OFTlzMWiGSySo5XPjqu1SX8bCu+BvdCGtW
        tfMYpouZBk92OTW3N43EDnSrIhX7VWDkWcgP+h4WJ8HDFMqolfOV8PDZNLW5OqXI9hK8fa
        K4RfyxSeDtoZ5RyNIXnSvdNnh7b750nXRTTajP8WAPKk/d6lw1+BqGTmXTa1AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619106130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlPW80ZD1S7l4GGiUYfpnDcgBS6YV2GnyPaBBzf4Ybs=;
        b=CW1w9NeP1jjagLZEkywhcLwJIY0u65aqwTTznQvS39q80LuLIeafCZxxWK+4CG3MyEbCz3
        6BX/k6uH9mHsxwDw==
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [IRQ] IRQ affinity not working properly?
In-Reply-To: <fdebec53-097a-d28f-96ec-cfe8d7ef8412@redhat.com>
References: <a0d5551e-761b-1571-b8e1-5586ec4d9f3b@windriver.com> <87blb3ce29.ffs@nanos.tec.linutronix.de> <fdebec53-097a-d28f-96ec-cfe8d7ef8412@redhat.com>
Date:   Thu, 22 Apr 2021 17:42:10 +0200
Message-ID: <87bla6xr59.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21 2021 at 09:31, Nitesh Narayan Lal wrote:
> On 3/28/21 2:45 PM, Thomas Gleixner wrote:
>> On Fri, Jan 29 2021 at 13:17, Chris Friesen wrote:
>>> I have a CentOS 7 linux system with 48 logical CPUs and a number of
>
> <snip>
>
>>> IR-PCI-MSI-edge      iavf-net1-TxRx-3
>>> 961:          0          0          0          0 28492         0 
>>> IR-PCI-MSI-edge iavf-0000:b5:02.7:mbx
>>> 962:          0          0          0          0 435608         0 
>>> IR-PCI-MSI-edge      iavf-net1-TxRx-0
>>> 963:          0          0          0          0 394832         0 
>>> IR-PCI-MSI-edge      iavf-net1-TxRx-1
>>> 964:          0          0          0          0 398414         0 
>>> IR-PCI-MSI-edge      iavf-net1-TxRx-2
>>> 965:          0          0          0          0 192847         0 
>>> IR-PCI-MSI-edge      iavf-net1-TxRx-3
>>>
>>> There were IRQs coming in on the "iavf-0000:b5:02.7:mbx" interrupt at 
>>> roughly 1 per second without any traffic, while the interrupt rate on 
>>> the "iavf-net1-TxRx-<X>" seemed to be related to traffic.
>>>
>>> Is this expected?  It seems like the IRQ subsystem is not respecting the 
>>> configured SMP affinity for the interrupt in question.  I've also seen 
>>> the same behaviour with igb interrupts.
>> No it's not expected. Do you see the same behaviour with a recent
>> mainline kernel, i.e. 5.10 or 5.11?
>>
>>
> Jesse pointed me to this thread and apologies that it took a while for me
> to respond here.
>
> I agree it will be interesting to see with which kernel version Chris is
> reproducing the issue.

And the output of

 /proc/irq/$NUMBER/smp_affinity_list
 /proc/irq/$NUMBER/effective_affinity_list

> Initially, I thought that this issue is the same as the one that we have
> been discussing in another thread [1].
>
> However, in that case, the smp affinity mask itself is incorrect and doesn't
> follow the default smp affinity mask (with irqbalance disabled).

That's the question...

Thanks,

        tglx
