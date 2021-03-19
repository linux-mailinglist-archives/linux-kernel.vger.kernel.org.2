Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8345B34176A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhCSIZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhCSIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BE4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u9so8276122ejj.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5sJeJ74F8ymxQq/7xf9FhHZmcrAt5y0yMPNHooyiic=;
        b=EqZNiy1vilBKzHtBB/JA2baYUg9hUlPSDynQji8XyUJLzXfdpYS5reLg/igob+jWCI
         LH/esZJEDeH4EU7JJ4uvVte/J9oV/Brhd8d/SdQK2fB/dtY92cwOlIkw3zOQ4916TEWt
         H//uHpkfb2QB6nv+2kOuphTzQFsUs6E+8mT3CSWv9IyWBqDqFx6P0xr7f6Asg/54qiDz
         DigoPJvjffhOCMZQs/+Ra/1xdQUpScFxG99mkGrbeU+815rokcxY368VMQOSVV2r5Yfz
         y0K7Qm27N33CBR2rO3wuuG60yUmB1Qhx7B7SNMEXwoAojnZBg70c9mWfDIT8iyovKtN+
         YW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5sJeJ74F8ymxQq/7xf9FhHZmcrAt5y0yMPNHooyiic=;
        b=bIaEZ12Ev2WW9Dgfwn5vjA3fhdSt3/JcvGEfzSULpRV5Ey/RJvGuGO3HDP0vcDyeDx
         LVvf7qIniVVZRvRIBDn7kMKqEM7j+jAtk6irPbQmSq+dGU84/iQ+fMp5lEu45gJ0g1BH
         Q2t42nvXTBIpIboE9Av0f73NF/QbeS2BAPgi6tLC9YWLBtSDCtkeHMp1V5inDG9YYEdb
         RJA8LLdsm00XEQN2jvR9zHa1yi1bc7f4NueqtuWcSW6Fn4v5+whIHgEpwR1YKGsJVNdh
         hK1tp317uXSJwkguGpoThqF0O7U07JXmbrfimGMwWchXCbaC+zEQ2bcAhGoOeLbfFwgW
         Mv2w==
X-Gm-Message-State: AOAM530h8RlOZEzlRdrSnZMGtN6fZyUv11ppatPmeOjfWu/IVGZ902dh
        4GCbc0XgdKDJdj/mdDny/If2/Q==
X-Google-Smtp-Source: ABdhPJzVPbpEzcLADX3H3VYHMHwRrOKLnf+8GraJSURrb0v6CpwJkCcB1hblNG8Ck8PooHZlonj9PA==
X-Received: by 2002:a17:906:2b46:: with SMTP id b6mr2916032ejg.521.1616142276934;
        Fri, 19 Mar 2021 01:24:36 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 05/19] drm/nouveau/nvkm/subdev/volt/gk20a: Demote non-conformant kernel-doc headers
Date:   Fri, 19 Mar 2021 08:24:14 +0000
Message-Id: <20210319082428.3294591-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 'speedo' not described in 'gk20a_volt_get_cvb_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 's_scale' not described in 'gk20a_volt_get_cvb_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 'coef' not described in 'gk20a_volt_get_cvb_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'speedo' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'temp' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 's_scale' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 't_scale' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'coef' not described in 'gk20a_volt_get_cvb_t_voltage'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
index 8c2faa9645111..ccac88da88648 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
@@ -45,7 +45,7 @@ static const struct cvb_coef gk20a_cvb_coef[] = {
 	/* 852 */ { 1608418, -21643, -269,     0,    763,  -48},
 };
 
-/**
+/*
  * cvb_mv = ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0)
  */
 static inline int
@@ -58,7 +58,7 @@ gk20a_volt_get_cvb_voltage(int speedo, int s_scale, const struct cvb_coef *coef)
 	return mv;
 }
 
-/**
+/*
  * cvb_t_mv =
  * ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0) +
  * ((c3 * speedo / s_scale + c4 + c5 * T / t_scale) * T / t_scale)
-- 
2.27.0

