Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05F039EDBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 06:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhFHEf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 00:35:56 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:43632 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFHEfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 00:35:55 -0400
Received: by mail-yb1-f202.google.com with SMTP id q63-20020a25d9420000b0290532e824f77cso25374408ybg.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 21:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1CsAHJB1drzJFE9aMs2rQoto13RGg0fVp1ldOeOJhJM=;
        b=AODPeS3Rxy2dCzZVvlT77V++MmhgHwq/LXwUy62+WDULLkPs3l7t2Y3YlSU2OjGQxR
         wRSr6oKoRjTEq51NPDaNczweGae+Jm19rFf8p0D5OaFId+n1nPwvgzxFuLh4LXw1S3QA
         MlDb9Z41YtIo7OVegofT3m75hTP5y4ZKA8kLLhHCTMA3VMmJxMvAugXCIMSbiEfuHiPX
         l+2sM+hwGu4aP8yjEWplKd/vPOAJeenAlCNz4bOpqFQQmQe5Eiee/FvebF7i5MxXku5F
         PHbrhdGGqnsemAsDaDo5A53MJ4cVUbzYoHZdk1btN6z0Gl0BwAEeWgU7kEOQooBIeWs0
         GOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1CsAHJB1drzJFE9aMs2rQoto13RGg0fVp1ldOeOJhJM=;
        b=DOKq+oemncsX5hMRqDSQMbSsuyZ2BAXfrSJH7YLhY67S1v0XGoRU6poionsx7sS0Lk
         QPE46G6mRrdz/CjcRYIjN3J3pAUHK8u9EeSEAy2yGsbtAYYABkWfR9FW6omf11+Wajzv
         v5DZiVPv3WYzLF5H0LWs5F9g5fxI0QVLyfJTAI7bsMfOxworl3NmP3BWV4frdoD4FKvq
         rhWPnQkUj7eBIKbx3sRlUO1bL27ggJuiAbNC/+DbnzUl7RCi9RNpLEff43kHD8d+/48O
         GGpYEOC9MuKoPDj7+1/gvqEEWdEzW1dxi9ujBK85KXNvjKro0lkQRgCLFCjgzllceJ+u
         wp5g==
X-Gm-Message-State: AOAM531vn/9g4VacX/nBkX1UzJFIO8cyzf1PbVAQH5uKuj0GFhu8dNAM
        uI3pTqSRAb2HHe3Oh98Q0ROuBwZKnyVE
X-Google-Smtp-Source: ABdhPJzGFYSJkGjEYy0wczei19iWM6Y/PFAcqGhaMiTDjHXzZj8TJzkLVLUqX7h6ji794vCiYrmvD3iMRwb6
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:7455:f4f3:5253:80b3])
 (user=amistry job=sendgmr) by 2002:a25:7a41:: with SMTP id
 v62mr28852515ybc.225.1623126766754; Mon, 07 Jun 2021 21:32:46 -0700 (PDT)
Date:   Tue,  8 Jun 2021 14:32:38 +1000
Message-Id: <20210608143159.1.I230026301243fbcee23d408c75aa468c1fec58f7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH] drm/amd/display: Fix error code on failure to set brightness
From:   Anand K Mistry <amistry@google.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Anand K Mistry <amistry@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eryk Brol <eryk.brol@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The backlight_ops.update_status function is required to return a
negative error code on failure. Returning a positive code may be
interpreted as a success. This is true for the 'brightness' sysfs file,
which passes through a non-zero value as the return value of the write()
syscall. This is interpreted in user-space as a successful write of 1
character, which is obviously wrong.

It's not clear exactly what error code to use, but EINVAL should be
reasonable.

Signed-off-by: Anand K Mistry <amistry@google.com>
---

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 652cc1a0e450..ad322613390d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3431,7 +3431,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 	else
 		rc = dc_link_set_backlight_level(dm->backlight_link, brightness, 0);
 
-	return rc ? 0 : 1;
+	return rc ? 0 : -EINVAL;
 }
 
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
-- 
2.32.0.rc1.229.g3e70b5a671-goog

