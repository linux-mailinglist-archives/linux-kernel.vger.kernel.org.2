Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA07437413
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhJVI6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:58:03 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44412
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231563AbhJVI6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:58:02 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2DFA440002
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634892944;
        bh=Ti/kWwWZCiPv4gL/LdQf6/gYsg4XXLTy9z9bRwDkCkI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Ud51/VuF9FIiD5QY85htXxUaQGKCM3qfBudQ67SsLhtcSyM4xF867DGSnaGwX4JdX
         1qn3VB+duEjAZiaavuL7luAcJa5rI3VQrv63Rphg5H7zoGENPqxe7l/hmcZjrqBNP2
         L+evpbUrA5sewuezcfylXtTO9/3dFCCPv936Bkcus9TpTtD/U6Zwgtkc89xHWCreAt
         N0ew9QtA4OlgVFR1ayxNIRzPk2r58FMA/VdLFlwEVnpI9p9CAE7/fCK2fSGx6yBBiM
         drVY+mygWbSAxbwB35xw5izW/JB8BBtaJyWyWNF8WyM0VBG+jZwj/r/CrPdMEcU4Yt
         WJQdFjFAYyGLA==
Received: by mail-lj1-f199.google.com with SMTP id o4-20020a2ebd84000000b00210ae894d18so1067900ljq.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ti/kWwWZCiPv4gL/LdQf6/gYsg4XXLTy9z9bRwDkCkI=;
        b=09fYZYIxPbRuAoPbCLHhOtEYJu4CKWU5FFX3yMc4zvnTgl0AuCwc9OOQWLXxUYqItd
         tBQFwSSbr8WlFjJny1hFq7lYCj+dUyIyYLW6aTD3xO6UdyPAlEGOUZFGJVejQ3yiQPX+
         kvxu9qWaO5o5wDQdhz9NaS4jfKjDaJyoT0UJoSJShDdfvd9Qv8wIGCMxCnjj3F4R9mJM
         QMeVUOlMqCABXCsK5ZyrYLdbOCiz16Sm+FT0epGdI++HWVnTXdrLfloMxaejZHZYdBIS
         jVAuQuhlYhQ4cdimuhaTP3n/WWlynkZ8Cp9qiO1+/X3fh+Z/92CoRtjh2Qj6GEPA+3gg
         ZPag==
X-Gm-Message-State: AOAM530OfcZO5jcOf0ztAJ6wiS9LOGl0CdCCS4pZci448u6hooRfEeBc
        7JI0HshH1pIhtqj6N31eCJYHi1OIDirfY23ZoQKY3Gfwup67Agk99LwhIUXQIgslcpPnV8WED/w
        7mkV13KGwoUMnTYQxAMrL2QLCqcAYZ2+9U6trVZQwDw==
X-Received: by 2002:a19:fc01:: with SMTP id a1mr10557864lfi.214.1634892943603;
        Fri, 22 Oct 2021 01:55:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym9KlsLquE+h9zu7V/QcUc3Crv0sHVj601Gyg6l+LuiW0HZGNuwzkArQkA5Em8fi4+NvG4SA==
X-Received: by 2002:a19:fc01:: with SMTP id a1mr10557848lfi.214.1634892943456;
        Fri, 22 Oct 2021 01:55:43 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id x4sm674150lfq.246.2021.10.22.01.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 01:55:43 -0700 (PDT)
Subject: Re: [GIT PULL] riscv: dts: few cleanups for v5.16
To:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Conor.Dooley@microchip.com, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
References: <mhng-0efa2067-b731-4121-9725-e40954222d89@palmerdabbelt-glaptop>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <accf35b6-2c13-227b-c101-a36cdcd5e73d@canonical.com>
Date:   Fri, 22 Oct 2021 10:55:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <mhng-0efa2067-b731-4121-9725-e40954222d89@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2021 17:35, Palmer Dabbelt wrote:
> On Thu, 21 Oct 2021 08:18:16 PDT (-0700), Arnd Bergmann wrote:
>> On Thu, Oct 21, 2021 at 5:06 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>> On Thu, 21 Oct 2021 06:09:50 PDT (-0700), krzysztof.kozlowski@canonical.com wrote:
>>>>
>>>> There is only one Microchip patch here (plic/clint). Others are for
>>>> SiFive. All the patches are described in the pull reqeust:
>>>> https://lore.kernel.org/lkml/20211021090955.115005-1-krzysztof.kozlowski@canonical.com/
>>>>
>>>> I had also second set of RISC-V patches for Microchip. These were picked
>>>> up by Palmer:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=for-next
>>>
>>> Sorry I missed this.  If you guys took this through the SOC tree that's
>>> fine, otherwise LMK and I'll put it in the RISC-V tree.
>>
>> I haven't merged it yet, please add it to your tree then.
> 
> OK, it's in.  Sorry for missing this, IRC is always a good bet for these 
> sorts of things as my inbox can get pretty hosed.

Great, thanks!

Best regards,
Krzysztof
