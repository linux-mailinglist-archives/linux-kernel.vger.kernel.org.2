Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC29D42EA8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhJOHwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:52:07 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41354
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236023AbhJOHwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:52:06 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6AC4B3FFF6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634284199;
        bh=7smbl6eLUD4Ng7INT7EmfV0PC0U+CLmxI4ShvMsaSUI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=SHkRvXilUBRGAWNlMH8avnOHc8YZpTHjxEbLn6TPr/lW1MJqM4OITyAeoPzYJZkgP
         gOot7M0hM00Thh0sBFoEajhfLOe+kSOuiySPj1Yjwyt349EzHc9dglF7lARbrLSDN6
         a7FxigDlGlWNk4o9jlZLA1hhVRDFCxDAT2jQ1a3JyFtnttqbwN3mVti4t72atI9jwy
         ELdkbmjsbu9aFMCNPrZFKgdwPnaa1flMW3D/QsPj6+gDj3zlpKbT2cGqDvWvGyw5dz
         c8mavY6kSvs8I6B/Dtcq9BSVNSkyxv+p1wi6xBBZgCyykpu4n6ou1wNeUHNSQakjID
         zzlT5JAt8LqrQ==
Received: by mail-lf1-f72.google.com with SMTP id br42-20020a056512402a00b003fd94a74905so6092813lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7smbl6eLUD4Ng7INT7EmfV0PC0U+CLmxI4ShvMsaSUI=;
        b=YSSQ1AMwt39Ih2OY3gRJt+HlpIZ3jTcRjxPOAE0Q2tzYDD3CZ5XvQm8AKNfH3HjQCN
         H492PcrL582a/dZBHR29axIJa1dCYXLmV3ajGoysN0y3g2z5lKD4r/FLK+E6alKQXwFC
         auCsLn61svAbLykIU7MMyI+iyKv8b96IOtRTQ5q8nbK/VPzpT2a/nWjipbWWe6dK0L2g
         tYdvsWLYHtK9dNGCSnLVkek/UBboN53Rnx0v87/DWZQAEATuJjNL+60/KoRBuELYTWB7
         3+lcPi3DxmKApm6wxTpsYWyLBCUECbFtrZRlcYc4mZM5BTUzwNuNkwXzfQNtEj7GKN2N
         ye3g==
X-Gm-Message-State: AOAM530op/tt3ugo5tKAOb8vw+7z55W6Gh7R4SI4ksrK/RKNpxzqRn+h
        vfU3lpZZ2k97u1OSNUBhUVGrmpX6BhmYii8WwXskC4i70TE/4A+afb6T69/htqIO7aVDUcPKRiv
        SQy1qUy0xlA3dMDXcThn2ddsCPeam4E5wuXThRP/iMA==
X-Received: by 2002:ac2:518a:: with SMTP id u10mr9699302lfi.367.1634284197782;
        Fri, 15 Oct 2021 00:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziBffQry3SgAM9Levwhe7XIZoAbKqytJfrPn0AsnDIQAmbq2ACnGZxDC3eOF/mYKKppo+2ag==
X-Received: by 2002:ac2:518a:: with SMTP id u10mr9699284lfi.367.1634284197607;
        Fri, 15 Oct 2021 00:49:57 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p16sm431493lfe.166.2021.10.15.00.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 00:49:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] soc: samsung: exynos-chipid: Pass revision reg offsets
Date:   Fri, 15 Oct 2021 09:49:55 +0200
Message-Id: <163428419206.64320.1460944164027641564.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014133508.1210-1-semen.protsenko@linaro.org>
References: <20211014133508.1210-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 16:35:06 +0300, Sam Protsenko wrote:
> Old Exynos SoCs have both Product ID and Revision ID in one single
> register, while new SoCs tend to have two separate registers for those
> IDs. Implement handling of both cases by passing Revision ID register
> offsets in driver data.
> 
> Previously existing macros for Exynos4210 (removed in this patch) were
> incorrect:
> 
> [...]

Applied, thanks!

[1/3] soc: samsung: exynos-chipid: Pass revision reg offsets
      commit: c072c4ef7ef09e1d6470c48cf52570487589b76a
[2/3] dt-bindings: samsung: exynos-chipid: Document Exynos850 compatible
      commit: 0a0124065fcd6b5e42968edbe33f85c7846d3f8c
[3/3] soc: samsung: exynos-chipid: Add Exynos850 support
      commit: 81a51eb6be3dbb76790b7353ec8dfaadfc751782

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
