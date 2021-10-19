Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C1E4331AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhJSJDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:03:15 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51454
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229930AbhJSJDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:03:14 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D06243FFDC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634634060;
        bh=RMajkc4I3FVoI6+Wp3gZyvuOiuHKTewU/0j4GZxBxaQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=J/b/mbGsCc5LTscxI6IeyMekCT9hMwNPEiq8S0jeQ/m+l4UpI2IadLVyC6z+rHq9r
         Vt6KD/xsABdJ3PCGNx+o0ut5ftd7bHYkXlYQgzL3fiAPxgBUdGeTCXNnQqL1+25QPm
         ++Oi1+KXG/mh+z19rG8vY5rxcHRgwa1YtpEcDC1+YUbog2YSRTNS7s1aVWZsnBFWNa
         1H6hMm6AuCqj33gwHKvNuuLh2cL1n/dmXVrPh//VeMWq3Jxv6/qWXsETL/uETUi9v7
         b0Q+QBcygoG/fVNKV6EllvCjmZV6E1rkn15LtxFlRJwAqlUsZkN+NZfJJg3YADe6dj
         aHsQtltuXbP+w==
Received: by mail-lf1-f71.google.com with SMTP id k18-20020a05651210d200b003fd86616d39so1178717lfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RMajkc4I3FVoI6+Wp3gZyvuOiuHKTewU/0j4GZxBxaQ=;
        b=DRAOalGIqfHju2OW1+NvCt+GWVzhn8SDUKs7yqwlWIM7s+Ub9upo5fWkCjFQnwDdSJ
         fqmE7qlh4osExB323lJ4ahUYomXKLfTKBNhJtF8Up7E0gFAeTiHEFLwGaFzQtF6xYIFc
         /aUxglsVYHDBoqxiBw5SlUrHg2Rv9vytgKFBc7yp/d679QX2JbWRU02mV67NtCTajdnV
         BV/fau2sMyPGL5op4uecna/ikvFKm0P+V6iysM4BPajznop8iQRJcWETrGthka1HGFK8
         yD5A7kcZdTcu7vSsh24dbMAv6Kl7rYayl0iyzf8jaIdz/g9b2EZ3yb+bR5cQFjtxmf1o
         4d/Q==
X-Gm-Message-State: AOAM5332352VyPDrHhVoT2w5R9aoku5LD+DmYYLGXCkT9WN+2O57E81e
        Yq+7HL/gPPCxxY/N+rJH/RjLj02BqTrd/1jBl3NC8dWbX1FEL/DanLnDshyDnX7PB69gcFtYbhc
        VRacOr1cS3qWksad7YRdyuQJI00gSL7X2tmr4gGbjUQ==
X-Received: by 2002:ac2:5d52:: with SMTP id w18mr4990211lfd.598.1634634059732;
        Tue, 19 Oct 2021 02:00:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWpaMw9n1ML2pcTlEiTBVS2ylCobbiDUJAMaO3ELY0TCWzs3TrxcN8V8FoKgyui+ZytbYeZg==
X-Received: by 2002:ac2:5d52:: with SMTP id w18mr4990192lfd.598.1634634059488;
        Tue, 19 Oct 2021 02:00:59 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id k18sm86727lfg.301.2021.10.19.02.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:00:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RESEND PATCH v2 1/5] riscv: dts: sifive: use only generic JEDEC SPI NOR flash compatible
Date:   Tue, 19 Oct 2021 11:00:52 +0200
Message-Id: <163463404795.23115.14748573491973282125.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
References: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 15:02:44 +0200, Krzysztof Kozlowski wrote:
> The compatible "issi,is25wp256" is undocumented and instead only a
> generic jedec,spi-nor should be used (if appropriate).
> 
> 

Applied, thanks!

[1/5] riscv: dts: sifive: use only generic JEDEC SPI NOR flash compatible
      commit: 8ce936c2f1a68c3a4f46578eed016ff92a67fbc6
[2/5] riscv: dts: sifive: fix Unleashed board compatible
      commit: 65b2979d52ebf96ed8261d82d84c62acf737548d
[3/5] riscv: dts: sifive: drop duplicated nodes and properties in sifive
      commit: 20ce65bf89aab248886b80d1e7fa12277b2a0f2d
[4/5] riscv: dts: microchip: add missing compatibles for clint and plic
      commit: 73d3c44115514616ee9c4f356bb86d4426d0fc36
[5/5] riscv: dts: sifive: add missing compatible for plic
      commit: 9962a066f3c1d4588d0dd876ceac2c03ef87acf3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
