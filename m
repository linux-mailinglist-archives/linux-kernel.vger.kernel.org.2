Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6ACE40CA96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhIOQlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhIOQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:41:50 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFB9C061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:31 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x2so3550624ila.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKV+lnWpUuZH5SUW1lKdicYs9iS1/HR/b6CwzZGnc9c=;
        b=S9I+VL+60lvXHiO1v3wKQjh2TLgFoU2zIMfzmpRCanTOXm0N805LWXpU8PnOp9+jBj
         YRCXjIVfoFkZ0qnzooWi4jakjLgWMbAhWAGnHoggpwQ+cbUtEdpNW92p7uTS6p17DZvH
         N/vmiOTIXtvaMLaIBIMoDS0HFQzImkKIDtAaEy2Eiacl3SS/Y0777LgQwBUaup2DuSa8
         IsPKTtGe5qWSyD7QwLAOsd60/KMq0v8ig3ixgX4L7G1sbcngNYtVDt4l6AWqxEb10axD
         u+Tiv4xEKG8II9Rt70IxMS3jnRfWXoL9qtIUaQh0lex3l7c6thr6oFOVWitknzptZEi2
         +DLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKV+lnWpUuZH5SUW1lKdicYs9iS1/HR/b6CwzZGnc9c=;
        b=yWwu1c5Z+etS5vhe41TuJhlwqwb/w1A+a/gFOJwjNJQJ4JqmvUn97yVa1cuY69x4pJ
         mWPQlIUy6GR1/Aeocl43dfunsfI7A3Gjc9T6OMVWuegPnFrYpp8hDBIN8iQy75tp0W26
         TU2aLz//Phugare8sToc/9JveHXPxhijglQjpqfUmU4hIRMByStdF2TBvBf2q0Qp6/Rc
         hcpKuy9F/CHTEoIUiBts7MpJ/q1sq8zZc6VeVr5eqjSdPbEMf+XKnuS6//ye8egHRA8U
         4sh1seJrLTb+2i2aTjMbCqFkva1yncxQgGtBAt1DfQM1umNC1iCty4dNqPmagEtmKscj
         L/JQ==
X-Gm-Message-State: AOAM5338VLJndYBImgOdRqSeUh3UQ6rMmZ6ElXGs62BnM1frO9C1OBbs
        InKsFxTGR3U+7IK/LoP4mR0=
X-Google-Smtp-Source: ABdhPJzFjY9IDEO5W7WNqwgctTlwlHwbvpjLICXGhOw3Qy7mcpDmGs/yUuIDeGAG/TErArDsOWTdTA==
X-Received: by 2002:a05:6e02:5a3:: with SMTP id k3mr688180ils.283.1631724030459;
        Wed, 15 Sep 2021 09:40:30 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:40:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 02/16] dyndbg: pr-info in boot-param should say so
Date:   Wed, 15 Sep 2021 10:39:43 -0600
Message-Id: <20210915163957.2949166-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add "bootparam" to format. no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dfe1e6a857bc..da91ff507117 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -998,7 +998,7 @@ static int ddebug_dyndbg_param_cb(char *param, char *val,
 static int ddebug_dyndbg_boot_param_cb(char *param, char *val,
 				const char *unused, void *arg)
 {
-	vpr_info("%s=\"%s\"\n", param, val);
+	vpr_info("bootparam %s=\"%s\"\n", param, val);
 	return ddebug_dyndbg_param_cb(param, val, NULL, 0);
 }
 
-- 
2.31.1

