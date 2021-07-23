Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA163D34A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 08:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhGWFq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 01:46:56 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:59576
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233879AbhGWFqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 01:46:52 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 62C103F34B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 06:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627021645;
        bh=BVfxHW5e0txMWNeBpenkIfYlW9+/vHPUxzadxmisj2M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ZrnFRL0GfkWrskmb3/CFK89YlQ08WG+8vPLS1bmowGdzTdW+xJAjKbV62gIyv9ho2
         Mgk4BQj3KGuZj4iCHdGmS3xUc3icnqrnH6daO7n7i/EozYAw6s7n6FNXAsC3dUZiqJ
         CHn8Dtg+o7/a5415rTycOc92K2V+C3uQQhL6pR3TMB6CBXVMm2igknPfTLaIWPp8gc
         y0VlRo8N5qa9PlG100s0njrByt24ir2DUkXpzWm3X1/1HZ4Nm7vmb4fO2kAZY5ANFS
         9seE225FGDn+8nibd1pnXK2LYIQVH602qi76gvqPgb09oBl2fEMisv4Y/Uvy6kQN4W
         cPKwcmCJqCi0Q==
Received: by mail-ed1-f70.google.com with SMTP id b88-20020a509f610000b02903ab1f22e1dcso159340edf.23
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 23:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVfxHW5e0txMWNeBpenkIfYlW9+/vHPUxzadxmisj2M=;
        b=XM8sET3AoD3pK3VkDCR4lP3Z36gw8GTPo1wmDfexZNYuugSIYr3gLRn5Cf+b3QR/DG
         3rR5WAF2QrkvxE81dlU21FLHt9kiQs/w+wRTjG+wU/nBghKtY2Y0CSYAePjGrZ5XYVkL
         gkr9U7cAA/fvDDuxwuPElCxKHqI/gQm9Ds5pgaBNb9qURFalWniDY0Jda0aOPD8B+yvn
         pXjlJNJeyQ/6ZIf5eWTVVfc7oWyZ65LG+7H/BzWfDWDFjSnFpCbFN4+aGAIqcQ/vzUq5
         0JYTu2C5/Xo16ujkJiGnLLjltGWL49SEhaTH3D22CYGoB96vqiRgqiiJb84lia+o16c1
         EwTA==
X-Gm-Message-State: AOAM531ZgfybMfa+T/rlZs6y+jOAAdB6tpcTUFAduHICm4R5xz4OMTLL
        hTIUqPNdOPW6Bf8aJAUsCDP4k6ebvsjfs7egZRCy0hvm3ZcOV0VlOBwMCuFQm4WwjLvE99qUz+6
        fDx+i6H2nbj7nfa3uThG+nGxggqfrd6ruEBkf7lEblg==
X-Received: by 2002:a05:6402:14c7:: with SMTP id f7mr3836125edx.84.1627021645159;
        Thu, 22 Jul 2021 23:27:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7YBaLklYdx8pMyrPGwqRyW3BrTXsuwbNayQmX95MvMBycvj7QgE68fkUlanxy0AVX3tZvBw==
X-Received: by 2002:a05:6402:14c7:: with SMTP id f7mr3836115edx.84.1627021645050;
        Thu, 22 Jul 2021 23:27:25 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id u5sm13449844edv.64.2021.07.22.23.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 23:27:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: fix unused-function warning
Date:   Fri, 23 Jul 2021 08:27:17 +0200
Message-Id: <162702163037.6229.205743572149857743.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210722090748.1157470-1-arnd@kernel.org>
References: <20210722090748.1157470-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 11:07:43 +0200, Arnd Bergmann wrote:
> The tegra186_mc_client_sid_override() is only called from
> an #ifdef block:
> 
> drivers/memory/tegra/tegra186.c:74:13: error: 'tegra186_mc_client_sid_override' defined but not used [-Werror=unused-function]
>    74 | static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] memory: tegra: fix unused-function warning
      commit: eaf89f1cd38cf7256ab64424fe94014632044d57

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
