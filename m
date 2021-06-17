Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9973ABE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 23:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhFQVwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 17:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhFQVwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623966640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yF7z1ZXkbARn9qymGKtrrZ4b8LWDAO30V08q/gw5sdg=;
        b=UOFCTrNXSoeogA47GlmFpHwl6b6Sx13P6Qv7P3pUFEzgMCr7PHRoy28D+CcoakBz3k+wj+
        9KDOr6mHLZqD0z79dqZ29LWmF2RlrPHPpDUXddPWRuyPvHoHu08FNc6BvwGTfv3ZM4TAIV
        /CwgSFoEjYG5ccldYAqQTRFOmqojbQ0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-mvcSokO8OJGIrRtrBJrdcQ-1; Thu, 17 Jun 2021 17:50:38 -0400
X-MC-Unique: mvcSokO8OJGIrRtrBJrdcQ-1
Received: by mail-ot1-f70.google.com with SMTP id 88-20020a9d06e10000b029030513a66c79so4710308otx.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 14:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yF7z1ZXkbARn9qymGKtrrZ4b8LWDAO30V08q/gw5sdg=;
        b=W4g6UzjaiWUbfdN6XSjwq1+zwgCU8GkuGGUK0dzOJrpTY3EkeFkbrSWtotLYFHi9cz
         4m95CVEyhmPFLATspTOhuXNs1VQU1kzRxyjjcWNC5CP7ZFN4quPky4odk8thdwKtOE9P
         G1xMKpNOh+pQOJdEnoHZAGsXh9r5A2+jrFccUXfHK663Xs1qgxQwVmm2m+v2SQLF8dYz
         a9IkbnOS+MoylMGwWBkF8ZckGBFE16MS2oJgiVrNfEsv2H+2Fje7ZP+K5u6xk+4K5ro5
         YdIYLHcWtzoLqQIRwkNJXDUKLNRdy7QZ7hzl05L8Zg7IZfebjQb2qA8dQTl+ojPF6aWe
         ydGg==
X-Gm-Message-State: AOAM531671zyQpBBCjrgE4XT4MMIzcFTSs8CMw0a2C6VrZk/0wYWqbnr
        WOhWf6hUazx8IRsV9ziab40G20C/4phzaHrlQOkb4e4ahF4NU7wr99UAB3ex9QffvthrJjtLsFS
        r8U3dETpAQ8NmpDF5f8Maoank
X-Received: by 2002:aca:d0d:: with SMTP id 13mr1332444oin.25.1623966638100;
        Thu, 17 Jun 2021 14:50:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAPSYZqrAeOBi2iQV/XrNzGumvqJ3SGCAytVjqAecnSf7E2bcYXFHe42NZzNsRtRr+7QSciw==
X-Received: by 2002:aca:d0d:: with SMTP id 13mr1332438oin.25.1623966637968;
        Thu, 17 Jun 2021 14:50:37 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a7sm1456247ooo.9.2021.06.17.14.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:50:37 -0700 (PDT)
From:   trix@redhat.com
To:     ysato@users.sourceforge.jp
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] h8300: bug: remove foreward decl of die()
Date:   Thu, 17 Jun 2021 14:50:27 -0700
Message-Id: <20210617215027.3501613-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

die() is defined arch/h8300/kernel/traps.c
and is used in arch/h8300/mm/fault.c

fault.c has a local forward decl of die()
So remove the decl in bug.h

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/h8300/include/asm/bug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/h8300/include/asm/bug.h b/arch/h8300/include/asm/bug.h
index 00fe5e966bb5b..99e7be5dc6564 100644
--- a/arch/h8300/include/asm/bug.h
+++ b/arch/h8300/include/asm/bug.h
@@ -7,7 +7,4 @@
 
 #include <asm-generic/bug.h>
 
-struct pt_regs;
-extern void die(const char *str, struct pt_regs *fp, unsigned long err);
-
 #endif
-- 
2.26.3

