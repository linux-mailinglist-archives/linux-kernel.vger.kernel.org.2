Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F303A4AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 23:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFKVwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 17:52:07 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:35474 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKVwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 17:52:06 -0400
Received: by mail-ed1-f49.google.com with SMTP id ba2so36952189edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 14:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gZ6KiYF+ULBEYypxNLYi61JZwgfjLGj9Wdtste4sHN8=;
        b=X3xnIeUCQLRBRUD5AX+jOCyBEFfTU3MpSIJD8z4CUhD2YzNCqa+noEdI9yGLsNwnoA
         wlbk9U7vkXW1hrqF//pPmcCeuQMnVrixnlvT0j/YrT4xOiu3USYZCm+NzdW7kGDS8m+J
         QflZU/3psC4uZxkPY+mdYeQLDWVfMDfnS42dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gZ6KiYF+ULBEYypxNLYi61JZwgfjLGj9Wdtste4sHN8=;
        b=H8DzYAe6h3W+Lp6j3+Fl00NXImZm+QjCttkLRf89Zr/c6JP2DDDveAOI1iiAyxbFzO
         HlRS+1Kigg9T66lElSl/KnEuCxqwSAAExE8/kC/qt8J7ACbddK7sZKpJUz0g6jZy7qWH
         GC7vjHHwrKITvjYlDswlcRpJSQFXb3sqE7nMFcSa6E4WAkauWCPClMmFVOjKHsbn24tK
         /6AKx7PQ/px2tBzqCniKDktxvwJsrnii+Hjns7zPHMPKS5LvLJB/MhZ8Jkd1b8c9T0Sl
         PbjmP3HFTgKxUvNHHP6nghsX7fYuNv8WENJTdH4ZnT3y+x3yeazMbgeWBpQrO0w89lNz
         4K5g==
X-Gm-Message-State: AOAM530bcIFVFTZqF8/AGaPa9WG4HBgt1JcBp8GKR521WQVffRZIgdhx
        iXGYyNLeiBO9Y3233aDzyP5otw==
X-Google-Smtp-Source: ABdhPJw7y4jm+G8eJ69mJJlfoVe93e1UWNWkYjhcKIzhDOSAz6gQrEv56n7I8AWH+5u/CSQaX3PXNQ==
X-Received: by 2002:a50:fe86:: with SMTP id d6mr5778295edt.141.1623448147624;
        Fri, 11 Jun 2021 14:49:07 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id g23sm2458567ejh.116.2021.06.11.14.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 14:49:07 -0700 (PDT)
Subject: Re: Panic on ppc64le using kernel 5.13.0-rc3
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     linux-kernel@vger.kernel.org, CKI Project <cki-project@redhat.com>
References: <CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com>
 <d13db73d-0806-00cd-ff84-5f5b03ffbef6@rasmusvillemoes.dk>
 <CA+QYu4oFGkP1G+9TqGtqffgOEBycSMKtFbV-1X+kL4NeTyEegg@mail.gmail.com>
 <45ea5042-9136-6f0c-144c-f09d05cd69ed@rasmusvillemoes.dk>
 <CA+QYu4rF6Bx5OwLzBSam_VXJ6gWqSjTocxTNxanfHuV5nZuzrA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4434f245-db3b-c02a-36c4-0111a0dfb78d@rasmusvillemoes.dk>
Date:   Fri, 11 Jun 2021 23:49:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+QYu4rF6Bx5OwLzBSam_VXJ6gWqSjTocxTNxanfHuV5nZuzrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2021 17.06, Bruno Goncalves wrote:
> On Fri, Jun 11, 2021 at 9:13 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 10/06/2021 17.14, Bruno Goncalves wrote:
>>> On Thu, Jun 10, 2021 at 3:02 PM Rasmus Villemoes
>>> <linux@rasmusvillemoes.dk> wrote:
>>>>
>>>> On 10/06/2021 13.47, Bruno Goncalves wrote:
>>>>> Hello,
>>>>>
>>>>> We've observed in some cases kernel panic when trying to boot on
>>>>> ppc64le using a kernel based on 5.13.0-rc3. We are not sure if it
>>>>> could be related to patch
>>>>> https://lore.kernel.org/lkml/20210313212528.2956377-2-linux@rasmusvillemoes.dk/
>>>>>
>>>>
>>>> Thanks for the report. It's possible, but I'll need some help from you
>>>> to get more info.
>>>>
>>>> First, can you send me the .config?
>>>
>>> The .config is on
>>> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2021/06/09/317881801/build_ppc64le_redhat:1332368174/kernel-block-ppc64le-d3f02e52f5548006f04358d407bbb7fe51255c41.config
>>
>> Thanks.
>>
>>>>
>>>>>
>>>>> [    1.516075] wait_for_initramfs() called before rootfs_initcalls
>>>>
>>>> This is likely because you have CONFIG_UEVENT_HELPER_PATH set to some
>>>> non-empty path (/sbin/hotplug perhaps). This did get reported once before:
>>>>
>>>
>>> CONFIG_UEVENT_HELPER_PATH is not set. In the .config we have "#
>>> CONFIG_UEVENT_HELPER is not set"
>>
>> OK. Then I assume some quite early initcall does a request_module() or
>> request_firmware() (or similar). I don't think this matters - that call
>> would be done before the initramfs was unpacked with or without my
>> patch, so it won't find anything in the empty rootfs. It's just my patch
>> added a note. But just to figure out where that triggers, can you do
>>
>> -               pr_warn_once("wait_for_initramfs() called before
>> rootfs_initcalls\n");
>> +               WARN_ONCE(1, "wait_for_initramfs() called before
>> rootfs_initcalls\n");
>>
>> in init/initramfs.c.
>>
> 
> I've managed to reproduce the panic with the patch.
> 
> [    1.498654] NIP [c0000000000137d4] wait_for_initramfs+0x94/0xa4
> [    1.498661] LR [c0000000000137d0] wait_for_initramfs+0x90/0xa4
> [    1.498668] Call Trace:
> [    1.498671] [c000000027debd60] [c0000000000137d0]
> wait_for_initramfs+0x90/0xa4 (unreliable)
> [    1.498680] [c000000027debdc0] [c000000000172fc8]
> call_usermodehelper_exec_async+0x178/0x2c0
> [    1.498691] [c000000027debe10] [c00000000000d6ec]
> ret_from_kernel_thread+0x5c/0x70

Thanks, but unfortunately (and I should have known better) that doesn't
tell us who actually initated that call_usermodehelper - it's most
likely some request_module() call. But again, I don't think this is
related to the later crash.

>>>>> [    1.764430] Initramfs unpacking failed: no cpio magic
>>>>
>>>> Whoa, that's not good. Did something scramble over the initramfs memory
>>>> while it was being unpacked? It's been .2 seconds since the start of the
>>>> unpacking, so it's unlikely the very beginning of the initramfs is corrupt.
>>>>
>>>> Can you try booting with initramfs_async=0 on the command line and see
>>>> if the kernel still crashes?
> 
> Using initramfs_async=0 I was also able to reproduce the panic.

Hm, that's very interesting. Can you share the log for that as well?

And, perhaps asking a silly question, does the crash go away if you
revert e7cb072eb988e46295512617c39d004f9e1c26f8 ?

Thanks,
Rasmus
