Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10E83995BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 00:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFBWM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 18:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhFBWM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 18:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622671842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUjPsHJ5PuL6/0to9YlDMTSAeVkKxMJlKUQySExiimw=;
        b=PPnd7cbdSdZnyQkwBUNBpTBXHrFVLM+FxRphCu+vSx/o390jD3up818s70L0FDeSJFzUWz
        vchmeJqF6JLDSZEBxivSYcIaC03yTfHdmGFpPtZBtVTJLZS/fzblZoS35YQrlE5JuI7ieZ
        gpfD2pPPSf4RPSro6t9R3OczFVQttlA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-3JE4iHMPNFSFqKAB6R_wjg-1; Wed, 02 Jun 2021 18:10:41 -0400
X-MC-Unique: 3JE4iHMPNFSFqKAB6R_wjg-1
Received: by mail-ot1-f72.google.com with SMTP id y2-20020a0568301082b02903b5696f0a64so2352221oto.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 15:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KUjPsHJ5PuL6/0to9YlDMTSAeVkKxMJlKUQySExiimw=;
        b=KqH1uV37qtEPqqe/99Q5WN0WCtIcbQDDY67Is9EbcuNamnZLpiE8XtKa2Orf8Rgu4y
         +R5aZ7AqTc444cj2tbTV3cXCJR4uWtYtpoBlK8s2eSOC1ikaUw0iFxkyA8viJhS9v8tr
         vh2S9JCY1YlUHKREVROUlHtTNNK6+GrEWYU48BOOnmp3B4zYs1dqxm5u9vE3TXCZ4mjK
         sjlTZi2/O9Z26bYrfVkAmlmUmhKp4edDMklAJsjMCVNASmas5Mbe+SEJZ85UQGtgXC8I
         RbT/xnuCXSg8hmsd1i0UXwmUd4hzvj4EvHcW219/uosULiqEaF1zUcOGfhVoNwqeGlmv
         wfAw==
X-Gm-Message-State: AOAM533whtNnt83TZYyRSDY87sMC9RNYptoRmmxA6sHFiX9BLX8mYElP
        JKHrnoYD62P7l8IXZO13DfUEtJKd6qEtE08E+2ujC5/4kW6IvQ3ALukLe856nCEfc+DVMEzBjhZ
        EW/Tj96hf9lda47ufIyAdw1sCujWdRU+YpGFk59iH9phwUWeJV9hY5IzuNtwQGYA8nAAc8BY=
X-Received: by 2002:a4a:250e:: with SMTP id g14mr26331509ooa.31.1622671840247;
        Wed, 02 Jun 2021 15:10:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3zxkPypJY+pMoZE8TmBBmrm3L1q7RwDYe8CB03JX/l9KFF+IfYbxpLYjT9JpPttLssjAZEg==
X-Received: by 2002:a4a:250e:: with SMTP id g14mr26331490ooa.31.1622671840004;
        Wed, 02 Jun 2021 15:10:40 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm283172oij.26.2021.06.02.15.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 15:10:39 -0700 (PDT)
Subject: Re: [PATCH] powerpc/8xx: select CPM1 for MPC8XXFADS
To:     Christophe Leroy <christophe.leroy@csgroup.eu>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210601175304.2634549-1-trix@redhat.com>
 <50ed000a-c1af-8552-9d35-771b3bc131e5@csgroup.eu>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d50f61b0-e165-b3d3-d278-ef0514ddccc0@redhat.com>
Date:   Wed, 2 Jun 2021 15:10:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <50ed000a-c1af-8552-9d35-771b3bc131e5@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/21 12:44 AM, Christophe Leroy wrote:
>
>
> Le 01/06/2021 à 19:53, trix@redhat.com a écrit :
>> From: Tom Rix <trix@redhat.com>
>>
>> With MPC8XXFADS, there is this linker error
>> ppc64-linux-ld: m8xx_setup.o: in function `cpm_cascade':
>> m8xx_setup.c: undefined reference to `cpm_get_irq'
>
> It looks like this config item is stale, it doesn't build any board 
> support, there is no define_machine() for this config item, no file is 
> linked to that config item.
>
> I think you should just remove that item from the possible choices.
>
Yes, this looks like a dead config and removing it is what to do.

I withdraw this change.

I am looking at sweeping the tree of dead configs.

Up a dir, my finder shows

PPC_MMU_NOHASH_32

is another (maybe) dead config.

Thanks for pointing this out,

Tom

> Christophe
>
>
>>
>> cpm_get_irq() is conditionally complied by CPM1
>> So add a select, like the other plaforms
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   arch/powerpc/platforms/8xx/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/platforms/8xx/Kconfig 
>> b/arch/powerpc/platforms/8xx/Kconfig
>> index 60cc5b537a98..919082cdb2f1 100644
>> --- a/arch/powerpc/platforms/8xx/Kconfig
>> +++ b/arch/powerpc/platforms/8xx/Kconfig
>> @@ -10,6 +10,7 @@ choice
>>     config MPC8XXFADS
>>       bool "FADS"
>> +    select CPM1
>>     config MPC86XADS
>>       bool "MPC86XADS"
>>
>

