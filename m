Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70C6364D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbhDSVzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhDSVzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:55:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D61CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 14:54:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lr7so2571177pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CWOqGghR0h61qz/kVunXFp7MUYbH9+eK+tLItI6o1wU=;
        b=vH/Bq3V2p2DxhvHBBcgQUSRJcF4X8rvfAT56irbWhrYYpoOt5b3tJzqHmi+vnBuPMQ
         qtothPcq/56mLrLfs5n9tMlRbcVdM4K1ttVMQbiltX67Qru9g0PGqb04F8YMImSvz6qj
         xD6aLJ81uqWqSKmgs3vKRZq81/iCLHbU6LhTZSpvIK3trac3y4XJE5s/sBVCEiuEhN/X
         jkb1O8rY7vQzpLX5SljJu+pvgArJxn8CzWksFJKNslTXnEmx4i3fjVAkzv3GRzaws8YS
         lvc5yNAu3h3icn1/1xL/2dcxhmZ7/lPCcNQThccJodojvOU4xDP9c5AQqUYtuTYeslOz
         PXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CWOqGghR0h61qz/kVunXFp7MUYbH9+eK+tLItI6o1wU=;
        b=Blvud44ZcEsFkTGaQsJPjrnQHbVO/ncthA5eHxxaC/5ErKIFvHHf5j/dbprYJW96HG
         fwc0df3q1cynMXWOahDV2Gxkh95MWFK3YWahuqUMAIKR6ItZUtcCsb7BF1SY5mQWKjf5
         jcBbQRbFJLhrc3ICq6Mw66syVgpduolhsNK1EmJ23ZncH2J+//EaNY1zVPvgF1jMupiV
         LHev4Ch5DXJ6pOyzLU/OtTgFdRS1cXmaNBg3Q0HAXeOs9F2h7BGggGAeVmOsNQL8jXW/
         GMGi18wF/GC5HvSHSfSzpC9ABQx2eeSgVmQdb4cZFQ9SuBN7SrKrGSzTLqTYGKxiGcYQ
         An9g==
X-Gm-Message-State: AOAM5311Pqtsrhzps8zYhLjS1uoWFR/vNl8FstgnNM9qLGaQ11rOkGw9
        kYFqjndzIvY7ZlsPOFUKjdQ=
X-Google-Smtp-Source: ABdhPJxfFnARh7c1u3Pi25K4eDfTImEB8Bv449HC7U4FSuUrOWNI8b2R9wo6HOckafJSSM2faCpbQg==
X-Received: by 2002:a17:90b:1183:: with SMTP id gk3mr1246371pjb.172.1618869273057;
        Mon, 19 Apr 2021 14:54:33 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id nv7sm371725pjb.18.2021.04.19.14.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 14:54:32 -0700 (PDT)
Subject: Re: [PATCH v8 0/3] ARM: Implement MODULE_PLT support in FTRACE
To:     Qais Yousef <qais.yousef@arm.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
 <20210409153309.wbebto3eufui35qs@e107158-lin>
 <be48adb2-c838-1a9b-37bc-da783f3d5dd3@nokia.com>
 <20210412110810.t7pqkwawn5zmqbca@e107158-lin.cambridge.arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b26651f2-a5ca-ff5d-23e4-05b7eb7d9583@gmail.com>
Date:   Mon, 19 Apr 2021 14:54:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210412110810.t7pqkwawn5zmqbca@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2021 4:08 AM, Qais Yousef wrote:
> Hi Alexander
> 
> Fixing Ard's email as the Linaro one keeps bouncing back. Please fix that in
> your future postings.
> 
> On 04/12/21 08:28, Alexander Sverdlin wrote:
>> Hi!
>>
>> On 09/04/2021 17:33, Qais Yousef wrote:
>>> I still think the ifdefery in patch 3 is ugly. Any reason my suggestion didn't
>>> work out for you? I struggle to see how this is better and why it was hard to
>>> incorporate my suggestion.
>>>
>>> For example
>>>
>>> 	-       old = ftrace_call_replace(ip, adjust_address(rec, addr));
>>> 	+#ifdef CONFIG_ARM_MODULE_PLTS
>>> 	+       /* mod is only supplied during module loading */
>>> 	+       if (!mod)
>>> 	+               mod = rec->arch.mod;
>>> 	+       else
>>> 	+               rec->arch.mod = mod;
>>> 	+#endif
>>> 	+
>>> 	+       old = ftrace_call_replace(ip, aaddr,
>>> 	+                                 !IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || !mod);
>>> 	+#ifdef CONFIG_ARM_MODULE_PLTS
>>> 	+       if (!old && mod) {
>>> 	+               aaddr = get_module_plt(mod, ip, aaddr);
>>> 	+               old = ftrace_call_replace(ip, aaddr, true);
>>> 	+       }
>>> 	+#endif
>>> 	+
>>>
>>> There's an ifdef, followed by a code that embeds
>>> !IS_ENABLED(CONFIG_ARM_MODULE_PLTS) followed by another ifdef :-/
>>
>> No, it's actually two small ifdefed blocks added before and after an original call,
>> which parameters have been modified as well. The issue with arch.mod was explained
>> by Steven Rostedt, maybe you've missed his email.
> 
> If you're referring to arch.mod having to be protected by the ifdef I did
> address that. Please look at my patch.
> 
> My comment here refers to the ugliness of this ifdefery. Introducing 2 simple
> wrapper functions would address that as I've demonstrated in my
> suggestion/patch.

What is the plan to move forward with this patch series, should v8 be
submitted into RMK's patch tracker and improved upon from there, or do
you feel like your suggestion needs to be addressed right away?
-- 
Florian
