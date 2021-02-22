Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FC3322026
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhBVT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhBVT01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:26:27 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC7C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:25:43 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cx11so218307pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=81xQbFqBfVM1puf6rirIzmcmTzQTCjqHgWWmAXvQ39A=;
        b=Xe30GRGYqLFy4shszF5sc+bWsKntX9Tqn20gS/o/ADejUnn9xqYjoVeWvve0El8qez
         aL9zOnJx6ipjj1Dag0qdQz+gAO06L30TpcqoXyVsU+0wdB9/AmhoiVvItg63DpA6S1Fj
         uKUWwTvCTbMjxNesuAQwV74tuUziLXyrJa5c6NHhFHRg63k40bfUOe64KqWF64Z5fn19
         RUxwgrCnDc5HdZ7JQcmPOrcRjrS5bRiq98KuoBk3bhgef/Za25niuPzyhs03zLYuZ94F
         gYGg0JNH6BgvHikaD7SBCgQElGmPlR3VEL3TU1uteP6uv8h1YWE2O9O3a93fPEreNS3g
         Qtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=81xQbFqBfVM1puf6rirIzmcmTzQTCjqHgWWmAXvQ39A=;
        b=Bq2y94oTqwsznBrvCnAAsV983s34yCMakApBQluEZuewqS4biLsRO3z3nHHL755wUv
         ecXYIzPWNRhMGrIf4ONPh5/HP+BKV7+dlyoFa4/YtLTa+9cd512uYRJYcXZCeNqIQI1G
         r0jGueXAA+/87pC8+ZGP0OklxR7h7HdoWHWu4qOaxGLyruHoNMMm+anBxbl4ZlecdXhb
         OZ8cYxbxvCGljSmLCI2dl6ppiynn3N141qP4smOEpsDm9kcaXqzPkU5Wisy5MBdIsIKb
         f8Tr/uz1N4zAYbM2WZxyA/8wK3ZY/jedT+k/+nABJH2JMYSwaIHfW/aIcSAmR2T1mGaP
         RO6A==
X-Gm-Message-State: AOAM530pSbT0eAyRp/RPbsLp51tMdxPyvKK1w36E7Q6NeiJKH7QS75zo
        uNuoIQ5KKuYCEJMks5nmB5Wlsa4q+pwV5w==
X-Google-Smtp-Source: ABdhPJwEunPRjSK3BfE+NLfURtzUMi+jTA9Vtz1FGyEaxZ2W0EhobibVFFUKsK6oezqOoTVluC2chw==
X-Received: by 2002:a17:902:e54e:b029:de:8c70:2ec4 with SMTP id n14-20020a170902e54eb02900de8c702ec4mr23952108plf.56.1614021943492;
        Mon, 22 Feb 2021 11:25:43 -0800 (PST)
Received: from localhost.localdomain ([49.37.83.164])
        by smtp.gmail.com with ESMTPSA id 184sm18688831pgj.93.2021.02.22.11.25.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 11:25:42 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
        Rodrigo.Siqueira@amd.com, aurabindo.pillai@amd.com,
        stylon.wang@amd.com, contact@emersion.fr, bas@basnieuwenhuizen.nl,
        Bhawanpreet.Lakha@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] drm/amdgpu/display: initialize the variable 'i'
Date:   Tue, 23 Feb 2021 00:55:31 +0530
Message-Id: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9804:38:
>> warning: variable 'i' is uninitialized when used here
>> [-Wuninitialized]
                           timing  = &edid->detailed_timings[i];
                                                             ^
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9714:7:
note: initialize the variable 'i' to silence this warning
           int i;
                ^
                 = 0
   1 warning generated.

Initialize the variable 'i'.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a22a53d..e96d3d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9717,7 +9717,7 @@ static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 					struct edid *edid)
 {
-	int i;
+	int i = 0;
 	struct detailed_timing *timing;
 	struct detailed_non_pixel *data;
 	struct detailed_data_monitor_range *range;
-- 
1.9.1

