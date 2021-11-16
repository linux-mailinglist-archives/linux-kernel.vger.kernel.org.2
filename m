Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EB6452FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhKPLO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:14:27 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57798
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234715AbhKPLOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:14:10 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CCB623F499
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 11:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637061072;
        bh=1lQZ2TW8TNK2thcDuVmU0UKGgRdlQUfKTNcFYQ2+bY0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=gLjGmJYbaQJj99TKFejbM6BwUIZ8aZzLZ0pvAn6+3KaqirxA0rfx+O2fBYNpN7hHw
         mICY4CCzYWCjA8Mu3FMDs8DmmrTodUhzRuOQdY4q56EyHpiFYaQDXPNqWJzFs0auTw
         YfcK5g4ALV2bx0TiDmnuglwBThPAW7bUZ59yWkQ/pzQYarRIt3hTq17W6gIXxLi0W5
         I6u8VtkebBPLbyvGN9DjLS9SDbc2vw1qzMoRluM5O+M0CbujNAaEZy2CAkIH7fPJhU
         QVL7hygTNoc/kiGWTuypFGxB9QjvoAC70kr4RPYZOmM0tbiqgM4Z3i7xGzf13GLgn5
         oE7PYxCAeT5JQ==
Received: by mail-lf1-f71.google.com with SMTP id b23-20020a0565120b9700b00403a044bfcdso6920103lfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1lQZ2TW8TNK2thcDuVmU0UKGgRdlQUfKTNcFYQ2+bY0=;
        b=nf9IpS3poPnHswzb8B4Kwr+u5M+Bcakye5WV+kv6xcAR/Vj4encX7kZnHnr97jIPBc
         d6llU5r2Ck/Z2wLqqGg/bIWD+b0KPn1rZRpkH/NE4AHbiuQqfgD14VpiT4CAIFssH+4o
         ssK1zjbQu1npCLgbvi/ByC8gDL5ZPNLzPH/F/+PaiUeOlXsep6ud0uoU9iZ7aZJ2xJjp
         SWoYQCZeTxT11DxP6vOZaPGkRIkw/kQzptRFoRP8Q9Jln5ZR1R+Bc8yKT2AontSWEnJB
         B7XSNMVNLfdCQ00lDwC1S7RZZCthvnbYQ+ehnjTRa6P4+YygYjhyIJIXM36jhDD9+3W6
         8Z9Q==
X-Gm-Message-State: AOAM532+pZJmTALS/sEXCXLIB0dSlezVCKCEbRBQsTF9REipoaen/9Zm
        KTvaRO+7fZ39Z1yxD38WWnOYVaokJFugHSf7ROcO74Vlq+HzpXaCGm3jJ1BYLL6iwQOJFkhX3RZ
        nKr0fEXZ27BYItnT68ND4B7g2S8CvxGQRNOdiKN/HTw==
X-Received: by 2002:a05:6512:3f2:: with SMTP id n18mr5810322lfq.646.1637061072247;
        Tue, 16 Nov 2021 03:11:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxl1qT20gjCKhmll8gsTUY3IyV/g1PKCe5fjVwz+LIGyWqxXMdDjQm+955DJ+O3odXNwgS4KQ==
X-Received: by 2002:a05:6512:3f2:: with SMTP id n18mr5810291lfq.646.1637061072055;
        Tue, 16 Nov 2021 03:11:12 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id h14sm1724427lfu.195.2021.11.16.03.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 03:11:11 -0800 (PST)
Message-ID: <0b8ea25e-eb53-f5ba-0707-c121e90348a0@canonical.com>
Date:   Tue, 16 Nov 2021 12:11:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 0/7] Add SPI Multi I/O Bus Controller support for
 RZ/G2L
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <a8b126e6-62e7-7979-01cb-b7a1ce4ae8d1@canonical.com>
 <CA+V-a8t=JsMJ=w9dDpeUfdTUwFhnHrZ-eWdpTmvOxC0uvOz4Wg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CA+V-a8t=JsMJ=w9dDpeUfdTUwFhnHrZ-eWdpTmvOxC0uvOz4Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2021 11:40, Lad, Prabhakar wrote:
> Hi Krzysztof,
> 
> On Tue, Nov 16, 2021 at 10:33 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 25/10/2021 22:56, Lad Prabhakar wrote:
>>> Hi All,
>>>
>>> This patch series adds a couple of fixes for rpc-if driver and
>>> adds support for RZ/G2L SoC, where the SPI Multi I/O Bus Controller
>>> is identical to the RPC-IF block found on R-Car Gen3 SoC's.
>>>
>>> Cheers,
>>> Prabhakar
>>>
>>> Changes for v2:
>>> * Rebased the patches on linux-next
>>> * Split patch 5 from v1
>>> * Included RB tags
>>> * Fixed review comments pointed by Wolfram
>>>
>>> v1:
>>> https://patchwork.kernel.org/project/linux-renesas-soc/cover/
>>> 20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>>>
>>> Lad Prabhakar (7):
>>>   dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
>>>   dt-bindings: memory: renesas,rpc-if: Add optional interrupts property
>>>   spi: spi-rpc-if: Check return value of rpcif_sw_init()
>>>   mtd: hyperbus: rpc-if: Check return value of rpcif_sw_init()
>>>   memory: renesas-rpc-if: Return error in case devm_ioremap_resource()
>>>     fails
>>>   memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
>>>   memory: renesas-rpc-if: Add support for RZ/G2L
>>>
>>
>> Applied parts 1, 2, 5 and 6. I think 7 is going to have a new version
>> due to Wolfram's comments?
>>
> Thank you for queuing up the patches, wrt patch 7/7 this can also be
> picked up, after the internal discussion it was clear that we cannot
> use the R-car hw manual for RZ/G2L (we will have to live with magic
> values). Wolfram has agreed on this and has already Acked patch 7/7.
> 

OK, applied now. Thanks!


Best regards,
Krzysztof
