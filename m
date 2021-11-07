Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3504B447533
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhKGTQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhKGTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636312435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2xydIVeJafL6b2NZjidflcc0qAgl05KhXAKdXRMYctY=;
        b=PtLG+E0xl1z6jhkrM/evNbPcz//a1CSIwWTPfi0cp/F4fv/Nk680Flr8bh++Y5vI9HgFYY
        S0gt88qmRc0AlBIiH1wtyf4FtBniDH61lYHdU8Z4u2lp39atQTWAvIM7+T8E5ooQpmFk9j
        1x+NoEN597zhVxKFYaX1GO8N1dFTRvA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-SHlLvelVPBWjA8bQ9KeMvg-1; Sun, 07 Nov 2021 14:13:54 -0500
X-MC-Unique: SHlLvelVPBWjA8bQ9KeMvg-1
Received: by mail-ed1-f69.google.com with SMTP id t20-20020a056402525400b003e2ad6b5ee7so13056347edd.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 11:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2xydIVeJafL6b2NZjidflcc0qAgl05KhXAKdXRMYctY=;
        b=fbpjsZ+3c6TR/xTgFpVTZHqkU7KZYw1WUD2i0jc9HbP7yajXDRmeZVHpScFNMNz0TH
         q+N5pbcpWYzzBOdC1aeQyTaKoYO+HpRvkVQ23bVmGB8EDKoFP3qSzAb19wexmOb0wHwi
         p7BU/ziky7qc7zrqw83pt8AJlPw1G3DcYoz+6xrKPkMTcXHQePNfasCS+y79gbHo4Cm5
         5/k/H9YYRsJwJ6O7sfpQvuzpLyB/GwmbNCSFSGihWoG1VRVr7X4r2RIdlSvDyQkteMtg
         ltPB89UbDjkK04nObdKIFabO3Rc92sbqSeCjf9UPRw09/xJpADILT7n81jcqvJo9FS1O
         cYkw==
X-Gm-Message-State: AOAM533GfqRVrfKYwOxC+kyS5IrMYlIvdqJuwP0vO/rB0zvK/TXbfJIv
        MiYsonMSLkq3f68gCa7LzJgXt94S1UUafAfTEuunRRrZs8C4j9UBqAQNFB/EGmEkj2lL+Z0iNlH
        FTM0ihjIU/AOuKogdREo6hbnC
X-Received: by 2002:a50:d88a:: with SMTP id p10mr99391136edj.274.1636312433333;
        Sun, 07 Nov 2021 11:13:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbp/i3XO1pNe15eDfkCR7zsnte1jFVTcbwIa10SAWQlJdL4ssgkAPt8T7le564ixhskSzD7g==
X-Received: by 2002:a50:d88a:: with SMTP id p10mr99391098edj.274.1636312433099;
        Sun, 07 Nov 2021 11:13:53 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id hb36sm4618309ejc.73.2021.11.07.11.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 11:13:52 -0800 (PST)
Message-ID: <ac250f46-84cb-d4cf-8a75-c9a0354ddad1@redhat.com>
Date:   Sun, 7 Nov 2021 20:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC][PATCH 15/22] x86,vmx: Remove .fixup usage
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, mbenes@suse.cz
References: <20211104164729.226550532@infradead.org>
 <20211104165525.408049586@infradead.org> <YYV1UeFeWUtnQ4jV@google.com>
 <18358428-e0cd-d329-7558-6eb548b3fc53@redhat.com>
 <20211106083646.GT174703@worktop.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211106083646.GT174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/21 09:36, Peter Zijlstra wrote:
>> Ouch, good catch.  It should be actually very simple to fix it, just mark
>> "value" as an "early clobber" output:
>>
>>        : ASM_CALL_CONSTRAINT, "=&r"(value) : "r"(field) : "cc");
>>
>> That's an output which is written before the instruction is finished using
>> the input operands.  The manual even says "this operand may not lie in a
>> register that is read by the instruction or as part of any memory address",
>> which is exactly what you caught with %1 and %2 both being the same GPR.
> Yes, but as Sean points out, that will negatively affect code-gen on the
> happy path. But perhaps that's acceptable if we add the asm-goto-output
> variant?

I think it's acceptable even without the #ifdef.  Forcing registers 
using the a/b/c/d/S/D constraints takes away some freedom from the 
compiler, but using two "r" registers is going to give as good assembly 
as anything else.  Most callers of __vmcs_readl call it either at the 
beginning or at the end of a function, where there aren't many live 
registers anyway.

Paolo

