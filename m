Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337263340A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhCJOqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232587AbhCJOp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615387558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qe7vnreao5ThhJBhWOb2yAQo6akg/BiUCkUWjObNy9A=;
        b=UJio361ycv3FfHgO/mmDPV8NnheNq+6b7BM4cir6sh7v9lyIgnHZV5dXntjgjS58IgBwVx
        skhW+DM+vFerBkOgHL1x1qzXHM5KcDTkxN2ItkAfmsnEMRqu+vlKEdHtS3/tybYh8tsXTR
        S7dOLRZtgGrsvvX1ItBX4ajqwvTIN8A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-NP8qXk91Nq-zfNLb0nv8XA-1; Wed, 10 Mar 2021 09:45:55 -0500
X-MC-Unique: NP8qXk91Nq-zfNLb0nv8XA-1
Received: by mail-qk1-f198.google.com with SMTP id b127so11123825qkf.19
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qe7vnreao5ThhJBhWOb2yAQo6akg/BiUCkUWjObNy9A=;
        b=MNIibYEcMxFAh5UntYETGPZZbZpQsN6wvKSLvBuRJ63lMfGUUS9PYyr5V9pAyZ2u3m
         vhlfFbFCeCCUXWAAoh2YkkVBCzgS8tYP7+YKbXPbmPFE0yPL11/Vqvd4QHG4vnhvH9Ne
         R3pFbu4RvyE2FS+hlethDvdMEB+3oWJHprVt4MSQHmlbPLzac0FD+oTkKflycv75+4yS
         WdJswEmYiG+6TxENwiOBsBnI1O1MSiF+Mkx4r4sI6vH/5BB8J6SyBdK1L7iq6mumAElT
         XrixAfGTfsdNHYqwmdLdGkZql+XBeHoETVkrG+PuacLmvx5DoekGqJ9m43J0fE88ISxn
         zFLQ==
X-Gm-Message-State: AOAM530yp9AhEdhy/FxKbNhiDH7wx7zh7t1PONKYOsvA4VHkuMosPPza
        40wOeh6Vlh9dJgrZbNz5QC1gRvFb6/0K136/PB6EyI8EEMwBkuGJJC8H2sv+Sb65PYTfXTLvgp4
        7RRoGyeLDnlHGvElpKWtDir39
X-Received: by 2002:a0c:8ec7:: with SMTP id y7mr3256298qvb.9.1615387555273;
        Wed, 10 Mar 2021 06:45:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlNoVM9BzWQNjpadCXVlfERPTQuROOGObYqvdAhHPCzlyHzhNVdnm6DSobOhCibwSlI7/4+g==
X-Received: by 2002:a0c:8ec7:: with SMTP id y7mr3256274qvb.9.1615387555052;
        Wed, 10 Mar 2021 06:45:55 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d2sm12859520qkk.42.2021.03.10.06.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 06:45:54 -0800 (PST)
Subject: Re: [RFC v2 3/5] arm64: socfpga: rename ARCH_STRATIX10 to
 ARCH_SOCFPGA64
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Moritz Fischer <mdf@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-fpga@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
References: <20210310083327.480837-1-krzysztof.kozlowski@canonical.com>
 <20210310083840.481615-1-krzysztof.kozlowski@canonical.com>
 <20210310094527.GA701493@dell>
From:   Tom Rix <trix@redhat.com>
Message-ID: <35c39c81-08e4-24c8-f683-2fa7a7ea71de@redhat.com>
Date:   Wed, 10 Mar 2021 06:45:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310094527.GA701493@dell>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/10/21 1:45 AM, Lee Jones wrote:
> On Wed, 10 Mar 2021, Krzysztof Kozlowski wrote:
>
>> Prepare for merging Stratix 10, Agilex and N5X into one arm64
>> architecture by first renaming the ARCH_STRATIX10 into ARCH_SOCFPGA64.
>>
>> The existing ARCH_SOCFPGA (in ARMv7) Kconfig symbol cannot be used
>> because altera_edac driver builds differently between them (with
>> ifdefs).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  arch/arm64/Kconfig.platforms                |  7 ++++---
>>  arch/arm64/boot/dts/altera/Makefile         |  2 +-
>>  arch/arm64/configs/defconfig                |  2 +-
>>  drivers/clk/Makefile                        |  2 +-
>>  drivers/clk/socfpga/Kconfig                 |  4 ++--
>>  drivers/edac/Kconfig                        |  2 +-
>>  drivers/edac/altera_edac.c                  | 10 +++++-----
>>  drivers/firmware/Kconfig                    |  2 +-
>>  drivers/fpga/Kconfig                        |  2 +-
>>  drivers/mfd/Kconfig                         |  2 +-
> If it's okay with everyone else, it'll be okay with me:
>
> Acked-by: Lee Jones <lee.jones@linaro.org>

I think the name is too broad, from the description in the config

+	bool "Intel's SoCFPGA ARMv8 Families"

A better name would be ARCH_INTEL_SOCFPGA64

So other vendors like Xilinx could do their own thing.

Tom

>
>>  drivers/net/ethernet/stmicro/stmmac/Kconfig |  4 ++--
>>  drivers/reset/Kconfig                       |  2 +-
>>  12 files changed, 21 insertions(+), 20 deletions(-)

