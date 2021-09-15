Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98F740C0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhIOHwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:52:34 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51286
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236739AbhIOHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:52:30 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A7C734028A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631692270;
        bh=6nQjB01kMNpwJ9V5V82yNfJ9kQBFgtVaK0a4ZeKC00M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=E0LxNg+pJXlVHPvt3Znxbt/bWERd6avSeY3jKqaZgZ39B7YGLg7GP9RVxN0Oo9kOi
         9QZ50LwnVL+4CA2p530RccQFWeLxl8/ABXgorwdVIsnIqxkEl6PBH889zd8yNB5mYY
         I/QH9JokNuSVyeQmyp7DIfLkxMP+E/fof7hh5ISQc3X5ExrEdMgPJQ4usUQlUV14un
         HrVmzhVTPi3gShZoZBlyiuSqlKf7b6lNOJBIN8QVdCwr+4OIhnzR50tenOyFclYpH3
         HiY5b3s7O+lJEokQFtUleNpqx8UePWP2YAMe0sj+mIiRhAedhn4vzxuBmbaK6UUDto
         A1k8n56+fwamQ==
Received: by mail-ed1-f71.google.com with SMTP id s15-20020a056402520f00b003cad788f1f6so1081927edd.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nQjB01kMNpwJ9V5V82yNfJ9kQBFgtVaK0a4ZeKC00M=;
        b=QiVbPgxoD7hGGJiVQyLBM2x+AKPss7KON6ORlhESKPWDLIPsa4zs7jYC0OKNjoyRAg
         Pf6u7IU7daK+KUh55lZHYy9hNm0b7cTX4VJHKZ3pJHdndV/EQ+jH2BtTdPsb9LDIVa7u
         Ke1bW9Ljk9zKnwBOjm/KQgkC8rbH1j40LTZn0Uye8odFl79Rsa2aKF2AO71LxC7uTNQ3
         rhxyxBPt7WTDIz5DUpI20gmR64c+a2uFibJd8pHifClxMFv6yaeGQ5LC119bKvJhlbeE
         Qy/SvfiOE85vJ3vV9LT9LTBz1r4xG6p10+SBa75irzjAGYIS9fcMg2F1S5KdvcFtVYJx
         7+Yw==
X-Gm-Message-State: AOAM532VFfs4cY2yMgufMWF7XR8Vad+8ocVcIA0XaFYSwhKOVDRJPn8Z
        ONHtciMNsGbCFE/IuPbQ55aIkbJuqDQamAX8JXlBpbOjy4pfVDaRisCQnLo/dbTl/647UENkSps
        /U6tJTSSCzg8IlJWBaUz1TjGm45KTZzQmt8CajcfCOA==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr24646917eds.149.1631692270182;
        Wed, 15 Sep 2021 00:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA2tbVQBLoL30Jl3YTk9ku6S+NDv6sYxofUgnF4egYt9J3Tr5bgPCBwS5p3dKNR9Or91yKYQ==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr24646901eds.149.1631692270057;
        Wed, 15 Sep 2021 00:51:10 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n11sm591922edr.51.2021.09.15.00.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 00:51:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: samsung: exynos-pmu: Fix compilation when nothing selects CONFIG_MFD_CORE
Date:   Wed, 15 Sep 2021 09:51:00 +0200
Message-Id: <163169222223.16372.8442242827654330539.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909222812.108614-1-virag.david003@gmail.com>
References: <20210909222812.108614-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2021 00:28:12 +0200, David Virag wrote:
> Commit 93618e344a5e ("soc: samsung: exynos-pmu: instantiate clkout driver as MFD")
> adds a "devm_mfd_add_devices" call in the exynos-pmu driver which depends
> on CONFIG_MFD_CORE. If no driver selects that config, the build will fail
> if CONFIG_EXYNOS_PMU is enabled with the following error:
> drivers/soc/samsung/exynos-pmu.c:137: undefined reference to `devm_mfd_add_devices'
> 
> Fix this by making CONFIG_EXYNOS_PMU select CONFIG_MFD_CORE.
> Fixes: 93618e344a5e ("soc: samsung: exynos-pmu: instantiate clkout driver as MFD")
> 
> [...]

Applied, thanks!

[1/1] soc: samsung: exynos-pmu: Fix compilation when nothing selects CONFIG_MFD_CORE
      commit: e37ef6dcdb1f4738b01cec7fb7be46af07816af9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
