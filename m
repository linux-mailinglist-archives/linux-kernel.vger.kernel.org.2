Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93915352043
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhDAUDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:03:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45358 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhDAUDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:03:11 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lS1Wb-0004kP-12
        for linux-kernel@vger.kernel.org; Thu, 01 Apr 2021 17:54:33 +0000
Received: by mail-wr1-f70.google.com with SMTP id b6so3097676wrq.22
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 10:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dMbR7wCBt/+xH/e8sgRUmjWpaig2muqZGSN778lIFA=;
        b=ZwYQZjV/Yc4cvzQdXHExjE9uGnVl4Q/7n540RtqznEKTvR5jiOSOu+HOUMElYq1L/3
         +Iu5LeODzxQhtpBP6G8Dc1WkDPpfm8X8lDN+mAIj6iKeYTGKWbI0B5/NJqmVivyfOag6
         uKdYP0/kHnL27f3N5knWBBYMv0CyQru3onY9g7MaA4dZ6Gzl7Q9XrB223Cj8muCDdkbP
         k7LiI+OeGGLlROICteEtX8wnqbNNes5v5c+g/0JgnMpZTfBajEGLS+Tb7DAT2VZKu5bP
         OfAdtaAGa0av0RKnDlGdwwZKglvtdpWqexuotrX5W3Mxhp1CMOHciEsu1EfBryYpVisM
         6DOQ==
X-Gm-Message-State: AOAM533LK+zee+mOu+yXcF+Y7cxNDC2eoh0B1ftOgTfRse9/4rThIhYf
        BIYPtCpOXUZbm5IICsqlQLmPCJGe4D2ZEmidYnKoKJA01y09Gy+nWe2OxK+2JUefPnevbSwTvDQ
        VP6RUIkkJm64ycA13RCJPwcr01FtTQmqOANi+aetIyA==
X-Received: by 2002:adf:ec01:: with SMTP id x1mr8807891wrn.353.1617299672595;
        Thu, 01 Apr 2021 10:54:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbSdlZKPMXFL4nQftb0j/6maPjV/oqPt8S+RTK5Jj3mxkExo7AEjR5QNpmbun8G+weRTqHrQ==
X-Received: by 2002:adf:ec01:: with SMTP id x1mr8807876wrn.353.1617299672482;
        Thu, 01 Apr 2021 10:54:32 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id c9sm10481524wrr.78.2021.04.01.10.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:54:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/6] NVIDIA Tegra memory improvements
Date:   Thu,  1 Apr 2021 19:54:30 +0200
Message-Id: <161729966152.12691.6136048726737117285.b4-ty@canonical.com>
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

[4/6] dt-bindings: memory: tegra20: mc: Convert to schema
      commit: 6553fa57cb1707396ad3a27dc78fa61e1750ab31

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
