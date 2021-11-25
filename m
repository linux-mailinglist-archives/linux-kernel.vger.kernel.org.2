Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8285445D4DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348126AbhKYGjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:39:18 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:65419 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345544AbhKYGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:37:16 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id q8KZmqDf3S9NTq8KZmdcCj; Thu, 25 Nov 2021 07:34:04 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 25 Nov 2021 07:34:04 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH 1/2] eni_vdpa: Fix an error handling path in
 'eni_vdpa_probe()'
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
 <CACGkMEvN0cgFQhJmLF3xDXHt_EyZ-TnfBM8CnpNwA9sKcwpzBg@mail.gmail.com>
 <393fb7b7-653b-eae6-16bd-5ffc7d600619@wanadoo.fr>
 <CACGkMEt3yA+fkFJxKfrXyui-rYVSk78=1AqrT0TYQqzcqTJVyg@mail.gmail.com>
 <069ed3fb-ef99-ff36-136d-a0221ba85a96@wanadoo.fr>
 <20211124185834-mutt-send-email-mst@kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <131b9250-f338-c931-39e6-ca3c1e3a9b66@wanadoo.fr>
Date:   Thu, 25 Nov 2021 07:34:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124185834-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/11/2021 à 00:58, Michael S. Tsirkin a écrit :
> On Tue, Nov 09, 2021 at 10:21:44PM +0100, Christophe JAILLET wrote:
>> Le 09/11/2021 à 03:54, Jason Wang a écrit :
>>> On Tue, Nov 9, 2021 at 3:32 AM Christophe JAILLET
>>> <christophe.jaillet@wanadoo.fr> wrote:
>>>>
>>>> Le 08/11/2021 à 06:55, Jason Wang a écrit :
>>>>> On Mon, Nov 8, 2021 at 12:15 AM Christophe JAILLET
>>>>> <christophe.jaillet@wanadoo.fr> wrote:
>>>>>>
>>>>>> In the error handling path, a successful 'vp_legacy_probe()' should be
>>>>>> balanced by a corresponding 'vp_legacy_remove()' call, as already done in
>>>>>> the remove function.
>>>>>>
>>>>>> Add the missing call and update gotos accordingly.
>>>>>>
>>>>>> Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
>>>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>>>> ---
>>>>>>     drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
>>>>>>     1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
>>>>>> index 3f788794571a..12b3db6b4517 100644
>>>>>> --- a/drivers/vdpa/alibaba/eni_vdpa.c
>>>>>> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
>>>>>> @@ -501,7 +501,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>>>            if (!eni_vdpa->vring) {
>>>>>>                    ret = -ENOMEM;
>>>>>>                    ENI_ERR(pdev, "failed to allocate virtqueues\n");
>>>>>> -               goto err;
>>>>>> +               goto err_remove_vp_legacy;
>>>>>>            }
>>>>>>
>>>>>>            for (i = 0; i < eni_vdpa->queues; i++) {
>>>>>> @@ -513,11 +513,13 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>>>            ret = vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queues);
>>>>>>            if (ret) {
>>>>>>                    ENI_ERR(pdev, "failed to register to vdpa bus\n");
>>>>>> -               goto err;
>>>>>> +               goto err_remove_vp_legacy;
>>>>>>            }
>>>>>>
>>>>>>            return 0;
>>>>>>
>>>>>> +err_remove_vp_legacy:
>>>>>> +       vp_legacy_remove(&eni_vdpa->ldev);
>>>>>
>>>>> Won't vp_legacy_remove() be triggered by the put_devic() below?
>>>>
>>>> Hi, I'm sorry but i don't see how.
>>>>
>>>> My understanding is that:
>>>>      - on "put_device(&eni_vdpa->vdpa.dev);", the corresponding release
>>>> function will be called.
>>>>
>>>>      - This release function is the one recorded in the
>>>> '__vdpa_alloc_device()' function.
>>>>
>>>>      - So it should be 'vdpa_release_dev()'.
>>>>
>>>>      - This function, AFAIU, has no knowledge of 'vp_legacy_remove()' or
>>>> anything that could call it.
>>>>
>>>>
>>>> Unless I misread something or miss something obvious, I don't see how
>>>> 'vp_legacy_remove() would be called.
>>>>
>>>>
>>>> Could you elaborate?
>>>
>>> I think the device should release the driver (see
>>> device_release_driver()) during during its deleting.
>>
>> Hi, I still don't follow the logic and I don't understand how
>> 'vp_legacy_remove()' will finely be called, but it is not that important.
>>
>> If it's fine for you, it's fine for me :)
>>
>> CJ
> 
> So pls post just patch 2?

Patch 2/2 should apply cleanly with or without patch 1/2.
Do I really need to send a v2 just for dropping the first patch? :/

CJ

> 
>>>
>>> Thanks
>>>
>>>>
>>>> CJ
>>>>
>>>>>
>>>>> Thanks
>>>>>
>>>>>>     err:
>>>>>>            put_device(&eni_vdpa->vdpa.dev);
>>>>>>            return ret;
>>>>>> --
>>>>>> 2.30.2
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>> _______________________________________________
>>> Virtualization mailing list
>>> Virtualization@lists.linux-foundation.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>>>
> 
> 

