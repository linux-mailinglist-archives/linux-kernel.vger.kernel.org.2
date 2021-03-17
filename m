Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2713C33F91A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhCQTZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhCQTYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:24:49 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549D9C06174A;
        Wed, 17 Mar 2021 12:24:49 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c6so2315222qtc.1;
        Wed, 17 Mar 2021 12:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHf4Zd/xk2APnMJaB2+YTf5Gt9D99Q0t4UzNTB9Qzgg=;
        b=CS+faDzMcyiCI2IAOgVXYPQGtzZKWWlgL56sAcG0zXcn/HxxK04+DGLfZ9uNmbnWmV
         u80EiiZBbrJfnSQNIkwEMaCEQOZvSBdHVBat7x/xLLDe7DSkQS2mA/6uQF00KeijhceP
         e+mtYbt2J/pVskLTRYh0GbxYhPT1N77afYdNl6CesxJuuwqheiitBtXUMtVZfqe4BjK8
         UZOSUdTrRx13Zifz9WabZL9A5s40FK/AjaPVCKksvj06sE2CjOWpKvEqhx4Xj3Xdqi3R
         DbkSXipEI968z4j/plSgfhSHlUclntPhVM/9AaHlEwoVs1kMAwXPzuUXC3TcHkEKPT4k
         AY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHf4Zd/xk2APnMJaB2+YTf5Gt9D99Q0t4UzNTB9Qzgg=;
        b=Trp0mYYTasttjwOrrlfG1DmeWwoQFVZAunFvqSgni1IK7zH3jot3q7BhJ44dWGvXH9
         VvISrmmMwoSPHQ0039OJ4tNgKU9yPAHjuCj52OosCEbRtJGnBSqY0TWfDJZqlXeUSZ4a
         HWlIU1qeSQ1gJ+7CSuBaXfllotH3ld4xCgzDzUwojcU/x1v6WMAn8zyZvmDwFhcQUppE
         EQ2K9I7drP14b79cKpkn/OPuq6LLH8hCuuDFSan0lTpYbFYO75Mf0PsaU5vX436LR3g2
         Fd2FPjj9Y9ajXe2bbmfgSdq3eh/MTcU8CaHjtJiXchSVPmxYhgdZSUL4dHhkd9dE/zB1
         JA3Q==
X-Gm-Message-State: AOAM5316YFENCggkxF6o5y9rEaOspA86ph1MyGL+uc7FX/k5CoVt+HCS
        r90Z5PtiT0MBkxHMkY2dhXk=
X-Google-Smtp-Source: ABdhPJwzpnjH23bUO1tK9vc30IEH4UvwAUzDTH/JgEwfEkxceYTyTnptwD9OIbetmqD3tYXcKjT+kg==
X-Received: by 2002:ac8:4a91:: with SMTP id l17mr609295qtq.174.1616009088615;
        Wed, 17 Mar 2021 12:24:48 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.138])
        by smtp.gmail.com with ESMTPSA id a20sm18376710qkg.61.2021.03.17.12.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:24:48 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de,
        unixbhaskar@gmail.com, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V3] parisc: math-emu:  Few spelling fixes in the file fpu.h
Date:   Thu, 18 Mar 2021 00:54:27 +0530
Message-Id: <20210317192427.2050913-1-unixbhaskar@gmail.com>
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
  Changes from V2:
  Incorporated the changes suggested by Randy

 arch/parisc/math-emu/fpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/math-emu/fpu.h b/arch/parisc/math-emu/fpu.h
index 853c19c03828..ea1c8c3539c6 100644
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
- * is thorough the potential type field from the PDC_MODEL call.  The
- * following flags are used at assist this differeniation.
+ * The only way to differentiate between TIMEX and ROLEX (or PCX-S and PCX-T)
+ * is through the potential type field from the PDC_MODEL call.  The
+ * following flags are used to assist this differentiation.
  */

 #define ROLEX_POTENTIAL_KEY_FLAGS	PDC_MODEL_CPU_KEY_WORD_TO_IO
--
2.30.2

