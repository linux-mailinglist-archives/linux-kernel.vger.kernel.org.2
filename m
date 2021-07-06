Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF803BDB5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGFQbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229935AbhGFQbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625588921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irckbVn6yrKSfa9qUP6LkAQmjlPbZerZu/LlcR/gbWA=;
        b=F3nW489eqWD3v4S1d4bQTNtNZRKuarWQoT6EdduMU5diBnoeNyX/HasLYqOC1Zs/m1++3X
        w5Msq2sTKaQamaLSV0Yp6Vcn88A15fj/55UKGd69OV151GdXUnShzpWYm4IwLm7rmwOV2O
        asozvsLo1OU3+i4Q1z0mwjNdtULzU0M=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-Ro9aR142NuqRSUB2M8j2xQ-1; Tue, 06 Jul 2021 12:28:39 -0400
X-MC-Unique: Ro9aR142NuqRSUB2M8j2xQ-1
Received: by mail-oo1-f72.google.com with SMTP id p6-20020a4ae1460000b029024c388a4835so7794559oot.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 09:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=irckbVn6yrKSfa9qUP6LkAQmjlPbZerZu/LlcR/gbWA=;
        b=dOXpv8eiUHw3p9yUuusQw51n0AXST5K6Un/h5nkTBYuGrsTsjQg7JC1+gMuRFXrVjx
         fiCpXS4mn8Qw7Ifq2m0Pg8An2OIKgIkdkCejoDuNpZ8i9Xkqr5nMZceC1PjYfCFFWfUD
         C5Zd1CS7/EHj9+RPHhduu/N1eMCNOH2XZzkoadMZ9vFlAPdJbqZcQuavnySH/MIHqwUB
         0hb/zNjNZYTSHxl6XsHKdFgam7G/z+t0H95Io5ytEkZb1ndp3+MAM+f8qVnN9XG2dFzx
         mIeLj2ClOGnbnsXpp358/TCyUB4MfTx/tSWxVQR/9c8wTkL/7Td6CN3QRr3Fd5vDbmEg
         6XfQ==
X-Gm-Message-State: AOAM533xDr0BNS7ZSyo82QMjuIzPPHw+pPhD2tTM6qtRE58vJSDHsv75
        fARlYgG1raGbDVh2hcu8S+fv5qOnbXZKTGemoZOPF7SE4OUvhXmwg92uEHkF3yIM4VBy7O1RTh5
        K1VmdzTNJChfVsHPp9p1sbPN0Mlp6HvMiCsY0iHhWCTehUn4DbHLnuLxYWbXrAoBfzybNF+0=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr14595931oou.23.1625588919056;
        Tue, 06 Jul 2021 09:28:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbwBNVEJjT5lRnoa5en9DUU3mJO4JDSUNRsL7D1/qT+l2u/1oFJnVkQ0Hb/P/3gd5prA9CZg==
X-Received: by 2002:a4a:d781:: with SMTP id c1mr14595919oou.23.1625588918830;
        Tue, 06 Jul 2021 09:28:38 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p26sm1578132otp.59.2021.07.06.09.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 09:28:38 -0700 (PDT)
Subject: Re: [PATCH 0/4] FPGA Manager address unused variable warnings
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210702035404.397853-1-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d0088161-ec7f-4ff4-d5c1-c0746ca17283@redhat.com>
Date:   Tue, 6 Jul 2021 09:28:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210702035404.397853-1-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/1/21 8:54 PM, Moritz Fischer wrote:
> This patchset addresses a handful of warnings as result of_match_ids
> being not properly wrapped in #ifdef CONFIG_OF.
>
> Moritz Fischer (4):
>    fpga: altera-freeze-bridge: Address warning about unused variable
>    fpga: xiilnx-spi: Address warning about unused variable
>    fpga: xilinx-pr-decoupler: Address warning about unused variable
>    fpga: zynqmp-fpga: Address warning about unused variable
>
>   drivers/fpga/altera-freeze-bridge.c | 2 ++
>   drivers/fpga/xilinx-pr-decoupler.c  | 2 ++
>   drivers/fpga/xilinx-spi.c           | 2 ++
>   drivers/fpga/zynqmp-fpga.c          | 3 ++-
>   4 files changed, 8 insertions(+), 1 deletion(-)

I am not seeing these warnings, but it is still worth doing.

I think a few more files need this change.

altera-ps-spi.c, dfl-n3000-nios.c, altera-hps2fpga.c, stratix10-soc.c, 
socfpga-a10.c, altera-fpga2sdram.c

Not needed for

altera-pr-ip-core-plat.c and ice40-spi.c

These have depends on OF in Kconfig.

Tom

