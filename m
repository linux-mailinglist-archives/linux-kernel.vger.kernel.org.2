Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDFD41D90E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350570AbhI3Ltk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 07:49:40 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35002
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350490AbhI3Lti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 07:49:38 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0FF38402D2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633002475;
        bh=2I691nvxU/lO8++QbjVQLPuSPw++eMWKgLS4yAxN8zc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=MQMJtlxuUSexb6eLopj9TGoKs0f/cEuYxvS3XOuM4JXgTh4rRK5SVmjEbJJ6beaiy
         mMFtvixKxRJKXo1IccAr8Rl+lV5kKrvgpRk2VFsF26BgiI9XSdHx8PCXGMpOLDM6bp
         U38AzUPtWx6nurq5MmE0Pq9VZvfxCkOLgW/stgaCnU+r3b3Je1W5EmMUK6zaZLINw8
         +lMGhr1gBBZufDNhDvM6QZmyDPKpFmJphC06bdYC7r7iFTmF90ZT/0zbCpzcDXUvQ+
         91kzHOglVOQxfMqGRGbO74tteO6mbCBVpjeekpESkdbbXCJ28gcJgDonk+H7r1YTRj
         pbMFbfQ5fJtbQ==
Received: by mail-lf1-f69.google.com with SMTP id i40-20020a0565123e2800b003f53da59009so5358327lfv.16
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2I691nvxU/lO8++QbjVQLPuSPw++eMWKgLS4yAxN8zc=;
        b=MGqSb7FhpWIXPstbgQoX2rdK5XAHTZk7s+3GGOg1Sa24HR+w9/zOS6TzIvfhanuVmm
         E31hHvBuHQpdLrBJmPp2CdgUaduSXEArt73a105X2V8svqyGRD9U/QBSdZqdwOj3fbEu
         tw3XXnTzCQtPhr/R2ZWeDOuBZkdwX7Y17Q5f1bvLgwfi8Is46SOuoFU6KPwpKL+dOH5K
         JIQpYakwDQ3q/CnBPjK00Z4vx88iOWrqolLJgWdWEm4zJH3mFwStj2Bg0h3MDsT32LNY
         Wnwxb/lVuA8cAorrzghkq0IOUDUX0O1HUQV85AdCcswgvg5lqKfn2DUgrkVUEwjIDOTa
         eirw==
X-Gm-Message-State: AOAM530MYTjnMQLG2oieN28pCSxIOEPNQGcPN9yp7r2XWC3pz9VDZJav
        WnewjoMZMxzTBZYFug0L4sF9/NQuvu644GFFOd8m/FgmHGaUhfdj41JMsk4Pzqwmx8B/4FoyGuT
        Xn+eZtsKHtxOncsEAaMnMu+9g5t/IK+HwEuUCy8t6bQ==
X-Received: by 2002:a05:6512:3a96:: with SMTP id q22mr5172730lfu.228.1633002474481;
        Thu, 30 Sep 2021 04:47:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxxYXwhD32IdBAqEB2fAWGTXTprOHL2G3T691kTIriVXTz9p4loVv7RSJMT2Gvh5L2Ki1NSA==
X-Received: by 2002:a05:6512:3a96:: with SMTP id q22mr5172709lfu.228.1633002474326;
        Thu, 30 Sep 2021 04:47:54 -0700 (PDT)
Received: from localhost.localdomain ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id w19sm311349ljd.110.2021.09.30.04.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:47:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: (subset) [PATCH 12/12] ARM: dts: exynos: use spaces instead of tabs around '='
Date:   Thu, 30 Sep 2021 13:47:16 +0200
Message-Id: <163300242600.178519.4513175036717923621.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928084949.27939-13-krzysztof.kozlowski@canonical.com>
References: <20210928084949.27939-1-krzysztof.kozlowski@canonical.com> <20210928084949.27939-13-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 10:49:49 +0200, Krzysztof Kozlowski wrote:
> Use spaces in Origen boards instead of tabs around '=' for simple
> property assignments, to match coding style.
> 
> 

Applied, thanks!

[12/12] ARM: dts: exynos: use spaces instead of tabs around '='
        commit: 7ec804d6025c952e3122ad7fe768178efca3300e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
