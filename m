Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D1F3A3E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhFKIry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:47:54 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:43141 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:47:53 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210611084554epoutp03f9f684a8592c1b5ac87cbe975de567c4~Her_t51bl2162921629epoutp03v
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 08:45:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210611084554epoutp03f9f684a8592c1b5ac87cbe975de567c4~Her_t51bl2162921629epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623401154;
        bh=O0dVq6dUXe8Z7tT9tduINofy0WkZCDv1+3HWNNPA1/E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YA4yMcegLE4SC087FjCOzWSP7GcDAcu2CpCHUnFBDeRTdsU1tqlQrKy5JrslDpYey
         Ff2mAsBCU5QXKso5kEf/Odda+/FXZaLE738IUO1JwsCdYV6GNo5FraKyKGOXM5cJL5
         UsitJLF7YTK0hj/pzWE8BfO0L8UfJB3qQA7WK+ac=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210611084553epcas1p14587062e4809fab1136129617ec23b1c~Her_HfRRb3213032130epcas1p1W;
        Fri, 11 Jun 2021 08:45:53 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4G1ZDv0jc3z4x9QH; Fri, 11 Jun
        2021 08:45:51 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.EB.09736.EB223C06; Fri, 11 Jun 2021 17:45:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210611084550epcas1p141b012f0d94adb9027d8ea9a4a7c8229~Her7KMVQt3195431954epcas1p1K;
        Fri, 11 Jun 2021 08:45:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210611084550epsmtrp245aed14bad9eefe7c0e0bb5edf0bce59~Her7JUAG61669016690epsmtrp2X;
        Fri, 11 Jun 2021 08:45:50 +0000 (GMT)
X-AuditID: b6c32a39-8efff70000002608-ed-60c322be0d76
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.36.08637.EB223C06; Fri, 11 Jun 2021 17:45:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210611084550epsmtip2aab66216c065c030255e2435a30054d8~Her67QFLB1351513515epsmtip2Q;
        Fri, 11 Jun 2021 08:45:50 +0000 (GMT)
Subject: Re: [PATCH RESEND v2 3/5] extcon: extcon-max77693.c: Fix potential
 work-queue cancellation race
To:     Hans de Goede <hdegoede@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <95e2f093-eb2e-722f-b249-435d10cbfbd9@samsung.com>
Date:   Fri, 11 Jun 2021 18:04:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <2d32dbab-7972-d064-6b5f-0789872db834@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmru4+pcMJBqffWVpsnLGe1eLN8elM
        Fhvf/mCyuLxrDpvF2iN32S22f3vEZjFn6QkWi9uNK9gcODxmNfSyefw++pjdY+esu+we7/dd
        ZfPo27KK0ePzJrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRb
        JRefAF23zBygg5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BZYFesWJucWleel6
        yfm5VoYGBkamQIUJ2RnHr/YxF6yWrOjb8Ju1gbFBtIuRk0NCwERi5cP9LF2MXBxCAjsYJZau
        /c8M4XxilHj/eCsThPONUaKpaykzTEt77xRWiMReRolfv1oZIZz3jBJbDuxhBakSFsiSePdg
        I1i7iEAPo8SfG3/BHGaB14wS966cYASpYhPQktj/4gYbiM0voChx9cdjsDivgJ3Es9PXwCax
        CKhK/F34F6xGVCBM4uS2FqgaQYmTM5+wgNicQPVds6+C1TALGEgcWTSHFcIWl7j1ZD4ThC0v
        sf3tHLDvJARWckh07drPDvGQi0T30wNQtrDEq+NboGwpic/v9rJB2NUSK08eYYNo7gD6c/8F
        VoiEscT+pZOZIGxFiZ2/5zJCbOOTePe1B6iGAyjOK9HRJgRRoixx+cFdqHJJicXtnWwTGJVm
        IflnFpIfZiH5YRaSHxYwsqxiFEstKM5NTy02LDBFjvJNjOAUq2W5g3H62w96hxiZOBgPMUpw
        MCuJ8O5ceShBiDclsbIqtSg/vqg0J7X4EKMpMIgnMkuJJucDk3xeSbyhqZGxsbGFiaGZqaGh
        kjjvTjagJoH0xJLU7NTUgtQimD4mDk6pBqbwI91WG7tq1P+xnn625MWVsldvDIxbBGXj12R8
        lZ3yMXdnw4e6rM8u09NSz7gvCmSZmnjF7GhCaMVdy9jsysz7NblL3i+PymNlsCg0n6h5oENd
        cfafzV8qbtzl+Oj1UHba5hLTrjNhXTuSjOv3MS+YMeFN79lqzpQfYdc1mB8tFlXZ4L97y6OP
        fZFKXE/PbTL6GbgnyvxSnvZP4ZXfkkuNKk78L1C5qDXh9q6OCtWnz/lnZQUV2X6oWnp9gnP6
        hED+Y8Z56tqWJjv92mYpGTKeWBOYcKI3if8d73OdWEfOhx8yjiyfzXvgc2ywwdaA8G3fSh49
        Vf7+/bkM35HpC+5eb3ReKGLdd+vtzZA7eYeUWIozEg21mIuKEwGHZ77zOgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXnef0uEEgyPPpCw2zljPavHm+HQm
        i41vfzBZXN41h81i7ZG77Bbbvz1is5iz9ASLxe3GFWwOHB6zGnrZPH4ffczusXPWXXaP9/uu
        snn0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxvGrfcwFqyUr+jb8Zm1gbBDtYuTkkBAwkWjv
        ncIKYgsJ7GaUeD45HiIuKTHt4lHmLkYOIFtY4vDh4i5GLqCSt4wSW0/dZAapERbIknj3YCMT
        SEJEoIdR4uDEqWwgDrPAa0aJmY8eMkJMvc8k8a5RHsRmE9CS2P/iBhuIzS+gKHH1x2OwGl4B
        O4lnp6+BXcEioCrxd+FfsBpRgTCJnUseM0HUCEqcnPmEBcTmBKrvmn0VrIZZQE9ix/VfrBC2
        uMStJ/OZIGx5ie1v5zBPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3
        uDQvXS85P3cTIzjGtDR3MG5f9UHvECMTB+MhRgkOZiUR3p0rDyUI8aYkVlalFuXHF5XmpBYf
        YpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwLQl8kUvZ0AY8/K8U1ZTKqqqjMv0emfm
        R4kILbsZq1r97XVVjJBn3xtTl/J2zsBEznmvKhNv8Jxc1lyb/Ur9a2nAo/dbXqcWLNxVtqr7
        xmoD0+vxdRJzmPJV71RcXvU/eZJEd5b6ue+5R+zerOk6uWpXQIrRvOeVta0hW6s6VSe3vz24
        +KbwNXfJpO4KfQaJ7yfcsn7bzjnjf2LVW4faf0t2tTj4ml1YLXGd06925a12zSmOvBpGHM03
        Cmb7vHCLPHu4+ODn0LZlpeV78qbM8HmhO8Fd1XJ69NzK+5xnQy/sM9/eES4qzfNxxQa3LNZw
        q8UP9Odt6mNRDzr/PHSFgO3UrtoUgXpZj3w7FespSizFGYmGWsxFxYkAHoDY+iADAAA=
X-CMS-MailID: 20210611084550epcas1p141b012f0d94adb9027d8ea9a4a7c8229
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210608101022epcas1p1c1623dfb74f412153706d3986b373a03
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
        <CGME20210608101022epcas1p1c1623dfb74f412153706d3986b373a03@epcas1p1.samsung.com>
        <cbe8205eed8276f6e6db5003cfe51b8b0d4ac966.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
        <7f39c731-b644-0122-d68f-7da7e78b4252@samsung.com>
        <2d32dbab-7972-d064-6b5f-0789872db834@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/21 6:49 PM, Hans de Goede wrote:
> Hi,
> 
> On 6/10/21 11:43 AM, Chanwoo Choi wrote:
>> On 6/8/21 7:10 PM, Matti Vaittinen wrote:
>>> The extcon IRQ schedules a work item. IRQ is requested using devm while
>>> WQ is cancelld at remove(). This mixing of devm and manual unwinding has
>>> potential case where the WQ has been emptied (.remove() was ran) but
>>> devm unwinding of IRQ was not yet done. It may be possible the IRQ is
>>> triggered at this point scheduling new work item to the already flushed
>>> queue.
>>>
>>> According to the input documentation the input device allocated by
>>> devm_input_allocate_device() does not need to be explicitly unregistered.
>>> Use the new devm_work_autocancel() and remove the remove() to simplify the
>>> code.
>>>
>>> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>
>>> Please note that the change is compile-tested only. All proper testing is
>>> highly appreciated.
>>> ---
>>>  drivers/extcon/extcon-max77693.c | 17 +++++------------
>>>  1 file changed, 5 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
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
>>> @@ -1127,7 +1128,10 @@ static int max77693_muic_probe(struct platform_device *pdev)
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
>>> @@ -1254,22 +1258,11 @@ static int max77693_muic_probe(struct platform_device *pdev)
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
> As mentioned in the commit message, in input_unregister_device
> is not necessary for input-devices created with
> devm_input_allocate_device():
> 
> "According to the input documentation the input device allocated by
> devm_input_allocate_device() does not need to be explicitly unregistered."
> 
> I have verified that the documentation is correct here, so there is
> no need to keep the input_unregister_device() as it was never necessary
> to have that there.

You're right. I got it from Matti Vaittinen review.
I replied the ack message.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
