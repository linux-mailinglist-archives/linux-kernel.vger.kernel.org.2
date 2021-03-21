Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7150B343597
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 00:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhCUW7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 18:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCUW7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 18:59:23 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B68C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 15:59:22 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y5so7287820qkl.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 15:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S8WSTHlsD8p4klro0pqgy1PAO3q46+flzVq6y026y48=;
        b=F5w2/qZJLvluiLTE9SnTX2r3h8ADO8T2qrX5n5/LePVXy/OFb9fIz2IFlvHXEKHOrr
         uRSSZz9vBwMfa0JE+0O45pXHA6T/HLrwL51lt7Vb8gpXa79utYi83cMv1J0RkJuMiA5Q
         YOxcSK7s/+hW/QMzLl6vQcdylDd0Ea1NAbUQeK6JeeqFrLzHnTQZsoxyJz6IGK5fujCT
         DzE/7uNWhTKsJs82yqbrMuw4ch+7y1gHi1S87YZUfBYsqtv94xAlsqWAVOLbdhh86HMH
         u8bMvYXOIQ/m90Bx0I4xqekFUqHY4k41sCBkf/GQ5ND9M4+JNp5XnAaXGcvqulS7yuYN
         YgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S8WSTHlsD8p4klro0pqgy1PAO3q46+flzVq6y026y48=;
        b=R+XtM0shT9F3/cnr45lZ0lMvrpt3CQxVaahRmLV5PmTKJeirsb45709VW2B5oAOIo0
         5/ege2jDdEl8tMnDRb13Ww0WSDV4Vwt9EUpZjAt5K5JJpaNH5PTBjCFIxhbdCt8HbcLt
         ZCrXGdIoP4yvX78E+R3nURNJwYjl4widN7YSP/2u3537GgZXVXW6IbZ5yKaG2CnO3rKe
         iO5zQYnlL+hQmHEYr1NO5omSFacceck8QoSmBvu8FIaEqRKujCpUs/WeE7Zx91qqZapd
         qAztmNBwsiwNGcH265k+AT8WgG3VkYdf8Ggd6PnCYPYQIdYD103hCI+5HqtVYoKm6VG0
         uqgA==
X-Gm-Message-State: AOAM533uk4NUaiQBssO/LibPQQgC3xAH5m1DIT7FPvEICR0CcpjNsBW8
        RgGvRp0kQms2dF2exNCjkv8=
X-Google-Smtp-Source: ABdhPJzIc9IP66lTE0IQT4XvLXnhT4TOmm4eR9gytcaFdagBUiBoCb2M4KUyrWIW3Z8qC6vSCavrbg==
X-Received: by 2002:ae9:e40b:: with SMTP id q11mr8554407qkc.318.1616367561643;
        Sun, 21 Mar 2021 15:59:21 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.54])
        by smtp.gmail.com with ESMTPSA id g18sm7858095qtp.43.2021.03.21.15.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 15:59:21 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] x86/entry: Fix a typo
Date:   Mon, 22 Mar 2021 04:29:03 +0530
Message-Id: <20210321225903.2807032-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/swiches/switches/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  Changes from V1:
  As Randy pointed out, corrected the word.

 arch/x86/entry/entry_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index df8c017e6161..6dc36790f1e1 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1107,7 +1107,7 @@ SYM_FUNC_END(entry_INT80_32)
  * Switch back for ESPFIX stack to the normal zerobased stack
  *
  * We can't call C functions using the ESPFIX stack. This code reads
- * the high word of the segment base from the GDT and swiches to the
+ * the high word of the segment base from the GDT and switches to the
  * normal stack and adjusts ESP with the matching offset.
  *
  * We might be on user CR3 here, so percpu data is not mapped and we can't
--
2.31.0

