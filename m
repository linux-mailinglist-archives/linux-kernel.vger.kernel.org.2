Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD137002C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 20:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhD3SHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 14:07:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230093AbhD3SHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619806022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D7miYpQHKUyjQ+9R5jWrbmacmh9BSN80I7pxXKphNsc=;
        b=Y75OeA/nY5Mrlo2ykQfETuarKJwXxHBf8uoJYJdm6ElnbQ7XTmPVjoLLMtVuROHM/38Ach
        2I6tDybH8fyV0u9mFjtPndrcUlRuKn626c19cF6c/lIP1zcy12FRZ4HP7rY+A24Ijgjdvu
        X+igsG8k10naG9WLsBuO7BTE7hNi0ZQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-MmSpV3DZPDqfRxNuqqelRA-1; Fri, 30 Apr 2021 14:07:00 -0400
X-MC-Unique: MmSpV3DZPDqfRxNuqqelRA-1
Received: by mail-qk1-f200.google.com with SMTP id m4-20020a37a3040000b02902e6776757c3so6195930qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 11:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D7miYpQHKUyjQ+9R5jWrbmacmh9BSN80I7pxXKphNsc=;
        b=pIyWZ09j9u1MtLvNsY2OJZ43JVokNqAGcVNiz3qxpXR6TQ/qdt+5EbPh+6iOlKnZh8
         JGQz6/ekFhkNMJZ/DMJeqEZZy0jOA0F+5TwKvHZ2lf1PUPeSdFaybp4r65DeAFr3q94o
         9Gi2hOFtDTiSk3/Uc2OH1Zij4wMhV8ZVqGnCmPhDw9zsPBsHB1kaQa6xuNQvYGDB+tIw
         +ILBZQITQdUF7k68vpYyWQXFN8nu0D0xnzwZedXigwGi/4Vj7wkyJZQIKidhr2AE1biT
         3zMgINBhjv2o0LyeOEQpGOMqMwOSUR6VZMPamw4EzSK2N3kNq75CW8iJuH8+1WuQDoDK
         0W6A==
X-Gm-Message-State: AOAM533ea+NHnz2GOJjojQoQbamZmoKEW6cFR1npDvZlPL077Od60su6
        6il+JQbSj8VDQzrTz/PDL62Rp/wYBS71W7FvS9MC6ueFuziORc3uYsHpfU/JGFljOSJIGJrrHA6
        aFWG5w6QRhPcNmrG+vcdEOo8H
X-Received: by 2002:a37:7a05:: with SMTP id v5mr6870608qkc.266.1619806019279;
        Fri, 30 Apr 2021 11:06:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAlxc1hPUTwEYH0l2ED+glJWfPMlmvkcqtM/2BRdmPojLgUYqc00LlHS8YezDjVVdYYegf3Q==
X-Received: by 2002:a37:7a05:: with SMTP id v5mr6870595qkc.266.1619806019138;
        Fri, 30 Apr 2021 11:06:59 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x19sm1965052qkx.107.2021.04.30.11.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 11:06:58 -0700 (PDT)
From:   trix@redhat.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs: initialize return variable
Date:   Fri, 30 Apr 2021 11:06:55 -0700
Message-Id: <20210430180655.3328899-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem
free-space-cache.c:3965:2: warning: Undefined or garbage value returned
  return ret;
  ^~~~~~~~~~

ret is set in the node handling loop.
Treat doing nothing as a success and initialize ret to 0.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/free-space-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index e54466fc101f..4806295116d8 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3949,7 +3949,7 @@ static int cleanup_free_space_cache_v1(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_block_group *block_group;
 	struct rb_node *node;
-	int ret;
+	int ret = 0;
 
 	btrfs_info(fs_info, "cleaning free space cache v1");
 
-- 
2.26.3

