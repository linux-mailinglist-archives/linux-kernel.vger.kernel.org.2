Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD07A436192
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhJUM1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:27:50 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38542
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230231AbhJUM1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:27:49 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0D638402CE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634819133;
        bh=OEvgfMSIzLFlHfTd+aj6jAI5gittIjBiCSXpIdeWxOQ=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=QdcMk4Jj1Cp/tQU67s3GhkmBC1/xhsmui+sH8BAezONB8rB2lfhIdEfqspxEQhirS
         sqoD7o/X7WDgMamjKO9WrrBhUCwIlDPKZiSqMEyYpdpjf3RrquP+dAJzNGseSMLFC/
         CDw13dFbHT9K/FpGrtMItVAfX6XPWwT6QQgyo5nLu/z2J/lYc2gF9cljWmPEZLzsYq
         p1Yh/x0cUzx3w06y1hhWCjM+hA9LZ1+e1aJ2OrXO1j8eDLbmuoK/fTMwnQZKbc9TnV
         zFFF1LoJLeBQ+QDXInXb8jhiZrQxxVZWfW1s1+dzjW9bETkih7TI0oy4FreQc5L/Ki
         Sbkx3qvw56Y/w==
Received: by mail-lf1-f70.google.com with SMTP id p19-20020a056512139300b003ff6dfea137so219554lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OEvgfMSIzLFlHfTd+aj6jAI5gittIjBiCSXpIdeWxOQ=;
        b=psBvgFsymosDOt4l0DIJPOK93Jrfrk3p4MsnFFxq6li+1TRIdbmCRfrcXUUbSkwNSr
         JsgWqNh0rjOvPw1Fr/CsgW5LQCUONMyJmW8/sfKNaMIcnw6/wpm96MWOFUio1a9ETvNq
         GjJWZ+Tz4QKa89l5cMEBNUsDCn/VhRwEAqnWQZlQ6sCqrNt/MgCp8xHB22Rc5XvVhHPX
         d8uTcDO2ccNqWIDf7p4MML/8InAqyd/RS6BvhPGUh5PTDfiOZ08dpTMG1fuTd4caZ4uH
         5A8ZwaMYmrHK1ljv7ZhdvIY0x2CpuNAKGAN4KJpmbJ7jgYsro5X3XE9M7R0ueZm9Y2Op
         Dgqg==
X-Gm-Message-State: AOAM531x24evAZLNcX8RdDEQJp+XvnWaI5pybxqAKvoNvLSkNJBFX/BW
        84xWrq18o2CO8CvwzoBHjpoC+vM20RygH2tMd7RW8IWKpftsNIqygKJylm4CXFIp91B7M3uGZH4
        TQQ+zGBP0+ojy7q6sHFlSLFPl21lthNrA4dHNhRjLdg==
X-Received: by 2002:a05:651c:230e:: with SMTP id bi14mr5404511ljb.467.1634819132271;
        Thu, 21 Oct 2021 05:25:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0/8NcGHTrSWS0H6+LXQbRBX3Abg2xVQ13rASma1FIwjNQK3yxWARDRCPBIvJmD3bqslQp8Q==
X-Received: by 2002:a05:651c:230e:: with SMTP id bi14mr5404491ljb.467.1634819132086;
        Thu, 21 Oct 2021 05:25:32 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o15sm537797ljm.139.2021.10.21.05.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 05:25:31 -0700 (PDT)
Subject: Re: [GIT PULL] riscv: dts: few cleanups for v5.16
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20211021090955.115005-1-krzysztof.kozlowski@canonical.com>
 <CAK8P3a08QiwA4+zPGLt3xA=01HLiBcLcC4gM1+8N6uo5KMTQLw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <4f9141f6-a35f-e412-7a9e-a00a7c8376b2@canonical.com>
Date:   Thu, 21 Oct 2021 14:25:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a08QiwA4+zPGLt3xA=01HLiBcLcC4gM1+8N6uo5KMTQLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2021 14:23, Arnd Bergmann wrote:
> On Thu, Oct 21, 2021 at 11:09 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> Hi Arnd and Olof,
>>
>> I have an old patchset for RISC-V dts cleanups which I sent to mailing lists in
>> August 2021 (v1, v2), resent in September and pinged two times.  They got some
>> review (from Alexandre Ghiti for SiFive, from Conor Dooley for Microchip) but
>> unfortunately Palmer (RISC-V maintainer) did not respond here.
>>
>> The usual RISC-V patches go via Palmer to Linus and I am not planning to change
>> that, but I want to get these fixed.
>>
>> Could you grab these to soc tree?
> 
> Sure, I can add them to a separate branch in the soc tree, in case the
> riscv maintainers
> take them after all. I notice that you have only Cc'd Palmer, but not
> the other two
> maintainers or the RISC-V mainling list. Adding them here to maybe get their
> attention.

Yes, my bad. Thanks for cc-ing them.


Best regards,
Krzysztof
