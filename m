Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD64D3B3D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFYHib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:38:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34614 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhFYHia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:38:30 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lwgNk-0003je-Vh
        for linux-kernel@vger.kernel.org; Fri, 25 Jun 2021 07:36:09 +0000
Received: by mail-wm1-f72.google.com with SMTP id p22-20020a7bcc960000b02901de8f2ae18aso2374143wma.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nbaaKHR5ZpYe85F3BN+ohVLxdeR5Xvy5GBXCZuo0Jew=;
        b=oz2oKoqyYw2PU5jVkscOCpmF4959gnuzfYrXjfdFZx5Qh7lM/c03TvzA50HnQtGOvq
         aDb64LzyJPdPpBVGN40QDTWKc0gY8qAJotd3xuADdDefbcJ2k21a30VIAkTjv5rCp6Ye
         U67YCCS9+BpSa93v2pN6MtFRoA+U/5LqDGY8sKl0aCWwRbchH+d+TG1Y3NXLz08CtqYy
         OVJKvDlTZAPIgHDX9uTZyEWMXW5H3f9iFM5HinrD9t6kbdgDsbb9fqXVRMCbVtB9fYP6
         UWlg8Jq23Ms0ehK37xwPiZSHqjzmgO0K20eY0+gqpUxUoSmdcEjdmWTTBfkzb7jgMO6e
         yFbg==
X-Gm-Message-State: AOAM532LwKwaXZ+833R6f5b9dQ2LEMQeZLQPY61CZyM6pPo935WGDnyI
        XW+ucSQyw3WfVruvZfP0zOIyMyMFz/4pItUBs5SV8SnrkpYo15EuovCmDzKjhc+JT905cSIGVSe
        v9o3UyjPR8R9WQE/EzZjb0ytPDX/TejNE6SdsBINwFg==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr9338953wro.194.1624606568269;
        Fri, 25 Jun 2021 00:36:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3dKrCURHFg3PIpYiy6kcKs/cc8ALeRf55hqXv9kAgRiaHVuodNNseBYhflvBvEBS/f5ZiPg==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr9338931wro.194.1624606568114;
        Fri, 25 Jun 2021 00:36:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id d3sm5343681wrx.28.2021.06.25.00.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:36:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Subject: [GIT PULL] memory: tegra for v5.14, late fixes
Date:   Fri, 25 Jun 2021 09:36:04 +0200
Message-Id: <20210625073604.13562-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Late fixes for Tegra memory controllers drivers for issues introduced in this
branch in previous tags.

On top of previous pull (memory-controller-drv-tegra-5.14-2).

If it is too late, I can send as fixes after merge window, but maybe better to
get these into merge windows earlier.

Best regards,
Krzysztof


The following changes since commit 2c1bc371268862a991a6498e1dddc8971b9076b8:

  iommu/arm-smmu: Use Tegra implementation on Tegra186 (2021-06-11 08:44:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-tegra-5.14-3

for you to fetch changes up to bf3ec9deaa33889630722c47f7bb86ba58872ea7:

  dt-bindings: arm-smmu: Fix json-schema syntax (2021-06-23 07:55:10 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.14 - Tegra SoC, late fixes

Two fixes for recent series of changfesi n Tegra SoC memory controller
drivers:
1. Add a stub for tegra_mc_probe_device() to fix compile testing of
   arm-smmu without TEGRA_MC.
2. Fix arm-smmu dtschema syntax.

----------------------------------------------------------------
Thierry Reding (2):
      memory: tegra: Add compile-test stub for tegra_mc_probe_device()
      dt-bindings: arm-smmu: Fix json-schema syntax

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++----
 include/soc/tegra/mc.h                                | 9 +++++++--
 2 files changed, 9 insertions(+), 6 deletions(-)
