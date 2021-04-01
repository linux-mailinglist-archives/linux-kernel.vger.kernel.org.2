Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84843352045
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhDAUDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:03:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45358 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhDAUDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:03:13 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lS1T4-0004IV-Va
        for linux-kernel@vger.kernel.org; Thu, 01 Apr 2021 17:50:55 +0000
Received: by mail-ej1-f70.google.com with SMTP id li22so2551710ejb.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 10:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jI4Q1f6JmKvUhseU4uFtZHzreA5O97M1GFvewVTukcc=;
        b=gW4N6M+14HV7tCHfF8Iwn60l1LNXWX8O/YH3BaUIRno9HzphgLUmHLKF/zSJ+i7Uxc
         iW4mXlD6MdvMzg1JppD9VRVuTSXH2C3TAyj0P4k0n2bZGuzTGQjA+ogefww3mSaHELRa
         oN+PIXugDLgD9uLzEpg68V2+Q0mmPckYuD5URMp6YXzD7vmuwlbHvL0M+6pCG6xwoudG
         w7CNi+4gsY/R4goIsYHH1oI85D6fr9wFIINF/ZUuli5dPjL8rgUP0PYrNru3fsmhIQKC
         YMgCOCe+Y9e2vSanCZ6yPaln1GECOQ3s8GRPOQXICyPsEMwot2S6b6GlqsIck3ZP+nYV
         FDXA==
X-Gm-Message-State: AOAM532sOnmN6dJ0Ru3WZKb8Ps0uOAR+XlqZT7SjmO8gPjUyi9SfKaBQ
        sBrvAGKvQeZX40PuhxQPj4MkIQIJly8JX48KIkfRRBLZtsiYC8xYvD60yZHNRgawEnJsTJyGzej
        wEKyyJCdMT4mX/cZMolm1slvSDy6/PDu3R2xhMmmmHg==
X-Received: by 2002:a17:906:86c6:: with SMTP id j6mr10041941ejy.197.1617299454729;
        Thu, 01 Apr 2021 10:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDSkyQ6PuA/8iyU/VtM67QamGObdqG0BXSB2U5ohluI5HgA3wKWbFxOvwx6jhDgk/pg1SS7A==
X-Received: by 2002:a17:906:86c6:: with SMTP id j6mr10041932ejy.197.1617299454607;
        Thu, 01 Apr 2021 10:50:54 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id v24sm3137066ejw.17.2021.04.01.10.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:50:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 0/6] NVIDIA Tegra memory improvements
Date:   Thu,  1 Apr 2021 19:50:52 +0200
Message-Id: <161729942370.11933.4405261208235446764.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330230445.26619-1-digetx@gmail.com>
References: <20210330230445.26619-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 02:04:39 +0300, Dmitry Osipenko wrote:
> This series replaces the raw voltage regulator with a power domain that
> will be managing SoC core voltage. The core power domain patches are still
> under review, but it's clear at this point that this is the way we will
> implement the DVFS support.
> 
> The remaining Tegra20 memory bindings are converted to schema. I also
> made a small improvement to the memory drivers.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: memory: tegra20: emc: Replace core regulator with power domain
      commit: d46cf7106c4979117e108336dfadcaf57d23f9ed
[2/6] dt-bindings: memory: tegra30: emc: Replace core regulator with power domain
      commit: c19137a97e39a9cdf24c9feb580af4564997c1f9
[3/6] dt-bindings: memory: tegra124: emc: Replace core regulator with power domain
      commit: 749d01cd0b796adb69d68e9079520f4f95b17cd2
[6/6] memory: tegra: Print out info-level once per driver probe
      commit: 06949d1d9accbc7d3a029536650162bbca30151b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
