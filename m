Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11853397DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFBBEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhFBBEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:04:47 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35411C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 18:03:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w15so368017ljo.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 18:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4lnPBDBr7sIl/dpoQJKyl1JI78Mt5N3SQMNWpb+V64=;
        b=I5CZp/C/myLXZRjn10WMf/FKlSMSO2DqGpyT8WA2USAYqJM0O5TGrd+eqtsXlebG7f
         y4N6I9SaVuh1Fc7lSg1yJu7bGxetfmE62pjGsbIa+ywZmdOcJrJQjQJs0EBDbEA8ueSA
         dRs3OSL3RtrV3cFXrOzGgsNOkzkF/VW6hoMeZK/n7+qQRfXb5lJPOIDsUkNEluQe9HH9
         k4FLs3uR4TDWoROBT2ZI9fvaNIJ4J4EtF0IDsiomrNOwdTE6ZcrtPByf24XVYFJhBKob
         WTGMbF66o9tpkBawTsotfjjZT1ivz0xqW209AJvPnenSvq20LBXPWfGVqIowImvEhw7A
         vyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4lnPBDBr7sIl/dpoQJKyl1JI78Mt5N3SQMNWpb+V64=;
        b=eE3v6LoDBMessIiFHAcUZ0llhYF5y82TDc35WTNU7IMEiL9TEWciTB+9peQDTlccKu
         dMqko/LIr8O7YwjWO5o31l3xQSljtm2vx8Q9khSuMtGAdMCuqB6DtmDMI9OXfIGS94oW
         JxabCOtONAN3VfnygXpXrkmpsK3YymI4WmUiRXG2zz9E6x4jXzHjhhJ+x3R9NGenCG4E
         Xgz04sHojzZJDG2UaWG4R/0SfQvTVchAzdNDRApFw5FaLh9yv40bYJt9Tc6Hm5XZwRtM
         OkIwmeVloRZvbALeNEK8c8+WJozDTIwfj0yYI2yga4Tk8xNCl/Rsqi6dF7w0DMNcUUD4
         GvEg==
X-Gm-Message-State: AOAM531iR9K6/3ec2YPsKVbXsLBAaO5E93KYfrnq1Dy/5dOMWHuE7eZH
        /N83a0ONyZaBiIkb+XY9TOs=
X-Google-Smtp-Source: ABdhPJyjQ3KqH0ifIrwpwDFTAZYK6NAhdN02kRpm5LfaTmqCHc9rBtNKCdHe/Ga5sXXQKww79s0/Lg==
X-Received: by 2002:a05:651c:1251:: with SMTP id h17mr23984138ljh.215.1622595782635;
        Tue, 01 Jun 2021 18:03:02 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yb9bh06yk5jm2qt-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:3d09:bda0:2327:559b])
        by smtp.gmail.com with ESMTPSA id d7sm1825403lfg.253.2021.06.01.18.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 18:03:02 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, morbo@google.com
Subject: [PATCH 1/1] pgo: Fix allocate_node() handling of non-vmlinux nodes.
Date:   Wed,  2 Jun 2021 03:57:04 +0300
Message-Id: <20210602005702.9650-2-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602005702.9650-1-jarmo.tiitto@gmail.com>
References: <20210602005702.9650-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently allocate_node() will reserve nodes even if *p
doesn't point into __llvm_prf_data_start - __llvm_prf_data_end
range.

Fix it by checking if p points into vmlinux range
and otherwise return NULL.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
 kernel/pgo/instrument.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
index 0e07ee1b17d9..9bca535dfa91 100644
--- a/kernel/pgo/instrument.c
+++ b/kernel/pgo/instrument.c
@@ -55,6 +55,10 @@ void prf_unlock(unsigned long flags)
 static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
 						 u32 index, u64 value)
 {
+	/* check if p points into vmlinux. If not, don't allocate. */
+	if (p < __llvm_prf_data_start || p >= __llvm_prf_data_end)
+		return NULL;
+
 	if (&__llvm_prf_vnds_start[current_node + 1] >= __llvm_prf_vnds_end)
 		return NULL; /* Out of nodes */
 
-- 
2.31.1

