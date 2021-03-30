Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8770634EE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhC3Qqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhC3QpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05191C061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x16so16871172wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhZMxOF5DIQEa6gsAl2dfJPPNSUSMOj2y0CwF6nVMAo=;
        b=k8KVZ/mefZ8jDFdm4vbYoC2GmhDNiYNLbLTa6gv1LpVtMjv8FffewtFn8F4FaPWJx+
         28c3qu28VkjaTryTU6r1twImofcaUAB5rLqxk64a4mTH6iqZWR2RA9iz0+Wf+ljN6yJE
         iDQfbzHU6TXHIyQPMslaHbySQkpTEUa95IwrzhUa/6VbwLtaYus0WBS9or7qkbK7izl+
         W180E4wop3klOLeVmy48vakMxP7quBRvHLqejiQpaevBvhT2ohABuE0MSZXYRMgYfllV
         MonEbRCO2YLIX+PYXNADJpD3ioHBsugFaOm3ZnE5Lqhv9Xa6TxaPTQGOyTSoS1FbMpN8
         cjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhZMxOF5DIQEa6gsAl2dfJPPNSUSMOj2y0CwF6nVMAo=;
        b=fDmKINWjkrpq+tv4sCBwOilNIMs9i4crr1Xwd30TjtLsvQ9HLtDfgh2JKn3NF6bahY
         /P/qKG+taj/ZK4kxiAXZkGgTvkFCxLAkmk6pcPspRmPM0SBW7ajhYJdAJ1ewMuty0vPF
         CP6JWADZBVeYK7mUlPZzwzxoL5qvPG7tJtK+xeVJMq591gNZTpFMHqTqfuObsq6IrBng
         8PnBW8lQMNcSY3TsPx/6l94i7STjILnKl36LRMAhLrV1UGPi7GTxEc2JrN+Z6VY93+2J
         LXQ6sCIgu8FBgoVLYGU7tS7Mtv2QB7hAr+a1ioM/zMwM2dZCCRtdVOmUw4WzMehyVRn6
         G7OA==
X-Gm-Message-State: AOAM53331YTi4qKXIxkkrVXQY2w7UII2qsebeC3WEdi1YgpQA8RzLUJ9
        sx14G/RenO/WF7q+Mg7VxpVpew==
X-Google-Smtp-Source: ABdhPJzFIj5h10clKCWBJEdUpQezJbeJoineJgqfOaOnso+v4mKYZjMoAftK2fVTD522I5ySmS8LdQ==
X-Received: by 2002:a05:6000:1281:: with SMTP id f1mr35171282wrx.243.1617122718750;
        Tue, 30 Mar 2021 09:45:18 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 18/31] fs: gfs2: lock_dlm: Demote incomplete kernel-doc header
Date:   Tue, 30 Mar 2021 17:44:45 +0100
Message-Id: <20210330164458.1625478-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/lock_dlm.c:48: warning: Function parameter or member 's' not described in 'gfs2_update_stats'
 fs/gfs2/lock_dlm.c:48: warning: Function parameter or member 'index' not described in 'gfs2_update_stats'
 fs/gfs2/lock_dlm.c:48: warning: Excess function parameter 'mv' description in 'gfs2_update_stats'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/lock_dlm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 153272f82984b..4afd98c91e73e 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -22,9 +22,8 @@
 #include "sys.h"
 #include "trace_gfs2.h"
 
-/**
+/*
  * gfs2_update_stats - Update time based stats
- * @mv: Pointer to mean/variance structure to update
  * @sample: New data to include
  *
  * @delta is the difference between the current rtt sample and the
-- 
2.27.0

