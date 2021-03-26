Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD14F34A3E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhCZJNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhCZJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21FDC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u5so7312325ejn.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGLqWsMKMFzu8AgI6vn47Mo1M3gcJ+HFYMnTl8CpPNE=;
        b=GPhgAeFt6ecZCwLSwUVDgEy0s1/aBY+0R5py6uB7xAt1GVXOLt1M/ZJP8E+F9NItQY
         Ii71CcijoWg6OsuBhpjfo8T1+aJ1x4NEtbTdYFt+PS935I8XwW1LxrIrF97jyutMd/c9
         1rRGlrPiZD6s8Ziytms9Do51X6ehGy1pSa9D7tJcxyGr0F7iBAoPoKPe3LEVOqfLiBzB
         NCbtisJJFxT6I+ywUyP7aP1rLvTlGx5acx64gavkvPtR7wO5wyaRA8kHL8WPWM/bk9q/
         JbrftP88q5n2soQJ93h3sO0Kv8BrJgd0Lslq/4wLOacP+v0OXSnUjPjculGI19urzYw3
         +5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGLqWsMKMFzu8AgI6vn47Mo1M3gcJ+HFYMnTl8CpPNE=;
        b=aXlPwu3Cd0vnDIeZB4TdcNYHrNu5xwy8p2vTON4fNo3nngxr6mNRgE/745yz/fvt5k
         RM0EAOZRLIDg5+uhoSib88fxCpu96Gj+o9XZrY3JlyeWiOGNyzNHxk/ZSbxb8ZTSO8i3
         OFv1qebOuw4TfstQ54GXrBodhKrVHIF/OPrQl/pw2LUiAqkvC1odU59xo9CvWwW/bnf/
         1M3fm5U2S9PtHFZ5DgTxv7ekESPZlWBqawMWZVpfP48N9dM0Mwaya0em3oFxQ+ZZ0dah
         uKhQGesEY+eHPdI5QkqeFqNNDwJYIFCOPUeyMxaMMpLFyEajZvabfHqT8SDw0WuK9exr
         RQYg==
X-Gm-Message-State: AOAM533B08228sXMnRN5aH8AuHPSEQ9blPoH+M64eCQfjFiansfIS8tz
        6m0T2tyt/VYkw4tuNWuDWJPydg==
X-Google-Smtp-Source: ABdhPJy09Omtyxi7eHHuA/xo7XFKjicayB902xQdiYZUcSn7f/EGtDd2mkJihUZ+hpejdJAXbw0wow==
X-Received: by 2002:a17:907:20c7:: with SMTP id qq7mr13708003ejb.528.1616749928629;
        Fri, 26 Mar 2021 02:12:08 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 15/18] fs: gfs2: recovery: Provide missing param descriptions and remove one other
Date:   Fri, 26 Mar 2021 09:11:48 +0000
Message-Id: <20210326091151.311647-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/recovery.c:169: warning: Function parameter or member 'head' not described in 'get_log_header'
 fs/gfs2/recovery.c:169: warning: Excess function parameter 'lh' description in 'get_log_header'
 fs/gfs2/recovery.c:199: warning: Function parameter or member 'pass' not described in 'foreach_descriptor'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/recovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 2821737740055..26004d5431165 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -154,7 +154,7 @@ int __get_log_header(struct gfs2_sbd *sdp, const struct gfs2_log_header *lh,
  * get_log_header - read the log header for a given segment
  * @jd: the journal
  * @blk: the block to look at
- * @lh: the log header to return
+ * @head: the log header to return
  *
  * Read the log header for a given segement in a given journal.  Do a few
  * sanity checks on it.
@@ -187,6 +187,7 @@ static int get_log_header(struct gfs2_jdesc *jd, unsigned int blk,
  * @jd: the journal
  * @start: the first log header in the active region
  * @end: the last log header (don't process the contents of this entry))
+ * @pass: iteration number (foreach_descriptor() is called in a for() loop)
  *
  * Call a given function once for every log descriptor in the active
  * portion of the log.
-- 
2.27.0

