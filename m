Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85EE38AEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbhETMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbhETMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D4C04FF21
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d11so17350206wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IrecHDGGhuuW2uy8xg0gZxiHWZxNzWt+fwsCAZdUnjQ=;
        b=rC0jlPpG5RHjBDxkWP6NNtSMhwCFjhEGHCjW4b/2fv6q5dxzD3u4yKrrZkUFn0mP95
         XGJikuCsnZtTObKS4ap42LR3pshswKDXBSTalYJ40YDmmLwtqnmjdOjN79V05yT2b9Vt
         Sgj4W6p/+3Yc//WjeQt3SSSA74NO28vW0k6RYT4oQiXJYHE6NY4z0uKfB2GE6OX4eDAk
         ti3y0Q/4noMdeX6mXxcxAA9fmFA2MgWmANqYbyolieo7a1zPOZ54Lh4e7DqTTEA+pSKC
         F6WisuiQ5bZBUOvS6JiZWvdIbC62lKe68U43xvm7/l5TW+fe1GT/XTt5giCrRWLCAOu2
         KpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrecHDGGhuuW2uy8xg0gZxiHWZxNzWt+fwsCAZdUnjQ=;
        b=OU+1dhxO2LcbKO8FN1b3wZ5wiwzXCLsH1Cc5z12cl6DNJ75Eiuj+MxmhhQhmWZlg3Y
         tNVdtDjy4NujnJFLQB2J4UDBL4B9JCY/EoujU7tOtzJ+WgWMSshzD9hmqbWtZLzlv99c
         kEFw957egEf0GKrVvTYt4q3AIJx1WVdOUkcN71kBBg+HRo5ZVgk8YOn9RVvrZETEP5Nz
         Zvgl2i0iMPvGujcqBTbMsIN9VqOwEFC9nstwBspU5iT80HC8TghlyqfHuA83n7Cjay4h
         gFqwEROJEN6/q1Y5yNTRPCUdeLMt3TVo+5E1Zn8idZpts+v007nt3mpJMTE/hoHi+tu8
         OGOg==
X-Gm-Message-State: AOAM531Tb/ZVX3HevYTe28Y2AoL09SMri/EcFo4TWxBqxASPYzq67ED0
        KFbz5mIiiV7NwUwbnO2nziSW8Q==
X-Google-Smtp-Source: ABdhPJz7cC4NnNn65EdvJ8Uug3Zp0RDyzB8AKm1MBilLOc6LjMU4EPTgfxc0uvzy7btQJ+FNy+G8FA==
X-Received: by 2002:adf:a519:: with SMTP id i25mr3939197wrb.312.1621512056713;
        Thu, 20 May 2021 05:00:56 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 13/15] fs: ntfs: mft: File headers to not make good candidates for kernel-doc
Date:   Thu, 20 May 2021 13:00:41 +0100
Message-Id: <20210520120043.3462759-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/mft.c:24: warning: expecting prototype for c(). Prototype was for MAX_BHS() instead

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/mft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 0d62cd5bb7f84..d197d402933a7 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * mft.c - NTFS kernel mft record operations. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
-- 
2.31.1

