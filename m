Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B806F431245
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhJRIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhJRIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:41:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED92DC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:39:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so13945736pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FIeLaEFyC6pKx/l+fqT/NHQt2GUwspGRSiBadau7wM8=;
        b=ccCc1hfbRRVQIiBA+jjdnAy93d/6C+WBoAHxQeuzOGiDe7owhfpj61rm+hQG+SkIGI
         N4pjQyQe16nSsB3PCAzu3byN83WsstHBMXBT1k1T5pYihw6kMdeUgjL1wuWLtDOAZAlI
         V+Ek9iMsO89dTq2tmrnrDj4/ZCUbFzBj0muFqvYc5bBYKjzYqTU7E9d6s6eOAIhA/1Fm
         75tv+YHAhWHtwsrHHNFMAes6noY0KmbGnHJlNEMRJ3USSEEqfOeIMix02wb6QkpuVOZM
         8MoPajkr1GiZY4P9ak7WZ7wLGq+xO0sFxTUw48SAGwQCDvQjXJXxLmqD/9OpQX2BG1dF
         JSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FIeLaEFyC6pKx/l+fqT/NHQt2GUwspGRSiBadau7wM8=;
        b=bSJaQBx36F/jetCt5JVzyUvEE9GpimJJFM7CcgS+A/Byr53WFcOPQ7qKePyHlKFQBj
         ldUCJqf4O45O0EtoKC0XJKW3P4RMJ7oDOBozr2AiDDN+6VvBiQopxTJieVKQOFcyLNz9
         0mIb6QAeJ0Jh4PqkHznfAHu5Tpp5OtJYeCCQzNWWqpjxiU4TMdthr/Qv9WtK/ILAcDEC
         PYNCTX5bHTFA7buOAFmYAn+Bc6HrH5yfJd4XMeaJG4X9B3gQP8LpPk9+EJKlGguPz1OV
         m76e3Q10wWRB1Yf2ZenEKivARhYWbYwT+MyBhsgB5nnnJgh/8ktNnpxNAusY6mbi/nUB
         EspA==
X-Gm-Message-State: AOAM533b2mrRBHUsDnblCHSWaobcmrnBvEyfI7sUG8qf/ZZNZ3AU9xU3
        r0znE3QJSsy9owrCSqKPWbs=
X-Google-Smtp-Source: ABdhPJxMs62rsRWoqISWhuPFvLb7uxg30l1ZlrUwvWREQRfP+no5flZFs55dKbU5UDdePfP0yUIZGA==
X-Received: by 2002:a17:90a:4fc5:: with SMTP id q63mr46187263pjh.148.1634546367487;
        Mon, 18 Oct 2021 01:39:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id mu7sm13142829pjb.12.2021.10.18.01.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:39:27 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/i915/display: Remove unused assignment
Date:   Mon, 18 Oct 2021 08:39:20 +0000
Message-Id: <20211018083920.851150-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assignment will be overwritten by the later, but the variable
is not used.

The clang_analyzer complains as follows:

drivers/gpu/drm/i915/display/intel_dpll.c:1568:2 warning:

Value stored to 'dpio_val' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/gpu/drm/i915/display/intel_dpll.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll.c b/drivers/gpu/drm/i915/display/intel_dpll.c
index 28b1616..cb77d7f 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll.c
@@ -1653,7 +1653,6 @@ static void chv_prepare_pll(const struct intel_crtc_state *crtc_state)
 	bestp1 = crtc_state->dpll.p1;
 	bestp2 = crtc_state->dpll.p2;
 	vco = crtc_state->dpll.vco;
-	dpio_val = 0;
 	loopfilter = 0;
 
 	vlv_dpio_get(dev_priv);
-- 
2.15.2


