Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC5B42CD53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhJMWKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhJMWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:09:53 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA69C061769
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:07:45 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r134so1427390iod.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJf7UOH/EFdpIroNWXJapHbcL/ElBCAxgV8NvOwUt9A=;
        b=Cw7y/bTOL4pbyIVrB/YkcYOEsgtbThZeazfaY04GcnRBSVV0MkFXHR+43sri5/vK6H
         3TEeTGlMhfB9W7US3RPhhEIpYT2S4Ce8uUbr5vFTUjQ+KXYkIm77g1Ky9qM40YCNNCCS
         QPMIb2jvsJRpc88rK32rDuTjQ3RfvmBtOCqhDhCzKk/6eVtPIE9luVDn+/ppda1CiO3X
         Juq9j83ZIEBl1g3SiewJFVGahZNLbvOEY737iKw/nR09fEF8xZBzAb7+eFtvHiuE/V6N
         OuM40N0KH6cbRD3gcDSURRg8r7S6JuBRXvCNOltuh9MOnbGioPrQwqkMX98BVv6CMz3I
         N3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJf7UOH/EFdpIroNWXJapHbcL/ElBCAxgV8NvOwUt9A=;
        b=uwgciuAGTWsBDCd1PZXBHYOQ055k3okmILeQKyQRLe3x7jvPN/XlkbUseTrD1k9D8R
         I3+sFRqs7P4g/zJDQR9BFzJjRHYSWIY+dXcD59TCXmR3MT9ghE2OBE1XKImTdNGL/5AW
         ++cKsCRadq3X+CTyagmXWkIIqkqRZHuR9oonUwv1ZPcTDqX77EDffywbo1BQ7hKOF+Xv
         3If2oD3XxIEtm3ZVX+YG+TrRTyLU16DnUcbUHqpMjyBOAHZBiTQhebIze/ILcTiymsEY
         /daYGyW++PSEOj4dvaV0GC3ejth2p/wnVbOgaYX7w5+TWIZMgrjrZUzDmflOzLShtFE4
         fIbA==
X-Gm-Message-State: AOAM531D6GhVFxRELYQ5UIEyEtjpVGGpVJVcK49JnydvsZOiMuEgdGIc
        A0SpFlYSq8W2XJ+pZFvg/uk=
X-Google-Smtp-Source: ABdhPJy+lVntQlRN0jjPhdsFDIA2ZcHijoyCEfEyVZkIgm8G4tRVDpPr2EuFREI/1PygjtlGAzxndw==
X-Received: by 2002:a6b:f816:: with SMTP id o22mr1536241ioh.106.1634162858111;
        Wed, 13 Oct 2021 15:07:38 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id i15sm324633ilb.30.2021.10.13.15.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:07:37 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 3/3] dyndbg: no vpr-info on empty queries
Date:   Wed, 13 Oct 2021 16:07:26 -0600
Message-Id: <20211013220726.1280565-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013220726.1280565-1-jim.cromie@gmail.com>
References: <20211013220726.1280565-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when `echo $cmd > control` contains multiple queries, extra query
separators (;\n) can parse as empty statements.  This is normal, and a
vpr-info on an empty command is just noise.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index bc1ac55ac328..7744c787e256 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -540,8 +540,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		}
 		i++;
 	}
-	vpr_info("processed %d queries, with %d matches, %d errs\n",
-		 i, nfound, errs);
+
+	if (i)
+		vpr_info("processed %d queries, with %d matches, %d errs\n",
+			 i, nfound, errs);
 
 	if (exitcode)
 		return exitcode;
-- 
2.31.1

