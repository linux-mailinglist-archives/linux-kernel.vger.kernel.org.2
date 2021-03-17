Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB533EE75
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCQKkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhCQKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:39:44 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8D9C06174A;
        Wed, 17 Mar 2021 03:39:37 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id t5so1113046qvs.5;
        Wed, 17 Mar 2021 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbr728L3UVVod70isECM7otuPY2J5V9A5LN2QDpnXyg=;
        b=QTwLRmNOcDdaK6G+/t8KDhrvH0q8oaLjVv/SCvSZ7vt16XtjAXliPAK/Jba4wSaQBC
         0TZCjsHx2Q5pwZZHwLpvgNdC+/RTKIEp39TEyCHrt+8a7hK612kZR+VrtOmDDO93edBT
         sf+FBjd56THRqL7D+vyXZsBDiNAgzVabuPmRrK8uS/DUPSUk9hPDWHfumtEKOBQHuMLm
         vCH9Q8RCiKt8OGHTkahhg7CYb6PUt7k7jGn9wAGUdLIRyB4Bgm7/E/swm+0lKGcyi6Hd
         7KK5MZGJn4Rm6pzysNk4oMiX03A4y7tYjcGDE2HV5LjSAbBj6yZ8Rm+zs91tZ+ZxK2uq
         mmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbr728L3UVVod70isECM7otuPY2J5V9A5LN2QDpnXyg=;
        b=mjp8Nn+cwXJSnASmu05AIbJl9N313UXwvHP9ct89w98sjBVZr3qxdjsFD2yQdZ9m1f
         4SZFW4rbDCwQHEsAjrndx+mNbZNyspYtihbRE5Ym3PCLbHqwbHDzeTS9G51CyC0eg2Si
         eFZDdYeUAJlBynEENE0Yhuod6Uj7I5oU2PnwydCwzIemqEOygmNZhOJuc2H3yaGxGZi2
         o542DLlOiXvVhP+SWEAHYV2UGPgFDX1JNH/09OgCfyDpGqOoEsZOqwjQsPlOcxJqiueR
         yRSfFPu/a1rsDZywyfgHsw6+RjoagDFRI/NufCOViHS5lUr0IyLMOQPbXvp/QwTxrBkj
         Q9Fg==
X-Gm-Message-State: AOAM533d9MGwDZA0XfY24KYGUCdafohW8Ue/j3zUwAhetg/UOZVo5jlz
        FHNky9KVRjimbLpGQCPAZc0=
X-Google-Smtp-Source: ABdhPJxXPoMcOlm/JYlvLB3kFtqrR9m1baplchfpKpV3XGj3CXQP42SxuqQTSiKqh+3Uvnc0Cl0V4w==
X-Received: by 2002:a0c:9a04:: with SMTP id p4mr4702308qvd.38.1615977576425;
        Wed, 17 Mar 2021 03:39:36 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id i6sm16877988qkk.31.2021.03.17.03.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:39:35 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de,
        unixbhaskar@gmail.com, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] parisc: math-emu: Fix a typo in the file float.h
Date:   Wed, 17 Mar 2021 16:09:17 +0530
Message-Id: <20210317103917.3869933-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/synopis/synopsis/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/parisc/math-emu/float.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/math-emu/float.h b/arch/parisc/math-emu/float.h
index 531bbda5e31f..77b1b5bf1a65 100644
--- a/arch/parisc/math-emu/float.h
+++ b/arch/parisc/math-emu/float.h
@@ -12,7 +12,7 @@
  *      @(#)	pa/spmath/float.h		$Revision: 1.1 $
  *
  *  Purpose:
- *      <<please update with a synopis of the functionality provided by this file>>
+ *      <<please update with a synopsis of the functionality provided by this file>>
  *
  *  BE header:  no
  *
--
2.30.2

