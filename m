Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B23A6F24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhFNTfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:35:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35370 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbhFNTfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:35:20 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lssKi-0000AF-71
        for linux-kernel@vger.kernel.org; Mon, 14 Jun 2021 19:33:16 +0000
Received: by mail-ed1-f70.google.com with SMTP id v8-20020a0564023488b0290393873961f6so13445121edc.17
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qoNs0rkeMMUPf/jH63Pbn4GEa6xEussm8RBcM0JZAj0=;
        b=b41ozAYOIvylxR0ZICVBXXyqTyHvXz8dGjD4J1n8DvkcDCDddMWYZtnnIxgvQD/7zv
         ceW4EVgNfc+CE/+uduPMKnc/h1LkKgo7XfB1lVpL/KthKNZLHAhB36oX20i+oT/czBnt
         XSBo7EpMwGC5E5FsXUIpajEqNuVRJx+BadM20zgXeSfMVgIz/DH9jZjIWQJlkQ3YJtEP
         yl6vVog6j7RioPZPDrnQE4loHi51y0MWKqbyZ94vdkgRgusRqC6t/30muapILfnKmbiA
         x61FWL2j39rX0evdRyBoyBFMfnSZx5p1lO+x19yIju2mwW2GxTAlx0xvh9JO3XXD+DuD
         G1EQ==
X-Gm-Message-State: AOAM532BZOgx1jR82sF58ISJTXPd2JF/Q/L5Am2bn+H/2wb55/RyrsCr
        LHAOtvmOg6ucalnVrzFzZWWYSujinClPCcKwvR/AUI85rcOr7WbjPpsH6U8V8C7VdFOiV8CQDMb
        mGtj4raNz3Hb/tfdaS9bWJKxsQV1dfN2ziRdhxUTRbQ==
X-Received: by 2002:aa7:c818:: with SMTP id a24mr19448647edt.53.1623699196023;
        Mon, 14 Jun 2021 12:33:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq1B8upiBsEetFmAjSMtxkDRFzyHcPey+4IkR631CQiOXVzgOKDik6rb85uCWnTOZsFAP0FQ==
X-Received: by 2002:aa7:c818:: with SMTP id a24mr19448632edt.53.1623699195929;
        Mon, 14 Jun 2021 12:33:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id gw7sm8029291ejb.5.2021.06.14.12.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:33:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/2] ARM/arm64: defconfig: samsung: pull for v5.14
Date:   Mon, 14 Jun 2021 21:33:09 +0200
Message-Id: <20210614193309.20248-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210614193309.20248-1-krzysztof.kozlowski@canonical.com>
References: <20210614193309.20248-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-5.14

for you to fetch changes up to 38f61ef1a0cefb4e3b37c3e7b16c0f68df34a3dc:

  ARM: exynos_defconfig: restore framebuffer support (2021-06-11 12:54:33 +0200)

----------------------------------------------------------------
Samsung defconfig changes for v5.14

1. Enable Exynos Universal Flash Storage (UFS) driver for Exynos7 arm64
   boards.
2. Restore framebuffer support in exynos_defconfig.

----------------------------------------------------------------
Alim Akhtar (1):
      arm64: defconfig: Enable Exynos UFS driver

Marek Szyprowski (1):
      ARM: exynos_defconfig: restore framebuffer support

 arch/arm/configs/exynos_defconfig | 1 +
 arch/arm64/configs/defconfig      | 2 ++
 2 files changed, 3 insertions(+)
