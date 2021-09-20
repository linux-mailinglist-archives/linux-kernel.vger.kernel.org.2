Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DFB41289F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 00:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhITWEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 18:04:10 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:33629 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhITWCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 18:02:08 -0400
Received: by mail-oi1-f174.google.com with SMTP id 24so5726136oix.0;
        Mon, 20 Sep 2021 15:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=85k2h7hTnCn74TyVn6/B2+2QyfK04Tc6eq2dn9dH2gg=;
        b=n+VkeN+YrJ+Deafu3v1qWDw9Vy5EA1Hqpv0KDvfw9r6biTcgrdePP6FXaVBWukRBNN
         BbKI+WDVe0nDcc+MZvBO1HW7D+kpYB1engyo/DuNBr4EbNCAzXTi5F7B3RKVZ2JPashz
         XfnLepXBDXaXkfj2q9QALYi3db8Z9YKIPF3cLY2R/moue8Wts10XOMNRnNJesSN68ZYo
         HkWXJcmpnDxTWgPpln8ZQ7CnTSP9JpNAwW1um1GeUWvjrb1uS2Ze3TMbitKzGptBI5GS
         sEKeLM4sJk4juFvWMQhC69LsYHEdQabtm2E8xp3Tj5yhPDPCIR4dAlOmhY9dh4DGMcIz
         kPuA==
X-Gm-Message-State: AOAM531KrHBnWTHopbbeAd1T2H+XXFsPtChMRHsaMJ6jc4/G7238VcMO
        aOjQK2yNHiYR+Slrd32i5d0xpFCTpg==
X-Google-Smtp-Source: ABdhPJxot0dlqDRaMgzpZNc5Q01aOjO7eJzgFh12vVttfBsXxGXI67HiP+rpBqxR94tEcHUvm/dPyA==
X-Received: by 2002:a54:4e1d:: with SMTP id a29mr1003635oiy.7.1632175240929;
        Mon, 20 Sep 2021 15:00:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w8sm2666505ots.25.2021.09.20.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:00:39 -0700 (PDT)
Received: (nullmailer pid 863268 invoked by uid 1000);
        Mon, 20 Sep 2021 22:00:38 -0000
Date:   Mon, 20 Sep 2021 17:00:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [RESEND PATCH] dt-bindings: riscv: correct e51 and u54-mc CPU
 bindings
Message-ID: <YUkEhi+SeLN4539M@robh.at.kernel.org>
References: <20210920132559.151678-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920132559.151678-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 15:25:59 +0200, Krzysztof Kozlowski wrote:
> All existing boards with sifive,e51 and sifive,u54-mc use it on top of
> sifive,rocket0 compatible:
> 
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: cpu@0: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['sifive,e51', 'sifive,rocket0', 'riscv'] is too long
>     Additional items are not allowed ('riscv' was unexpected)
>     Additional items are not allowed ('sifive,rocket0', 'riscv' were unexpected)
>     'riscv' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Hi Rob,
> 
> You previously acked this patch but I think it will be easier if you
> take it directly.
> 
> Best regards,
> Krzysztof
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Applied, thanks!
