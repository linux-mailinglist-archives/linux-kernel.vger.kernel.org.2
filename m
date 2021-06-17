Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE37E3ABE55
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 23:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhFQVqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 17:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231379AbhFQVqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623966236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4/8ZsrnV9kT518dUAoy2KJrq344KI7QjcpIIYk0eZg=;
        b=QmPH11wyidqMxdZSuSJbjZ//b9qDoRBkzKYPasUONtsIQqaSMgNXppK+wbutr3WtDiNADf
        QbS0Zs2+zgMUDqTXlPNYIHBd9ivgkoOTJe+webgeeaLv25jDHDwi90fLsr7G40fQovaFfl
        DB5xtUgltIFqrG9z9hHHrePfffLY6FQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-m9--2a2YOiaa7aAR2KqLIQ-1; Thu, 17 Jun 2021 17:43:55 -0400
X-MC-Unique: m9--2a2YOiaa7aAR2KqLIQ-1
Received: by mail-ot1-f71.google.com with SMTP id v9-20020a0568301bc9b02904494d2869f2so3811012ota.20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 14:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4/8ZsrnV9kT518dUAoy2KJrq344KI7QjcpIIYk0eZg=;
        b=K3UI+7k2p4tVxUI68/8P6+oq48NJ9C3ZwjQbp33F8Clu23b5y3ommwK7RKoKR6qWlo
         NgaYKzeIK0lZ07Kfq60djRvoZweVXv/UAplLm1yP8wwhvcKI68Fjpew8YKTwXtQm28SK
         1dxfrhuslzeSOP5Nq8UA2bh0Ns+l0vA+5Sk8QEITlu2OxSiRlNPVPBhOZHPJmVze1dDe
         Qqz7leTSm+nhOotcuBg4HJhuNKf7RryVL9PuwxXdrPXWvX0ZOyjYafOCp42MHeEsAK4J
         eBFMas/NxLx+Jue+83X65MYcR8DnBKQnZ9kIjx7DUzU5bV6PsudBX8k2f/SpCb2k43WR
         uVmw==
X-Gm-Message-State: AOAM532/PEEjS9VMmpVHM76Z740kr/JMmJXhGhvcaDp4wCKYdmtt5tGl
        Ee0iLdruL0y3i9Rg5y0NZtoHlZrjitInA6/dzxSC0VEoUVdX3V2HvaDNdpYq4dD5p3cv+656xGc
        BhsurUVte6BL8dp7lZNBCnETL
X-Received: by 2002:a9d:12a9:: with SMTP id g38mr6810619otg.114.1623966234748;
        Thu, 17 Jun 2021 14:43:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/MpfIdnRaMMuXLpXImcZSfOF2dMx/96uo+/FPPE6d05WXuSqepKcSIyq07IAiSgtXhdFX7Q==
X-Received: by 2002:a9d:12a9:: with SMTP id g38mr6810607otg.114.1623966234593;
        Thu, 17 Jun 2021 14:43:54 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm1366313oij.26.2021.06.17.14.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:43:54 -0700 (PDT)
From:   trix@redhat.com
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 1/1] bug: mark generic BUG() as unreachable
Date:   Thu, 17 Jun 2021 14:43:28 -0700
Message-Id: <20210617214328.3501174-3-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210617214328.3501174-1-trix@redhat.com>
References: <20210617214328.3501174-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This spurious error is reported for powerpc64, CONFIG_BUG=n

fs/afs/dir.c: In function 'afs_dir_set_page_dirty':
fs/afs/dir.c:51:1: error: no return statement in
  function returning non-void [-Werror=return-type]
   51 | }
      | ^

When CONFIG_BUG=y is BUG is expanded from
  #define BUG() do {
 	BUG_ENTRY("twi 31, 0, 0", 0);
 	unreachable();
   } while (0)

to

static int afs_dir_set_page_dirty(struct page *page)
{
 do { __asm__ __volatile__( "1:	" "twi 31, 0, 0"  ...
   do { ; asm volatile(""); __builtin_unreachable(); } while (0);
 } while (0);
}

When CONFIG_BUG=n, the generic BUG() is used which
expands out to

static int afs_dir_set_page_dirty(struct page *page)
{
 do {} while (1);
}

Without the __builtin_unreachable(), gcc reports the
warning

ref: gcc docs https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
" ... without the __builtin_unreachable, GCC issues a
  warning that control reaches the end of a non-void function."

So add an unreachable() to the generic BUG(), the resulting
expansiion will be

static int afs_dir_set_page_dirty(struct page *page)
{
 do {
   do {} while (1);
   do { ; asm volatile(""); __builtin_unreachable(); } while (0);
 } while (0);
}

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/asm-generic/bug.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index f152b9bb916fc..b250e06d7de26 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -177,7 +177,10 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while (1)
+#define BUG() do {						\
+		do {} while (1);				\
+		unreachable();					\
+	} while (0)
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-- 
2.26.3

