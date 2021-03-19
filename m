Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65816341508
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhCSFpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhCSFos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:44:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17049C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:44:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v3so2956239pgq.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wz/WsPQUF/kjHU+6IEFrzHVpAW1UcXHBX33paA47bqk=;
        b=TdczdL9JGhDcdhS0IIrBZ0ipqyUNx3ZVtASANAdvYlH2UdFO3h9avLWRdVP9zkgnd1
         f57qBRdj+vB3H6aXArxRK6q0QhcMZ0sEy81gJdsREyxAodkSZpi3IGvFWKNzZjVDQGtq
         jvpTNi6CvD3+SHS3cpDTofIawYJjLWkT1kEfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wz/WsPQUF/kjHU+6IEFrzHVpAW1UcXHBX33paA47bqk=;
        b=RMl+02L04eZ7k4rcXHbSAgEzrOpqY+jzIp3l8v7mm7o3ucEYg1V5Yiu2NE0b9w8gi5
         vplpyySs5/qrqRoe+hoVN70vVX/TAUkrGswlKE79G6HKf+WdtZVcnXkXwNtpMUG7Lvjr
         akda8h8Ef/jIucJt7p9p8nj1P6Ta8ApuLpQkgFuw0kmPlfdY2LTVCKROovWDB21qYaoh
         3oGnVY99/1Bd054jP2PyxiQfqCpcLm3YNABluBh4Y92BjjAlfldi8UU4i4tmbPkIjW5n
         7uMJtT4PP44W2aMAOKxzyehT60hoJNU2Y1Z/SS6iQYS9medkFt5gLM994Nod0JQnJPrM
         HYfw==
X-Gm-Message-State: AOAM531teotTV9MSZuA42Qi4pBCBTb6CFKMc28pqp0v5DcvAPnxTplhn
        93aknbQeGXQjuX9lU4qwbene/3vXUFnbOdi4
X-Google-Smtp-Source: ABdhPJzNAUDAluK8lkNYzmEWoqVGWUqyMjKD5Xro5rorUyMlUXLZeAFWuBxdE809wFGbu+cmOLDO/Q==
X-Received: by 2002:aa7:9202:0:b029:1f2:9439:f4b4 with SMTP id 2-20020aa792020000b02901f29439f4b4mr7420365pfo.12.1616132687025;
        Thu, 18 Mar 2021 22:44:47 -0700 (PDT)
Received: from evanbenn1.syd.corp.google.com ([2401:fa00:9:15:d0d6:1466:f005:1b0a])
        by smtp.gmail.com with ESMTPSA id mr5sm4184087pjb.53.2021.03.18.22.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:44:46 -0700 (PDT)
From:   Evan Benn <evanbenn@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Anand <amistry@chromium.org>, Evan Benn <evanbenn@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eryk Brol <eryk.brol@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Stylon Wang <stylon.wang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Set AMDGPU_DM_DEFAULT_MIN_BACKLIGHT to 0
Date:   Fri, 19 Mar 2021 16:44:33 +1100
Message-Id: <20210319164418.1.I5d51cc12776ee8993a1a54089b548952f75ada41@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMDGPU_DM_DEFAULT_MIN_BACKLIGHT was set to the value of 12
to ensure no display backlight will flicker at low user brightness
settings. However this value is quite bright, so for devices that do not
implement the ACPI ATIF
ATIF_FUNCTION_QUERY_BRIGHTNESS_TRANSFER_CHARACTERISTICS
functionality the user cannot set the brightness to a low level even if
the display would support such a low PWM.

This ATIF feature is not implemented on for example AMD grunt chromebooks.

Signed-off-by: Evan Benn <evanbenn@chromium.org>

---
I could not find a justification for the reason for the value. It has
caused some noticable regression for users: https://bugzilla.kernel.org/show_bug.cgi?id=203439

Maybe this can be either user controlled or userspace configured, but
preventing users from turning their backlight dim seems wrong.

Also reviewed here: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2748377

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 573cf17262da..0129bd69b94e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3151,7 +3151,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
+#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 0
 #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
 #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
 
-- 
2.31.0.291.g576ba9dcdaf-goog

