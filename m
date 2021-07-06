Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9433BD8A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhGFOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhGFOpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:45:38 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE60C05BD0F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 07:34:35 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 10so10019431oiq.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oJL+fNs5nkHDjyl/QKUL9ML3S1rfgtNI85+6XyKQYwM=;
        b=W9SN77FOQYMfaGldHnDOnXRM2TPMlkob1TrxRG6IxaNSK809kNnUB0n9zDJOt57n6A
         gPtlJfvOK5ZeolUW6Kmbl8fmkO//sjjd/eyNy8P+PQJIP9Sw9d5h3rgCyX0+N6Lxtrvq
         Tjib2DzLN1/pGk+aRGpiYooYuoqc9svzjzEH6eN9wiiw/Xi7I7XumgT9W1hnJm5nEZoZ
         OvgmJxLBEbi6XghGeejNjCSrQ8CGe5Uns60zf5nGQJqMZBMnPVEGdbd7JiSmVkcU74Ix
         6HZdXELxgUTDjYn5mAt/KQnwEi+1D/2JVKpm7YDrcrpVNMeXN+4qItZDw8jnO5+6PsWH
         zPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oJL+fNs5nkHDjyl/QKUL9ML3S1rfgtNI85+6XyKQYwM=;
        b=ZnABbsgxJOeBZ1h7i9cmDc8BCaBAebJZ5soHctnQd4EAd/3lmUSjQqzquGU5q80OEk
         W0bpRwgzd+GbS3PA+DVwuH1CVCE/29egpU0chw7XEr5NhT6x0bczQ68r4vQIKmX0/hGm
         6d4reDM1eRRJGaX7YmBHNNbBu4roZfol71puPfBGL/Rm1SMpRu7PZc9NTpdWZsokQ0aH
         TkdgQjvAmEQ8CEmIGfUKMu5GDkce910putMxorXKJ0PkwA8wKMBK9IqRWyCMJDwV2nsP
         xhjAe9FvmMq6cJPbGsTXiWxDDewDoHjNDMa1oY0+YLUe9yby30HE5R5TecyveptqEAtl
         RcUA==
X-Gm-Message-State: AOAM53002I99WNDpbMO3jf16RehsLlM7OGLJg9ypyNa5tGRTYneId9xi
        SAauKC+QXkvVdF6C1XLA0ypNyj5MY/0=
X-Google-Smtp-Source: ABdhPJwW5yFe+56V+MFW6AnP/7DiBlWTbw8TcrZMyJ4mGjx08OdNICK8ORNLwBiloRaiGO7v10KMOg==
X-Received: by 2002:a54:481a:: with SMTP id j26mr639401oij.117.1625581399235;
        Tue, 06 Jul 2021 07:23:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b10sm3402858oiy.4.2021.07.06.07.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:23:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [irqchip: irq/irqchip-next] irqdomain: Protect the linear revmap
 with RCU
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <162341967699.19906.3242958007782554792.tip-bot2@tip-bot2>
 <20210705172352.GA56304@roeck-us.net> <87h7h88wsd.wl-maz@kernel.org>
 <79ec0069-553b-cac1-5ec7-d68c757619a5@roeck-us.net>
 <87fsws8uty.wl-maz@kernel.org>
 <fb3b9223-a811-af48-ead5-b2c6f7305de4@roeck-us.net>
 <87eecb94mq.wl-maz@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f24c29d3-ee7f-651b-6399-a1e7b5ed073f@roeck-us.net>
Date:   Tue, 6 Jul 2021 07:23:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87eecb94mq.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/21 2:24 AM, Marc Zyngier wrote:
> On Mon, 05 Jul 2021 21:36:36 +0100,
> Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 7/5/21 11:43 AM, Marc Zyngier wrote:
> 
>>> It definitely helps, and confirms my hunch. With the patch below, I'm
>>> not getting the warnings anymore. I'm pretty sure a number of other
>>> MIPS systems suffer from similar issues, which I'll address similarly.
>>>
>>> Please let me know if that addresses the issue on your end.
>>>
>>
>> Yes, it does. Feel free to add
>>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
>> to the real patch.
> 
> Thanks.
> 
>> Now the big question: Why does this only affect 32-bit little endian
>> mips images, but not the matching big endian images, nor 64-bit images ?
> 

Actually they do.

> Are you sure these images are using the exact same HW? A bunch (most?)
> of MIPS systems do not use irqdomains in their root interrupt
> handling, so this issue wouldn't be visible (irq_enter() will already
> have been done for the chained interrupt handling).
> 
> FWIW, I can reproduce the problem by switching your mipsel config to
> BE, and adding this patch fixes it.
> 

Yes, turns out I did not have the necessary debugging options enabled
in my other mips tests.

Thanks,
Guenter
