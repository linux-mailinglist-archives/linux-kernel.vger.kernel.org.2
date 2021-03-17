Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C43C33EF05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhCQLBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhCQLAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:00:39 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC79AC06174A;
        Wed, 17 Mar 2021 04:00:38 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id n24so8197465qkh.9;
        Wed, 17 Mar 2021 04:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CL8LK+9sf9UcMIdrX481SKnFK4jHWm4XPPjXsThij54=;
        b=DS9KB43EiCaeiWvuDu1EZX4QGVDY5X+Ep4KERxt1F8SfmimaeNnUt450NK7hCMr4pr
         Df1MT4gTor4/thwY0LlZahg4G2HDVgSYhXHNdEf6DUN1+x7AQ7WanEJRylaTps7fnxGc
         UiWjIdzbktMaV28JlC9u4/0oNZ0pZCBNv3FBLlUIO+g5FamXuaf3gw3kxBMjN1btvXm5
         +yTul9naPY9J9gWyP//vuI9HA/Qp22ng6JmkZFwpEb1PPgW9iCzTSabgX1tfYt2pVxRP
         xyAxbl+2PGLgfVa1GxY2G0nHx8Izf7cBUW3adcBctOjvHUaeaH6ukveWRHIgLnKmVc7v
         pFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CL8LK+9sf9UcMIdrX481SKnFK4jHWm4XPPjXsThij54=;
        b=URNTYuNGnBtNlhwg8r2MtHsz0gUtjeyJuQfoJOkm5vDhSJW3z5gd+1NzroijNELnaL
         HuQx693P5UleiJDokqx8Vq6wOCCU+YaJ7pRO6QuDOzCfHNZlZ7d9I43nwRe+4jxNVY/m
         vp7qVZunCCS3XzzUjwxlXcmQaxyrc431SDG4tXPpzgSl0sUBM/irlIk4vtdaI2vQE7Di
         P7fnKsIrV8w3dcaP+4Vn3ELo42O8G6a0qYfVYVqIyht/A7oBklTto34VnPVmYzi+8XuK
         5BVVLfiXHovdRH3pBXaQtzd3npMFJ5fWnSjtwhtZi1gglOUvLexTMVxImRd5Rl5xH/hC
         VHIw==
X-Gm-Message-State: AOAM533NKtMzpQNNA9Az+ocApoi34WD7+bYLf5j3e8uZCoJtCVRMrpZK
        0SgyuCS47ZjwCpRvPBK0PuU=
X-Google-Smtp-Source: ABdhPJzC1Xy0icDNRzssN2SsoCMW6zhwYTmXoZUJk1ZZTYCuLGnMzV3HTKK4WKdKO9IXzWBmkET5YQ==
X-Received: by 2002:a37:9c13:: with SMTP id f19mr4134282qke.31.1615978838126;
        Wed, 17 Mar 2021 04:00:38 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id j2sm16512891qkk.96.2021.03.17.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 04:00:37 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de,
        unixbhaskar@gmail.com, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V2] parisc: math-emu: Few spelling fixes in the file fpu.h
Date:   Wed, 17 Mar 2021 16:30:14 +0530
Message-Id: <20210317110014.387321-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/synopis/synopsis/
s/differeniate/differentiate/
s/differeniation/differentiation/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  Changes from V1:
  As pointed out by jer, the sentence construction change inducted.

 arch/parisc/math-emu/fpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/math-emu/fpu.h b/arch/parisc/math-emu/fpu.h
index 853c19c03828..b83da3d5b6d5 100644
--- a/arch/parisc/math-emu/fpu.h
+++ b/arch/parisc/math-emu/fpu.h
@@ -12,7 +12,7 @@
  *      @(#)	pa/fp/fpu.h		$Revision: 1.1 $
  *
  *  Purpose:
- *      <<please update with a synopis of the functionality provided by this file>>
+ *      <<please update with a synopsis of the functionality provided by this file>>
  *
  *
  * END_DESC
@@ -50,9 +50,9 @@
 #define EMULATION_VERSION 4

 /*
- * The only was to differeniate between TIMEX and ROLEX (or PCX-S and PCX-T)
+ * The only change was to differentiate between TIMEX and ROLEX (or PCX-S and PCX-T)
  * is thorough the potential type field from the PDC_MODEL call.  The
- * following flags are used at assist this differeniation.
+ * following flags are used at assist this differentiation.
  */

 #define ROLEX_POTENTIAL_KEY_FLAGS	PDC_MODEL_CPU_KEY_WORD_TO_IO
--
2.30.2

