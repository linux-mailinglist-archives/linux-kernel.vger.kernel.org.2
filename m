Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD27738AE93
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbhETMln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbhETMlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E83C0611E1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d11so17349451wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=litDP3dBoSqeZ9ru2ThnWBI6UxCaLCk4fTIzC6ohx5w=;
        b=Ntqqv7ULDWng2DYoB/c9DjVKM9VAQI0CQcz8P94RR1Tktm+KFbK+8yVyhhhYCC1EHS
         MQhz2wx6djsvgLEf5UQJ2u1amxnec4A4f7LUfX2M0IQqRbzFMSyo7AtVKcKhruROFQ+L
         V1CZH78vm9KT39gMtTqSHumzASve3jW9PSOHmtXfGCIZljsusjEliQ01NLIvjcKU2fzk
         naUfkDa8X6gZKIa4GqE21irv2uDo2gfWQKIsu5lH/HlUBFZB2hkIJbz04yMh12tH9fz8
         2QHbNJAP282tmAnmEo3QFb9Q70zDMrCOMOGBdDfM2WD6SbXM84HVoqnUWgrE0penduPM
         sFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=litDP3dBoSqeZ9ru2ThnWBI6UxCaLCk4fTIzC6ohx5w=;
        b=XmfCWugkFGvBxoY1ltlN35RarDI3KlbZhJbeBgJLoTJU++EqbwoTXWs9i0DkM7qJEs
         Sa6KB2NrRKk1vrqYq+jTEjcCxM1dEPavdQbOXRjqQj1iKln4UbrpJsflIuBYAZFIkQAU
         WjQWag6PXDcuC+rYdvsK8LO8HA6piIb6FgjIitnd7G04m4DACTHGQouOAl8Tfj5baIHv
         VSR4Pwt7qWjo5AE6B71sLF6oRtb6wDuPI0eQgJO0+BcTkHovY4L9k+2snAjt5hs5lzGD
         3BL3ty7nrGZABB1TeML2QkTLLuc9MuVMw52VjtPZixNbTMrOuNIofii0PbLfV2EmsooB
         bQMA==
X-Gm-Message-State: AOAM532whcKhwQ1WH97nNGTd3KIf9trgUmj1PFnFMrxeAmr/Gz9i8GOa
        TAMdN9txLaoQLd8ZoMeD4IBTAA==
X-Google-Smtp-Source: ABdhPJwEhQLoR/jKiPzjr4RLG0YjO1K801kkHxeAW1FaHiBqq24IajxLwf28og9Am1zvLL3RF1gTeQ==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr3788703wrs.303.1621512047225;
        Thu, 20 May 2021 05:00:47 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 02/15] fs: gfs2: glock: Fix some deficient kernel-doc headers and demote non-conformant ones
Date:   Thu, 20 May 2021 13:00:30 +0100
Message-Id: <20210520120043.3462759-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/glock.c:365: warning: Function parameter or member 'gl' not described in 'do_error'
 fs/gfs2/glock.c:365: warning: Function parameter or member 'ret' not described in 'do_error'
 fs/gfs2/glock.c:461: warning: Function parameter or member 'new_state' not described in 'state_change'
 fs/gfs2/glock.c:1277: warning: Function parameter or member 'delay' not described in 'handle_callback'
 fs/gfs2/glock.c:1277: warning: Function parameter or member 'remote' not described in 'handle_callback'
 fs/gfs2/glock.c:1578: warning: Function parameter or member 'p' not described in 'nq_m_sync'
 fs/gfs2/glock.c:1993: warning: Excess function parameter 'wait' description in 'gfs2_gl_hash_clear'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/glock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index ea7fc5c641c7e..0b34f50b51331 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -356,7 +356,7 @@ static void gfs2_holder_wake(struct gfs2_holder *gh)
 	}
 }
 
-/**
+/*
  * do_error - Something unexpected has happened during a lock request
  * @gl: The glock
  * @ret: The status from the DLM
@@ -1263,7 +1263,7 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs)
 	return ret;
 }
 
-/**
+/*
  * handle_callback - process a demote request
  * @gl: the glock
  * @state: the state the caller wants us to change to
-- 
2.31.1

