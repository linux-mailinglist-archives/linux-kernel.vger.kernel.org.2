Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2319C355FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 01:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344820AbhDFXxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 19:53:47 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50032 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245241AbhDFXxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:53:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4FFPVm3dSGz9vCCy
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 23:53:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dkCz4jNWAy1v for <linux-kernel@vger.kernel.org>;
        Tue,  6 Apr 2021 18:53:36 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4FFPVm26J4z9vCCn
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:53:36 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4FFPVm26J4z9vCCn
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4FFPVm26J4z9vCCn
Received: by mail-il1-f198.google.com with SMTP id v7so12717399ilh.23
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpfUu7thUIxHoKtSoeYtB9AvLxQFw0ALtYzefKcsYuM=;
        b=aTmXU9Gh62tIhl9S96zDwBXdgT7sGNhAHueo9mfwzFXBETGlWWtfnvSeOxU4620x3m
         8QENm+NfSf0Rce8m+Ik1+dYJ7YJbRbHj5pEknqLg1DldPynv4A/3xbPbZQddAJgTKnnK
         XsGyO/aiOUu4RRM4NKC6hd1qps908IIT8EBH27oAVEGYWT615fL1HgTbpXCWM3g5qwVk
         +oTgFgiQK1g/hItfzLi3HrU5O1kZdpS/Ba71EsMBA+DUxPE25lhHf9HELWNg4y4Cmfm6
         5dlhJRS3jMsPUt9KkLlO/1rS1N/kznI7PXSNKFOzbBU/HE2BUD3W5pK4HF7QgX168Nek
         h5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpfUu7thUIxHoKtSoeYtB9AvLxQFw0ALtYzefKcsYuM=;
        b=JRPsrJF0EVzS/9iIOVIwF6TjKstjXqymtIDzrVEGzMkc1FdXF2utXhuRgO/EHwpdH0
         gXake6CxlThVh1j4SVFG2R/miZfYIKYMnK5JVjp3MBf+NM/BuGCbqE06pb7h26RVWOUf
         pL1VfTyfAuCByM1TilCskitw3KnvArrK6Eg3WDT4STUSXsWMBUIPLyHBRLKOzZSGZRb1
         I2Qo0CfWu6uxl4zuLOEhB0xfxSYN8dY1qiY3alXrosMssqrW0cB811DVvqAZmWotSFqP
         C6nADNEcf9VU3/UFYAZ2TW1Ivbeiku3jNTzbeZd36NoLqFUY2A6xE3Nhy438ca/GU5WO
         0Y9A==
X-Gm-Message-State: AOAM531CPkOrEJWb55L9zr9RN3vK7ULanPTezdiGqRTvBMQs2kTCIFHl
        r91VT1FTuLmU+76vcYNeKGJYml/7GS9ba8v397eFLks9/uZN1mC3fKkkIwFFyZopJDxFTrKIV/X
        gon3sYYOeWgVkqI+wlSrGiYYEJTzX
X-Received: by 2002:a05:6638:371f:: with SMTP id k31mr635429jav.143.1617753215786;
        Tue, 06 Apr 2021 16:53:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi8sJ0PLHiI3wL+/tFsMyaM/WZnC/A5jmQCDdwzuGKrEi4KumtcWbwNFHqNaX8oCGHBeh+0Q==
X-Received: by 2002:a05:6638:371f:: with SMTP id k31mr635414jav.143.1617753215614;
        Tue, 06 Apr 2021 16:53:35 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:6ecd:6512:5d03:eeb6])
        by smtp.googlemail.com with ESMTPSA id w9sm14589257iox.20.2021.04.06.16.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 16:53:35 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: Avoid potential use after free
Date:   Tue,  6 Apr 2021 18:53:32 -0500
Message-Id: <20210406235332.2206460-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In virtio_fs_get_tree, after fm is freed, it is again freed in case
s_root is NULL and virtio_fs_fill_super() returns an error. To avoid
a double free, set fm to NULL.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/fuse/virtio_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4ee6f734ba83..a7484c1539bf 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1447,6 +1447,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	if (fsc->s_fs_info) {
 		fuse_conn_put(fc);
 		kfree(fm);
+		fm = NULL;
 	}
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
-- 
2.25.1

