Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC13EDCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhHPSKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhHPSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:09:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9F1C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:09:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so15468777pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5peXWJzq1zaMYi9bQcdQwAvibU4I+RCeHIyxmwwnmQg=;
        b=TsCbPDVOG5A18r5ZVM0guu85vnZt6hqNjKbaHn1hNblNss9X18yLbBFvx7POVDCBtj
         iS0YIcoIHaqzbkw/sL+2HSONNjnYOqmD+8qPvlJzwYUq7pBCGD9qbRCIwIBlrtuHLIsK
         Nb4SOTf2d1LY4uY2DIKoIeA/UbebYm9Ibgvji3hLocuOPw9XnixECCryvxWsuDYMpkrl
         CzEgypEarsquRlO5Tqha7Dm+c4azB0YMolCg82MGfInXxU5vM0hk6xumUdquyn9aFgG9
         ySnmoVzJ7/9/qUjvdluFzkHfs3GWAaBNn+mmouh+l8mmq97IsMNMaIK3luNBvzmqF35x
         f1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5peXWJzq1zaMYi9bQcdQwAvibU4I+RCeHIyxmwwnmQg=;
        b=KnhwURo4ODA2yp5n49FhN/JVIfo5C2Ef2axXxvZExMsP06aS9GG623SD8Dc5bGgBVk
         q8YK7NyouePoiBEqL4QKWemcr3BB9/3f7+T4+1bv2HgrRHkCy6oDoN/A5DuDtOmAkIx+
         jWhBLM7FkzcAd+DNLeiaV/+e2vHzXnKbjJac3dPFVgWQeT4jw2uO6StvAyfRtgF1A0x8
         +i0ff6B+lHTejdKX2j+xd3GKCY9L5DLxvJCnzE4KN8Q+67WeApMu2RxZ4MXT4OT024QC
         D6KRSNEI/UKeS/JSFrFE5SAmw1z0oKN8dHh3ut1Xd0NIikO9zqyUfPRR85Droo3WTJQm
         XWGw==
X-Gm-Message-State: AOAM532qIM07qal0myuZgArqR0/TfVaXvRgkInSYWEaBMd+sS8+dz7OH
        YVxjIl6aIB5P34ttDuBBGKg=
X-Google-Smtp-Source: ABdhPJx0V/gUFYzqubxthldE74FPZnO9N+EOb7PLa3SQavtMaNMfqEBWKoODMWnfx8gyIGZaIOLFRA==
X-Received: by 2002:a05:6a00:1348:b0:3e2:c99:a7b0 with SMTP id k8-20020a056a00134800b003e20c99a7b0mr4508090pfu.62.1629137354749;
        Mon, 16 Aug 2021 11:09:14 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id g19sm149993pjl.25.2021.08.16.11.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 11:09:13 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, osalvador@suse.de, tdmackey@twitter.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] doc: hwpoison: correct the support for hugepage
Date:   Mon, 16 Aug 2021 11:09:09 -0700
Message-Id: <20210816180909.3603-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210816180909.3603-1-shy828301@gmail.com>
References: <20210816180909.3603-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwpoison support for huge page, both hugetlb and THP, has been in
kernel for a while, the statement in document is obsolete, correct it.

Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 Documentation/vm/hwpoison.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
index a5c884293dac..89b5f7a52077 100644
--- a/Documentation/vm/hwpoison.rst
+++ b/Documentation/vm/hwpoison.rst
@@ -180,7 +180,6 @@ Limitations
 ===========
 - Not all page types are supported and never will. Most kernel internal
   objects cannot be recovered, only LRU pages for now.
-- Right now hugepage support is missing.
 
 ---
 Andi Kleen, Oct 2009
-- 
2.26.2

