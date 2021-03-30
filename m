Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D26B34EE35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhC3QpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhC3QpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849DDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o16so16945838wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e231YlAtkWfHG8c7u1pVYJ7SLucjnEEbcHHLcgbxIik=;
        b=u9jwcTihxOxRl6YDlvZlPO9EdfvOvI5mo8z7teVrB7JwSuhbEx+M4vCoU9b7w0S/SJ
         IrNSs7Tu0eoMNNhk3fuqF6xuJ0y/I5pFzvbQFTMEbKG27HyfQQxMJb85X5mGab2vm8Bm
         lKBEtibvlMZHiUOmeQ+aIhXQ5gLdaWEbaOlU97C2RA/koCoiiRoaitcltTm6F7rolIdt
         21sTEOsF8LWaFBeVMj2rCrl/ZybBNQKQsHeCP+HAf9LcdEuMC9lYVVI8k4yaKZwk783E
         mjCnWXd2YhXA0/fVrD0pWMFmaMrN4gw3mIOJtp/Bp9mzuDxl+12obuHy1uybqi875Bk3
         Amzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e231YlAtkWfHG8c7u1pVYJ7SLucjnEEbcHHLcgbxIik=;
        b=QeLPRTOUEwugY0hWzl6XwU1q9a1r1Pw3VTXptjCOOCBVri/TtyaDVpZtQ2RgJNFZpx
         pgrfUW7scwKq9gNemePzNKGOeUhMEaQXplv6KEprMyHTztuhwd69X6bOyO88+FGaBrv8
         FMWhDi3RIvYfh5ZHSLdGml6n7kkjvTPpIs2Ka3J4duZLnObZpgYrvARyeEsah2fCUbvz
         a8pvChXjwYqsgMaw7ZnE89D/ymdA5KkQ7Ke8nK3mVbV17FXfJjgsLZ1I1HVcppwrpKcp
         13ZYNLlfy+pElxrsoVx85QXXtzlTaKsLeGcAFotBJqETiYIF2OQub4qeSGOc0SKQvCDP
         bmOw==
X-Gm-Message-State: AOAM533fReEeohBuC5yBLDU4lPalFzlaVDnI2c5YXw52nmrkihEZ7NZL
        M9TY14JEBx1Re2DYpZ5gDQMSbQ==
X-Google-Smtp-Source: ABdhPJzEfOIvt38mKaAHEVkJ2dm7wan3/OD+PYGAA+3Up4QG883khqnLq/ta1Mz1AqpeaDzWLvchtw==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr34237378wru.259.1617122704212;
        Tue, 30 Mar 2021 09:45:04 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 03/31] fs: gfs2: bmap: Demote half-complete kernel-doc headers fix others
Date:   Tue, 30 Mar 2021 17:44:30 +0100
Message-Id: <20210330164458.1625478-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/bmap.c:1502: warning: Function parameter or member 'rd_gh' not described in 'sweep_bh_for_rgrps'
 fs/gfs2/bmap.c:1502: warning: Excess function parameter 'rg_gh' description in 'sweep_bh_for_rgrps'
 fs/gfs2/bmap.c:1671: warning: Function parameter or member 'sdp' not described in 'find_nonnull_ptr'
 fs/gfs2/bmap.c:1671: warning: Function parameter or member 'end_list' not described in 'find_nonnull_ptr'
 fs/gfs2/bmap.c:1671: warning: Function parameter or member 'end_aligned' not described in 'find_nonnull_ptr'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/bmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 7a358ae051851..7ff20db4999fb 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1477,7 +1477,7 @@ int gfs2_iomap_get_alloc(struct inode *inode, loff_t pos, loff_t length,
 /**
  * sweep_bh_for_rgrps - find an rgrp in a meta buffer and free blocks therein
  * @ip: inode
- * @rg_gh: holder of resource group glock
+ * @rd_gh: holder of resource group glock
  * @bh: buffer head to sweep
  * @start: starting point in bh
  * @end: end point in bh
@@ -1656,7 +1656,7 @@ static bool mp_eq_to_hgt(struct metapath *mp, __u16 *list, unsigned int h)
 	return true;
 }
 
-/**
+/*
  * find_nonnull_ptr - find a non-null pointer given a metapath and height
  * @mp: starting metapath
  * @h: desired height to search
-- 
2.27.0

