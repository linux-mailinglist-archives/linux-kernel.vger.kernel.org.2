Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E62446FCE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 19:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhKFSWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 14:22:52 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52524
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230089AbhKFSWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 14:22:50 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B2FC24000F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636222807;
        bh=WIA6znI9FNppQXsU/4zd04Ze8Ju7uBicMpX5Dbq2EEw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=g0eWGUajXa98/eUvRyLkP9j0azEOioraiTZi1CZ6DQsnMIiSgP6DJAX9Ja24zytl2
         3pqU48ZgCyzvec9QwfmyXpFqUs/ga6XUSOmMzvCeztRt4XpbwHEOZ0Wa9tHfbMIgKT
         pjS/IvKIsMZc8ERDLIcU2Um+YKU2Ww+CMEUIbdvSQjtuhTbRBmyx7L1WcU2dx7sAXE
         OcJg/yrMIknJXios2Ibpj3rB1fijyu+4m/SNwjJ5ogqKbfe/zrCOExjtZEuqV7ypDc
         7A+WhLpvxVEk4x2nLi36E4+0G1IoIS6Pp1w3gfAlrOp+q45P+fuGqVTFB2uEqBeJxr
         VQSvD5C6pQQuw==
Received: by mail-lj1-f199.google.com with SMTP id e12-20020a2ea54c000000b00218c4c554baso620282ljn.14
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 11:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WIA6znI9FNppQXsU/4zd04Ze8Ju7uBicMpX5Dbq2EEw=;
        b=Wzto27ajzmztXj8abvUrtN/0oQzItjMbSBFbpBVzQfRE7XkEFexLqJfPyxTYNpnXFW
         t6u+2egAYbTFBgdX6sQliIgS+acJ5+5bcuFxWxqXmbf1OtsA8J1TwMEtwvUi5i+bA9c5
         m/jvZOcpo7qZcfqjyNIFmJamQscZbK++eC6c8EkUXG7MldF4qmH4QMrMLbozRlBZLQ4U
         ikE/L0KG3wGjjHKTa2BWj7vroR309dOwqlTE81XjcJRk9uoDxZ2Hhuo+gIBV9c5zhrmb
         93W+Ivov3Wys1FfC3IyrRz/a6g5WJbPD9rd9g5hQZkKoXZ3a3SRFGgcdk5fUGRZTEcsX
         6RJw==
X-Gm-Message-State: AOAM532v8DTeWDqSJYQ31Z6UB0dn3w51Vyk3tOweLJHGZ6iqXeP4wI3T
        xpSs8nvCtLUEb/Bz6oRcTogY7WBGLfk8eNJ4AO4zJKAm5Uh010QjwGQJAOdTEzRjD6EMXJ4kxFz
        3LVoUsH9GakDF4XduvgwtrEHOnEQajS05fs4Z7bJiog==
X-Received: by 2002:a05:6512:3e11:: with SMTP id i17mr59416675lfv.560.1636222807031;
        Sat, 06 Nov 2021 11:20:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcDjE7RoN0197mKZwHR2ILmAx9+DqEU9uM8skfKRIDRSOumC4sRX2YZjCDqODuVamG66SNQQ==
X-Received: by 2002:a05:6512:3e11:: with SMTP id i17mr59416661lfv.560.1636222806822;
        Sat, 06 Nov 2021 11:20:06 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id j20sm1226050lfu.199.2021.11.06.11.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 11:20:06 -0700 (PDT)
Message-ID: <08c8f447-dcae-83b4-e5b3-a13704a5b158@canonical.com>
Date:   Sat, 6 Nov 2021 19:20:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH] ARM: s3c: mark as deprecated and schedule removal
 after 2022
Content-Language: en-US
To:     Cedric Roux <sed@free.fr>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Kukjin Kim <kgene@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sam Van Den Berge <sam.van.den.berge@telenet.be>,
        Lihua Yao <ylhuajnu@outlook.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20211102110519.142434-1-krzysztof.kozlowski@canonical.com>
 <c4bcafd0-f614-78c8-4d72-5d2b672f7e32@free.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <c4bcafd0-f614-78c8-4d72-5d2b672f7e32@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2021 18:49, Cedric Roux wrote:
> On 11/2/21 12:05 PM, Krzysztof Kozlowski wrote:
>> If there are any users, they might respond and postpone the removal.
> 
> Hi Krzysztof,
> 
> I use a mini2440 (which is s3c2440) as an http server at home.
> I don't have much time but I can do some testing from time to
> time, but my setup is very custom so I don't know how helpful
> that would be for the community (if there is one).

We just need to know whether the kernel behaves properly on the
hardware. The setup itself should not matter, but what matters more is
that you do not run a new kernel at all. There is a lot of untested code
there.

> 
> I would be sad to see official support disappear, but I know
> how hard it is to maintain stuff, and I think I can keep going
> with the current kernel I use (which is not even 5.xx I think),
> so that would not be a big damage for me. And if I have special
> needs in the future (very doubtful) I guess I could hack something
> on my own.
> 
> Anyway, there is at least one s3c2440 server on Earth powered
> by the linux kernel. Now you know! :)

Thanks for coming back! We will see how much of feedback we gather.


Best regards,
Krzysztof
