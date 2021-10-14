Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330D942D411
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhJNHxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhJNHxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:53:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E24C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:51:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y26so23148296lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxL/1OygMqpG/Y7z2e565fj04wVwNqD56UmPqoPdvYc=;
        b=hgZvTc8HUb0gSrahoG2w8tewW9pN0zSL//XJQbnqu41qMO5hMDbop90sk+hgqskB5W
         dTqmys/scuT2Xh9QyyICM7853G//uKhlxWPr/OWDmxyjgYnEa89NntlqBluZ3GqtBqvz
         kf4QdTFfjtL8trcs04L8KD+ifCS6Dr696tDToXHaGeu4scoVJBAoP5if5LjWP4a482Ck
         umowCMYfx5vqymKDBwtwD22/dzYK7WmCnePHWE7oM5Eb+Op7Co7cA9IymgwbJVImbWPX
         MPeB3BivhkzaZll9wltzx27j0uZ9DBNwnl63MxpIv9Y4+uHSmz1LyMiQ7sXUMDyr3g0J
         4CdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxL/1OygMqpG/Y7z2e565fj04wVwNqD56UmPqoPdvYc=;
        b=hLQB1u6IrH3vZg9m32r7NeDGVRzKeXjikVbtLU7xKmiF9X0NprzA8GXbVUICX8KkOz
         MaRpKjokoLu5Hh2fhPyW6NKPm77GbE5XMGXXg8fe4ebOVEWzvRloUMwVXWPVAIQRA6ou
         EcqCUAJpTUTIdGGVvsrkzMOFOGuwQ1A/O9rpAivBryg0rtThfmOR3r62LQpg4uHC7Rj1
         Rapp9DH++KLF5dFA/w/MHR/KqCV9aVFd5K5hwN1+9PE/6vQyDYbzXj4s2opdm1HzOKLy
         zc5BaZdC8SHIoixq+NwZolBIGYzB2gxr1ixRn0lmjFALnUMMbkTiSlXKuxJQzkZ2WrGx
         FRAw==
X-Gm-Message-State: AOAM530wGX8A5gyLWM5PR3an1Kym2flSpmILc7YOdxmDM6KCEPtDzj1u
        AAqOeI+TmoZlP7jbo+CaKP8=
X-Google-Smtp-Source: ABdhPJw6RZ9DK6JULdAOGNqmEAxkDLU+F3bQTN3Dd1y4NMiMSMwtfmuZyl0vZkNkTEm2+w2KC1wkVw==
X-Received: by 2002:a05:6512:230c:: with SMTP id o12mr3679294lfu.653.1634197861894;
        Thu, 14 Oct 2021 00:51:01 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-5.NA.cust.bahnhof.se. [158.174.22.5])
        by smtp.gmail.com with ESMTPSA id t82sm172281lff.50.2021.10.14.00.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:51:00 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/2] mm/memory_failure: constify static mm_walk_ops
Date:   Thu, 14 Oct 2021 09:50:42 +0200
Message-Id: <20211014075042.17174-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014075042.17174-1-rikard.falkeborn@gmail.com>
References: <20211014075042.17174-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of hwp_walk_ops is to pass its address to
walk_page_range() which takes a pointer to const mm_walk_ops as
argument. Make it const to allow the compiler to put it in read-only
memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 92eeb317adf4..8d5faf347ed1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -674,7 +674,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 #define hwpoison_hugetlb_range	NULL
 #endif
 
-static struct mm_walk_ops hwp_walk_ops = {
+static const struct mm_walk_ops hwp_walk_ops = {
 	.pmd_entry = hwpoison_pte_range,
 	.hugetlb_entry = hwpoison_hugetlb_range,
 };
-- 
2.33.0

