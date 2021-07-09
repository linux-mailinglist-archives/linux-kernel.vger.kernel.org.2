Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD10F3C1DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhGIDiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 23:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhGIDh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 23:37:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13165C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 20:35:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fs7so5018149pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 20:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QgqesoC5qpl/edbOBllLil92AKJcrUsJTLsQmBAkv3M=;
        b=WSvB/aHB4PyQYa6s2owVlOvE5WTOZCBJtNvDp54FRHQ8Y5lQJLLT4k8EHF21mdgHQE
         dGaYSI2/YJ2vI6qpRcNDge5Vc/tCubf/Gfcb7eWHiAMTZnulsUGcqxGr/HtgRIpPmlhU
         A7OhK5uxFpSwpy/KUVpCKDa9Z0lYxlB35QKww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QgqesoC5qpl/edbOBllLil92AKJcrUsJTLsQmBAkv3M=;
        b=SHrOOY5EefPJISkxEoDplX1e+E4E/h+FMo428wqpxJ1Pl7qsOB0hxLoxycc2a+bSNi
         Qz152BJZOYNx3WsPW25BVTz14uSKrtuhdrZanUM8lKMvwqdUrdpeAvgWFUKiXdFpTYYk
         ufHEkEkA4PucUivsNJ2GryI5nehg0vnHmwhY9lYbWfYYsYP13ZSSyx3XlQSRDXDIvdUZ
         4mWihPCWH4rtMeHEyuGi9ywFcbZgVpdAMjsF6S30yrQo7Kr/sRuI0lVOW7kksy7Jva15
         t8EFzEWoQ08mydu+QLNycrgs/h/CqanRe6eet1/yBOgF4NQssMDJpm3wVkv+IRZ28VuN
         0CTw==
X-Gm-Message-State: AOAM5302D/6cOxAoDVoEVuJ2eihIMswCCXOpeg6SUl14KgMa+cI4K4VQ
        f/+xPJ+XxaIkFdWIyRQXZm/n4w==
X-Google-Smtp-Source: ABdhPJyscoeLU+fIni8rHH6VlaNI5+bdiO83XfOAz6wiKT+SHKtQYMVWdb5Ty1IRnZquh218puft0w==
X-Received: by 2002:a17:902:b111:b029:129:5cd0:110e with SMTP id q17-20020a170902b111b02901295cd0110emr27867718plr.51.1625801716483;
        Thu, 08 Jul 2021 20:35:16 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d47a:af0a:d5b9:e774])
        by smtp.gmail.com with UTF8SMTPSA id gk20sm3942228pjb.17.2021.07.08.20.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 20:35:15 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 0/4] Fixes for dma-iommu swiotlb bounce buffers
Date:   Fri,  9 Jul 2021 12:34:58 +0900
Message-Id: <20210709033502.3545820-1-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

This patch set includes two fixes for bugs caused by mixing up the
original buffer's physical address and bounce buffer's physical address.
It also includes a performance fix that avoids an extra copy, as well as
a general cleanup fix.

The issues were found via code inspection, so I don't have any specific
use cases where things were not working, or any performance numbers.

v1 -> v2:
 - Split fixes into dedicated patches
 - Less invasive changes to fix arch_sync when mapping
 - Leave dev_is_untrusted check for strict iommu

David Stevens (4):
  dma-iommu: fix sync_sg with swiotlb
  dma-iommu: fix arch_sync_dma for map with swiotlb
  dma-iommu: pass SKIP_CPU_SYNC to swiotlb unmap
  dma-iommu: Check CONFIG_SWIOTLB more broadly

 drivers/iommu/dma-iommu.c | 63 ++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

-- 
2.32.0.93.g670b81a890-goog

