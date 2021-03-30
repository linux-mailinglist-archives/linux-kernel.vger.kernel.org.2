Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE4234EE62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhC3Qq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhC3QpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED90C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c8so16871701wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CcaACtGBknSaAZjeIVoYylSZIgl+vXHSAulIEcUgKg=;
        b=y3amvOjrs5Exp2MfiO0TCLuiGufKMRasw0An8UjjDQWwpPgKp4HthrJSdsHX/BxOpj
         IhCO3tmJLW0HQ8Uatp8fwdPxXGtTOJlahS9IZnx88BJV0O6dScgB39fngJQqupnfllmB
         1mssR9SO5siz7y8TfvcfyXZimt/AEL3PxZkB5G131MpyOtKRycn1AN4KsjLbGK/xgWfd
         h9/UmMV3p8O7d2MM3eDlAZ/sqFg4mYGDW+IScaX+08HnHE3z4wH5N2sQ8u+ch+3j+2L7
         ww2gWRsZrKNKl9g49CIqydwIMVEID4VtFPaxVpebjpEA+Z5+yT/1jUvLfUfd2h5rfbbK
         +mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CcaACtGBknSaAZjeIVoYylSZIgl+vXHSAulIEcUgKg=;
        b=dOJYo98jFO41uAEDz3gywOunIxBML93LixfAJRfr3jZaQgOwUw1wX8MkTjgb8qquyT
         1CKgilMuKwpBF7unGdCH5yJBaBBCnq+PM+05D0XjL6ADPZbQzIggEwn2vmfoSHZiISF7
         50SX/S7vOkVumpEeObT6D9Erp7wsFE3AcKEYn60QBM/w5KqDtMYgVZfRhJa07Jn7QxKc
         ANIUUEEjnRLDEnaM4GDKRrQJDlnuMvdGjsqqO4tjwhMa7UObICNUyR2ni3K5AbV6P3LU
         tnVMncQffnKfFmiarQYhNtV1/CirpP/qzIiUa6aJDGN14OL1iY19y8ZHTRC7n4wUzFqc
         FlYQ==
X-Gm-Message-State: AOAM533ix6fIUe0r2j27bLT5fYPnK/OxjLyaVpZQ0dfqBjNLsf//Uegq
        JfLjthAJhh/81cgBem1wPr5e9Q==
X-Google-Smtp-Source: ABdhPJwEH8MaNR0P1smuAaU5O9UrfekWbbbU9aD6H82GpRXpotJSR0dpf3B24CDPcSr7NkKGRAu5qA==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr34063224wrs.86.1617122712025;
        Tue, 30 Mar 2021 09:45:12 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 11/31] fs: gfs2: file: Strip out superfluous param description and demote kernel-doc abuse
Date:   Tue, 30 Mar 2021 17:44:38 +0100
Message-Id: <20210330164458.1625478-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
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

