Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C10634762A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhCXKdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:33:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:18537 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhCXKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:32:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210324103256euoutp02ee8f0f34833b4d56c1c0d7c6ba989c50~vQL4rBaKO1694116941euoutp02e
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:32:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210324103256euoutp02ee8f0f34833b4d56c1c0d7c6ba989c50~vQL4rBaKO1694116941euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616581976;
        bh=1vwwsv0Ed8WWxT+Oz5o018Cgy0cHlncF8+8K7kvUhPo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SdKaaMQ7Omi6krsKcBsKRVmd41qVy2gIW7KM0KKDLpEeFjdVen85lh2jQo8PFld/B
         ylt478TcTJOFO2BhN2xIaesE3kMnfzyHZXZGe2zMmGE5KNpB9BcqBYE74RBhtgBT7w
         xpKzwd+YEJm9biCCjTdXAHrvRf/Y0qlS6D/Sysbo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210324103256eucas1p2163872c401443be61d2e6886cc76695c~vQL4NBpO33061230612eucas1p2h;
        Wed, 24 Mar 2021 10:32:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.3E.09444.8551B506; Wed, 24
        Mar 2021 10:32:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210324103255eucas1p275710cb9dc025443dbcaf090c9137bae~vQL3h7s_w3214332143eucas1p2L;
        Wed, 24 Mar 2021 10:32:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210324103255eusmtrp199a1997aaf4fe4cc035d80b11de63b0b~vQL3hO1_X1074610746eusmtrp1h;
        Wed, 24 Mar 2021 10:32:55 +0000 (GMT)
X-AuditID: cbfec7f4-dd5ff700000024e4-0b-605b155854d3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 53.31.08705.7551B506; Wed, 24
        Mar 2021 10:32:55 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210324103254eusmtip216ef4a92fc99de2a811673eaa147a1f6~vQL3BE2m10123801238eusmtip2i;
        Wed, 24 Mar 2021 10:32:54 +0000 (GMT)
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP queuing while stopping
 transfers
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c3cd3abb-ceaf-4752-5275-e8ff59d9f646@samsung.com>
Date:   Wed, 24 Mar 2021 11:32:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <eb91f1dc-d9ae-136d-4074-f1f70d666064@codeaurora.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7oRotEJBtt2MFu8nHCY0eJY2xN2
        i+bF69ksLu+aw2axaFkrs8XapllsDmwel/t6mTx2zrrL7rFpVSebx/65a9g9Pm+SC2CN4rJJ
        Sc3JLEst0rdL4MpYcHI1U0GHb8XExVUNjE8duhg5OSQETCSmPXvM0sXIxSEksIJR4nz7EjYI
        5wujRFfTclYI5zOjxJvZ+9hhWo7OOc8KYgsJLGeU2H24EKLoI6PE5j1f2EASwgIREo/2zQAr
        EhEIl+hoWccEUsQssJlRomnqA0aQBJuAoUTX2y6wBl4BO4mJy68zgdgsAqoSbY3vgLZxcIgK
        JElsOBQLUSIocXLmExYQm1PASeLXu39gBzELyEs0b53NDGGLS9x6Mh9sl4TABQ6JZU8vsIHM
        kRBwkfi4OBziAWGJV8e3QD0jI3F6cg8LRH0zo8TDc2vZIZweRonLTTMYIaqsJe6c+wU2iFlA
        U2L9Ln2ImY4SjTOKIUw+iRtvBSFO4JOYtG06M0SYV6KjTQhihprErOPr4LYevHCJeQKj0iwk
        j81C8swsJM/MQli7gJFlFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmDSOf3v+JcdjMtf
        fdQ7xMjEwXiIUYKDWUmEtyU8IkGINyWxsiq1KD++qDQntfgQozQHi5I4b9KWNfFCAumJJanZ
        qakFqUUwWSYOTqkGpvAwnegy9oMrN62b1t1osMb7QXE4085gTedYdl9mz6snvcQ91nLE2vGy
        hv5895NNq3bZa6mL2yVPJJ45sbj83eFP+dlTpvo/+XboiKBuQYG66OJ7P/aV309SM5mR9JBv
        yVPtC5r7tnW+Fevsn/3EMZzrhc7s0ta/93ke5nK5zin9KH6RoX+fuISF1rYtVV/lVk1d/UIg
        UyEqsYVVhUVmsmFTvCxXn+WN6L5FuTzKeX8Kw6NdapS8Hj6+2lFjPW3qH96l1xn3dRp5qOfW
        5l0oPWNezVRWmzDLdM6Ra02Tua30mDU/qk402rJ3ZWO1c91y85a9HjkHnke+PvcrKc3k188F
        ZV5JWW4Tv63+w6CnxFKckWioxVxUnAgAQNCwb6kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7rhotEJBsf/iFm8nHCY0eJY2xN2
        i+bF69ksLu+aw2axaFkrs8XapllsDmwel/t6mTx2zrrL7rFpVSebx/65a9g9Pm+SC2CN0rMp
        yi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MtYcHI1U0GH
        b8XExVUNjE8duhg5OSQETCSOzjnP2sXIxSEksJRRovndOiaIhIzEyWkNrBC2sMSfa11sEEXv
        GSUWvV7PDpIQFoiQeLRvBliRiEC4xL9vd9hAbGaBrYwST0/wQTQcZJFY9vY+2FQ2AUOJrrdd
        YEW8AnYSE5dfB4uzCKhKtDW+AxsqKpAkcXnJRFaIGkGJkzOfsIDYnAJOEr/e/WOHWGAmMW/z
        Q2YIW16ieetsKFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7N
        S9dLzs/dxAiMtW3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeFvCIxKEeFMSK6tSi/Lji0pzUosP
        MZoC/TORWUo0OR8Y7Xkl8YZmBqaGJmaWBqaWZsZK4rxb566JFxJITyxJzU5NLUgtgulj4uCU
        amBadNTUdsmCUJ0Lagt2vW55NKGOfUOPbNzKK2zblmlOf/y665eHDG9K359r9VVe5RViVctD
        EpIb4nZtUttwpTq0wz386MHfC07oxaxef89J4FxHsldBWfT65I6HM6W/2aw9d81Rx0MjazXf
        Yr3u4xGLWXK+Tqi9dyzQwfXIO7Of8xqPyi5aG/zOXVnps2r5ngS/Fc8YP8xgv+z+peNkm6jP
        kaX/9+7Y1p858WR3v8fRgg0pPxue/VZyCw3hTpcRTypdy/V422mWTIuHf4orljhGfP/i8u/r
        xwMdLT+ed6x+czGv/kWVQ55Q7CKB/7N9JkgqX/F/KjovKGzZcrvqGYvisyr3qKecVtIUTH96
        jVFQiaU4I9FQi7moOBEASgfPVD4DAAA=
X-CMS-MailID: 20210324103255eucas1p275710cb9dc025443dbcaf090c9137bae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210324103255eucas1p275710cb9dc025443dbcaf090c9137bae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210324103255eucas1p275710cb9dc025443dbcaf090c9137bae
References: <1615507142-23097-1-git-send-email-wcheng@codeaurora.org>
        <CAHp75VfUVCB4gzgOWf=bUpCjfyerQLPN_p-vOnVfxUKHi1WJkg@mail.gmail.com>
        <716dca12-2bfc-789f-ca74-5555852e4c8b@codeaurora.org>
        <CAHp75VeynZArUkrogdJdR9oh+6Ocuqz3ySeDoRBFWusm8F6NRQ@mail.gmail.com>
        <39fdd3c8-9682-6109-f47d-7f7bffc4b85e@codeaurora.org>
        <CAHp75Vexow3KLjAueNoPrEhXmWk_4AjUpWXOyWcFLZdfB-o2iA@mail.gmail.com>
        <5252d085-bbd6-0409-a8ca-2b73fe269259@codeaurora.org>
        <CAHp75VdR99vMOz-JPKKCfVvnsBd9SjGxhDtLsa_Zz2SKpWaZOQ@mail.gmail.com>
        <eb91f1dc-d9ae-136d-4074-f1f70d666064@codeaurora.org>
        <CGME20210324103255eucas1p275710cb9dc025443dbcaf090c9137bae@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley,

On 23.03.2021 22:53, Wesley Cheng wrote:
> On 3/23/2021 10:27 AM, Andy Shevchenko wrote:
>> On Tue, Mar 23, 2021 at 1:19 AM Wesley Cheng <wcheng@codeaurora.org> wrote:
>>> On 3/22/2021 2:14 PM, Andy Shevchenko wrote:
>>>> On Mon, Mar 22, 2021 at 10:06 PM Wesley Cheng <wcheng@codeaurora.org> wrote:
>>>>> On 3/22/2021 12:34 PM, Andy Shevchenko wrote:
>>>>>> On Mon, Mar 22, 2021 at 8:49 PM Wesley Cheng <wcheng@codeaurora.org> wrote:
>>>>>>> On 3/22/2021 5:48 AM, Andy Shevchenko wrote:
>>>>>>>> On Fri, Mar 12, 2021 at 2:01 AM Wesley Cheng <wcheng@codeaurora.org> wrote:
>>>>>>>>> In the situations where the DWC3 gadget stops active transfers, once
>>>>>>>>> calling the dwc3_gadget_giveback(), there is a chance where a function
>>>>>>>>> driver can queue a new USB request in between the time where the dwc3
>>>>>>>>> lock has been released and re-aquired.  This occurs after we've already
>>>>>>>>> issued an ENDXFER command.  When the stop active transfers continues
>>>>>>>>> to remove USB requests from all dep lists, the newly added request will
>>>>>>>>> also be removed, while controller still has an active TRB for it.
>>>>>>>>> This can lead to the controller accessing an unmapped memory address.
>>>>>>>>>
>>>>>>>>> Fix this by ensuring parameters to prevent EP queuing are set before
>>>>>>>>> calling the stop active transfers API.
>>>>>>>>
>>>>>>>> commit f09ddcfcb8c569675066337adac2ac205113471f
>>>>>>>> Author: Wesley Cheng <wcheng@codeaurora.org>
>>>>>>>> Date:   Thu Mar 11 15:59:02 2021 -0800
>>>>>>>>
>>>>>>>>     usb: dwc3: gadget: Prevent EP queuing while stopping transfers
>>>>>>>>
>>>>>>>> effectively broke my gadget setup.
>>>>>>>>
>>>>>>>> The output of the kernel (followed by non responsive state of USB controller):
>>>>>>>>
>>>>>>>> [  195.228586] using random self ethernet address
>>>>>>>> [  195.233104] using random host ethernet address
>>>>>>>> [  195.245306] usb0: HOST MAC aa:bb:cc:dd:ee:f2
>>>>>>>> [  195.249732] usb0: MAC aa:bb:cc:dd:ee:f1
>>>>>>>> # [  195.773594] IPv6: ADDRCONF(NETDEV_CHANGE): usb0: link becomes ready
>>>>>>>> [  195.780585] ------------[ cut here ]------------
>>>>>>>> [  195.785217] dwc3 dwc3.0.auto: No resource for ep2in
>>>>>>>> [  195.790162] WARNING: CPU: 0 PID: 217 at
>>>>>>>> drivers/usb/dwc3/gadget.c:360 dwc3_send_gadget_ep_cmd+0x4b9/0x670
>>>>>>>> [  195.799760] Modules linked in: usb_f_eem u_ether libcomposite
>>>>>>>> brcmfmac brcmutil mmc_block pwm_lpss_pci pwm_lps
>>>>>>>> s snd_sof_pci_intel_tng snd_sof_pci snd_sof_acpi_intel_byt
>>>>>>>> snd_sof_intel_ipc snd_sof_acpi snd_sof snd_sof_nocodec
>>>>>>>> spi_pxa2xx_platform snd_sof_xtensa_dsp spi_pxa2xx_pci
>>>>>>>> extcon_intel_mrfld intel_mrfld_adc sdhci_pci cqhci sdhci m
>>>>>>>> mc_core intel_mrfld_pwrbtn intel_soc_pmic_mrfld hci_uart btbcm btintel
>>>>>>>> [  195.835604] CPU: 0 PID: 217 Comm: irq/16-dwc3 Not tainted 5.12.0-rc4+ #60
>>>>>>>> [  195.842403] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
>>>>>>>> BIOS 542 2015.01.21:18.19.48
>>>>>>>> [  195.851191] RIP: 0010:dwc3_send_gadget_ep_cmd+0x4b9/0x670
>>>>>>>> [  195.856608] Code: cd 00 00 00 44 89 44 24 20 48 89 4c 24 18 e8 ee
>>>>>>>> f7 e4 ff 48 8b 4c 24 18 4c 89 f2 48 c7 c7 b9
>>>>>>>> ed 4f a0 48 89 c6 e8 ef 24 43 00 <0f> 0b 41 be ea ff ff ff 44 8b 44 24
>>>>>>>> 20 e9 80 fc ff ff 41 83 fe 92
>>>>>>>> [  195.875381] RSP: 0000:ffffa53c00373ba8 EFLAGS: 00010086
>>>>>>>> [  195.880617] RAX: 0000000000000000 RBX: 0000000000001387 RCX: 00000000ffffdfff
>>>>>>>> [  195.887755] RDX: 00000000ffffdfff RSI: 00000000ffffffea RDI: 0000000000000000
>>>>>>>> [  195.894893] RBP: ffff9ce8c8f2b028 R08: ffffffffa0732288 R09: 0000000000009ffb
>>>>>>>> [  195.902034] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 0000000000041006
>>>>>>>> [  195.909170] R13: ffffa53c00373c24 R14: ffff9ce8c11dadb0 R15: ffff9ce8c2861700
>>>>>>>> [  195.916310] FS:  0000000000000000(0000) GS:ffff9ce8fe200000(0000)
>>>>>>>> knlGS:0000000000000000
>>>>>>>> [  195.924409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>>> [  195.930161] CR2: 00000000f7f694a0 CR3: 0000000038e0c000 CR4: 00000000001006f0
>>>>>>>> [  195.937300] Call Trace:
>>>>>>>> [  195.939755]  __dwc3_gadget_ep_enable+0x2d4/0x4e0
>>>>>>>> [  195.944393]  ? dwc3_remove_requests.constprop.0+0x86/0x170
>>>>>>> Odd that this change would affect the USB enablment path, as they were
>>>>>>> focused on the pullup disable path.  Would you happen to have any
>>>>>>> downstream changes on top of v5.12-rc4 we could review to see if they
>>>>>>> are still required? (ie where is the dwc3_remove_requests() coming from
>>>>>>> during ep enable)
>>>>>> You may check my branch [1] on GH. Basically you may be interested in
>>>>>> the commit:
>>>>>> 0f86df1294ee7523060cc16eafaf4898c693eab0 REVERTME: usb: dwc3: gadget:
>>>>>> skip endpoints ep[18]{in,out}
>>>>>> Otherwise it's a clean v5.12-rc4 with a revert and another USB PHY
>>>>>> suspend fix (which also shouldn't affect this).
>>>>> Can you link your GH reference?
>>>> Oops, sorry.
>>>> Here we are:
>>>>
>>>> [1]: https://github.com/andy-shev/linux/tree/eds-acpi
>>>>
>>> Thanks, I took a look and even tried it on my device running 5.12-rc4,
>>> but wasn't able to see the same problem.  Could you help collect the
>>> ftrace after enabling the tracing KCONFIG and running the below sequence?
>>>
>>> 1.  Mount debugfs
>>> 2.  Set up tracing instance
>>>
>>> mkdir /sys/kernel/debug/tracing/instances/usb
>>> echo 1 >
>>> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_complete_trb/enable
>>> echo 1 >
>>> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_ctrl_req/enable
>>> echo 1 >
>>> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_ep_dequeue/enable
>>> echo 1 >
>>> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_ep_queue/enable
>>> echo 1 >
>>> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_gadget_ep_cmd/enable
>>> echo 1 >
>>> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_gadget_ep_disable/enable
>>> echo 1 >
>>> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_gadget_ep_enable/enable
>>> echo 1 >
>>> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_gadget_giveback/enable
>>> echo 1 >
>>> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_prepare_trb/enable
>>> echo 1 > /sys/kernel/debug/tracing/instances/usb/tracing_on
>>>
>>> 3.  Run your test, which should include:
>>>          - echo "" > /sys/kernel/config/usb_gadget/g1/UDC
>>>          - echo <UDC name> > /sys/kernel/config/usb_gadget/g1/UDC
>>>
>>> 4.  Collect the trace output:
>>> cat /sys/kernel/debug/tracing/instances/usb/trace
>> Here we are (I cherry-picked again reverted patch, other stays the same) [2].
>> On top I put a warning, so you may see timestamps.
>>
>> Dunno how long it will stay there, please confirm that you got it.
>>
>> [2]: https://paste.ubuntu.com/p/jNF565ypPp/
>>
> Hi Andy,
>
> Would you be able to give the below change a try?
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 80606b8..cd58bd5 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -791,10 +791,6 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep
> *dep)
>       reg &= ~DWC3_DALEPENA_EP(dep->number);
>       dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
>
> -    dep->stream_capable = false;
> -    dep->type = 0;
> -    dep->flags = 0;
> -
>       /* Clear out the ep descriptors for non-ep0 */
>       if (dep->number > 1) {
>           dep->endpoint.comp_desc = NULL;
> @@ -803,6 +799,10 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep
> *dep)
>
>       dwc3_remove_requests(dwc, dep);
>
> +    dep->stream_capable = false;
> +    dep->type = 0;
> +    dep->flags = 0;
> +
>       return 0;
>   }

Feel free to add my:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

The above change fixed the issue I was about to complain, introduced (or 
revealed?) by the $subject commit.

Before applying the above fix I've observed following warning during 
system power off:

------------[ cut here ]------------
dwc3 15400000.usb: No resource for ep2in
WARNING: CPU: 0 PID: 162 at drivers/usb/dwc3/gadget.c:361 
dwc3_send_gadget_ep_cmd+0x95c/0xae8
Modules linked in: cpufreq_powersave cpufreq_conservative brcmfmac 
brcmutil cfg80211 crct10dif_ce s3fwrn5_i2c s3fwrn5 nci nfc s5p_mfc 
hci_uart s5p_jpeg btqca btbcm exynos_gsc v4l2_mem2mem 
videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common 
bluetooth videodev mc panfrost gpu_sched ecdh_generic ecc rfkill 
ip_tables x_tables ipv6
CPU: 0 PID: 162 Comm: irq/151-dwc3 Not tainted 5.12.0-rc3+ #2713
Hardware name: Samsung TM2E board (DT)
pstate: 40000085 (nZcv daIf -PAN -UAO -TCO BTYPE=--)
pc : dwc3_send_gadget_ep_cmd+0x95c/0xae8
...
Call trace:
  dwc3_send_gadget_ep_cmd+0x95c/0xae8
  __dwc3_gadget_ep_enable+0x40c/0x578
  dwc3_gadget_ep_enable+0x5c/0xf0
  usb_ep_enable+0x40/0x1d0
  ecm_set_alt+0xa8/0x1b8
  composite_setup+0x8b8/0x1840
  dwc3_ep0_delegate_req+0x38/0x58
  dwc3_ep0_interrupt+0xd2c/0x1048
  dwc3_thread_interrupt+0xe7c/0x10f8
  irq_thread_fn+0x28/0x98
  irq_thread+0x17c/0x298
  kthread+0x134/0x160
  ret_from_fork+0x10/0x18
irq event stamp: 1220
hardirqs last  enabled at (1219): [<ffff800010f96eac>] 
_raw_spin_unlock_irq+0x3c/0x80
hardirqs last disabled at (1220): [<ffff800010f97694>] 
_raw_spin_lock_irqsave+0xb4/0x148
softirqs last  enabled at (924): [<ffff8000100104e8>] _stext+0x4e8/0x614
softirqs last disabled at (901): [<ffff800010095304>] irq_exit+0x19c/0x1a8
---[ end trace 84804a1a38a2c9f7 ]---

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

