Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0455B341A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCSKga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:36:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40344 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCSKgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:36:11 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lNCUD-0000se-W8
        for linux-kernel@vger.kernel.org; Fri, 19 Mar 2021 10:36:10 +0000
Received: by mail-ed1-f72.google.com with SMTP id k8so22580954edn.19
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktHOzWahPd2LQ9icir3lUZmC+ztJuw75XTCkzt8BS98=;
        b=SDBG9D0GGKV5MJ84sK5iin/iG185yifLSyARhS/2DrWLN5hlfj6aX++UUjE2+rSxAf
         WO7mt/yw7+2onNe+G3p/HPmJLlOQOaHCZp/WvPi7a6HoBj4RJzDjL1zRWOjOUOTsMzrs
         VR+MnU6BbxTtWCOlpjKy1NLWIEfHCwL79ZjM1P5TLaMPaADdk4QDZ+UQK7HVh/fE9z9V
         +3YQJUXiGdX/Dmvc+O+sS0p5WPndENsctp+2G8DcL9QF3RuqjP9g9F2f3JTQ4/6SW9KU
         frsx7xOHdILKzaVKtVAx45qxwcn7anIWGHn5YjIyeEwgVSlwjxMDX1uq+IOdyOR5AIlO
         8jFw==
X-Gm-Message-State: AOAM533ZaexO6sELvTuMUj/8q0yhWml4a0b2vM3j/W9Rn1dSDjo2erYV
        57h6OP6/bnMbIVF/DvZYpoTKsLvH3uV9m46wBn8hq5iPnLsprOheJR+cT+MiF8xkA92fJwv4Ih1
        Al8unjdZGtQPj8J1pVo+d0UquAJzF9PmkpNzaKghhEw==
X-Received: by 2002:a17:907:72ce:: with SMTP id du14mr3504498ejc.301.1616150169794;
        Fri, 19 Mar 2021 03:36:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAQyLtHwJgaaBm7E08MxH7vvE0tikBi/QO2/jypkyZkmGfwIH5ycZjFx2iwfpRXblNOupoDg==
X-Received: by 2002:a17:907:72ce:: with SMTP id du14mr3504483ejc.301.1616150169636;
        Fri, 19 Mar 2021 03:36:09 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id h8sm3822589ede.25.2021.03.19.03.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 03:36:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/3] ARM: dts: exynos: replace deprecated NTC/Murata compatibles
Date:   Fri, 19 Mar 2021 11:36:05 +0100
Message-Id: <161615015846.19086.10537563136172847080.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315124313.114842-1-krzysztof.kozlowski@canonical.com>
References: <20210315124313.114842-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 13:43:11 +0100, Krzysztof Kozlowski wrote:
> The compatibles with "ntc" vendor prefix become deprecated and "murata"
> should be used.

Applied, thanks!

[1/3] ARM: dts: exynos: replace deprecated NTC/Murata compatibles
      commit: 61342bc64d03d88fbdddde6247f490504257f36d
[2/3] ARM: dts: exynos: white-space cleanups
      commit: 4a4f3a07a5c419ee8e527ff2c9a35eae93c3d04e
[3/3] arm64: dts: exynos: white-space cleanups
      commit: 7d2636e9d6dd884ae2ec6127f29963d4da0dfe6e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
