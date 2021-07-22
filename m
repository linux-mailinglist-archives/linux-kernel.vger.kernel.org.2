Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCDF3D20E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhGVItc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhGVIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:49:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A817C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:30:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e14so3774627plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdUv+GXySeA885YGpZmLXS+2jizmvcJ4lSDniuXWHI4=;
        b=EhYdQIseNy6lMDk8YjKQ1veyCiTbOgIoJ/VBVn2vLDHGjdPFhTNSRUWUK0bPWotrpJ
         XSI48OOBzprocJPN7b707Qc5XV1f9dLIpRoM7q+PNMy9LwG20xJmvNbKcGSK6p/43ngv
         jDxmxG5TXCq5VK530lsn/vAQrKCaKcQpM7lW3d1Fq/JexqDaA+V87C8Xhqbqp1A/6NrL
         WmSWXzObWM7UDCKqx7X0RGvebf9a9LFGYQcEiQtpFff0ndaFx1/emvMQExqEB3bVyCHs
         Z5PVVvZNWxv6xwAeBz0zwPyunJkYBvTruohXRBUZOy/c20hg9bs5aXsGxSpOS4Gj/5oz
         L9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdUv+GXySeA885YGpZmLXS+2jizmvcJ4lSDniuXWHI4=;
        b=pFeaO827TJDxVRQUyn6pT4v/X0Yl2qsoEc5YK6rAB/rSan1Qqb6kA17G0G9cLSZo7k
         /6SojHdSRgIXXFMshOipBH2Gp7r+KpDFerNWsZ58nkiXGgM5NW4cVeYl3WVCM9W3qV4T
         9weLX98fE22LNMv8veU+4T/O/P1drDpq3YALqCSku/Kd8UoYkTVQ4e5akpfdt7+kYznx
         3t8IAbcJDPLoITP7N/XpwVRYOcH1PtKpUaKXZuTQavAeX1lxcC00+2y6M6wgm7gNJwtD
         OgqSL0f308B2TVw+XO7C14uiFswmpsIxRyZBQQJMTY0OTsRK5/wVOWSUgjB8hwMxSIK2
         qpTQ==
X-Gm-Message-State: AOAM532xeaosShs+XxlP3BOit5ddd8Ezi2PW4ZOnMzSCWrwinRdc630z
        TVnI+T8nHS+k9lKr8Rvn3pg=
X-Google-Smtp-Source: ABdhPJzNOnM2Xiyy747iVpPkppzdexY5XMa3HjOqEYwbnOjXK0DTZlH0ZcQCcNQf3tlBT+6SeQX2yA==
X-Received: by 2002:a63:e250:: with SMTP id y16mr40565172pgj.247.1626946204761;
        Thu, 22 Jul 2021 02:30:04 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id q5sm1069592pjo.7.2021.07.22.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 02:30:04 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/3] drm, drm/vmwgfx: fixes and updates related to drm_master
Date:   Thu, 22 Jul 2021 17:29:26 +0800
Message-Id: <20210722092929.244629-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series contains some improvements that Daniel Vetter proposed following a discussion on a recent series:
https://lore.kernel.org/lkml/20210712043508.11584-1-desmondcheongzx@gmail.com/

While preparing these patches, I also noticed some unprotected uses of drm_master in the vmwgfx driver that can be addressed by new functions from the previous series.

This series is thus broken up into three patches:

1. Switch from the outer drm_device.master_mutex to the inner drm_file.master_lookup_lock in drm_is_current_master.

2. Update the kerneldoc for lease fields in drm_master to clarify lifetime/locking rules.

3. Prevent potential use-after-free bugs by replacing calls to drm_master_get with drm_file_get_master in vmwgfx_surface.c.

Best wishes,
Desmond

Desmond Cheong Zhi Xi (3):
  drm: use the lookup lock in drm_is_current_master
  drm: clarify lifetime/locking for drm_master's lease fields
  drm/vmwgfx: fix potential UAF in vmwgfx_surface.c

 drivers/gpu/drm/drm_auth.c              |  9 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +-
 include/drm/drm_auth.h                  | 62 ++++++++++++++++++++-----
 3 files changed, 58 insertions(+), 17 deletions(-)

-- 
2.25.1

