Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9003F372BD6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhEDOSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:18:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45557 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhEDOSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:18:38 -0400
Received: from mail-qv1-f72.google.com ([209.85.219.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ldvrq-0003qi-4A
        for linux-kernel@vger.kernel.org; Tue, 04 May 2021 14:17:42 +0000
Received: by mail-qv1-f72.google.com with SMTP id d11-20020a0cdb0b0000b02901c0da4391d5so7711519qvk.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Mdj10uq8YyfvX11RWMMGRr3/VZzdY5+rc9TfTZ6UC8=;
        b=bwBs02xfihFCyjpSvJNbDQ92l5cvrWZm4m7iSU43EOq6HEEOA+SxphJgH1VZ3c1KaW
         NCCFWtdu4lsRMvlkj/cmYC9gwQLS0kFaoPc4SoWsjxVheqrBekvOManigvy98RA7GY/T
         +M2wrSVoXTxHFOgzaAPoaWKk9FEjVDG8hPmgBQdmH9rYVuQ76gkGt3M8EldQD8NeZd1G
         cmuSoqff3F0QHKuJhWRQ7b9GwWKT95IiEzh1YOt7tJ15EsS3iqeuEJQ15qyy7qW9MMaV
         FFpLn4khF+hGfIpN/nBaH2Js5xfqE0Pce3HGAnzIjdkPfisZtS2XuVNSmWF/jLeEVx+e
         PGjQ==
X-Gm-Message-State: AOAM5336b0KRMz1JgHJMbHAfxoLRpLQStGhi+hviW2TKyU/g8Ytca4+g
        qIkdtXUR3HTJQ/1N2texupUDew/KhSXF3PA2Sqofic9UDvS3I2qmJftFTVF8zqpt79ZV/IiKgvO
        +muqzl8KiWcxbaPgv2JSEUDUpQbXyBPAbY5db97zN0g==
X-Received: by 2002:ac8:60c8:: with SMTP id i8mr22133290qtm.63.1620137861282;
        Tue, 04 May 2021 07:17:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBXSkZplOQFMqdOcrYIdibKIXwCDSIkqvwhTWqybS/PTYVBzFw35eerGZalnS6j+Q4dZ10Fg==
X-Received: by 2002:ac8:60c8:: with SMTP id i8mr22133258qtm.63.1620137861031;
        Tue, 04 May 2021 07:17:41 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.49.3])
        by smtp.gmail.com with ESMTPSA id y13sm1047947qkj.84.2021.05.04.07.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:17:40 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] memory: Add support for MediaTek External Memory
 Interface driver
To:     EastL Lee <EastL.Lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, cc.hwang@mediatek.com,
        joane.wang@mediatek.com, adrian-cj.hung@mediatek.com
References: <1611746924-12287-1-git-send-email-EastL.Lee@mediatek.com>
 <1611746924-12287-2-git-send-email-EastL.Lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2cf92fc2-ccac-312f-f4a6-9a4dfd9aee9c@canonical.com>
Date:   Tue, 4 May 2021 10:15:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1611746924-12287-2-git-send-email-EastL.Lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2021 07:28, EastL Lee wrote:
> MediaTek External Memory Interface(emi) on MT6779 SoC controls all the
> transitions from master to dram, there are emi-cen & emi-mpu drivers.
> 
> emi-cen driver provides phy addr to dram rank, bank, column and other
> information, as well as the currently used dram channel number, rank
> number, rank size.
> 
> emi-mpu (memory protect unit) driver provides an interface to set emi
> regions, need to enter the secure world setting and the violation irq
> isr will collect mpu violation information, after all regions have
> protected their respective regions, emi-mpu will set the ap region to
> protect all the remaining dram.
> 
> Signed-off-by: EastL Lee <EastL.Lee@mediatek.com>
> ---
>  drivers/memory/Kconfig                   |    1 +
>  drivers/memory/Makefile                  |    1 +
>  drivers/memory/mediatek/Kconfig          |   23 +
>  drivers/memory/mediatek/Makefile         |    4 +
>  drivers/memory/mediatek/emi-cen.c        | 1305 ++++++++++++++++++++++++++++++
>  drivers/memory/mediatek/emi-mpu.c        |  908 +++++++++++++++++++++
>  include/linux/soc/mediatek/mtk_sip_svc.h |    3 +
>  include/soc/mediatek/emi.h               |  101 +++
>  8 files changed, 2346 insertions(+)
>  create mode 100644 drivers/memory/mediatek/Kconfig
>  create mode 100644 drivers/memory/mediatek/Makefile
>  create mode 100644 drivers/memory/mediatek/emi-cen.c
>  create mode 100644 drivers/memory/mediatek/emi-mpu.c
>  create mode 100644 include/soc/mediatek/emi.h
> 

Use scripts/get_maintainers.pl to get list of people you need to Cc.

Run checkpatch, smatch, sparse and coccinelle on your new driver. I can
easily see that some of these steps were missing (e.g. OWNER field...).

Best regards,
Krzysztof
