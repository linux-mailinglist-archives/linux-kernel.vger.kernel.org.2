Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0707422B67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhJEOqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhJEOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:46:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65AAC061749;
        Tue,  5 Oct 2021 07:45:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so3349141wmc.0;
        Tue, 05 Oct 2021 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YXZfnyZzs6v/eJz0e4UKaBStwmo6ryE6VJWfKXr4q0c=;
        b=dddqSbWdPXGBiaVL6knpSwIqXaIvtrVfq3NV0MutkmkWWi1F/DmbuZ4bShqrVIFKiY
         0aynSiMfvufZUArfLXNh0RJk2l040F5WrvvqKqAruxZclOuuT0locv11xGs2YuMry3dJ
         nmB4UARLotYzQzZtjkApXRkcMLXjN87vtuHkY8g5/4QNrRQYvhITf3cIC67LlukmCoEC
         bTiNYDQqaZlfZnrkC44S2i0hL/cDDkaA2CUj5FGPcM+aLuqqSgdCBpuIc+E4vLg+rabA
         /UIIykroWMGr7iIE9lTOhjWy0Tr9O4Xj6Enc7f2qkT4ReHa0ZZmZ+ITffDUtyNVTtYW0
         l1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YXZfnyZzs6v/eJz0e4UKaBStwmo6ryE6VJWfKXr4q0c=;
        b=K/uPzt1mCP2pHNI38KVo71s8OriWyUxWjkiuSxV9qZA3yVSLMbvqdLluLcNzMU4+Gs
         eZavq+D8FkP9T/m47seuo0aY6GykzmhbX6TJJTiY+6FLYDw3Mb8jIIYHldKk0yWcRMWm
         BgmLucjJTfk+mckDs9rYAKkjwderwZVVW3dPon75cRxqQk/mROQhXWaP9Rqm+EiaUBWB
         1Oai1nxTqibnURYDzfT3FOLKEMxogNLVc6jhJuKCTzVsMKorPtyY3m69SD6JeXvZ0h9Z
         Nl6ClfVOABv+O6ZIbqiG3n7SqAsJ9eLxZDn5HxeZHrblsrlpvYNnb278tEUtAyfhLRPL
         Ysdw==
X-Gm-Message-State: AOAM533H6c0nhV9SQjVGrBThRdzbiQtdvTdH/rduhmDDotWtL2oPDVHj
        hlkO0KBhMjN4k4zD6DzNNqIxN4uUKpo=
X-Google-Smtp-Source: ABdhPJyepddN/BFvvGROmi7gtcZT/ArkckBkntmxZCTEE2QIOvscegBbH7DKBB9MbcYYjcBc1e+67A==
X-Received: by 2002:a7b:cd13:: with SMTP id f19mr3941323wmj.109.1633445101577;
        Tue, 05 Oct 2021 07:45:01 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id f1sm19756506wri.43.2021.10.05.07.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 07:45:00 -0700 (PDT)
Subject: Re: [Bug 214453] New: skl_int3472_unregister_clock: kernel NULL
 pointer dereference (HP Elite x2 1013 G3)
To:     Borislav Petkov <bp@alien8.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
References: <bug-214453-6385@https.bugzilla.kernel.org/>
 <YVsy5Gv3z6JAWnxj@zn.tnic>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <81329df6-b24d-e860-fcb1-b01c8b5caa91@gmail.com>
Date:   Tue, 5 Oct 2021 15:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVsy5Gv3z6JAWnxj@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav

On 04/10/2021 17:59, Borislav Petkov wrote:
> Adding more people to Cc.
>
> On Fri, Sep 17, 2021 at 12:18:27PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=214453
>>
>>             Bug ID: 214453
>>            Summary: skl_int3472_unregister_clock: kernel NULL pointer
>>                     dereference (HP Elite x2 1013 G3)
>>            Product: Platform Specific/Hardware
>>            Version: 2.5
>>     Kernel Version: 5.14.5
>>           Hardware: Intel
>>                 OS: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: low
>>           Priority: P1
>>          Component: x86-64
>>           Assignee: platform_x86_64@kernel-bugs.osdl.org
>>           Reporter: kernel-NTEO@vplace.de
>>         Regression: No
>>
>> Created attachment 298863
>>   --> https://bugzilla.kernel.org/attachment.cgi?id=298863&action=edit
>> dmesg oops log
>>
>> On a HP Elite x2 1013 G3 a kernel oops is caused by int3472:
>>
>> [    8.820565] int3472-discrete INT3472:02: No sensor module config
>> [    8.820569] int3472-discrete INT3472:02: error -EINVAL: Failed to map
>> regulator to sensor
>> [    8.820574] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> [...]
>> [    8.820654] Call Trace:
>> [    8.820657]  clkdev_drop+0x1d/0x60
>> [    8.820665]  skl_int3472_unregister_clock+0x15/0x30 [intel_skl_int3472
>> a61329898df9463f8661b1eee1ed1e20b1626f62]


Thanks for the report; let me take a look and see if I can spot what's
going wrong.


>> -- 
>> You may reply to this email to add a comment.
>>
>> You are receiving this mail because:
>> You are watching the assignee of the bug.
