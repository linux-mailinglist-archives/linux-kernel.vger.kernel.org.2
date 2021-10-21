Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E4543626E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhJUNMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:12:10 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40396
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230508AbhJUNMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:12:09 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7CBE0405F9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634821792;
        bh=LsLSwWX/aooK7LR05wvQfGIlyo9Xtj71zHzTzlar0ms=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=riCC7N2MSJijx1PIF6W6itwzUVeQ0MgjKrWvDl085SnwFcTEuzkt2nKmduvMqcmNi
         Cexiza3MFRCWBwtU8cptvoJzCzlK7Tw4ckJkfzyhQF6MxiEPuwT8racj37NDgmUKDW
         ZCwByheydvb5J1FHFGhNgn3lsZg6Mj0j3cJJdN8sMoZiIUJYA8TpRN2gLPmjZ9aX4H
         qaA3BF7xrpgQPxr3KsP5viUYpMv0jxpZd7dZ9o2oXIduhzAg+l7vkWrAE2kw6eGbsF
         zQMpO4nQQGMsRetmGScETJZuQq4raroAd5rz4i0ESu9XYeMlpiYjhpM0Sy/vUdsM96
         Vxc7Srfo8o9sQ==
Received: by mail-lf1-f72.google.com with SMTP id f17-20020a0565123b1100b003fda40b659aso302391lfv.23
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LsLSwWX/aooK7LR05wvQfGIlyo9Xtj71zHzTzlar0ms=;
        b=0pS/2lgMejSzUVst8VEY+MQdr/hoaL+lrNsOoOn9dplsGrMVV74HJCkImIzjb9RLOm
         KW31cRso5f7zXL2fsZnZaYcR/tDNnqY+8ZYZ8HgHkzH1ZEuwczZR2lP2fjb9Gh/50iK8
         fWylRSdXYCyNUfT+KSM7l0OWSM5Qh3EG/54WRiCIk8YBKMnVCcCoGtSXCcwmpCnyV0xP
         AVrg0qphIbzPkVUw402iDPcW/M4DKqqvi7D6L/pzWizlE+QwRsUExaC6myjt1U+3mPxc
         vK89A4FlNlXToCnJpS/rBKByHXZgRwFYiPefErzJYwqTywpEbYVSkwZPzuylUosHFRT6
         CPyA==
X-Gm-Message-State: AOAM533od8hfem60GE0k8jHjF1qE7zw7aAKsltQ19LvH6dr5nTo9jDdR
        cvhZm5E0liyTsjaEY8M36pjo+eqybbe1OiKveSKm8Omk0HWgBBlKiqeLGeQ5YJg7rsnOo2VWMmH
        DwQ0ILDWIwTvwVraHKYJIQINPB7RHohn6f5CJLj42Tg==
X-Received: by 2002:a05:6512:20ce:: with SMTP id u14mr5618475lfr.548.1634821791885;
        Thu, 21 Oct 2021 06:09:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Q8yU5QzJPLw3kvAdO+Jn8XVXoKvjIRiitatn+3XEGA9u7UY2LAfxyxt0u2Zf+taROiCpGQ==
X-Received: by 2002:a05:6512:20ce:: with SMTP id u14mr5618453lfr.548.1634821791675;
        Thu, 21 Oct 2021 06:09:51 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id r10sm539546ljp.56.2021.10.21.06.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 06:09:51 -0700 (PDT)
Subject: Re: [GIT PULL] riscv: dts: few cleanups for v5.16
To:     Conor.Dooley@microchip.com, arnd@arndb.de
Cc:     olof@lixom.net, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
References: <20211021090955.115005-1-krzysztof.kozlowski@canonical.com>
 <CAK8P3a08QiwA4+zPGLt3xA=01HLiBcLcC4gM1+8N6uo5KMTQLw@mail.gmail.com>
 <10f5244d-ba2a-33eb-72dc-77b2a7a0d101@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <4a27b400-4fb1-bb7a-335a-ae1d084cdf73@canonical.com>
Date:   Thu, 21 Oct 2021 15:09:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <10f5244d-ba2a-33eb-72dc-77b2a7a0d101@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2021 15:06, Conor.Dooley@microchip.com wrote:
> On 21/10/2021 13:23, Arnd Bergmann wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Thu, Oct 21, 2021 at 11:09 AM Krzysztof Kozlowski
>> <krzysztof.kozlowski@canonical.com> wrote:
>>> Hi Arnd and Olof,
>>>
>>> I have an old patchset for RISC-V dts cleanups which I sent to mailing lists in
>>> August 2021 (v1, v2), resent in September and pinged two times.  They got some
>>> review (from Alexandre Ghiti for SiFive, from Conor Dooley for Microchip) but
>>> unfortunately Palmer (RISC-V maintainer) did not respond here.
> 
> Out of curiosity which series is this one? Is it the one with the 
> plic/clint changes?
> Pretty sure that I have taken them in internally, but I am going to 
> submit a bunch
> of changes to our device tree soon (tm) and want to make sure I have the 
> right
> dependent series listed.
> 

There is only one Microchip patch here (plic/clint). Others are for
SiFive. All the patches are described in the pull reqeust:
https://lore.kernel.org/lkml/20211021090955.115005-1-krzysztof.kozlowski@canonical.com/

I had also second set of RISC-V patches for Microchip. These were picked
up by Palmer:
https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=for-next


Best regards,
Krzysztof
