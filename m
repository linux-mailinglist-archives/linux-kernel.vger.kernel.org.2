Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E06368FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbhDWJqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbhDWJqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:46:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F9C061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:45:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id v6so71672513ejo.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9xL3vV7hsHxa0jz4RAzpmBQrBoUSRd61yPE89/kLfI=;
        b=hQmx2UwtN5nzyHTpzZR4WpzFjbFvhVjOWaMjU/09mS2hGvKIyJQSPZvtIFjj2jus7y
         n7Jzt6/7gKZ/yeRnqaH9KEPkj/xPDja2HF+TGTfF/Xm8DdeP/KyGBBeU0s2RwBSV8A3a
         2dLYjPBng0pgYA+hgUXfnI7JtFEX1AARjG6WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9xL3vV7hsHxa0jz4RAzpmBQrBoUSRd61yPE89/kLfI=;
        b=Y5qegTIdoH/LbzHOIQhR3mZTdBI7snU9kZMh9/DrQmxZoNG4oi1KutbBMtIJ0FSYug
         3b0gQ5w3C5bCnG2KgAaoJCCEjV7W0LFo/E3OiNqI66krm+5E3w2/5GdlxCNt0m9u7dsU
         O0d8LtmK2cJytRLJOgDbOTutKZTAcegObmrV+MIGS2VMf7Y/Zhd3ZBA934N7fGkrVu5j
         Leoa7igSSrvSVxjsvy/7pUePK9J1ja93Qd9vaYCpGsIPX7Jkv3YzQPwrLD59PFAOci4c
         GQSlTjUTdYgoz/ryr+eUPwkr3Ynqe9KNx/h47VkBsaNl0SkwExhL55x7FLc/YXlKfUM/
         apZQ==
X-Gm-Message-State: AOAM532uHdgVUKBu+87E1tWoiCimLbGAXrKL55rZtBBpB3T/PCvj2H1L
        96wQ9vzAbWFgxoawhGhep86udA==
X-Google-Smtp-Source: ABdhPJwjXM4/+wZkHXmMrc0PoCbkvgYC2b6wK1ZAtFFY4bRBv0AVtL0Y3jrCK9hLI9H2amJEAtFCaA==
X-Received: by 2002:a17:907:76ae:: with SMTP id jw14mr3366109ejc.60.1619171133192;
        Fri, 23 Apr 2021 02:45:33 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id s13sm3574225ejz.110.2021.04.23.02.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 02:45:32 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/vsprintf.c: remove leftover 'f' and 'F' cases from bstr_printf()
Date:   Fri, 23 Apr 2021 11:45:29 +0200
Message-Id: <20210423094529.1862521-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9af7706492f9 ("lib/vsprintf: Remove support for %pF and %pf in
favour of %pS and %ps") removed support for %pF and %pf, and correctly
removed the handling of those cases in vbin_printf(). However, the
corresponding cases in bstr_printf() were left behind.

In the same series, %pf was re-purposed for dealing with
fwnodes (3bd32d6a2ee6, "lib/vsprintf: Add %pfw conversion specifier
for printing fwnode names").

So should anyone use %pf with the binary printf routines,
vbin_printf() would (correctly, as it involves dereferencing the
pointer) do the string formatting to the u32 array, but bstr_printf()
would not copy the string from the u32 array, but instead interpret
the first sizeof(void*) bytes of the formatted string as a pointer -
which generally won't end well (also, all subsequent get_args would be
out of sync).

Fixes: 9af7706492f9 ("lib/vsprintf: Remove support for %pF and %pf in favour of %pS and %ps")
Cc: stable@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 41ddc353ebb8..39ef2e314da5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3135,8 +3135,6 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 			switch (*fmt) {
 			case 'S':
 			case 's':
-			case 'F':
-			case 'f':
 			case 'x':
 			case 'K':
 			case 'e':
-- 
2.29.2

