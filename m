Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5103DFB07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 07:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhHDFZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 01:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhHDFZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 01:25:45 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BDCC0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 22:25:32 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so654271ott.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vHNz6EgMpzpbs2ab4Zs6bAjD3BVkQJArI/buz9v+9rU=;
        b=GziRt2jznB/phirmy2W/L1RHlsdc8g5zjEAgQ3JQPb7Rwg8L1jL8xXWoYv790bmR7q
         wR8D/Js7C4D169J95zsmd2vuISX+G8TjLg6oYI0Npn/YX2F3cLN9hN/sJoo9ZQkIkNHr
         +lTWri5CerhC7CfcL8uG0Ox++EMpbBeAB2MSd+/p+SWLCu68WP+AKa9hXwRhCHpw8xYc
         2s/UWsPMIrFAVV77w5tHyOZXo1Zd/FX9/G4a+AcpnD+HI7/g+fXhRvFL4kjef0rwMtsC
         hxFB1JepEWT06cqoKQaGUX1J843Ea9BpebCatOp1xVko7yJbZ1/f0NPSzyyghIJlPs8A
         GH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vHNz6EgMpzpbs2ab4Zs6bAjD3BVkQJArI/buz9v+9rU=;
        b=kmYVC3OZxc6q9Bz+tnXsKAebmzjuql+DySdjCgy0CIPaVQAUCSp/IBqX9lnbmDSI8x
         xpNOidNy3iIat4A9k9+LksZEQ8AQHOwwF8F9oBsbs1Ebfk6YiOfEYfGBCC4Q3XwaZAI0
         Pf2kccj0d6tTl3dHYIfW4xHB5O4b/Le1rEz5wrSQ7uBxxMZujE7TiqQQmu2wLSm5WOnT
         LQESoPPSoRt0Rw6eNEfsIy2foK+H8DZZJxLwLw2Sdqb3JODADpIVP9VCINzjLtokS0Pj
         BEseKLhnKG5aqI/MLLe7bLC+h8pseT19eftF/UXZQ3QPMMarv2JWQrdWDMekngJo0uoQ
         8Gfw==
X-Gm-Message-State: AOAM530EEa0AbGuanUr7o1WXirIBfWU0YV53n+0fuuHHv6Qgn/v3XMpy
        uJy16xnMqyhbhRf6n2adbcw=
X-Google-Smtp-Source: ABdhPJyP89BhSd6xNI4Q58MVHOs3sr1qYdFIjShPIo4MC8ZxMZ9uag3kHS1OoMAlaoAsDkJET7j/1Q==
X-Received: by 2002:a9d:62d4:: with SMTP id z20mr18088775otk.305.1628054731543;
        Tue, 03 Aug 2021 22:25:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b2sm247495otf.40.2021.08.03.22.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 22:25:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] riscv: Disable STACKPROTECTOR_PER_TASK if
 GCC_PLUGIN_RANDSTRUCT is enabled
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com
References: <mhng-5b3c9fa7-2e28-4788-9013-3a988ac5280d@palmerdabbelt-glaptop>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9a2918b0-0c85-7e56-58e0-d2ea0ea10068@roeck-us.net>
Date:   Tue, 3 Aug 2021 22:25:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <mhng-5b3c9fa7-2e28-4788-9013-3a988ac5280d@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 10:14 PM, Palmer Dabbelt wrote:
> On Fri, 23 Jul 2021 17:58:13 PDT (-0700), Palmer Dabbelt wrote:
>> On Tue, 06 Jul 2021 09:26:21 PDT (-0700), linux@roeck-us.net wrote:
>>> riscv uses the value of TSK_STACK_CANARY to set
>>> stack-protector-guard-offset. With GCC_PLUGIN_RANDSTRUCT enabled, that
>>> value is non-deterministic, and with riscv:allmodconfig often results
>>> in build errors such as
>>>
>>> cc1: error: '8120' is not a valid offset in '-mstack-protector-guard-offset='
>>>
>>> Enable STACKPROTECTOR_PER_TASK only if GCC_PLUGIN_RANDSTRUCT is disabled
>>> to fix the problem.
>>>
>>> Fixes: fea2fed201ee5 ("riscv: Enable per-task stack canaries")
>>> Cc: Guo Ren <guoren@linux.alibaba.com>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>  arch/riscv/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 469a70bd8da6..3afb84fa2190 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -486,6 +486,7 @@ config CC_HAVE_STACKPROTECTOR_TLS
>>>
>>>  config STACKPROTECTOR_PER_TASK
>>>      def_bool y
>>> +    depends on !GCC_PLUGIN_RANDSTRUCT
>>>      depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
>>>
>>>  config PHYS_RAM_BASE_FIXED
>>
>> Thanks, this is on fixes.  I do an allmodconfig build and haven't seen
>> these failures, is there something special I need to do to get this
>> working?  I know nothing about GCC plugins...
> 
> Sorry, looks like I screwed something up and I didn't actually merge this onto fixes.  Not sure what happened, but this time it should actually be on fixes.

Ah, I thought you decided not to apply it for some reason. I changed
my test scripts to always disable GCC_PLUGIN_RANDSTRUCT for riscv
build tests and stopped reporting the problem. I mentioned this
a couple of weeks ago in my test reports. Just in case you wondered.

Guenter
