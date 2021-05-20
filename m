Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF3238AEA1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbhETMmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbhETMlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADEDC04FF20
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c14so15593581wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbOeaLHaZdzOotTNwai+IPwZLrwmiEGVhMGqTe5wzTI=;
        b=PGxl7GWDRI1/M1YA09Vz39LjVylOYYtutNYT2QeXCzNYwYMRc4EsaxHjcGOlsGO3FC
         PMW0PnbdNUXfAZaEesl1yhgSU7PhFwjJK4P4XOeziDoSPtNVcgA+h1JrJNhDQNc4HeBc
         ST+UTp+23b9EPukmxol9Wf/IVsSJ9uHiShv0/RbHPOdoZ114VKcCFAYEDgA2TCn+or/Q
         hGSo8NPJlgKjsw6s8NiBe3AAcQNk2+94qLdDSMsxRW7sOEzIukUB+9Fup8wM5HKPvmuB
         YZ4tRiqCHXQUfLuJpiHQmHM5YiXSTyenuV6bp0oVZyN5YHW7JKrPZGo0H5cgHqHokHF7
         oUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbOeaLHaZdzOotTNwai+IPwZLrwmiEGVhMGqTe5wzTI=;
        b=ekyRwr0hPX674+E0hCxExdVDReHDjH5F6EGZtvDGeh5WhCIw4FC28rlAkeUz/FX0y4
         hp0wjoM3I4L9f9EOMrjrUhfsAMMIVF/GCloDGlcoAN0uv1JQbu0sCNI8EWfgNmr7tac+
         x+VOWz5XOy7Tm+D9SBqzUaZID7x5/re/oLlRjRkHnh5LzN+7FU0LWsuc5zuRQzvEwDUj
         93HQoBwleESa5VsC7ntYfNmNE708WXTKopiTZmuYIbDOmOQTVefFKhm3AL7av/Z5k0kB
         29VWwvETryNjzTURrJnbOtwjnI9LTrWMtkCtjRyWEFnVkHguzaO1rNfFPXK3+xEB6yfA
         WY5g==
X-Gm-Message-State: AOAM531PWnpTfjoDS/qbXvGGCDgHulu+GjACMA35j8v2/MNAxQF7a+hy
        bHXcyLQ3fs6mlG9yv5wjDRh8Kw==
X-Google-Smtp-Source: ABdhPJzmI8EFwVW4tHkAIp5qfV3wXoUJe+jgzvnTaGoBAUvb+NlTj0sQkxW+kNtyLa22FScXwOpqvg==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr3925495wrr.388.1621512055886;
        Thu, 20 May 2021 05:00:55 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 12/15] fs: ntfs: file: Provide missing descriptions for 'start' and 'end'
Date:   Thu, 20 May 2021 13:00:40 +0100
Message-Id: <20210520120043.3462759-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/file.c:1969: warning: Function parameter or member 'start' not described in 'ntfs_file_fsync'
 fs/ntfs/file.c:1969: warning: Function parameter or member 'end' not described in 'ntfs_file_fsync'

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index e5aab265dff19..1f3d8804324c1 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1943,6 +1943,8 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 /**
  * ntfs_file_fsync - sync a file to disk
  * @filp:	file to be synced
+ * @start:	offset in bytes where the range starts
+ * @end:	offset in bytes where the range ends (inclusive)
  * @datasync:	if non-zero only flush user data and not metadata
  *
  * Data integrity sync of a file to disk.  Used for fsync, fdatasync, and msync
-- 
2.31.1

