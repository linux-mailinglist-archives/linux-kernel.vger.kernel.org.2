Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6D73DBC41
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbhG3PZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:25:57 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:35706
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231439AbhG3PZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:25:55 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id E21BE3F24D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627658749;
        bh=TEvW673M4tlEqNAgqaz/ijFkYi/5QPh9cKHdp/b4gIY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=GbVMlC7JmzONC8Dro/ZjQgSTSqlDYBHF/F69h9nFYjWJPGHK+IOxsMO/7ZF/Hk+i5
         wT9x2Dqdk0U4YTRj5kEDK6ZIGV7Irzf7Rx/DpZgwlpefwlkznmLVJlVeVvA1YLyaCq
         oC6VawUfDg4s25N0iTaZejuuhDbFvlz+Egmxr7jnH2/yVxlZodngJv0PZrkjEaFS2s
         hbfSckTxFhCn0RjklSDmllrM5xjDpkXRfzXHnYEtiApvLHEKBOxyMptRHLNq76opO/
         Fbs80OAOOG9pDxAB18tY7M0l1B23aMxpzE0vwDUJwpakTozhWR9y13++unIZjohOnD
         4zRMOgF33qWDg==
Received: by mail-ej1-f72.google.com with SMTP id ne21-20020a1709077b95b029057eb61c6fdfso3213717ejc.22
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 08:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TEvW673M4tlEqNAgqaz/ijFkYi/5QPh9cKHdp/b4gIY=;
        b=VcQVIZ4zTdHRDSuUUaah9Wkjd254BB85zR+cmFsOcXivULzJPl/ExQHYGuAq3c5cuL
         diA5JhmcmMSHpsbiegM36jiBUj2mF+uDWk1M/RDPV2ZO/OTeLVcpKj/Ukh1auxbzaMXG
         aPK6YzB7hS5EnolfIkWIA9KcctHpzZHGmgatzbChGl7W3afOqXBSnW104A0miXs/dZW3
         /8h1xkbhql0354v0tKyXrPcG/zi7rEms7x90gCpxxX3CTBC8E5p1v1slZVCjtbak59y9
         1IvE0tiRjFSg66VggyBGNHDiPSumHzRTHgOnslez9gHf6Ltb+8F7rH2mFknYyf+Wu6Q4
         X6wQ==
X-Gm-Message-State: AOAM531/OTGo11CCgGr6H5Ush/LsI2jPC5XpwuTqfOMpgXDeGl/h26AL
        CjJS3BJtnqK5gLihgZcT1u1nb9JJJuADXtNCLUZpIP+83/ni7QctvgPpY4knkGQwUeHQHBtZOh2
        W4esmCFIuDWfCdS/sWujqDtvqnehUFWdVzlv6d/yS7A==
X-Received: by 2002:a17:906:2d51:: with SMTP id e17mr3031156eji.500.1627658749657;
        Fri, 30 Jul 2021 08:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGrmbK76jzm7R0wU9rDjzOLSuvi09IncVRLsAPOuK8inPZj/nU5vtfrdytg3IgHkG0o3Lyzw==
X-Received: by 2002:a17:906:2d51:: with SMTP id e17mr3031123eji.500.1627658749527;
        Fri, 30 Jul 2021 08:25:49 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id p16sm826354eds.73.2021.07.30.08.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 08:25:49 -0700 (PDT)
Subject: Re: [PATCH 08/12] MAINTAINERS: Cover Samsung clock YAML bindings
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-9-semen.protsenko@linaro.org>
 <CAHp75VcugLnV6D8xhkMHuW-X6LCtHDDnghD2G+vqwYmRvFP9Nw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8202e9f9-06f4-f1ba-4f30-e1a0c8340450@canonical.com>
Date:   Fri, 30 Jul 2021 17:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcugLnV6D8xhkMHuW-X6LCtHDDnghD2G+vqwYmRvFP9Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2021 17:06, Andy Shevchenko wrote:
> On Fri, Jul 30, 2021 at 5:50 PM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
>>
>> New device tree bindings are usually added in YAML format. Fix "SAMSUNG
>> SOC CLOCK DRIVERS" entry to cover both txt and yaml docs for Exynos
>> clock drivers.
> 
> Fixes tag?

No need because the pattern is correct at the moment. The patch does not
make sense on its own and should be squashed with the next one.


Best regards,
Krzysztof
