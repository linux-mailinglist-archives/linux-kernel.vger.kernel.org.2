Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE4443E7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhKCIhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:37:38 -0400
Received: from mail.loongson.cn ([114.242.206.163]:58904 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230463AbhKCIhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:37:37 -0400
Received: from [10.180.13.153] (unknown [10.180.13.153])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf2ulSYJhOackAA--.58098S2;
        Wed, 03 Nov 2021 16:34:54 +0800 (CST)
Subject: Re: [PATCH v1] usb: xhci: add LPM quirk for ensuring uPD720201 into
 D3 state after S5
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuyinbo@loongson.cn, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1635751025-25906-1-git-send-email-zhuyinbo@loongson.cn>
 <f7cfa6bc-a0f6-aaa6-aafa-b4fe2714ca40@linux.intel.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <59c395bf-daac-9835-7063-5f8b6a9f3338@loongson.cn>
Date:   Wed, 3 Nov 2021 16:34:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f7cfa6bc-a0f6-aaa6-aafa-b4fe2714ca40@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9Dxf2ulSYJhOackAA--.58098S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW3CF45KF4fZF48tF1fZwb_yoW8Ww47pa
        yqg390gFn8GFn29r12kw10v3yfA3s5ZryDJry3A34DCrZrWr92v34UKr4DA3s7WFZavw1q
        9F4jyr98uw4UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/11/1 下午5:18, Mathias Nyman 写道:
> Hi
>
> On 1.11.2021 9.17, Yinbo Zhu wrote:
>> After S5, any pci device should into D3 state that if supported, but the
>> uPD720201 was not and it may be the cause of xhci firmware and cause
>> OSPM power consumption is more higher that S5 than S4. I think xhci HCD
>> can add a quirk ensure it into D3 state after S5 that is appropriate
>> and this patch was to add LPM quirk and set PCI_D3hot to uPD720201 pmsc
>> register in xhci_pci_shutdown to fix xhci power consumption issue.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> I think we need a better understanding of the underlying issue before
> adding a quirk like this.
>
> Is this a known issue with the uPD720201 controller firmware? or is it
> an issue with ACPI table entries not supporting the proper D state in BIOS
> on the tested platform, or something completely different?

Yes, and I notice other xhci hc doesn't encounter this power consumption 
issue I think that xhci firmware

may be set D3 after s5, but the xhci firmware code isn't visible,  in 
addition I find that test platform the

_PS3 method wasn't implemented in acpi table which can make device into 
S3, Bios team didn't add it for

some platform reason and I think xhci hcd to ensure device into D3 state 
after s5 that is appropriate

>
> Also, LPM usually refers to "Link Power Management" in the xHCI spec.
> This is about the U1 and U2 link states for the connected USB device.
>
> If we end up needing a new xhci quirk it will need a new name.
>
> Thanks
> -Mathias

Hi Mathias,


I had changed the quirk that replace XHCI_LPM_QUIRK with XHCI_LWP_QUIRK 
as v2 version patch.

please view the v2 version patch.


Thanks,

Yinbo.


