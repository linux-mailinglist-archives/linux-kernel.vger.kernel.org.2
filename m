Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4736C336D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhCKHaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:30:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48734 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhCKHaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:30:11 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKFlP-00030R-Oy
        for linux-kernel@vger.kernel.org; Thu, 11 Mar 2021 07:29:43 +0000
Received: by mail-wr1-f71.google.com with SMTP id h30so9130932wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 23:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UM3RKX0XCDpJCuubU4GyjNFkIs45HL7bg2XqkxuxPoo=;
        b=elYYuRRIyX9irgRyX291xmGvVgKzqhYojwiIIC8nGrSxKotBkF4RtcqDAtTnaF1BKi
         BhgclAe1o/TZ4qOVn+r55r5VGG1yEBuANVIW7vsuAUvYX8bNVfOjXyXhZtG0PvAQFXzU
         VG07y7eRSbBSRsOtBiCgJE+f0t6sgnmzZc6K5HCryYDygpu+m5a+HIKOy2dj9VbWMyeu
         rnV0IQ7WS+3s0jtfwsOPlahmgZcI7I2IHAQ/34gBOgMh0078HdAqWM7XxsCoXa9foHj/
         GfyDxV5TTCPa3oTWQ1mS/EE7UqYXVbs55v9AwNa+Q5KxbL8dAuanV/F4jFtznT2PrAFO
         n58A==
X-Gm-Message-State: AOAM533Y8zD1TITzHhqwwUbGByKpLSn4yUwTtrEFB5BzGLs3cs7DccXX
        trTil6FjK2j7NOBj3eknFME/EuT7ibKtOBd/8j+RJsx1xSV8lbXZurltryH2n+LvoJGQa2Bk1lT
        f1rfknetRk29vQDPqSPsOuis15V4fYWZQe/AGtxTUVQ==
X-Received: by 2002:a5d:4708:: with SMTP id y8mr7473163wrq.382.1615447783439;
        Wed, 10 Mar 2021 23:29:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwntEUdVEQpqMsRTDpIua5kEKJ6BAuZNIC5Far5vVjfExGBGIXOrXsOxt/q5mJ8+gEXtFcFdw==
X-Received: by 2002:a5d:4708:: with SMTP id y8mr7473131wrq.382.1615447783295;
        Wed, 10 Mar 2021 23:29:43 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id z3sm2323807wrw.96.2021.03.10.23.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 23:29:42 -0800 (PST)
Subject: Re: [RFC v2 5/5] clk: socfpga: allow compile testing of Stratix 10 /
 Agilex clocks
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-edac@vger.kernel.org, linux-fpga@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Olof Johansson <olof@lixom.net>
References: <20210310083327.480837-1-krzysztof.kozlowski@canonical.com>
 <20210310083840.481615-1-krzysztof.kozlowski@canonical.com>
 <20210310083840.481615-3-krzysztof.kozlowski@canonical.com>
 <CAK8P3a27hAExCKtsO7k1HQwLKk-5Q8uxYYt_G2v-Osq8RZv2tg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a1f296ad-19db-824e-5d33-c93c6af87e70@canonical.com>
Date:   Thu, 11 Mar 2021 08:29:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a27hAExCKtsO7k1HQwLKk-5Q8uxYYt_G2v-Osq8RZv2tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2021 17:48, Arnd Bergmann wrote:
> On Wed, Mar 10, 2021 at 9:38 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>> --- a/drivers/clk/socfpga/Kconfig
>> +++ b/drivers/clk/socfpga/Kconfig
>> @@ -1,6 +1,17 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> +config COMMON_CLK_SOCFPGA
>> +       bool "Intel SoCFPGA family clock support" if COMPILE_TEST && !ARCH_SOCFPGA && !ARCH_SOCFPGA64
>> +       depends on ARCH_SOCFPGA || ARCH_SOCFPGA64 || COMPILE_TEST
>> +       default y if ARCH_SOCFPGA || ARCH_SOCFPGA64
> 
> I think the 'depends on' line here is redundant if you also have the
> 'if' line and the default.

Yes, you're right.
Best regards,
Krzysztof
