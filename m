Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0423F3801
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 04:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbhHUCML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 22:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhHUCMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 22:12:10 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60DBC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:11:31 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l24so9025195qtj.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMOMaJvaeTN/zMSoH+yottbjrmkkaZ//2BiPGEM7agI=;
        b=AqXuCh9/8Gm644jDgI2P8NHhFOE05XE2pP0Mi6OJqgKdrdFVIBYUokPuBPnApxJgFE
         3+VMh/BLiG9oQUQShDiF80pIoYwLiY+Yoq+7qTXfMQRAnMacSCNMqcYxSRO9byfG6yKc
         HJTu+WCwXBArb2J6MSFbJeHqjplAgWLLPl6k8HjMCvvRy3bVBCysfdwjg6tOOlm9OWZI
         /1F/JEl6klG1/zEap+9tln/P8wdOk1njxgbOyMsEXIX4CeSRFiRiYN8h7P27ubvEYB9q
         w//VOEHSFC/A/yb3h94Ea96VsypxaC4Aab+AotXxU73dzZkxgkD1nkyje9c4AJcxxbND
         HgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMOMaJvaeTN/zMSoH+yottbjrmkkaZ//2BiPGEM7agI=;
        b=jKwgFm02Er2HgBelFdmCoV+tuf3AmHpHLldrCn0ktfHYeZec/U5IWxqeSJjzHwXIVt
         bt4xfPly5ETlAcySxBa/E41Of4616Fs3SWc6IHnMLGrlkeMgRTpHdkZRR1IF7o5ZGCKf
         jwIoFbSzywBaenHiO1FhXrTZGasqUROIfF5IGJaGAEHoXAFVeEnBJs43kAsnbqWOUqcT
         tSrpHA4mCYJeBOiDaszTXV9SPcsnMz4AHB5yXyInmOEi51kmjJ93z/YAa1GXpGsbGgbg
         2o2DfTqmf5+AWExF4QOPwnIyj5/76TE2M0CBF5M2WVN4r22WyzIsL3Tdc/HHuf5H4KWY
         yISA==
X-Gm-Message-State: AOAM5333wpH0/Nit3gkX60aRvfT+jQfrT0xPOeC8Wkta1lLeNX6eF/9n
        3Xc2j2HlXS98ozxGMvgTonCt19bUEI4=
X-Google-Smtp-Source: ABdhPJx7jHQlITGbPG1pD7X0WSMeLJdpYKDi+OcXhx+LFEb+S4DIg5FSZMDGWs9MqJK+54Ikcn7Hig==
X-Received: by 2002:aed:2029:: with SMTP id 38mr20651107qta.71.1629511890769;
        Fri, 20 Aug 2021 19:11:30 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c2sm4186054qkd.57.2021.08.20.19.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 19:11:30 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <luo.penghao@zte.com.cn>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/nouveau/mmu: drop unneeded assignment in the nvkm_uvmm_mthd_page()
Date:   Fri, 20 Aug 2021 19:11:06 -0700
Message-Id: <20210821021106.27010-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo penghao <luo.penghao@zte.com.cn>

In order to keep the code style consistency of the whole file,
the 'ret' assignments should be deleted.

The clang_analyzer complains as follows:

drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c:317:8:warning:
Although the value storedto 'ret' is used in the enclosing expression,
the value is never actually read from 'ret'.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Luo penghao <luo.penghao@zte.com.cn>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c
index c43b824..d9f8e11 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c
@@ -314,7 +314,7 @@ nvkm_uvmm_mthd_page(struct nvkm_uvmm *uvmm, void *argv, u32 argc)
 	page = uvmm->vmm->func->page;
 	for (nr = 0; page[nr].shift; nr++);
 
-	if (!(ret = nvif_unpack(ret, &argv, &argc, args->v0, 0, 0, false))) {
+	if (!(nvif_unpack(ret, &argv, &argc, args->v0, 0, 0, false))) {
 		if ((index = args->v0.index) >= nr)
 			return -EINVAL;
 		type = page[index].type;
-- 
2.15.2


