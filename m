Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C760F35FD41
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhDNVYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhDNVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:24:48 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3A4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:24:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id j32so592037pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ngC+8CX71tyIhWsOpGPzwvs7zLSIxz8Pt7kSS42e2k=;
        b=J177beviUVuOGpGcCJ5ILLC8BAqSTgHSCi83UiYgqNvmhvvXq9Ll0CNa/4zxWdmccz
         62g9CYE9XGHeeRMKyepM3wZVh/bvOgkGLIH9TL2O/VMPQ4WOM4p036ijeZ8X3SlTyxrX
         dNCnXnmuFjgiXaaO353cmbhhE6fTGFIQbk1mEwwYWyRukzNBkRDwvngMEo85vYc7p4GN
         RHb9vxDY1SdBgnZ+MgO8fEZWDytSFmh4FHCCMP5N0ca0j6BSTQD/KbC5w3VYHUaa5fZm
         zsqMBBldmTt7393lYAerwlkuu5/ulbdoIcKHqaxIY61x/Ge6caHlg47Jz9FHplqfN1zw
         AVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ngC+8CX71tyIhWsOpGPzwvs7zLSIxz8Pt7kSS42e2k=;
        b=UYKIIbTKBfDrRwp3RvJ1KHnzp2JLKMSPUNuyweyEZQr5iQKYhUeZ/G1pikaqLEubLf
         l8BnZrHWAzk/EUGREKbFSL1ZDJ1dPX3IPG67Qb0jtz1CkAQlk1+4yycj7HUbebdRGzX5
         BJWxoM/stmr9FRRBDWmyLja7aIvwYDxCEeAOnjfFM4QafQgS6g+9IT/3nLmrRGbXOHgU
         gfqOIN9VTwhypHF2w9jWF6Fpff15JvdWEXN9zvX/L28SuvHeAMpwPZEnEdX2J6/oczty
         OxGiKfeh17YagyoJ3WJlyOW90f4fx9YEKXrRjKZSwuAb00AL7Qbh7wPfglUjB5vEaBt3
         65/Q==
X-Gm-Message-State: AOAM531N7CvmKqxhoO4sHd3DR9HuoiBq9tDIGlPPYyzuiMGN0ZhInEKS
        sQ7c1GKuPpBv2kcXxbMiyGY=
X-Google-Smtp-Source: ABdhPJxi6by0el4l564DA2JwqiWSA4DoXPlvXpIgPPgJDmPTjs4I1mwDP0lssiSpK9OuCDGHy5WORQ==
X-Received: by 2002:a63:360b:: with SMTP id d11mr275723pga.297.1618435465809;
        Wed, 14 Apr 2021 14:24:25 -0700 (PDT)
Received: from shuochen.svl.corp.google.com ([2620:15c:2c5:11:709c:3913:46a6:a31])
        by smtp.gmail.com with ESMTPSA id gd13sm260487pjb.56.2021.04.14.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 14:24:25 -0700 (PDT)
From:   Shuo Chen <giantchen@gmail.com>
To:     Jim Cromie <jim.cromie@gmail.com>, Jason Baron <jbaron@akamai.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Shuo Chen <shuochen@google.com>
Subject: [PATCH] dyndbg: fix parsing file query without a line-range suffix
Date:   Wed, 14 Apr 2021 14:24:00 -0700
Message-Id: <20210414212400.2927281-1-giantchen@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Chen <shuochen@google.com>

Query like 'file tcp_input.c line 1234 +p' was broken by
commit aaebe329bff0 ("dyndbg: accept 'file foo.c:func1' and 'file
foo.c:10-100'") because a file name without a ':' now makes the loop in
ddebug_parse_query() exits early before parsing the 'line 1234' part.
As a result, all pr_debug() in tcp_input.c will be enabled, instead of only
the one on line 1234.  Changing 'break' to 'continue' fixes this.

Fixes: aaebe329bff0 ("dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'")
Signed-off-by: Shuo Chen <shuochen@google.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c70d6347afa2..921d0a654243 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -396,7 +396,7 @@ static int ddebug_parse_query(char *words[], int nwords,
 			/* tail :$info is function or line-range */
 			fline = strchr(query->filename, ':');
 			if (!fline)
-				break;
+				continue;
 			*fline++ = '\0';
 			if (isalpha(*fline) || *fline == '*' || *fline == '?') {
 				/* take as function name */
-- 
2.31.1.295.g9ea45b61b8-goog

