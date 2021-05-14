Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4B4381381
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 00:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhENWJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 18:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbhENWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 18:09:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41E6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 15:07:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i17so562646wrq.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DhuPFApLGOtvh1kz8ikn2yTKqWGR5Z4X25H+F0j0ysw=;
        b=QUIr/6fwIO2tErTJyLKCczmSQubH7RAlO9UZ3PV/iWRhj6D+5l4SdAQAePaWZRwPBw
         /sVFAXS6NzUVyP3ZMq5RbyFCU1NNddhZajQX69lhPAnPRXTo7PCrEkcU+14Dng+L6jKg
         eP2rP7YMV9vB7I/6ps+F4SJXFxM6aLCVGC+z3Zw7By+nkC5hIE3ZN1GiDntoIKaKNBrg
         vW15eGBXuhUM2ShIlyKqBkWC1r+QCMIvQ1BsCvIf53DozDQo/7/HsmHd0FlLjdP2jwnD
         HLyb3e3T79hsVWfNodQB2YfJgWy30i0fhD6nl/wu/SIHSDGZRvlBB59qScHA9iT9xJEi
         5Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DhuPFApLGOtvh1kz8ikn2yTKqWGR5Z4X25H+F0j0ysw=;
        b=ZBAQCucojllft/QARqrtg8EVmsv5Zf061bTyEckTm7MIsFOjTnuwO0faxKtkllBukI
         PiLlF8d5l9Ww2WNPpxLujrJ7zTPW3Dz/TrAiKtX/tcDhzrjqJLm7wo0cwcbmnL/ijJOB
         fWJTdoxGG4k6Q1lmSi6WUtJrkRbaAHoQ3sk7oCFsOHVUzq3KqoBmNfSmFue+9KsyxTyC
         o/NOsrIGD02fRY/HDEXcpNa/BtX3Pl8RkGJn4/Is/ClIH9XrysjIZSHP4dwfRULWkJca
         uD2vpCBgaZ0yYxxta2ce2yY3ZL96i+IoVnRmVnxcBprK9oVBMzG0XxX8dZBOPHZrOwK6
         j2yQ==
X-Gm-Message-State: AOAM531YC1i7YBGIPROHzN7gYvlofCb/T1vIqk+aEPUY9qoQ4icriYGb
        zMR1dtShFyULYNFkbofwZys=
X-Google-Smtp-Source: ABdhPJwRNV+9ikTcMrSJc6TO+MRSwgto7RenISgLBS0zY5UQ7LW313EUylp8AComiO5tYDvn1ffNqA==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr62145933wrt.164.1621030077038;
        Fri, 14 May 2021 15:07:57 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a369.dip0.t-ipconnect.de. [217.229.163.105])
        by smtp.gmail.com with ESMTPSA id p10sm7282820wrr.58.2021.05.14.15.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 15:07:56 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator: shut up clang
 -Wconstantn-conversion warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210514140556.3492544-1-arnd@kernel.org>
 <219848ed-e0ce-634a-29c2-caca813b054c@gmail.com>
 <42f70914-e46c-20b9-6b13-8e8d855112a9@redhat.com>
 <29d069f2-a1c8-eb43-02ec-69c86b3cb107@redhat.com>
 <CAK8P3a2J=rv6HW1SiTS1R89CZFDe1-bxn+7qRFO2f3trDk0EuQ@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <c47ed6bb-33ff-0a5f-74fd-65d3383467ef@gmail.com>
Date:   Sat, 15 May 2021 00:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2J=rv6HW1SiTS1R89CZFDe1-bxn+7qRFO2f3trDk0EuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 10:04 PM, Arnd Bergmann wrote:
> On Fri, May 14, 2021 at 9:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> I just went to patchwork to drop this patch from the queue:
>>
>> https://patchwork.kernel.org/projecat/platform-driver-x86/list/
>>
>> But it never got added there because platform-driver-x86@vger.kernel.org
>> was missing from the Cc even though get_maintainer.pl lists it.
> 
> I checked this as well now: the entries for the various surface drivers all
> contain a reference to platform-driver-x86@vger.kernel.org, but (at least
> in v5.13-rc1) the entry for that subsystem that lists the include file
> does not list this email.

Right, I must have forgotten to add that, sorry. I'll send in a patch to
fix that in a second.

Regards,
Max
