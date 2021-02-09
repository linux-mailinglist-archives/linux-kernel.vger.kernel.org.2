Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA364315C79
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbhBJBnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhBIXtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:49:05 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C97C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 15:48:24 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p21so113047lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 15:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JxrYmkpfatu4jodGQPHh0hSLDnzosVKpfQHIfMv8e0E=;
        b=a4+ooLUJ9FAgYmcQzjbHCIpUbILnxr0074Y7TTtS1niQ+OXcKKkFAsRlv+n9w0AUkQ
         xe96JuBYSxsjSoG5BEljDZyWPe1gwovgctMxvYmdE28Hwp0sPHLsdXyJAcU0QXtaq3Ym
         uomHIr1XdDf5At6EGGhv4uoX0JQzFyecpIm3b3bL8wtD6MJWLHMk+1zDoPzD0movYJI9
         0GR6a1OloL8GztF3h+lPLankIHYuKJ5VHAXf7Zgxvts4XKr12RjOSufxZFB1okHKMjvZ
         YF849P6oN+vcI0XgnW7eDgoU+xBS7BKdxksYrCMY6hMD9ceCGu4QEbA3zxL5iShcqypd
         hkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JxrYmkpfatu4jodGQPHh0hSLDnzosVKpfQHIfMv8e0E=;
        b=XWIJWBAQXVtx66bBXEkkFm16MPGXqnqdmkTCO4Kbv6xTllU3wnF6TtKiGWzCabfrWX
         63lBYkRl8YLc/ei8qGy7HCSnRQXTlSPnDVo8HCfbwKYiA+RAqykcJgcZdXZNlLeovwxx
         AorXzIYQDuAqldPOP/snvFFCX6kwSMCb1vx8p6MN4/3/pJn4w8gOLtD9c6psnrEiEpxV
         1A73p925oYU4COEbC+ur07dWXYV8Jwk+nk37QJcCntQm1gB8YF1p9mfhnwHU027gqq1g
         LSv0T8BM110O4alwSMOk7LZc0YwJS2kHRsKjXiak4LmjSh+H+bEErM1e8ilt8opqz5Ww
         Mp9g==
X-Gm-Message-State: AOAM53131q+V2Gfr/XvJIt78dcarUxr/foYH9jS8yAMf+y+2QKzvVzGf
        +XE3NlvcG7F9BDrrRxfAYF0=
X-Google-Smtp-Source: ABdhPJwqKSKzlI6Nl6bidLwNbX9MfrP2AS8P6ODueDZoOP887CZ/ogaO4H8idiomt1SKtPzz3UjJIA==
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr189106lfm.375.1612914503392;
        Tue, 09 Feb 2021 15:48:23 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id c25sm23779lja.131.2021.02.09.15.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:48:22 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/3] drm/ttm: constify static vm_operations_structs
Date:   Wed, 10 Feb 2021 00:48:14 +0100
Message-Id: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a few static vm_operations_struct that are never modified. Their
only usage is to assign their address to the vm_ops field in the
vm_area_struct, which is a pointer to const vm_operations_struct. Make them
const to allow the compiler to put them in read-only memory.

With this series applied, all static struct vm_operations_struct in the
kernel tree are const.

Rikard Falkeborn (3):
  drm/amdgpu/ttm: constify static vm_operations_struct
  drm/radeon/ttm: constify static vm_operations_struct
  drm/nouveau/ttm: constify static vm_operations_struct

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c   | 2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.30.0

