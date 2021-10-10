Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC834282D9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhJJSAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 14:00:45 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47554
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231895AbhJJSAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 14:00:42 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C00F40018
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 17:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633888723;
        bh=88UqIy9mwzkWtlrhM9oP3Aj9E83Jl4ATz7t0s5yWwqE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=bhc5FPmjPAB82dUkRuW7J19kieU4W3tie/zTuFeE0sroyxM2MehQujvQJ+wXT5FyA
         2LbOm3HvmPNjlXnzSvrIaJH77zrCbKT7MNiHBwysACjrDDQLrsynScH3I5Du9/1FBJ
         p3Vb/BSWIQ8S13k7TsRlsG8IOMUvTodRMRRH+nmyMFO0+r5V2BzuyRMABVsJjujnhO
         knfWZw2diWlJ0UPhCYYz2SJv0I8OhM3gclbiKqkxbFW/6CP7HRtef2l+E3EpEWme8s
         8mvNaU9fwDqSrEcGU4SucJooVN4EaLFSOEbXWx2WuhK6SSjWrz2bJFf4vG1YEXZmKU
         zKY1GbXqXpaLw==
Received: by mail-ed1-f72.google.com with SMTP id h19-20020aa7de13000000b003db6ad5245bso5113563edv.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88UqIy9mwzkWtlrhM9oP3Aj9E83Jl4ATz7t0s5yWwqE=;
        b=KmX1mrQni5TRlU588Zi4HCy3eEhiP1Zced8lo3oEaeq+hKpi7YwC+Ky1Wu8xiEFjs8
         9pgAhODRSn8/Imv0vzfWZVlN6xsdFmEsNkK6lydtilC9Q6TIZb++pOSbbmPYsB+ZbPpF
         wZQe3gj+JetopA4ENIRxyzcXqUA+/pb1J8WaqJa/fD27tNceVt81apZKOZJaCeHe+GHv
         Sa/3b2/rcsUtDYiAVOFIeLh5bc7OfhbclEupmDGbbw8gy1J8Ml5cK2ifwEUboNdKvqg+
         TQgMP5PgG4OQoEsbbgfRGiNOn8XcrDa9afM/SCs5nXZ8ytLwF3rYfuU5aoF+l1w/1gqi
         Ks/w==
X-Gm-Message-State: AOAM531eojU8SAcw8uwPrO4eg0NrqWxTZUQMVDl4m2/bzZbHyqX82XSh
        3YMrMoYKkL+E9ECty+N5VWEXACxzNaHlkmvL2OmP81pep42Dm3ZV971kYDJOZmEsqQsuksIoJKp
        6p54c1RlqD1sA0ZZFwgbxJLO1KQyDJStKrO5IRz9fGg==
X-Received: by 2002:a50:e141:: with SMTP id i1mr34582891edl.157.1633888722545;
        Sun, 10 Oct 2021 10:58:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3AK4hp7TVCpa0+xVG9MP6rRwFiy7pmtaN7TMdn7+eU2k3Cv/acIFnEkH3HPjZ1RBFGW9zbA==
X-Received: by 2002:a50:e141:: with SMTP id i1mr34582857edl.157.1633888722325;
        Sun, 10 Oct 2021 10:58:42 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id au26sm2347948ejc.53.2021.10.10.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:58:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 3/3] memory: tegra for v5.16
Date:   Sun, 10 Oct 2021 19:58:36 +0200
Message-Id: <20211010175836.13302-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010175836.13302-1-krzysztof.kozlowski@canonical.com>
References: <20211010175836.13302-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A topic branch specific to Tegra.

Best regards,
Krzysztof


The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-tegra-5.16

for you to fetch changes up to 31b88d85f0432e1c0738fe0714191e8504f505c3:

  memory: tegra210-emc: replace DEFINE_SIMPLE_ATTRIBUTE with (2021-10-07 20:37:33 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.16 - Tegra SoC

1. Several minor improvements.
2. Handle errors in BPMP response of Tegra186 EMC.

----------------------------------------------------------------
Cai Huoqing (1):
      memory: tegra: Make use of the helper function devm_add_action_or_reset()

Colin Ian King (1):
      memory: tegra: make the array list static const, makes object smaller

Dmitry Osipenko (1):
      memory: tegra: Remove interconnect state syncing hack

Jing Yangyang (1):
      memory: tegra210-emc: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE

Kai Song (1):
      memory: tegra210-emc: replace DEFINE_SIMPLE_ATTRIBUTE with

Mikko Perttunen (1):
      memory: tegra186-emc: Handle errors in BPMP response

Yang Yingliang (1):
      memory: tegra186-emc: Fix error return code in tegra186_emc_probe()

jing yangyang (1):
      memory: tegra30-emc: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE

 drivers/memory/tegra/mc.c                     | 25 ++++++++++++-------------
 drivers/memory/tegra/tegra186-emc.c           |  5 +++++
 drivers/memory/tegra/tegra210-emc-cc-r21021.c |  2 +-
 drivers/memory/tegra/tegra210-emc-core.c      |  6 +++---
 drivers/memory/tegra/tegra30-emc.c            |  4 ++--
 5 files changed, 23 insertions(+), 19 deletions(-)
