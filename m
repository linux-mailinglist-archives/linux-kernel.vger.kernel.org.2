Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760CA394336
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhE1NIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhE1NHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:07:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5675C06138A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lz27so5189855ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXF0Ts56dwHAndcdIXFBR1E/2W75Wukvn1BbkoOuP3s=;
        b=GIzRpEPP+mEiI+M7ckcQ/slkmUTYqGmhOGTej6PmDuhSzka2kqH41IB1DFJenbMi1c
         08ibSUvl0mnhV5YWffgTXeQY/b0mHGuEu9whZc1J8WyOhUjtY2A53tENr4RfRImNGeOq
         2yL9aS0/uLvlnXr360MhMjytDsjv2kx3XiDZyE0BbjV8SfSGEei9HI7z6TzuDZjdPFz9
         QaHGCreUCG2Ux1fw/Rw9V3FnaHFjh2tXXm4HpAX+lyYSiwqwbby+gKK0vbxl4YYkW8+2
         k0HLuqj+NOf746VAW2+sOEsWj2t7Udi/sgeFq1XS3ZMQQSsQtb64NL7bpGRV9vzQ5ZTq
         0kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXF0Ts56dwHAndcdIXFBR1E/2W75Wukvn1BbkoOuP3s=;
        b=bBDfUxTYHdR/4EZV60YRJYov3ey4rFV8N8+4zJk095cccvLBO6VFr/fRgrQX6DytJP
         1QIV+nyS9lFzxIeck2+iaRFerN4lILkbS6w/pJRtJw7uW1IGryaAihuTzjHsHLnzrACZ
         IiphiPfzZiGf6EnmC2gjlnbLsbA/GHMJZUUnrceNScBxfUI+le70XgPiSQTcJnCbiQZb
         6iGJNrpSEXaLJp6dnosEIaSsp2XR25Cluwjind9boLAH3o5BYnJARuJuAVNWdWyfNQyA
         EZXef33j4DmJW8ciV/I8cEBqUgu5j9NzQKHHGD7MQJqxIy24vVHKcV3w/VzX6TdlDWMZ
         VwbQ==
X-Gm-Message-State: AOAM531TwI9zXaGt4pghr1qLsHXnElj328IEtCR2HvUNO/qhUp7OXLcg
        CNK0gRZyBS+0faA0vHrM+g==
X-Google-Smtp-Source: ABdhPJybEOzv6Dmyb9n/L+ylVeUxGip+f0N75LsX5IiJGN1MgjT0EIL2I29E+yM3bVVb6uPrQgTgeQ==
X-Received: by 2002:a17:906:1796:: with SMTP id t22mr3529966eje.304.1622207178511;
        Fri, 28 May 2021 06:06:18 -0700 (PDT)
Received: from localhost.localdomain (ip4d17b4b8.dynamic.kabel-deutschland.de. [77.23.180.184])
        by smtp.googlemail.com with ESMTPSA id u21sm2322778ejg.50.2021.05.28.06.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 06:06:17 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 5/5] drm: rockchip: set alpha_en to 0 if it is not used
Date:   Fri, 28 May 2021 15:05:54 +0200
Message-Id: <20210528130554.72191-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528130554.72191-1-knaerzche@gmail.com>
References: <20210528130554.72191-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alpha_en should be set to 0 if it is not used, i.e. to disable alpha
blending if it was enabled before and should be disabled now.

Fixes: 2aae8ed1f390 ("drm/rockchip: Add per-pixel alpha support for the PX30 VOP")

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

 Changes in v2:
 - capitalize "F" of "Fixes" in the commit message

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 64469439ddf2..f5b9028a16a3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1022,6 +1022,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		VOP_WIN_SET(vop, win, alpha_en, 1);
 	} else {
 		VOP_WIN_SET(vop, win, src_alpha_ctl, SRC_ALPHA_EN(0));
+		VOP_WIN_SET(vop, win, alpha_en, 0);
 	}
 
 	VOP_WIN_SET(vop, win, enable, 1);
-- 
2.27.0

