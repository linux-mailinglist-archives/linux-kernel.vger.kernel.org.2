Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17093370025
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhD3SGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 14:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230356AbhD3SGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619805915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QlUIlAKYE4495cvc4WfUS3fiQGRr+yuPORiuKa9dPbk=;
        b=cQ+VaG4wwFtosTGDQi+fXic8EK3y3KExweTXuhlCsHPyxdWHYhsPfRvc4kwa27R5fQjb45
        ULtmRXxinhFcfop8xkOIp4SIFWhLh0ab93DYxKxgbbInz3j/piL4ZS/kItLf17RHuhh928
        7J3+HDsvoCXENtO6byXU7LQyJe9xnYI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-ASe6G9nkPbWJ6lcz8HIFxA-1; Fri, 30 Apr 2021 14:05:13 -0400
X-MC-Unique: ASe6G9nkPbWJ6lcz8HIFxA-1
Received: by mail-qv1-f72.google.com with SMTP id p2-20020ad452e20000b0290177fba4b9d5so33546434qvu.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 11:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlUIlAKYE4495cvc4WfUS3fiQGRr+yuPORiuKa9dPbk=;
        b=eFWheEcZ1AtIPUHxqqbXo6wfhGJ7PE1fbGycgPFcYIvjrxvUs9yiYrxH6LuAO9Ce95
         le//Bbsv66eVQCDYUgdZM93ti9EOkgvlp0eT/hOConiPDNPiPhsLvFx33wGFj2G2Rxjy
         OuDXRCP9zphLj2dp6HrgEIJ39QiIvaHHK4/ypm2FS8hGlKSiZaAV/HqlxKoJhp0toMFr
         onSEnPfPLksUHoMG+ycfOk5sH4pWymBkWag9v1Hr9EbuUqTds7+BNLf7I6Z09TtH69hX
         yxdRSU0VZYeZDQC/o8NrsG/eJuQI3auXRo9SiLQ2IMmMLZ4klbdXm3z9SPmgpKdb8j8B
         SJGw==
X-Gm-Message-State: AOAM531fBYhQ+ZNqPX78/E/yzEPFxPUWAmwDaB77nY+mAPKpy4/eBHvo
        GK8ei05v41Y1T6mGE/mlIPZV54XfyHN5R8/UW9uarTwXVEvaATjFCV1EzIoB/4c0Pbmixs4RXS8
        Yjy8dJIGIAYXir3cdjeGMQec3
X-Received: by 2002:a05:620a:9dd:: with SMTP id y29mr6472031qky.83.1619805912662;
        Fri, 30 Apr 2021 11:05:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0fuV+OSVOqxqrRktaPY/gHGGzWK734pNZzRkulGOtAXJjRCbXyYaNKA83MtpCVXrMGEbhuw==
X-Received: by 2002:a05:620a:9dd:: with SMTP id y29mr6472012qky.83.1619805912484;
        Fri, 30 Apr 2021 11:05:12 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p187sm2061155qkd.92.2021.04.30.11.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 11:05:11 -0700 (PDT)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
        nirmoy.das@amd.com, kevin1.wang@amd.com, ray.huang@amd.com,
        darren.powell@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/pm: initialize variable
Date:   Fri, 30 Apr 2021 10:16:54 -0700
Message-Id: <20210430171654.3326745-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem

amdgpu_pm.c:478:16: warning: The right operand of '<' is a garbage value
  for (i = 0; i < data.nums; i++) {
                ^ ~~~~~~~~~

In some cases data is not set.  Initialize to 0 and flag not setting
data as an error with the existing check.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 4e459ef632ef..9a54066ec0af 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -451,7 +451,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	struct pp_states_info data;
+	struct pp_states_info data = {0};
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
-- 
2.26.3

