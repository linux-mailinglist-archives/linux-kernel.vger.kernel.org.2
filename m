Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9540039D58D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFGHF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhFGHF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:05:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA50C061787
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 00:03:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y7so11644298wrh.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 00:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N5+FdmS1ov7QWRtUf1NBqQlwi8g+qrI20OYrFvNTgFI=;
        b=KT5HTMznlO7nCDmmnVydpypxznSTPApslma2/j6CA6xuNHzsrxjfiQy3V2HXJ304up
         xD/6WBcpG3YqNjv2Lhu1uBtWv5WjCWdVVYEYEsrmrxkGr7JC4D6XvpB/81qIjn1NohUF
         eX1ISndmML1V/4ZCoC0RATX405XFT5eopPcmso/Q4YPB/RMyLpLjONWOuVUVgXE4e1VB
         WpOrkqVHvNC62+L4Fd8xNtGWHnOyBPOT5gxMM8Mdxhra27w3SBL0yYaasx0R9UTZzdm1
         fqEcXoRItX1w7JHuzSbzs8ZlBlssLw5D4kIDQRm6bIRPWXMHjo1IWYrtfEHgUNqKT5vI
         sLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N5+FdmS1ov7QWRtUf1NBqQlwi8g+qrI20OYrFvNTgFI=;
        b=ZktuErmQ9DFch8MxIsekLFU213h93Gfxnjqpg6kTVo0FTAbvBeNuljnktwqeQffTFg
         Y89pdkb1lKtkov8wRqB8kn+IhOQGy02nvN4VnRELsTGQIPdMbSrdZhn+G7t6q7dvtLBz
         zL0SqSix7aeerSUj+4UjKhoIQ+tH8pdG9C/xOI4+xL8UZ3+uAEtVTFBLk2knjkBsi7fy
         xdyiIPVTJw8DYHpP6Msw9g5bFsOPewUtZhJhVYBtHQt7c1Ubyu11s2VbB1O93QbDqf0W
         AYCgdU94A3qIcNCxnuu9PVBCBWJb5tcjxpTIdQF9ueChNM7pYVM8qy0y+hSDWKv0Mwu4
         FnCg==
X-Gm-Message-State: AOAM531XzhbdKwqW9YIFGDcDesLZINc9llPG19ZU33kQDioqC6mu3Fuq
        5uc5uI+DGJoC+ib0QcSgN0Ptgg==
X-Google-Smtp-Source: ABdhPJzfDmgztfmf3PgpSCVnOGSZxZos4pCR5Pf9xgp5G5FiGHkBf+howGpsMWbnEBRsMjrZnFApCA==
X-Received: by 2002:adf:e944:: with SMTP id m4mr15308238wrn.244.1623049431529;
        Mon, 07 Jun 2021 00:03:51 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:7c1f:1c9f:555e:7398? ([2a01:e0a:90c:e290:7c1f:1c9f:555e:7398])
        by smtp.gmail.com with ESMTPSA id b26sm16223506wmj.25.2021.06.07.00.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 00:03:50 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: vim3l: add NNA node
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        xieqinick@gmail.com
Cc:     robh+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        nick@khadas.com, artem@khadas.com
References: <20210605030915.411391-1-xieqinick@gmail.com>
 <CAFBinCA+Rm3X43fT4oePS0vXphPPEZMweoM_7c0MR1ZwSbsoaQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <f42f343d-0d32-bbd8-9066-17b72b69f99a@baylibre.com>
Date:   Mon, 7 Jun 2021 09:03:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCA+Rm3X43fT4oePS0vXphPPEZMweoM_7c0MR1ZwSbsoaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/06/2021 11:49, Martin Blumenstingl wrote:
> Hi Nick,
> 
> On Sat, Jun 5, 2021 at 5:09 AM <xieqinick@gmail.com> wrote:
>>
>> From: Nick Xie <nick@khadas.com>
>>
>> Add Neural Network Accelerator device tree node
>> for Khadas VIM3L.
> we neither have a driver for this upstream nor any binding
> documentation in Documentation/devicetree/bindings/
> are you planning to add this?
> 
> Especially the missing binding documentation is problematic as it
> causes some warnings when validating the .dts files against the
> bindings from Documentation/devicetree/bindings/

Actually the NNA core is a verisilicon VIVANTE core, but I have no idea what is the difference
with the VIVANTE GPU cores ?

the userspace libraries & SDK shipped by Amlogic exposes OpenCL and (AFAIK) NNA over OpenCL, so I think
the HW description should be similar to the current Etnaviv bindings.

Neil

> 
> 
> Best regards,
> Martin
> 

