Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4570034E49B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhC3Jmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhC3Jma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:42:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA9C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:42:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ce10so23863296ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v6VbFOVaNZFibaVBnSDLK//9i3b0qySPXiFFUzfcK3I=;
        b=YhVn8HBZTxcElEmF6mQOYtRdRlfZ/mNqJVUXJYpdRnIWSNswD0Wt0mtAgdlnQSNmji
         9QMgFO+q2Kj1VR3shtlV5F89e2GOdCH0vd8pO0poV9Fk3OLlskF/f2Qi1jQ45vwngIt+
         ZUHPWt/j7Kvl/0E1Z1TsmUQHZn16Yy1sSfpyd/eebchaiDVEuCzY8ULeSVFhdKmJWeaP
         cuqQG2vz/N+K7IafzrXYEYSYwJLhk6tcmW4QYXNYxucEAcX1LQhjGFs49sme1f6taynM
         tHRDJthuqwxO6K9FxYVZT2j7N+KS8PiSFfeyWNR7u3A1+z5mdyqtn0KZU1alIm47KjgE
         d1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v6VbFOVaNZFibaVBnSDLK//9i3b0qySPXiFFUzfcK3I=;
        b=QATh4C4X16lh7n/13Y3kRtgD+ghRGV3lGNTNs2dk22Zdxx/de3/ConAncv4oeITMrr
         DZwlGLsoXsTIaLWSECXyK+WRhE1i8bw1nx9MiZLyLFLvV4rtK4p9Amp1GTmGsnWV9Zs4
         wu1jghmghFh31gTro5DUl+h3dh3nX5L/i0TiU5GMEOS5XZdTTVVwx/kATyl2ljfn81GE
         7tqbLNJmYHjZgDOlZ0VgbE4EC0VMBNL7KAGoyHftQSJ5xuuAAPl9wXFguAhRaCrxojSV
         4yxC4QfdAWlIIhILfE3ST0L4Ibh44dx/W83WelPKtmKS/bVr8rU4pvuEZFTQNfunJPi8
         aYiw==
X-Gm-Message-State: AOAM532PjRnPrPJ+IrHYVcG2VATQE9FTzkjtiBTqL1HGuf/K9kn17qhi
        nuj3YgdrUb8Jv0H+N9DPnNZ7OQ==
X-Google-Smtp-Source: ABdhPJwLRR/3EKdhrZYj144DyAFroQH65OuBeTtBKfOXrIgqAPJW4TQBTrI3jccJWYW2fmEFW7Jc1g==
X-Received: by 2002:a17:906:14d4:: with SMTP id y20mr32510201ejc.190.1617097348710;
        Tue, 30 Mar 2021 02:42:28 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id v15sm10626830edw.28.2021.03.30.02.42.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 02:42:28 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] mtd: core: OTP nvmem provider support
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20210322181949.2805-1-michael@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ace5b308-d6ea-b301-0d2e-29f95b91fe8b@linaro.org>
Date:   Tue, 30 Mar 2021 10:42:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210322181949.2805-1-michael@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 22/03/2021 18:19, Michael Walle wrote:
> The goal is to fetch a (base) MAC address from the OTP region of a SPI NOR
> flash.
> 
> This is the first part, where I try to add the nvmem provider support to
> the MTD core.
> 
> I'm not sure about the device tree bindings. Consider the following two
> variants:
> 
> (1)
>      flash@0 {
>          ..
> 
>          otp {
>              compatible = "mtd-user-otp";
>              #address-cells = <1>;
>              #size-cells = <1>;
> 
>              serial-number@0 {
>                  reg = <0x0 0x8>;
>              };
>          };
>      };
> 
> (2)
>      flash@0 {
>          ..
> 
>          otp {
>              compatible = "mtd-user-otp";
>              #address-cells = <1>;
>              #size-cells = <1>;
> 
> 			some-useful-name {
>                  compatible = "nvmem-cells";
> 
>                  serial-number@0 {
>                      reg = <0x0 0x8>;
>                  };
> 			};
>          };
>      };
> 
> Both bindings use a subnode "opt[-N]". We cannot have the nvmem cells as
> children to the flash node because of the legacy partition binding.
> 
> (1) seems to be the form which is used almost everywhere in the kernel.
> That is, the nvmem cells are just children of the parent node.
> 
> (2) seem to be more natural, because there might also be other properties
> inside the otp subnode and might be more future-proof.
> 
> At the moment this patch implements (1).
> 


Have you looked at this series[1], are you both trying to do the same thing?

[1] 
https://lore.kernel.org/linux-mtd/20210312062830.20548-2-ansuelsmth@gmail.com/T/

--srini


> Michael Walle (4):
>    nvmem: core: allow specifying of_node
>    dt-bindings: mtd: add YAML schema for the generic MTD bindings
>    dt-bindings: mtd: add OTP bindings
>    mtd: core: add OTP nvmem provider support
> 
>   .../devicetree/bindings/mtd/common.txt        |  16 +-
>   .../devicetree/bindings/mtd/mtd.yaml          | 110 +++++++++++++
>   drivers/mtd/mtdcore.c                         | 149 ++++++++++++++++++
>   drivers/nvmem/core.c                          |   4 +-
>   include/linux/mtd/mtd.h                       |   2 +
>   include/linux/nvmem-provider.h                |   2 +
>   6 files changed, 267 insertions(+), 16 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mtd/mtd.yaml
> 
