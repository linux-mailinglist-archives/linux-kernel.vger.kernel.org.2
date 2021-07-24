Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BFF3D475B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhGXKia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 06:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhGXKi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 06:38:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E132C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 04:19:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso12698943pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fu+EOl8MzFHnqJUqNfrpGZTo0/rhrJKaN+eR+XuGHMc=;
        b=O85DMHyeVRIuNVgeITMNvJFbLraGrRkBIWg4sV/aVqhdxkebXDwNJJLp+AUkqsDeEL
         Na7LsPIPk6TvdsnmYa2vHP35R21S4kl96KOk9HSz0FzBQ6wgclLdqQZs74HukQKS0ckC
         shl5r8IQqN4Esh1S1GLl8L4MppOhtJku495fCCLt1X6Zj601Rljo4zYNmKVItA6h8/St
         D/mC85zB75DvGX/fE3DM0VpUNJeagVUTRdXcN4jxdZOE+Nq6WlYcWdZqOEFZ5mU6BCY9
         2VniXcW1EHtTMG0eT76mpjoJcRkv6UMuoA0DWDS2+bmBoQrSfP6m8FFfTG3slhbMHdZo
         jEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fu+EOl8MzFHnqJUqNfrpGZTo0/rhrJKaN+eR+XuGHMc=;
        b=iMgzfPoSaI3oJWXLWWAUdHYBvvVm80/E801fMb8EYlP0XYztAo3hsr75PP4nbWMS24
         epPx7DfHYF4KSEdUY98D+da/GDwlNUJkenZjNi5A89ZO2+cpe2a+SbXDRfJ3ui0DKiA/
         6D/YwTYOH/lglKd42uGC3o4RIWZe+MJsX/Bvm4Go40ecLLOj9dyu0lDQyxXTpCTDawE/
         qcyGwDGgMUSEpzQlD6U/uo5s1xNsaUUmGZKCluf8rlATrfYdV3cPmbIyKqkVp3qoXvgY
         JVnkQWphsejRMUmCVlrXSY8SzSwxLSryOadUYeBWQDjg1SE7rh3kWnWcPv4I+d7Lb5hB
         fTrQ==
X-Gm-Message-State: AOAM530U3YhDuBqsSRQ5tV6hjVjxvGhkOHCURI5BSQJUbnbzwMFyLuqx
        uYFPMf98XZgk27e5zGt1vmA=
X-Google-Smtp-Source: ABdhPJxbdpJ6RuIPKFdq0gqilzFZT9DQCDdNnN2S5MzYOUyd3XCuX/ms1akPJbumH/5igHmyD+GLbg==
X-Received: by 2002:a17:90b:b12:: with SMTP id bf18mr17739337pjb.74.1627125540031;
        Sat, 24 Jul 2021 04:19:00 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id v15sm21310057pff.105.2021.07.24.04.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 04:18:59 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, corbet@lwn.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 0/3] drm, drm/vmwgfx: fixes and updates related to drm_master
Date:   Sat, 24 Jul 2021 19:18:21 +0800
Message-Id: <20210724111824.59266-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a note that only patch 2 changed from v1 to v2 of this series.

This series contains some improvements that Daniel Vetter proposed following a discussion on a recent series:
https://lore.kernel.org/lkml/20210712043508.11584-1-desmondcheongzx@gmail.com/

While preparing these patches, I also noticed some unprotected uses of drm_master in the vmwgfx driver that can be addressed by new functions from the previous series.

This series is thus broken up into three patches:

1. Switch from the outer drm_device.master_mutex to the inner drm_file.master_lookup_lock in drm_is_current_master.

2. Update the kerneldoc for drm leases to clarify usage and lifetime/locking rules.

3. Prevent potential use-after-free bugs by replacing calls to drm_master_get with drm_file_get_master in vmwgfx_surface.c.

v1 -> v2:
Changes to patch 2:
- Clarified description of lease fields in drm_master with suggestions from Daniel Vetter.
- Added an overview DOC: section for drm leases in drm-uapi.rst.
- Cleaned up function documentation in drm_lease.c to use kernel-doc formatting.

Best wishes,
Desmond

Desmond Cheong Zhi Xi (3):
  drm: use the lookup lock in drm_is_current_master
  drm: clarify usage of drm leases
  drm/vmwgfx: fix potential UAF in vmwgfx_surface.c

 Documentation/gpu/drm-uapi.rst          |  15 ++
 drivers/gpu/drm/drm_auth.c              |   9 +-
 drivers/gpu/drm/drm_lease.c             | 182 ++++++++++++++----------
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |   4 +-
 include/drm/drm_auth.h                  |  67 +++++++--
 5 files changed, 187 insertions(+), 90 deletions(-)

-- 
2.25.1

