Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7E3A2F34
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhFJPXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:23:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55887 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhFJPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:23:52 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrMVH-00072h-I2
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 15:21:55 +0000
Received: by mail-wm1-f69.google.com with SMTP id 128-20020a1c04860000b0290196f3c0a927so3989229wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EWTjDquQxTbWQL7tao6uaX3QOuXXhjaN5XNi3DDASoE=;
        b=oM7HnwrsKdtMqXTs1tWUpvi5+5azmluk7gJO1MK87Zz2jADsCR3p+tbUAozTS/BZtY
         tYDsTeDACGVMN3ID9frDfPuSgQOklsd0p6CW6AzoSwW06KnSaqhBFbVtKFhMlSra4d+z
         HYjWoYz+cbwz4O6QueNmFh78kMsxz6bXqBUaiD32yi2TFVw5KaBDlCZc/id2SL37Abyt
         +pk4L/HDqytaG9ClXc76vac+ePsSB1tVkzSXFP3U6CS81uuVAmL1FNGF3LPtT2kYWRND
         G3vjN4h9gocaKOHguRJgL5bb+KB+chKOyfIn29eaBBUpJbHw+uJ32MAvkOJ5DxFrvova
         jzWw==
X-Gm-Message-State: AOAM5316x8AJSSXInFp6714MtNOtylpam4/GmFzfpBZikENFqapJvB9Q
        03GIH49jC7viuCvJcHtjdytkRSVr0Ko11X0GONLx3mzDHqLvSbbSKbR3QIOggBBhOq5wzdNpiDL
        eH/6b1RZqc5sSrxRHf/LF0qNJO9eY5tlQWHr/1stxcA==
X-Received: by 2002:adf:f94c:: with SMTP id q12mr5943527wrr.417.1623338514783;
        Thu, 10 Jun 2021 08:21:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykUgbl4Jm24V1lZxkiY74VTRt613BlK2Ms3DFn4TvvhbYNYSqz3rV2y9063jE43MgGZjez1w==
X-Received: by 2002:adf:f94c:: with SMTP id q12mr5943499wrr.417.1623338514584;
        Thu, 10 Jun 2021 08:21:54 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id l13sm4200303wrz.34.2021.06.10.08.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:21:52 -0700 (PDT)
Subject: Re: [PATCH v23 00/18] ARM Primecell PL35x support
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        helmut.grohne@intenta.de, Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <5639e973-c5a0-abbc-6a9d-212d33dd28bf@canonical.com>
Date:   Thu, 10 Jun 2021 17:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2021 10:20, Miquel Raynal wrote:
> Hello,
> 
> I am taking over Naga's series, here are the major changes:
> * Cleaning of the SMC bus binding file (and yaml conversion)
> * Superficial cleaning and great simplification of the SMC bus driver
> * Addition of a yaml file describing the NAND controller
> * Full rework of the NAND controller driver. JFFS2 and UBIFS not tested
>   yet, only bare test tools have been used to proove basic correctness
>   of the helpers.
> * Addition of a couple of MAINTAINERS entries.
> 
> A Github branch named pl353 is available on my repository:
> https://github.com/miquelraynal/linux/
> 
> Thanks,
> Miquèl
> 
> Changes in v23:
> - Collected Naga Acked-by's.
> - Used const instead of single enum entries in the bindings.
> - Dropped the address-cells/size-cells superfluous definitions out of
>   the NAND controller binding.
> - Enhanced the SMC reg property description to mention that the various
>   CS are described in the ranges property.
> - Fixed the SMC child nodes regex to match Rob's requirements.
> 

I'll apply the memory patches here - dt-bindings which has Rob's ack and
driver changes. It's getting too late in the cycle and soon arm-soc
won't accept such big patchset.


Best regards,
Krzysztof
