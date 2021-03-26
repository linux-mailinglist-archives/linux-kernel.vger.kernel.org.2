Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48F834A3E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhCZJNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhCZJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AB9C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k10so7375813ejg.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhZMxOF5DIQEa6gsAl2dfJPPNSUSMOj2y0CwF6nVMAo=;
        b=V3EfufY9jncLxlFb9mVROrV9XrCRCr8zEHV5jjJPOtw0JyGZwGE7w9jQhcN8hus8Rw
         FG3hWiQ8wW0wDE/neg9fzXUrPuqdPHjT0am9e3KHJReVuJb2w9a7Lo1Akb05UFQN/qOM
         xkFqoNlcfgQi7Qwt9tcRrWjsfGAdqoDZKUhfo2yaWDD34TI8LUyL+OXniXZdYy1QkIV1
         Ikkq/mkG9A9oEo2KvoztmnrJaqQIyfyi/rGPkHB+euO+EL0BAcFIMBbdKhmwDXvwch+B
         RmtkNlzTQsyfcgZXQhkWugm0WQIOjHbyzhZtkb9PyL0R3vqfw7opKaicVAt9AO2K4Q0h
         0ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhZMxOF5DIQEa6gsAl2dfJPPNSUSMOj2y0CwF6nVMAo=;
        b=e2ByZDPveTPCRBX9xE4MLYyvnvoUkYuCG5gPdBaRfWCjTyyxxruvft9lqjmU8sMsXI
         zI0NjzTYRGfDt/fRK0G5u2FFR3KJmQQtxa7XAT4iwGi4DUM5zn82cCqWoZxNi1sgEaVf
         IKPN7XEG/i5HFsqow1qho2OpGbAovFLDHt5EjDS9uewlGdSnBm9e0I2pNLw+7MMKnYuW
         3O++JwqGube7D25p+yCorYwCjkMfzfkfnjPwnEspnU+mNVLGGYJvHSSpBPgz+iRtnKnS
         Ad4tSzBkGw53X0PTVii3qWnNdw2xGKHbUih1DSIuk+dENRWJxpHnkKFV98ok1zzrpwX/
         OARA==
X-Gm-Message-State: AOAM53209rW7XuanEDR30JpC2WVdGOLSxP4dDRbYG7Jk7zHT0RoS6x4R
        Jty8KdKbP+vTTDlMbmdEvAEWfg==
X-Google-Smtp-Source: ABdhPJzzmYzb1Xb+jNI8vIBthz701GseAY7wfQ6fBZOuJL/MqLEBHqKyrpXN5/sldoWxB18iszFiQA==
X-Received: by 2002:a17:907:76a3:: with SMTP id jw3mr14380776ejc.353.1616749931740;
        Fri, 26 Mar 2021 02:12:11 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 18/18] fs: gfs2: lock_dlm: Demote incomplete kernel-doc header
Date:   Fri, 26 Mar 2021 09:11:51 +0000
Message-Id: <20210326091151.311647-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
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

