Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7088933D79B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbhCPPds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbhCPPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:33:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B021FC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:33:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso1692103wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4MtyicSEo1IFZBpiFoiow7kzS1Jr8w9+zJmQTxAoVfE=;
        b=aOBu4s4YBTkov1on28kzZszJKza9hsa6v9IjY9CZuG1RXgyJINqB2YR9wqD8mrJsG5
         oW9CNdk48E00tfQFFqf7eabOXr4V6g1rSZIOZUrY2E9p4jZhOHsIqTc/Zrr2iIrrLpRW
         UO0d+H76OkhNjzww3mqsdcDytyEk8Lp3GsJCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4MtyicSEo1IFZBpiFoiow7kzS1Jr8w9+zJmQTxAoVfE=;
        b=DpNKYZWdrQ9FFh1+0tni4LwCWkHUeMlGGI/HvyqBKZwkgFucWO3QhZ7c2Hydg7oovW
         PWk+/492Zu+g5n2KkQ57XO88MMSzmm3mNCxotO8pudHLdwbgIJ/OkYrUySH2hqsHpkdb
         xKHpPWENlH57INE/WDZaB/DxN9b6H4JBXGLqnmNbhmranhwt1LxYaS/zo1gxcUy0FZAH
         CyjZ/5czjSqOAc6V4Dj1u5kUcs2vETiMO8mdj0yYa/7rhUAlpSohnHkWSf6+yWzwf/xg
         v1+Jw13OSaQx27QtLChjVAiKV6YVy+madJamAQ0gT9NQaEuVweAg0TLL4yXc8JhD+Aqs
         61xg==
X-Gm-Message-State: AOAM530ShIB6Uuo8FT62tpa7pSDEXUg88FNYUiFlFKKitimyDJhhMWCi
        9gJB+YoAyigIaSoJYpQVTZGTtQ==
X-Google-Smtp-Source: ABdhPJwLcv8LIcwpJj11nT7CjeCYw+rPcm7MmzmWjcj9F/IESEfr8FtSUIk9PgYxtf0usoMMx2lQNw==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr258796wmo.36.1615908792340;
        Tue, 16 Mar 2021 08:33:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h22sm3985078wmb.36.2021.03.16.08.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:33:11 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 0/3] switch to unsafe_follow_pfn
Date:   Tue, 16 Mar 2021 16:33:00 +0100
Message-Id: <20210316153303.3216674-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This are the leftovers from my pull that landed in 5.12:

https://lore.kernel.org/dri-devel/CAKMK7uHQ=6OJcRguCUtiB456RWdCfwSNEXV8pQsfsPodTJ6uxw@mail.gmail.com/

Only changes compared to the old submission are:
- dropped vfio and kvm patch
- add patch to just remove follow_pfn at the end

Assuming no objections I'd like to lande these three patches in my topic
branch for 5.13, for sufficient amounts of testing in linux-next before
the merge window.

Ack/review especially on the two mm patches very much thought after.

Cheers, Daniel

Daniel Vetter (3):
  mm: Add unsafe_follow_pfn
  media/videobuf1|2: Mark follow_pfn usage as unsafe
  mm: unexport follow_pfn

 drivers/media/common/videobuf2/frame_vector.c |  2 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c |  2 +-
 include/linux/mm.h                            |  4 +-
 mm/memory.c                                   | 46 ++++++++++++-------
 mm/nommu.c                                    | 28 ++++++++---
 security/Kconfig                              | 13 ++++++
 6 files changed, 68 insertions(+), 27 deletions(-)

-- 
2.30.0

