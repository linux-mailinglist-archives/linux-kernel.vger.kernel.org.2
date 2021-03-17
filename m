Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10C733EAF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhCQH6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhCQH6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:58:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20DDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 00:58:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t18so652933pjs.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=I20ao//jp0K+ljf1zyYRmUDybDGX4o2ZQ8hxDCPtACs=;
        b=grlmjP9cLtgbJiOVVtTbtM9/sum9yzN6kUjg+qj2AT2HHoCwMg/hZ+ajTEmXhLd4Go
         8IUt/u2OhcF0Lg0BI2M4P2BRFgLjpNL/Uf1kuek5vH0u5J1q6gEKYQWGCymwOT/Mg3W4
         AXckl48lO3Q2vWc0mSuVaGOKfDPvABPsJIDaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=I20ao//jp0K+ljf1zyYRmUDybDGX4o2ZQ8hxDCPtACs=;
        b=KNcuxgm/OrEiywOkp/PdGoVNT7/GJVs3gq3b3Ta+1HCSgRGKiyVRAbbD47pNul9G26
         yzE/zD9Gzb/FNbkAEHSXwe95MHz1Ig9BMrU3cfwXR4YQ+whbqiR8pTlWpMrkM3bcZZBS
         TKUFa7AS8+L5Qz+wa9E4TYq4dKce8Jehs/6MVost+ajo4fbFzCINmH0QzWDoeDdombm2
         uBXKMaPYD3+NJQt+NrwL1hoqV6mbwrxDcgBa3kKte6JmLH9a7XKVxfgY+diDj9p1UTyB
         0zon9XgIrK7e1A5r2s86p5jgoZVpk+oLp+UpB7kXqj2MUB2N/W9XPuArjSgx7g4PT/d9
         G9sw==
X-Gm-Message-State: AOAM531DbGek/YdlhjuIIHYrry9fCwkg44IZtxlek8gf8PgEzFsoiYRs
        r7V9s/uVpKhnAGg4Td+h246DtA==
X-Google-Smtp-Source: ABdhPJxYxOzfNLuJLRkClYD1JdcEoh936YPYAebHe0scmNtkzZ7wQeI3uoofXXe493EipbmEgLeTBQ==
X-Received: by 2002:a17:90a:ce0d:: with SMTP id f13mr3249699pju.85.1615967898257;
        Wed, 17 Mar 2021 00:58:18 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-13b2-19b2-2ae0-4d54.static.ipv6.internode.on.net. [2001:44b8:1113:6700:13b2:19b2:2ae0:4d54])
        by smtp.gmail.com with ESMTPSA id nk3sm1717212pjb.17.2021.03.17.00.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 00:58:17 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     "heying \(H\)" <heying24@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        rppt@kernel.org, ardb@kernel.org, clg@kaod.org,
        christophe.leroy@csgroup.eu
Cc:     johnny.chenyi@huawei.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: arch/powerpc/kernel/setup_64.c - cleanup warnings
In-Reply-To: <f0130916-a8f3-75ba-b5da-7d37d9139ff3@huawei.com>
References: <20210316041148.29694-1-heying24@huawei.com> <87wnu6bhvi.fsf@dja-thinkpad.axtens.net> <f0130916-a8f3-75ba-b5da-7d37d9139ff3@huawei.com>
Date:   Wed, 17 Mar 2021 18:58:14 +1100
Message-ID: <87tupab4a1.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"heying (H)" <heying24@huawei.com> writes:

> Thank you for your reply.
>
>
> =E5=9C=A8 2021/3/17 11:04, Daniel Axtens =E5=86=99=E9=81=93:
>> Hi He Ying,
>>
>> Thank you for this patch.
>>
>> I'm not sure what the precise rules for Fixes are, but I wonder if this
>> should have:
>>
>> Fixes: 9a32a7e78bd0 ("powerpc/64s: flush L1D after user accesses")
>> Fixes: f79643787e0a ("powerpc/64s: flush L1D on kernel entry")
>
> Is that necessary for warning cleanups? I thought 'Fixes' tags are=20
> needed only for
>
> bugfix patches. Can someone tell me whether I am right?

Yeah, I'm not sure either. Hopefully mpe will let us know.

Kind regards,
Daniel

>
>>
>> Those are the commits that added the entry_flush and uaccess_flush
>> symbols. Perhaps one for rfi_flush too but I'm not sure what commit
>> introduced that.
>>
>> Kind regards,
>> Daniel
>>
>>> warning: symbol 'rfi_flush' was not declared.
>>> warning: symbol 'entry_flush' was not declared.
>>> warning: symbol 'uaccess_flush' was not declared.
>>> We found warnings above in arch/powerpc/kernel/setup_64.c by using
>>> sparse tool.
>>>
>>> Define 'entry_flush' and 'uaccess_flush' as static because they are not
>>> referenced outside the file. Include asm/security_features.h in which
>>> 'rfi_flush' is declared.
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: He Ying <heying24@huawei.com>
>>> ---
>>>   arch/powerpc/kernel/setup_64.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup=
_64.c
>>> index 560ed8b975e7..f92d72a7e7ce 100644
>>> --- a/arch/powerpc/kernel/setup_64.c
>>> +++ b/arch/powerpc/kernel/setup_64.c
>>> @@ -68,6 +68,7 @@
>>>   #include <asm/early_ioremap.h>
>>>   #include <asm/pgalloc.h>
>>>   #include <asm/asm-prototypes.h>
>>> +#include <asm/security_features.h>
>>>=20=20=20
>>>   #include "setup.h"
>>>=20=20=20
>>> @@ -949,8 +950,8 @@ static bool no_rfi_flush;
>>>   static bool no_entry_flush;
>>>   static bool no_uaccess_flush;
>>>   bool rfi_flush;
>>> -bool entry_flush;
>>> -bool uaccess_flush;
>>> +static bool entry_flush;
>>> +static bool uaccess_flush;
>>>   DEFINE_STATIC_KEY_FALSE(uaccess_flush_key);
>>>   EXPORT_SYMBOL(uaccess_flush_key);
>>>=20=20=20
>>> --=20
>>> 2.17.1
>> .
