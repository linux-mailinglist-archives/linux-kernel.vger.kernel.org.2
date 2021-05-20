Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043DF389AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhETBhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhETBhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:37:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE31FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:35:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x188so11172438pfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HdbC6Qq/yz7JB7oSzhlG/82Bio7SKh70aQI+8BeOHQ=;
        b=MNEfN88/RyB3mCU/7aCJ0Hw3bmPBydWEXWPEIKDFUCGCeeesdcPKbvobydNyBpKszQ
         pjxuf1+EDXNUoCIrGxMnXpCfNOU1oqw/zPBsQyslGsZnWqmFmyT2Sp+q9QxXREbmPA9b
         e1Rcwt3k7nDWGnk/drXvWqD3Wb2YHWdxOWnfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HdbC6Qq/yz7JB7oSzhlG/82Bio7SKh70aQI+8BeOHQ=;
        b=VbwPOTfhcpmqu7MqRLg9489/S5U1pP4kKvNBUIvbC34xJK0LPiuN3i+Ku5XqgR5Gh3
         o0VEOyeugFtaNKdDs3/bFXQuAX6pmrEBjo8njd6jJYz1vfoUSPTMiQ0dl7+1O9IbcfGN
         ivexTXQuZBODt7A01JBma1gPx7dDl7gDf/UIe0uzueZ6w7+9g50CzRGs18/kEHvMw8PR
         KWIoboLmZmRkuszrsv6sb2vJG7Aanamm3t9SroGXWf+qu0+qeCUsgxDS24ToxeLFPsn5
         HzF76GwafYFit4m8HsmIVEcS0p8HA8zSoIJ12bQSeXhWLFz7tycN1l6QR6XK4PuprcN3
         bI8g==
X-Gm-Message-State: AOAM533i6qpXRwhckuyXTuod44cnGmM9DD99HMl0hvZJGmNCggAYAh1f
        vAL2lTIkrGdh4jqmKUXcMf5Gfw==
X-Google-Smtp-Source: ABdhPJz2X8JYbDmKUNUk9qvyngr+KED+DcHFzaqYy8AzZ6VANQl9OtTY+LghGfAw2P0kXqdWDbnoag==
X-Received: by 2002:a63:585:: with SMTP id 127mr2033467pgf.322.1621474542276;
        Wed, 19 May 2021 18:35:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:200b:db75:4e6c:8b96])
        by smtp.gmail.com with ESMTPSA id m20sm5097368pjq.40.2021.05.19.18.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 18:35:41 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: [PATCH 1/3] lib/hexdump: Add a raw pointer printing format for slub debugging
Date:   Wed, 19 May 2021 18:35:37 -0700
Message-Id: <20210520013539.3733631-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210520013539.3733631-1-swboyd@chromium.org>
References: <20210520013539.3733631-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to get actual pointer addresses when we're looking at slub
debugging reports. Add another prefix format specifier that says we want
raw pointer addresses, i.e. %px, in the printk format.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/printk.h |  1 +
 lib/hexdump.c          | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index fe7eb2351610..a7b0b620982d 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -567,6 +567,7 @@ extern const struct file_operations kmsg_fops;
 enum {
 	DUMP_PREFIX_NONE,
 	DUMP_PREFIX_ADDRESS,
+	DUMP_PREFIX_RAW_ADDRESS,
 	DUMP_PREFIX_OFFSET
 };
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 9301578f98e8..87af5755563f 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -211,8 +211,12 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
  * @level: kernel log level (e.g. KERN_DEBUG)
  * @prefix_str: string to prefix each line with;
  *  caller supplies trailing spaces for alignment if desired
- * @prefix_type: controls whether prefix of an offset, address, or none
- *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
+ * @prefix_type: controls how prefix is printed
+ *   %DUMP_PREFIX_OFFSET - offset prefix
+ *   %DUMP_PREFIX_ADDRESS - hashed address prefix
+ *   %DUMP_PREFIX_RAW_ADDRESS - non-hashed address prefix
+ *   %DUMP_PREFIX_NONE - no prefix
+ *
  * @rowsize: number of bytes to print per line; must be 16 or 32
  * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
  * @buf: data blob to dump
@@ -260,6 +264,10 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 			printk("%s%s%p: %s\n",
 			       level, prefix_str, ptr + i, linebuf);
 			break;
+		case DUMP_PREFIX_RAW_ADDRESS:
+			printk("%s%s%px: %s\n",
+			       level, prefix_str, ptr + i, linebuf);
+			break;
 		case DUMP_PREFIX_OFFSET:
 			printk("%s%s%.8x: %s\n", level, prefix_str, i, linebuf);
 			break;
-- 
https://chromeos.dev

