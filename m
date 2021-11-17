Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE49453E38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 03:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhKQCKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 21:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhKQCKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:10:30 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DC5C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 18:07:32 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id n2-20020a17090a2fc200b001a1bafb59bfso438169pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 18:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hm/r5eitKAhAvWdhE8mJWzffo0OEnbzo5qWeVRgm1k8=;
        b=CPo/C6GtgA5B8TPAasIkOvNwZw3gP/UYGqGPQQd7nTq7uDtpt4P76mPWhLnKBgfmLa
         igZTlgD12NrJEYaVL+/xpj+ReKr7Taptf8t+QL4HpJ5uRvBIkvX2su3dh3sf7udsOOBf
         7RyFuVuwrrvYH7nj3rk37MZ4c459qmfI8KNsVyPDDY4zv3oGJmwVi4fO848mjUhQceVW
         cEwIr6XlFgclxO/QodL2tZziqbe5j4ZPo2h+HEyZk95EhyPrEGWyZYxLA+pg1dK5sdVB
         C3BdedKE9lrJhjgrlUek5EGl0U3M2ULftGxVZc5leDGhm1o4EAnISXwdfCnCe2DYzPPP
         YE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hm/r5eitKAhAvWdhE8mJWzffo0OEnbzo5qWeVRgm1k8=;
        b=AxUDP++hoJIL7piwaXQ3pOBOnwjazezbIvNdo6kkAk0w5UJQHx681sZ+NSuSCi0E6N
         rrLhYiEaWe7KAfXqLoDpmVoFK7ZNV6g/5JuFkN475zALwl4GwwVlY8fXg5SBtbUWvFKA
         WqZir9YrOigJIJBte6beJZ2IE5Wq3YwlNnQR93gpQxm22eOBukBQhQskJPniK27Y8ZR1
         6NEfOPcaZaCDrGnyPsy9Weh31Kh9E42Moi6n/UFxNgCwSSUQOIvDO/3YojG40ntnx2cK
         t8lJ2bpeqnOWy6DqPhAgmIcc8iWiR5VjfH580KqR4OU2DLJrWLqD3KfOuznrTFKm8b6u
         3fMg==
X-Gm-Message-State: AOAM533DL/bRFrqa38grG9X8YebsH6gDON1hc0L/ydDTqgPh5Sy5qN0e
        C6wtNAX+afdxYSE09+aZ8VKuv7E=
X-Google-Smtp-Source: ABdhPJxI6FRG73rAsHm323JnCKMhq4pB3PcnYBXk14h/tsQYeYEeHo8w/6xWeXQvyHhFOSQqZ2IPvTs=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:dc63:3518:5cae:d4f6])
 (user=pcc job=sendgmr) by 2002:a17:902:684b:b0:143:84c4:6561 with SMTP id
 f11-20020a170902684b00b0014384c46561mr50657272pln.33.1637114852063; Tue, 16
 Nov 2021 18:07:32 -0800 (PST)
Date:   Tue, 16 Nov 2021 18:07:24 -0800
Message-Id: <20211117020724.2647769-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] lontium-lt9611: check a different register bit for HDMI sensing
From:   Peter Collingbourne <pcc@google.com>
To:     Robert Foss <robert.foss@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been observed that with certain monitors such as the HP Z27n,
the register 0x825e reads a value of 0x79 when the HDMI cable is
connected and 0x78 when it is disconnected, i.e. bit 0 appears
to correspond to the HDMI connection status and bit 2 is never
set. Therefore, change the driver to check bit 0 instead of bit 2.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I7e76411127e1ce4988a3f6d0c8ba5f1c3d880c23
---
N.B. I don't currently have easy access to a monitor that works
with the existing driver, so it would be great if people with
monitors that currently work could test this patch to make sure
that it doesn't introduce any regressions. Otherwise I will change
it to check both bits.

 drivers/gpu/drm/bridge/lontium-lt9611.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 29b1ce2140ab..71f1db802916 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -586,7 +586,7 @@ lt9611_connector_detect(struct drm_connector *connector, bool force)
 	int connected = 0;
 
 	regmap_read(lt9611->regmap, 0x825e, &reg_val);
-	connected  = (reg_val & BIT(2));
+	connected  = (reg_val & BIT(0));
 
 	lt9611->status = connected ?  connector_status_connected :
 				connector_status_disconnected;
@@ -926,7 +926,7 @@ static enum drm_connector_status lt9611_bridge_detect(struct drm_bridge *bridge)
 	int connected;
 
 	regmap_read(lt9611->regmap, 0x825e, &reg_val);
-	connected  = reg_val & BIT(2);
+	connected  = reg_val & BIT(0);
 
 	lt9611->status = connected ?  connector_status_connected :
 				connector_status_disconnected;
-- 
2.34.0.rc1.387.gb447b232ab-goog

