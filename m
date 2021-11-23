Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1629945A6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhKWP7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhKWP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:59:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r8so39707205wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2h9+eOusicYcP8DCFAdl+7wpFRmfX7bffRGLqx4D/2Q=;
        b=FxlITfJ6MxJai1qOMwtzZY1Mwr0qrN2jCa8ZGdbpEEgJ98AYpdKbApJl6Go9hfgqcE
         8YCA6vjP0mfMhtcMfQl95tUkxhKMNEAzTPFDzr6K/zvKHiSzPS+D5pOa1UKhqXtYKewN
         H+a/GM55YSlJ1L+PaDc33vw9yxogKe8+INGI9DqIDELEyBxd+XAQ4w+y9kl+cF2InX6Q
         lOuKRqFJPA6ONElBqRiD7xFGouZ1+uwKQqRnzqzbBHMw/G8C2E4Jt8bEZohWa+OMEIUH
         hx5qNERj9+3fm8uMfMC+d5Hmy0CLcNq9QluVI+wx3ev7HDrK26FawZQGUjA6UPhxE99+
         LsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2h9+eOusicYcP8DCFAdl+7wpFRmfX7bffRGLqx4D/2Q=;
        b=tpSW4h2YbWPX9zx0/GDQ9zcHBANtDaCkqw8zqXXgcYD2rBcMAoFlGXN6v4UPobA0UU
         zAFpMChrCg6iIKX9HbE0WNiwL79aGfqYZBxz5H77o6ZNO366eRIzzUuOFQz07Y3IYaEJ
         jlGkXjYti0qW5Ut65o1lGevZ2ORX2rUkvSivQxA8P/et5Sq4Fp3W2KF702FSgYh3K8ct
         INgs5zQkLC8t41anI5X/PuCRXAKoatEFuw1wiXLeNbK4Gohok1WMpAZUf1246X9HYO8h
         ktUFPgw21hpE61TnzL3Wb0/q1rFa/cYRR8OgR5mTGj/sGfXMZKmdS0E3NTeYf6WOyVph
         3wFw==
X-Gm-Message-State: AOAM532NnnJOD35Mf/mxm+H+L6o3dA9Q9J9titVyf4GA91NehsjlvMaK
        pwFvFzw1f6w9fnpsg0y7UABEeQ==
X-Google-Smtp-Source: ABdhPJxE/ueRhpKmoEAe0x7ByieCf1bstJi80kJ8JOsohjcAgrt5vQZPfOlTM4IpVq/jmmdrlS7A9g==
X-Received: by 2002:a05:6000:15c6:: with SMTP id y6mr8371349wry.422.1637682997211;
        Tue, 23 Nov 2021 07:56:37 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:56:36 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, mst@redhat.com,
        jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com, pasic@linux.ibm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 0/5] iommu/virtio: Add identity domains
Date:   Tue, 23 Nov 2021 15:52:57 +0000
Message-Id: <20211123155301.1047943-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support identity domains, allowing to only enable IOMMU protection for a
subset of endpoints (those assigned to userspace, for example). Users
may enable identity domains at compile time
(CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time (iommu.passthrough=1) or
runtime (/sys/kernel/iommu_groups/*/type = identity).

Since v1 [1] I rebased onto v5.16-rc and added Kevin's review tag.
The specification update for the new feature has now been accepted [2].

Patches 1-2 support identity domains using the optional
VIRTIO_IOMMU_F_BYPASS_CONFIG feature, and patches 3-5 add a fallback to
identity mappings, when the feature is not supported.

QEMU patches are on my virtio-iommu/bypass branch [3], and depend on the
UAPI update.

[1] https://lore.kernel.org/linux-iommu/20211013121052.518113-1-jean-philippe@linaro.org/
[2] https://github.com/oasis-tcs/virtio-spec/issues/119
[3] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/bypass

Jean-Philippe Brucker (5):
  iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
  iommu/virtio: Support bypass domains
  iommu/virtio: Sort reserved regions
  iommu/virtio: Pass end address to viommu_add_mapping()
  iommu/virtio: Support identity-mapped domains

 include/uapi/linux/virtio_iommu.h |   8 ++-
 drivers/iommu/virtio-iommu.c      | 113 +++++++++++++++++++++++++-----
 2 files changed, 101 insertions(+), 20 deletions(-)

-- 
2.33.1

