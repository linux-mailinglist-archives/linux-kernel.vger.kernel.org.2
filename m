Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC26330986
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhCHIk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhCHIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:40:24 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D9C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 00:40:23 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 15so4202077qvp.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 00:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=x5rG9aYCLmGpPdT1gIS00tPAzki6U9cSpND2lD2WOlM=;
        b=CkDWQlQ6GHdDraLv3anrBHYzX3l+GPCYPSV0Qw1GtEJd92CAiWb7nDCpLUsLX7yBn+
         3ZPSKvHK7mce8XC80tINfLyPho8B0q+gF3PlXhfl32nEO+43XejG1461q2RlK8DGjgCh
         bEfnfnIO9yKM3NxwUmYxxWXq+3d2c5LInbx+WVYu0VpYekAbspGB5lo3VpbZbIcjC6QD
         MCEXjG2G1Y59gb9Y1p+0ZF+5PT2qooat59zy0hkG2Bq2RX7QdwLslrMj3nmdQqCeAGBC
         ne8F4odG77YXjOcznaYmCiLUuW3oJK9cOJbpxbgbuMlO0NJ3JQIW/M3TqIOTjjAMQ/Rk
         4YAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=x5rG9aYCLmGpPdT1gIS00tPAzki6U9cSpND2lD2WOlM=;
        b=V87JtMRE0kA5L5ihLlxLedFKLSVo4TRSt+hRa8q2rPFbLwz6cBuG6BiVD3fLXMD/7C
         hzBiG978cN3eMrtY3IBPaxNgwn6bX1zBtte8LyrMSLxl6TLglr/NPKe2V66h+OzOjJvp
         Tc3GEHeQc+cjjW8GqCYRhlg6LstB0MYQoH4lQaAFbcMoZGNNwsutZgUmqtVDoKszICi7
         GcnyrMGvsBxkREM/E+xFAz+SqpKPpqTHYiSyKWv8TJjbRwNCRx4ky4hqA6b8TaNMVF3k
         YwiZFZ172/bsowt2/gcYsBSn2Teg1s8KL4XGagU31TjxADwhrv6/gl+LDJbjH9C/uEig
         5cig==
X-Gm-Message-State: AOAM532a41MxcbrW3JfhM7g0lANV11F+Vqz8ZKNYLQvA+DuJXdqEX3Zd
        axvL7YThrSLZ4OWV2FTYpSLAfQ==
X-Google-Smtp-Source: ABdhPJxBFmcaEKYvSHTfFwbk8pePy6cbeN3l05HQEeSn1CNXe4M5yc+dUSSvNLJCdcKaTMn8dkjmTw==
X-Received: by 2002:a05:6214:1c45:: with SMTP id if5mr20052355qvb.9.1615192823066;
        Mon, 08 Mar 2021 00:40:23 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id j15sm1104015qtr.34.2021.03.08.00.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 00:40:22 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on old gcc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Mon, 08 Mar 2021 03:40:21 -0500
Message-ID: <279558.1615192821@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that older gcc (4.9 and 5.4) have gnu++11 support, but
due to a gcc bug fixed in gcc6, throw errors during the build.
The relevant gcc bug is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959

Version the option based on what gcc we're using.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Fixes: 27c287b41659 ("gcc-plugins: fix gcc 11 indigestion with plugins...")
---
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index b5487cce69e8..cc779973724a 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -21,8 +21,11 @@ always-y += $(GCC_PLUGIN)
 
 GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
 
+# need gnu++11 for gcc 11, but 4.9 and 5.4 need gnu++98
+GCC_FLAVOR = $(call cc-ifversion, -ge, 1100, 11, 98)
+
 plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
-		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
+		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++$(GCC_FLAVOR) \
 		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
 		   -ggdb -Wno-narrowing -Wno-unused-variable \
 		   -Wno-format-diag


