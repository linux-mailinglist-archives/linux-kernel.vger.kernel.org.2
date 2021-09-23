Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60904163BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhIWRBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:01:07 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41507 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhIWRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:01:06 -0400
Received: by mail-ot1-f44.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso9379781ota.8;
        Thu, 23 Sep 2021 09:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1i+M8EOr7e57ftQjdyXXIOehi2M7Hp7GON39uqkaep4=;
        b=urD8tnNoP15us9B2BiaQzewpgBT8gMx9dolQalsVOt4BnyLIFuzaLdL2e3pV4NxSIT
         aKv7oBbDBMz+2dhbi5XoO3aMsJB7jTmbMqqrNa5tOKYMwuaZ2F8i06u3gIsiNObBdSw3
         7lIPAh0S8pOAIxqUkwkDQVb7hEtprunXOgZRtXM/ixbTwrq8qZtbk7BPqLWjLT54b7pr
         yigVF10n2SDNxtwTUo2x940Y5OqrWpGntgQOSNRbbdcLF81wAteuumnyS2z3TG5/xUT2
         9rUs0/EUvKzyV4L/nvQADoXe8zZCelg1Mqb1Smxg7Lr5RcYLk83mirn06Z69XCKA9nsy
         xpvQ==
X-Gm-Message-State: AOAM533wcSV55Pz2TVeuoUDFlFghdoZlD0EUw7T8uH3ivRTIJjPF1nwh
        Gdzhu0HaaKIqwKwr3nGq22vaK9TtIw==
X-Google-Smtp-Source: ABdhPJyJacfEO2U/tWDyQhP1Mzyf1Ng9ln0l9pqO8lCSU02mh5acU8WvyIVenmskQ9rvKbUnPHh2iQ==
X-Received: by 2002:a9d:7b4f:: with SMTP id f15mr5168057oto.158.1632416374200;
        Thu, 23 Sep 2021 09:59:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g23sm1407552otl.23.2021.09.23.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 09:59:33 -0700 (PDT)
Received: (nullmailer pid 3169434 invoked by uid 1000);
        Thu, 23 Sep 2021 16:59:32 -0000
Date:   Thu, 23 Sep 2021 11:59:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Zong Li <zong.li@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] dt-bindings: clock: fu740-prci: add reset-cells
Message-ID: <YUyydGrDNzISu6JX@robh.at.kernel.org>
References: <20210920144944.162431-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920144944.162431-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 16:49:44 +0200, Krzysztof Kozlowski wrote:
> The SiFive FU740 Power Reset Clock Interrupt Controller is a reset line
> provider so add respective reset-cells property to fix:
> 
>   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml: clock-controller@10000000:
>     '#reset-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/clock/sifive/fu740-prci.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
