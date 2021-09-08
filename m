Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D540C403D9D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbhIHQfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhIHQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:35:19 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AADDC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 09:34:12 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso3694988ott.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PEH8WKYvFMU21oKJ95EnqmpYBea+F8R4xSX9djSHkyM=;
        b=TSkO9D2L/NC7hTy1z2Kz92K3d0OmmHRmnAz0SL47POwjsrbLhz5giS4VAhgkcr85Ki
         2kAjXNMIq2WqQYSMboFKhLZxr3Sb1r0HIEN+Zhr/ecIstROrDw664zq5bIdeaLtzLW2b
         hC15n+nlN7b628N6Us/GxktUuZnW2yie4b8sFQlQzzj63+1ExqeDHDCN948QfGe9yeXH
         cdgxX+S6TJAp010S962vnrTuxQP5qhOy+skpGgWCPPwFWAuE6eyUfcYijKTAg9/FkxKl
         IdWSUY2xhBjjwKaBOkJrm2YdM5umz/yH+0CVXyLxPmzWgiBlDz9yjkq494rp0shvuaAJ
         Qhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PEH8WKYvFMU21oKJ95EnqmpYBea+F8R4xSX9djSHkyM=;
        b=Q2o1emnEr48Uql33E/WUcnGdAMrI8dD+XRG1L1BcSHwcNCt7m4XGVOIiDBQ/nLn11Z
         Ry/0Dr62pRY0/1uM4qqulqeChnM9LR4LNgatVxpJtm2UBXDQhIuG0fVdHznbqd9Skayf
         4iEqCBgAnMEZT/BmKsEc7QANDaBML6J3KnoxxLUiDJ8tW40YMn8CKt2TAB6bhevtPSk4
         vpBl1Z/JW8azTd0l3Z7zAZpaup2CunjkZIKCcqRmkPFVoWFy8so9DQJkwQWAxhT7S0k3
         Dm81byViBNsVovQaAP4EQDETWskAUgN1VdtTVpAbwJODppU5HQIRbkJWXp6N2+Jc81CN
         v3lg==
X-Gm-Message-State: AOAM532q05OPtCkVtMg9HvQvNM9riCXqUa62rsvPNkWwEXYbMUUl4mps
        w+um/f0zpUTlAsXPloTDuimrRo7wTSQ=
X-Google-Smtp-Source: ABdhPJxsF9+xmq80xFZXfBaOy7W9TErXblki0axlk5IN0LqFEOERF4RHcnUSQEMhCuBrE5fMpE+7xQ==
X-Received: by 2002:a05:6830:88:: with SMTP id a8mr3813759oto.233.1631118851484;
        Wed, 08 Sep 2021 09:34:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3sm554652otu.7.2021.09.08.09.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 09:34:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] trace/osnoise: Do not use 'main' as variable name
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20210908151407.217052-1-linux@roeck-us.net>
 <20210908115350.555941ba@oasis.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0e88250a-21ac-800b-e6e4-eb7dc459b04e@roeck-us.net>
Date:   Wed, 8 Sep 2021 09:34:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908115350.555941ba@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 8:53 AM, Steven Rostedt wrote:
> On Wed,  8 Sep 2021 08:14:07 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> gcc 11.x may get a hiccup when encountering 'main' as variable name.
>>
>> kernel/trace/trace_osnoise.c: In function 'start_kthread':
>> kernel/trace/trace_osnoise.c:1515:8: error: 'main' is usually a function
>>
>> Use a different variable name to silence it.
> 
> Egad, no. NACK! Double NACK. Linus already NACK'd this.
> 
> (although it's ironic that he also added -Werror as the default :-/ )
> 
> The bug in is in gcc, go send them a patch.
> 
> THERE IS NO ISSUE WITH HAVING A LOCAL VARIABLE NAMED "main"!!!!
> 
> This has already been discussed:
> 
>    https://lore.kernel.org/all/CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com/
> 
> For now, the workaround is this patch:
> 
>     https://lore.kernel.org/all/20210813224131.25803-1-rdunlap@infradead.org/
> 

No problem. Sorry, I didn't find the other patch.

FWIW, it wasn't gcc 11.x, it was gcc 8.1, which is the only gcc version
that I can get to compile nds32 images (more recent versions either fail
to compile gcc, or fail to build the kernel with assembler errors).
I'll just stop build testing nds32:allmodconfig instead.

Guenter
