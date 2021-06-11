Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF593A3C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFKG7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:59:34 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:49046 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFKG7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:59:32 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210611065731epoutp04738fe8b644f35f0bac942939673b2fb2~HdNWkrn742054020540epoutp04O
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:57:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210611065731epoutp04738fe8b644f35f0bac942939673b2fb2~HdNWkrn742054020540epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623394651;
        bh=X3xjJoHAijOdBdATDp6jQyUVhkxRQGBvTWwym/WpWf4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vYFjUFT1XRDtKSH3GIP2rUI02WkBIIcd++jA2CS/xnzRc2tnxaow4MZCYDABag1KQ
         7NKp5G9CVJhRFVV553C3JR6rqPB4cOBS+1gq/Uj9JrEBus3BDgmbyf5wdHJ0B5oegP
         a6MnXs9uuiWr1XIsZ0lG5YFLdCbizei7ZUSvoTyc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210611065731epcas1p199a7cab8d2a0a430c88c145a151996e2~HdNWNlTfJ2528225282epcas1p1M;
        Fri, 11 Jun 2021 06:57:31 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G1Wqr631Cz4x9Q2; Fri, 11 Jun
        2021 06:57:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.92.09701.75903C06; Fri, 11 Jun 2021 15:57:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210611065726epcas1p1e9a6b82350d2485ad8a11de7ecafcb2f~HdNSNfsqn2681426814epcas1p1c;
        Fri, 11 Jun 2021 06:57:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210611065726epsmtrp23088c144c156bac40a76fc438e5cd55c~HdNSMrGoy3107031070epsmtrp22;
        Fri, 11 Jun 2021 06:57:26 +0000 (GMT)
X-AuditID: b6c32a36-c0126a80000025e5-16-60c3095786e2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.56.08163.65903C06; Fri, 11 Jun 2021 15:57:26 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210611065726epsmtip233c9d3f1d08594cab285cb213d0d31c7~HdNR8Tn0S2972429724epsmtip2b;
        Fri, 11 Jun 2021 06:57:26 +0000 (GMT)
Subject: Re: [PATCH RESEND v2 3/5] extcon: extcon-max77693.c: Fix potential
 work-queue cancellation race
To:     matti.vaittinen@fi.rohmeurope.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c2a97466-e341-de1d-3d44-60cafce9774f@samsung.com>
Date:   Fri, 11 Jun 2021 16:16:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <5939eb35e75e9f1288042430c367650b2e8b2996.camel@fi.rohmeurope.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmgW445+EEg5ezBC02zljPanF40QtG
        izfHpzNZbHz7g8ni8q45bBZrj9xlt9j+7RGbxe3GFWwOHB6zGnrZPH4ffczusXPWXXaP9/uu
        snn0bVnF6PF5k1wAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqt
        kotPgK5bZg7QQUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS9
        5PxcK0MDAyNToMKE7IxDy5vZC+7KV9xZeZulgXG+VBcjJ4eEgIlE+6QXbF2MXBxCAjsYJfY8
        b2MDSQgJfGKU2HHUBSLxmVFi7YXLbDAdD2esY4FI7GKU2Hp9FlT7e0aJh//es4JUCQtkSbx7
        sJEJxBYRUJVYs2slK0gRs8B+JonWZ8fZQRJsAloS+1/cABvLL6AocfXHY8YuRg4OXgE7ift/
        wOawAPX+mncDzBYVCJM4ua2FEcTmFRCUODnzCQuIzSngL3G0eRNYDbOAuMStJ/OZIGx5ie1v
        5zBDXL2UQ2LzIUGQ8RICLhIr9oZChIUlXh3fwg5hS0l8frcX6slqiZUnj4D9JSHQwSixZf8F
        VoiEscT+pZOZQOYwC2hKrN+lDxFWlNj5ey4jxFo+iXdfe1ghVvFKdLQJQZQoS1x+cJcJwpaU
        WNzeyTaBUWkWkmdmIXlgFpIHZiEsW8DIsopRLLWgODc9tdiwwAg5rjcxgpOqltkOxklvP+gd
        YmTiYDzEKMHBrCTCu3PloQQh3pTEyqrUovz4otKc1OJDjKbA4J3ILCWanA9M63kl8YamRsbG
        xhYmhmamhoZK4rw72YCaBNITS1KzU1MLUotg+pg4OKUamPS75h1q35ZlJT856r3v+muruXuc
        is2aMyZvcrKt+f3n6rKfacs/xOpK8D42lTNQLVETu/1uTphS5Z03WgqaH5itGtbPaTu+eUL6
        3DluoufFue8Zik4VYLfY87Ay59q+AyV2c24o1fxLW5arfsXoy6ynZ9epCM4671NxqfTwr38H
        1+63aF7oyeE58Yup9SYlX7HDz0Neyz4suVZ6IEuaIWWFVLpeyOwTR7vMre9GcF2u+6lkevBD
        o/Lv5/5Khp4lZ0vyH1yetzV6WVxHrNSuT3+3Fzd1HMibtPeJf3XK+lTuwxJfrrlaBa+f55N7
        rT7TW8FvgofIG2N3o7gFR805rJzdDA6ueSs/uzVxZVCOuhJLcUaioRZzUXEiAJ/inRAzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXjeM83CCwdoTRhYbZ6xntTi86AWj
        xZvj05ksNr79wWRxedccNou1R+6yW2z/9ojN4nbjCjYHDo9ZDb1sHr+PPmb32DnrLrvH+31X
        2Tz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr49DyZvaCu/IVd1beZmlgnC/VxcjJISFgIvFw
        xjqWLkYuDiGBHYwSWxe3sUAkJCWmXTzK3MXIAWQLSxw+XAxR85ZRouvKMiaQGmGBLIl3DzaC
        2SICqhJrdq1kBbGZBfYzSWw8Zw7R8IFJ4syOCWwgCTYBLYn9L26A2fwCihJXfzxmBFnAK2An
        cf8PWC8L0Jxf826A2aICYRI7lzwGm88rIChxcuYTsNs4BfwljjZvgtqlLvFn3iVmCFtc4taT
        +UwQtrzE9rdzmCcwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeu
        l5yfu4kRHGFaWjsY96z6oHeIkYmD8RCjBAezkgjvzpWHEoR4UxIrq1KL8uOLSnNSiw8xSnOw
        KInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgSvvJd0Bjz6TjfyRnzI1qXsLq9U/2SM8cW/n3
        1kFCk/m7b0+dudXns+n7B3/jW/NMirJmZqw/mMIiYq2ee9e+7tc/88fm9fdWp3699Un9ku6V
        mOgDa8uKbt8zK7eV9dHQFCu0cszJvHbmv0d4/93F016928KXVVbHuez5p5SECOaluQoWy5ae
        +WYQYPidg6/pQW3YNHap2/ENL46+fbT7j2nn8vnmOZu2Rl1VFrw/f+FVHWkHm/0actY9jeGs
        ziy/bZad3LBtTqxTmPCdidsvCAjeTlsnkPXTbu3BKbsWnIh1fKd0zOXS44PuYmXBkwLEbzZe
        2OxVwNmreLLnaID5/VPGq9r5+7uOTdRvUlnCrMRSnJFoqMVcVJwIAODD2IYfAwAA
X-CMS-MailID: 20210611065726epcas1p1e9a6b82350d2485ad8a11de7ecafcb2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210608101022epcas1p1c1623dfb74f412153706d3986b373a03
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
        <CGME20210608101022epcas1p1c1623dfb74f412153706d3986b373a03@epcas1p1.samsung.com>
        <cbe8205eed8276f6e6db5003cfe51b8b0d4ac966.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
        <7f39c731-b644-0122-d68f-7da7e78b4252@samsung.com>
        <5939eb35e75e9f1288042430c367650b2e8b2996.camel@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/21 6:57 PM, Matti Vaittinen wrote:
> 
> On Thu, 2021-06-10 at 18:43 +0900, Chanwoo Choi wrote:
>> On 6/8/21 7:10 PM, Matti Vaittinen wrote:
>>> The extcon IRQ schedules a work item. IRQ is requested using devm
>>> while
>>> WQ is cancelld at remove(). This mixing of devm and manual
>>> unwinding has
>>> potential case where the WQ has been emptied (.remove() was ran)
>>> but
>>> devm unwinding of IRQ was not yet done. It may be possible the IRQ
>>> is
>>> triggered at this point scheduling new work item to the already
>>> flushed
>>> queue.
>>>
>>> According to the input documentation the input device allocated by
>>> devm_input_allocate_device() does not need to be explicitly
>>> unregistered.
>>> Use the new devm_work_autocancel() and remove the remove() to
>>> simplify the
>>> code.
>>>
>>> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com
>>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>
>>> Please note that the change is compile-tested only. All proper
>>> testing is
>>> highly appreciated.
>>> ---
>>>  drivers/extcon/extcon-max77693.c | 17 +++++------------
>>>  1 file changed, 5 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon-max77693.c
>>> b/drivers/extcon/extcon-max77693.c
>>> index 92af97e00828..1f1d9ab0c5c7 100644
>>> --- a/drivers/extcon/extcon-max77693.c
>>> +++ b/drivers/extcon/extcon-max77693.c
>>> @@ -5,6 +5,7 @@
>>>  // Copyright (C) 2012 Samsung Electrnoics
>>>  // Chanwoo Choi <cw00.choi@samsung.com>
>>>  
>>> +#include <linux/devm-helpers.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/module.h>
>>>  #include <linux/i2c.h>
>>> @@ -1127,7 +1128,10 @@ static int max77693_muic_probe(struct
>>> platform_device *pdev)
>>>  	platform_set_drvdata(pdev, info);
>>>  	mutex_init(&info->mutex);
>>>  
>>> -	INIT_WORK(&info->irq_work, max77693_muic_irq_work);
>>> +	ret = devm_work_autocancel(&pdev->dev, &info->irq_work,
>>> +				   max77693_muic_irq_work);
>>> +	if (ret)
>>> +		return ret;
>>>  
>>>  	/* Support irq domain for MAX77693 MUIC device */
>>>  	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++) {
>>> @@ -1254,22 +1258,11 @@ static int max77693_muic_probe(struct
>>> platform_device *pdev)
>>>  	return ret;
>>>  }
>>>  
>>> -static int max77693_muic_remove(struct platform_device *pdev)
>>> -{
>>> -	struct max77693_muic_info *info = platform_get_drvdata(pdev);
>>> -
>>> -	cancel_work_sync(&info->irq_work);
>>> -	input_unregister_device(info->dock);
>>
>> I think that you have to keep the input_unregister_device().
> 
> Are you sure? I can add back the remove() if required - but the
> kerneldoc for devm_input_allocate_device() seems to be suggesting that
> this would not be needed:
> 
>  * Managed input devices do not need to be explicitly unregistered or
>  * freed as it will be done automatically when owner device unbinds
> from
>  * its driver (or binding fails). Once managed input device is
> allocated,
>  * it is ready to be set up and registered in the same fashion as
> regular
>  * input device. There are no special devm_input_device_[un]register()
>  * variants, regular ones work with both managed and unmanaged devices,
>  * should you need them. In most cases however, managed input device
> need
>  * not be explicitly unregistered or freed.
> 
> https://protect2.fireeye.com/v1/url?k=ffe6f053-a07dc951-ffe77b1c-0cc47a312ab0-aa86636d08cba7ad&q=1&e=f8aab92a-f090-4b48-91f8-4dffa41042e9&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.13-rc5%2Fsource%2Fdrivers%2Finput%2Finput.c%23L1955
> 
> I am not going to argue with you though - I am not really familiar with
> the input subsystem. I'd appreciate if someone could shed some light on
> when the input_unregister_device() can be omitted? 

You're right. Thanks for pointing out.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
