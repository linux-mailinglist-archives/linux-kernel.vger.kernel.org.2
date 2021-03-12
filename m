Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC520338AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhCLLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhCLLCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:02:43 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C1CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:43 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso15519956wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7Nef7Azn0rfESy5emyU385qg/IaOuZL4XvG5ZQpiKY=;
        b=yngzM0lfJCS5YFiCAuUZbRTmslDDjdgwygwpJOwE95L/0L9QXKKc/Y2/bnWruPRXTB
         vvsGIVUytKycJULfddrWSEMtxaUJYx42ovZ+VqeYOKJM/+eBXsLFeM3UNsKHCD5pbhZ8
         iQ2C1inzjqL8ENneKPorMghSCfRLx6OoqG9CpoPd+2q0hWO04sZo5GewiZChGf/mF16k
         0KA7tqzoF5ql+nhaymBRjoMLxCFReQ7fUuNtms31Ek5SiqSjMbPnOhirfd7gV/fKAScE
         exahUMEbXG7CHsRR6NTGgZUBVKPD06o6mx0n2/gufATHicytMXbjxgmKurxbwGFqpG3w
         qUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7Nef7Azn0rfESy5emyU385qg/IaOuZL4XvG5ZQpiKY=;
        b=ghiiNxpjJLqCuMQt57MKwsL1oqQPZJ9FPpTX+mklmDiRwJV4t0yOm/KUIgLCfiOqTp
         Df19dPOpsls7dJiSIz59q3ZLSqM84KqscTKO8I0CMiky27O/mu/sKrvci/tB/gr11oR+
         3Dmr9ut6t2vSxLPTS7qgc/YqtdfkjaXay/qSjQpowOtdXxVpBL4D8dwM4gK+a0PKd7OO
         PpwNX47H1gOrDrumxbVfzF7QfIRIfnDWccLl2f/eteE10ssz1BrlP+1zSR2JJSgjvyBg
         zlJgsVCmK1wqUPS4VnNxUmsx1SGrNQsyiFCUIMLLbrxtFspv/RKSAPjfYAEuuaEWsIgp
         Qejg==
X-Gm-Message-State: AOAM532IwV6t1E5vkSZ/m4hyhgX5V/rlPOK0yKtSJG4Ev8izvNNb3Mqz
        QmsyXVcz/+GXF92i9TAy7ewo5g==
X-Google-Smtp-Source: ABdhPJwnt2uaNqVKItQpyz4mm0MIEFwGFzxnwhKTrgHCnGXIlg2U1bSLGL0fRE2eOB6pAOF3WURvyw==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr12263204wme.39.1615546962039;
        Fri, 12 Mar 2021 03:02:42 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id w131sm1761318wmb.8.2021.03.12.03.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:02:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, dahinds@users.sourceforge.net,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Takashi Iwai <tiwai@suse.de>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH 0/6] Rid W=1 warnings from PCMCIA
Date:   Fri, 12 Mar 2021 11:02:33 +0000
Message-Id: <20210312110239.2220197-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (6):
  pcmcia: rsrc_nonstatic: Demote kernel-doc abuses
  pcmcia: cistpl: Demote non-conformant kernel-doc headers to standard
    comments
  pcmcia: pcmcia_cis: Demote non-conforming kernel-doc headers to
    standard kernel-doc
  pcmcia: ds: Fix function name disparity in header
  pcmcia: pcmcia_resource: Fix some kernel-doc formatting/disparities
    and demote others
  pcmcia: rsrc_nonstatic: Fix call-back function as reference formatting

 drivers/pcmcia/cistpl.c          | 12 ++++++------
 drivers/pcmcia/ds.c              |  2 +-
 drivers/pcmcia/pcmcia_cis.c      | 10 +++++-----
 drivers/pcmcia/pcmcia_resource.c | 11 ++++++-----
 drivers/pcmcia/rsrc_nonstatic.c  | 22 +++++++++++-----------
 5 files changed, 29 insertions(+), 28 deletions(-)

Cc: dahinds@users.sourceforge.net
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Tian Tao <tiantao6@hisilicon.com>
-- 
2.27.0

