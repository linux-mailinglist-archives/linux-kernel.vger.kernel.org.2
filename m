Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36419457701
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 20:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhKSTbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 14:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhKSTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 14:31:02 -0500
X-Greylist: delayed 1102 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Nov 2021 11:28:00 PST
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD2AC061574;
        Fri, 19 Nov 2021 11:27:59 -0800 (PST)
Received: from p54bc6060.dip0.t-ipconnect.de ([84.188.96.96] helo=[192.168.1.169]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mo9GQ-0002Bb-I1; Fri, 19 Nov 2021 20:09:34 +0100
Subject: Re: realtek,rtl-intc IRQ mapping broken on 5.16-rc1
To:     Marc Zyngier <maz@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
References: <bbe5506a2458b2d6049bd22a5fda77ae6175ddec.camel@svanheule.net>
 <87ilwp6zm6.wl-maz@kernel.org>
 <fdfe6615a0ec0d4a770b04a437922956e8586078.camel@svanheule.net>
 <877dd46w2b.wl-maz@kernel.org>
From:   Birger Koblitz <mail@birger-koblitz.de>
Message-ID: <da4965eb-715f-ad50-7281-00b28dd64a66@birger-koblitz.de>
Date:   Fri, 19 Nov 2021 20:09:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <877dd46w2b.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1637350080;b84fad9f;
X-HE-SMSGID: 1mo9GQ-0002Bb-I1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would vote for (2), the somewhat dirty fix, at least for now.
We are working on an updated version of this driver for newer Realtek
SoCs (RTL839x, RTL930x), which support VSMP and where there are
multiple instances of this controller to support per-cpu IRQs.
However, this is not ready for prime-time yet. But at that
time we would also fix the IRQ map.

Cheers,
   Birger

On 19/11/2021 15:48, Marc Zyngier wrote:
> On Thu, 18 Nov 2021 19:45:26 +0000,
> Sander Vanheule <sander@svanheule.net> wrote:
>>
>> Hi Marc,
>>
>> On Thu, 2021-11-18 at 19:19 +0000, Marc Zyngier wrote:
>>> Hi Sander,
>>>
>>> On Thu, 18 Nov 2021 15:56:06 +0000,
>>> Sander Vanheule <sander@svanheule.net> wrote:
>>>>
>>>> Hi everyone,
>>>>
>>>> On 5.16-rc1, the realtek,rtl-intc interrupt controller driver for
>>>> Realtek RTL8380 SoCs (and related) appears broken. When booting, I
>>>> don't get a tty on the serial port, although serial output works.
>>>
>>> Thanks for the heads up.
>>>
>>>> The watchdog (currently under review) also cannot acquire the
>>>> required phase1 interrupt, and produces the following output:
>>>
>>>> [    1.968228] realtek-otto-watchdog 18003150.watchdog: error -EINVAL: Failed to get
>>>> IRQ 4
>>>> for phase1
>>>> [    1.978404] realtek-otto-watchdog: probe of 18003150.watchdog failed with error -22
>>>>
>>>> A bisects points to commit 041284181226 ("of/irq: Allow matching of
>>>> an interrupt-map local to an interrupt controller"). Reverting this
>>>> above commit and follow-up commit 10a20b34d735 ("of/irq: Don't
>>>> ignore interrupt-controller when interrupt-map failed") restores the
>>>> functionality from v5.15.
>>>
>>> OK, back to square one, we need to debug this one.
>>>
>>> [...]
>>>
>>>>          cpuintc: cpuintc {
>>>>                  compatible = "mti,cpu-interrupt-controller";
>>>>                  #address-cells = <0>;
>>>>                  #interrupt-cells = <1>;
>>>>                  interrupt-controller;
>>>>          };
>>>>
>>>
>>> [...]
>>>
>>>>
>>>>                  intc: interrupt-controller@3000 {
>>>>                          compatible = "realtek,rtl-intc";
>>>>                          reg = <0x3000 0x20>;
>>>>                          interrupt-controller;
>>>>                          #interrupt-cells = <1>;
>>>>
>>>>                          #address-cells = <0>;
>>>>                          interrupt-map =
>>>>                                  <31 &cpuintc 2>, /* UART0 */
>>>>                                  <20 &cpuintc 3>, /* SWCORE */
>>>>                                  <19 &cpuintc 4>, /* WDT IP1 */
>>>>                                  <18 &cpuintc 5>; /* WDT IP2 */
>>>>                  };
>>>
>>> Something looks pretty odd. With 5.15, this interrupt-map would be
>>> completely ignored. With 5.16-rc1, we should actually honour it.
>>>
>>> /me digs...
>>>
>>> Gah, I see. This driver has its own interrupt-map parser and invents
>>> something out of thin air. I will bang my own head on the wall for
>>> having merged this horror.
>>>
>>> Can you try applying the patch below and rename the interrupt-map
>>> property in your DT to "silly-interrupt-map" and let me know if that
>>> helps?
>>
>> I've dropped the aforementioned reverts, and applied your suggested
>> changes to the DTS and irq-realtek-rtl. Interrupts now appear to
>> work like before; UART console and watchdog work as expected.
> 
> Right. So here's the problem: what this interrupt-map property means
> is "an interrupt descriptor with value 31 really is interrupt 2 on
> cpuintc, and nothing else matters(tm)". Up to 5.15, the kernel would
> simply ignore such directive. It now honours it.
> 
> There are only three solution to this:
> 
> (1) we change the DT and the driver so that it actually describes the
> HW rather than some crazy interpretation. This means breaking backward
> compatibility with older kernels on new DT, as well as new kernels on
> old DTs.
> 
> (2) we add a quirk to the core DT parsing code to ignore an
> interrupt-map property placed in a "realtek,rtl-intc" node.
> 
> (3) we revert the change and break the Apple M1.
> 
> I'm obviously not keen on (3). I can (sort of) deal with (2), but I'd
> rather do (1) because what currently is in the DT doesn't describe the
> HW in any shape or form.
> 
> Rob, what do you think?
> 
> 	M.
> 
