Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8396D427390
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 00:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbhJHWUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 18:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhJHWUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:20:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49348C061570;
        Fri,  8 Oct 2021 15:18:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v17so33800037wrv.9;
        Fri, 08 Oct 2021 15:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bWOgwilT6VD43EvIJ1tP1v9WaROqnMW57Ad5BUGuzRc=;
        b=ilfcL4c24dz3/MzdmDcGmGPVnv2iJyPhEJB+yBdnLd2h1t6AyG53i7d2e7riY/lOi6
         Hd+KgYtrpZJQLeDeRoFfQvMigAY56h0YprIXdbby3vEUA9WTE6GfUfBPRPQ4yw9Vx7vS
         wz5hIVjwPV92OBDj76UeMC5e2XsbC0JwsF4xQE09JWNt64ZOosfWKLO4zFChrg8n/3Bi
         iRH/muTFuwAx9lU+tuWoi5Nhj9S/KwUNoFhvM3GFOmtXR6entsL62mPFNG1i8Z4kUjB9
         xaKWN55SAuPla38apjTmF2aV68oVEQxFBnwWZU+ZH/9bLMC6aKOg8Bxexth37lfBanlx
         XjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bWOgwilT6VD43EvIJ1tP1v9WaROqnMW57Ad5BUGuzRc=;
        b=nHIQaEb3IoHafXLBRABzBPFNGLr2iOV7tB4qCSrgh8PSBYA3088oBsJYsWfq8QFUzx
         exxf7ipg3St2PfTLsOzytc2RwHbB/2EJmPWG7kRmYl4a6Opvhuht/Lkd8wKwYZZhibrU
         fJ8yqTPMvyBnXLvzVwRxY4SmHjiLD/eogHM84tG46QDiK1JYKLY0lkPKpPdjBn/6dffo
         yhyhuCrRu2VMiSaWyzxzGo/XLGOESQWT17mEAAb1DiBfMOi3mz7yFDuY0KXB2FDvcNJb
         uR92SSwe9PlGGGY+L5GSWwNYt9FTnv+QxeAScatTQyqsi7ZBX35Tk3qZzWFCot8Iyd4S
         MJ4A==
X-Gm-Message-State: AOAM5330v/ij/OR02/XWRs/1ARyzuFq8CpX/yWeROIuVP8tkmKmIK/ns
        SM18eUHscbtaHL2oogfxDKT+6mxt4fg=
X-Google-Smtp-Source: ABdhPJyPNoIJkc6h/gpJwNyg5ICN/WXqFxLQ+/nuZ/YG3E0xT/zSzMZxXgoIJx+Ae1AfWt9XK7AqiQ==
X-Received: by 2002:a05:600c:350a:: with SMTP id h10mr6030690wmq.163.1633731531872;
        Fri, 08 Oct 2021 15:18:51 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id k8sm380659wmr.32.2021.10.08.15.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 15:18:51 -0700 (PDT)
Subject: Re: [Bug 214453] New: skl_int3472_unregister_clock: kernel NULL
 pointer dereference (HP Elite x2 1013 G3)
To:     Borislav Petkov <bp@alien8.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
References: <bug-214453-6385@https.bugzilla.kernel.org/>
 <YVsy5Gv3z6JAWnxj@zn.tnic>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <035a956e-9987-9b26-38a5-8319f69d4b6d@gmail.com>
Date:   Fri, 8 Oct 2021 23:18:50 +0100
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

Hello

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


I can patch this - but do I need to do to show that the patch is for
that specific bug report or anything?

>> -- 
>> You may reply to this email to add a comment.
>>
>> You are receiving this mail because:
>> You are watching the assignee of the bug.
