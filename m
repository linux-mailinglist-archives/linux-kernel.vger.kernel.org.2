Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C036373071
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhEDTMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhEDTMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:12:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D05C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:11:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b15so8990419pfl.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TxzHRwKZbDTKhAa3rqkFK95SxSm1x12WqGIcE5Es6j4=;
        b=AFowgdU/OmbKbthBcKzRkr7Y5AT78+GPyr1ojZ6S//j2d0LhJwRPyFipq4OnJPXA31
         JeZhy6Y+9i8KtY5CAN+rWgw/VqGDruzdEsEoJ7pS+Uor11OL2HFIlbFKLeqP2ltwvE8R
         RYuDwduyL+BQXtaXUWttDjQtueH2mbSfaHgpaFLVX4R1k6YaZmPm06w0KqJqpZdXmyKr
         YVXEAjmwq8yAUEcgZ9aB++GswYH+79ZBdpz5eDPWKgE5SRDelgoMn47a+6oS3ka4anC5
         Y46lOpAz0ztEwzucbXqJbdo/KNtP7CvbHQYVW7VlMrgGqrAnHFLkp4jFhd+vS9PbOLOW
         Qhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TxzHRwKZbDTKhAa3rqkFK95SxSm1x12WqGIcE5Es6j4=;
        b=A6Brfxu+YRIry1nfE2EUHbW4qlDt1HofOjYjMAJnIv5EXlL5T2Fa19K9xLO+yAny2q
         ZiWglI5Y8aAWsbkIMth1AYEyGqbFDE4OWs2DfrYr0zNbun4XoW/oK86kjCMqxwkC9yL8
         S7natMQ06pW9SmA6uo738P99v9PFGFzocjJBz6y1F9Www62E3KrLYTtt95rSAxhFQ9mg
         HUTAIcrQcf0VytMpoN6B2ZmRAa87B/ZCdIZZV4hb01rRUtzyTGEU1kUWxSwhD1GY0awy
         49ABukoBLsng5oev11mFcUAdyiHqZxmg6Y4ZtCSaXis1IcBUEljUClPYBMC7SBfGnTWh
         y7BQ==
X-Gm-Message-State: AOAM530ZW20Rc0lg7sQN5hkzkxXux+xhFfu9ryE5XRhHU33SyGvqFkN3
        10JvhyPl4uxI5IrQRBMVxDv4LeYwp4w=
X-Google-Smtp-Source: ABdhPJwesoeSKj4IzrFaOZdUqefGTqzsYZhBL0PG4+uoscVLKtLuvnTlt8c7QlURYqfUFwALg//c1Q==
X-Received: by 2002:a17:90a:d24a:: with SMTP id o10mr6848029pjw.138.1620155464463;
        Tue, 04 May 2021 12:11:04 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i126sm12638288pfc.20.2021.05.04.12.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 12:11:03 -0700 (PDT)
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
 <b26651f2-a5ca-ff5d-23e4-05b7eb7d9583@gmail.com>
 <20210419223448.vummlz37nyc3a64i@e107158-lin.cambridge.arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <761c79cf-8709-6da6-cdb7-9e03e25f0272@gmail.com>
Date:   Tue, 4 May 2021 12:11:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210419223448.vummlz37nyc3a64i@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 3:34 PM, Qais Yousef wrote:
> On 04/19/21 14:54, Florian Fainelli wrote:
>>
>>
>> On 4/12/2021 4:08 AM, Qais Yousef wrote:
>>> Hi Alexander
>>>
>>> Fixing Ard's email as the Linaro one keeps bouncing back. Please fix that in
>>> your future postings.
>>>
>>> On 04/12/21 08:28, Alexander Sverdlin wrote:
>>>> Hi!
>>>>
>>>> On 09/04/2021 17:33, Qais Yousef wrote:
>>>>> I still think the ifdefery in patch 3 is ugly. Any reason my suggestion didn't
>>>>> work out for you? I struggle to see how this is better and why it was hard to
>>>>> incorporate my suggestion.
>>>>>
>>>>> For example
>>>>>
>>>>> 	-       old = ftrace_call_replace(ip, adjust_address(rec, addr));
>>>>> 	+#ifdef CONFIG_ARM_MODULE_PLTS
>>>>> 	+       /* mod is only supplied during module loading */
>>>>> 	+       if (!mod)
>>>>> 	+               mod = rec->arch.mod;
>>>>> 	+       else
>>>>> 	+               rec->arch.mod = mod;
>>>>> 	+#endif
>>>>> 	+
>>>>> 	+       old = ftrace_call_replace(ip, aaddr,
>>>>> 	+                                 !IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || !mod);
>>>>> 	+#ifdef CONFIG_ARM_MODULE_PLTS
>>>>> 	+       if (!old && mod) {
>>>>> 	+               aaddr = get_module_plt(mod, ip, aaddr);
>>>>> 	+               old = ftrace_call_replace(ip, aaddr, true);
>>>>> 	+       }
>>>>> 	+#endif
>>>>> 	+
>>>>>
>>>>> There's an ifdef, followed by a code that embeds
>>>>> !IS_ENABLED(CONFIG_ARM_MODULE_PLTS) followed by another ifdef :-/
>>>>
>>>> No, it's actually two small ifdefed blocks added before and after an original call,
>>>> which parameters have been modified as well. The issue with arch.mod was explained
>>>> by Steven Rostedt, maybe you've missed his email.
>>>
>>> If you're referring to arch.mod having to be protected by the ifdef I did
>>> address that. Please look at my patch.
>>>
>>> My comment here refers to the ugliness of this ifdefery. Introducing 2 simple
>>> wrapper functions would address that as I've demonstrated in my
>>> suggestion/patch.
>>
>> What is the plan to move forward with this patch series, should v8 be
>> submitted into RMK's patch tracker and improved upon from there, or do
>> you feel like your suggestion needs to be addressed right away?
> 
> There's no objection from my side to submitting this and improve later.

OK, thanks! Alexander, do you mind sending these patches to RMK's patch
tracker: https://www.armlinux.org.uk/developer/patches/?

Thank you!
-- 
Florian
