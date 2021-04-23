Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585CB3695F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhDWPUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230470AbhDWPUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619191163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TaMjURk/uwKs3z6p90IdITDbLl5+F5GrY8JWDnXasqE=;
        b=aovWD9Wop84nxPw/KpHVjf0GDWZv0CImJLgDo9l4KrxJWQBFv8ZHxwgEMzC+bmviNnjrPa
        uLKTn32Ma3PajUdZJ3rQwS7Y/2IEQsO3bghmqb2DjVo4Vk2Cjf/BczSAIto8Xo/7YLn38k
        cMUIz6iB3rIJZwr2vtk8dk5wRm7V6HA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-Pr4W4pTqO-qZvcrdWvCQ8w-1; Fri, 23 Apr 2021 11:19:21 -0400
X-MC-Unique: Pr4W4pTqO-qZvcrdWvCQ8w-1
Received: by mail-oi1-f200.google.com with SMTP id h139-20020aca53910000b029018683516e74so8247184oib.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TaMjURk/uwKs3z6p90IdITDbLl5+F5GrY8JWDnXasqE=;
        b=LIoFpzwylXwu6TZN3siofDPff90zi8wh0V0Zz80t7QClAS23kw0+r23AhGlZDX1IY1
         k7C7dBLEZ61lp0OkkLvSJ8mlvuHm98l40vSfOZBP1ST4SYnffWu92vWZ68ZTzy5pZG/e
         0in0xZU1pB9Lq6aAtK8B5qflDMlMDun4zBGPojxaG356XDx+tNnK6JyMnjoIkz/bz1Hv
         Qo8GAsoxCCYfRlrsGe2zNPAzlc/0+DinGQ/ti8tu77g5yDFIdp77n8uTZztJJg4eEuOh
         uwaW6o1QIHm+lWPesa9AaqYE7rKrOqD/Q6TdIK/HB7PQTuLhfhP4w8LqorOWJwkop8Ed
         fn/g==
X-Gm-Message-State: AOAM532lFQ7QoKt5L9uuUGA6bZ8Eyb4qKZnYweOG0jRnDS9ZuQftvJp+
        Ux8GPqWRO90AB7FAH1Ijt/xjutPMiKIhQMm4SXsV4eHcGJOwFVU3JhsRqO8Ha8wyttrZCfYQYvH
        WkvrlaAHN6+BSo1YZKbl0oSLv
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr3845066otp.209.1619191161269;
        Fri, 23 Apr 2021 08:19:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzurjzgiMl3cxgk/fC4pQBmh5uOr3MKrNK0XYkFBb7x8BJXo1a36i2WiGtf+HYNmB9ou5o41w==
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr3845059otp.209.1619191161133;
        Fri, 23 Apr 2021 08:19:21 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id b12sm1468927oti.17.2021.04.23.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:19:20 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: Send FUSE_WRITE_KILL_SUIDGID for killpriv v1
Date:   Fri, 23 Apr 2021 10:19:19 -0500
Message-Id: <20210423151919.195033-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FUSE doesn't seem to be adding the FUSE_WRITE_KILL_SUIDGID flag on write
requests for FUSE connections that support FUSE_HANDLE_KILLPRIV but not
FUSE_HANDLE_KILLPRIV_V2.

However, the FUSE userspace header states:

	FUSE_HANDLE_KILLPRIV: fs handles killing suid/sgid/cap on
	write/chown/trunc
	^^^^^

To improve backwards compatibility with file servers that don't support
FUSE_HANDLE_KILLPRIV_V2, add the FUSE_WRITE_KILL_SUIDGID flag to write
requests if FUSE_HANDLE_KILLPRIV has been negotiated -OR- if the
conditions for FUSE_HANDLE_KILLPRIV_V2 support are met.

Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cccecb55fb8..7dc9182d1ece 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1106,7 +1106,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 
 	fuse_write_args_fill(ia, ff, pos, count);
 	ia->write.in.flags = fuse_write_flags(iocb);
-	if (fm->fc->handle_killpriv_v2 && !capable(CAP_FSETID))
+	if (fm->fc->handle_killpriv || (fm->fc->handle_killpriv_v2 && !capable(CAP_FSETID)))
 		ia->write.in.write_flags |= FUSE_WRITE_KILL_SUIDGID;
 
 	err = fuse_simple_request(fm, &ap->args);
-- 
2.30.2

