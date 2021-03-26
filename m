Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1E234A3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhCZJMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCZJMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F42C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id dm8so5500750edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CcaACtGBknSaAZjeIVoYylSZIgl+vXHSAulIEcUgKg=;
        b=oWO9cV+YBGN8t5k7zqdjh0sBH0OmyJtb/4OEOOtoozkclloiofkGu71oE6xzDxkYon
         9K860OJiC5lNDquRASANlxLUbNMo515zTcRuWOzKZ86PlQkhEclOH4EeQfzWB+X+ETam
         RoDGPSX2qxySqzjE/wISvMNFeTC73yPMBiNa9zF8Jkt1kVeP9GnnE3higG3MspOecqgt
         gyzCv1HCPMfXYaZdO0P5w0IOQKAJ5P5GcyQacUTNTGHar6SU+PETVuCjKvoq3c4tXWEm
         +fzFMfHWvU6ZVwORn3u/9WU5CFvy5BFifP1eN8AXRSAdH9NGZ12+xUL5l7upSjtPnbzA
         22pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CcaACtGBknSaAZjeIVoYylSZIgl+vXHSAulIEcUgKg=;
        b=gV52cbrvAhZDEwEEFS+r3UEAXbuWeEDO+MrYnW0rMu+s9HHtD9H6RbdqhglLgpOIj7
         yvdEmUfoEB0k6TQqqRZqphtJyOeQEl3z/9r77Mp5q9cjweQE5rIEsViot2RvunPel+bc
         isnGXcSM3+RCWlJ+AqxqoJZRtH0+pe/mA1xSCNDNVQ2oN/Mt1zrRqUuaNKLdzxO1NNTz
         EUYRSZAkZ3nPWHxtumbqR3RBxMR+zJPwB1My3CAwcqCuhDTl8x33NPABcD0umTyBGJqy
         iy2TPq6EnT/zV+Eenyryo9i1A1lxaunHdt4Tk+KH0cBggXQg+NSAYAYtPRkjJyJGJHLx
         JKWA==
X-Gm-Message-State: AOAM533b08t5UaL8mt5XHuaxzYSaQVdmEB95f/y1SaLwHJl3t5NCzvKE
        lNzpnIfj5PxmlECxXA5XljiTjQ==
X-Google-Smtp-Source: ABdhPJxhg1D73bhbMet21+aKxDRVk5RvZGESp6L45Nso/Dem7mylXZI4gnsPmPG3hlUiYcsQXxXbEQ==
X-Received: by 2002:aa7:d917:: with SMTP id a23mr13780703edr.122.1616749925124;
        Fri, 26 Mar 2021 02:12:05 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 11/18] fs: gfs2: file: Strip out superflouous param description and demote kernel-doc abuse
Date:   Fri, 26 Mar 2021 09:11:44 +0000
Message-Id: <20210326091151.311647-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/file.c:127: warning: cannot understand function prototype: 'struct '
 fs/gfs2/file.c:446: warning: Excess function parameter 'vma' description in 'gfs2_page_mkwrite'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 2d500f90cdacf..afab20e5954fd 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -118,7 +118,7 @@ static int gfs2_readdir(struct file *file, struct dir_context *ctx)
 	return error;
 }
 
-/**
+/*
  * fsflag_gfs2flag
  *
  * The FS_JOURNAL_DATA_FL flag maps to GFS2_DIF_INHERIT_JDATA for directories,
@@ -435,7 +435,6 @@ static int gfs2_allocate_page_backing(struct page *page, unsigned int length)
 
 /**
  * gfs2_page_mkwrite - Make a shared, mmap()ed, page writable
- * @vma: The virtual memory area
  * @vmf: The virtual memory fault containing the page to become writable
  *
  * When the page becomes writable, we need to ensure that we have
-- 
2.27.0

