Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0F369BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbhDWU5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhDWU5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:57:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47FAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:56:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f29so35972677pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xC8clke3UM2mIx9JGjB0xLMHhnD9lAyHPoIkVfVmf7k=;
        b=UORleTQPlx//sA16AmZyNLDCyyT6yx4snwp1FzP4HvVAy1iDD1Ic7kri3Qcw3uhMD+
         xpgrMrKWQaNluZw0SPUjkfFiidjjQlmpIVcR/zzQHmKgnVp7FMBeR82Wu0rWCmpgK2UY
         0PbiLnAayVV0WXAUKOV1xr1WXhIXAzZJumDEPQnnLagOWQ2KazSvEZ4z0B3tgSefqEuX
         Bu7PUSyqKAmBIhUvX0zjXsVHdf1xyicGu3wrj9iWNgzoS2xIKtg/liwCMvLxy6FnoENF
         tB/onb2lv6kYgMAtvgdAQH2Juy+c0oZyDP9V3cWtjBPBvcYQoPdM3gZQKK4dq9MM5pjV
         vgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xC8clke3UM2mIx9JGjB0xLMHhnD9lAyHPoIkVfVmf7k=;
        b=a4sP8AYQ1v59+DE2u8WN/4ss1AcyDLIWSGJmN7e8v1T9qDVr/X+Nt1JDc/81Lw5Img
         4AKMfOcoz5iUdJkoxinn9916pQ6aSt1A0mkEEJguBmgp3aoQMvp8b8SUyWQ4GchxN3Yt
         h1ex6VB7NIsth4E7ycLjyEcufJ5MlmmCAH50EHV4+C8FyakFkIjC+JwnqTEndV3yotZ2
         G+lKQ+7LVc/5NeBfDm+b8BY8DCKEaKdoBfkQ0kU6Ru3TloBnw2gotNYMF+C6SKg8SP6O
         371bdWTyRLdngAdRpfn12qTZ8axRhaL+v8j2tzN4aJ+C6VN5SOF3sMbyQmDjRd/ACltR
         eG7w==
X-Gm-Message-State: AOAM532MTzaFxqqwjWk0ImijbmNojanXk5K3sALgt6GICY2FkIjcsl+E
        mFk0zy/5q9Xtn31Pms8pf+c=
X-Google-Smtp-Source: ABdhPJzL0RqFTXQzlWUn3TBLPE8uRtZmzcDmCmxaOZU1fHE1r7/T8vCM+UJ+PGA1xeCtwGogUkk4pQ==
X-Received: by 2002:a63:fe12:: with SMTP id p18mr5519203pgh.425.1619211415366;
        Fri, 23 Apr 2021 13:56:55 -0700 (PDT)
Received: from localhost.localdomain ([49.37.83.174])
        by smtp.gmail.com with ESMTPSA id g21sm5679013pjl.28.2021.04.23.13.56.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Apr 2021 13:56:54 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, mikita.lipski@amd.com,
        eryk.brol@amd.com, aurabindo.pillai@amd.com,
        Nicholas.Kazlauskas@amd.com, stylon.wang@amd.com,
        Wayne.Lin@amd.com, nirmoy.das@amd.com, bhanuprakash.modem@intel.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] drm/amd/display: Remove condition which is always set to True
Date:   Sat, 24 Apr 2021 02:26:44 +0530
Message-Id: <1619211404-5022-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:3015:53:
>> warning: address of 'aconnector->mst_port->mst_mgr' will always
>> evaluate to 'true' [-Wpointer-bool-conversion]
                           if (!(aconnector->port &&
&aconnector->mst_port->mst_mgr))
                                                  ~~
~~~~~~~~~~~~~~~~~~~~~~^~~~~~~

Remove the condition which is always set to True.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 9a13f47..8f7df11 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3012,7 +3012,7 @@ static int trigger_hpd_mst_set(void *data, u64 val)
 			if (!aconnector->dc_link)
 				continue;
 
-			if (!(aconnector->port && &aconnector->mst_port->mst_mgr))
+			if (!aconnector->port)
 				continue;
 
 			link = aconnector->dc_link;
-- 
1.9.1

