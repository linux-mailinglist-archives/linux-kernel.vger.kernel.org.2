Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3955408A59
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbhIMLhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbhIMLhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:37:38 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B3DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:36:22 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so2560485wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bSTKtlz5vNtVKimr2bFb/fQDhWY54+Y9NMMcBs2WGw4=;
        b=n6H74Olasmc94WeVrsI2xPj0QmitddSGAzXlHY1m6h98KxPqhp/OTPLd70kpNYOTn1
         EoLNEYyyYgzBUskSPsTKBIfsDUX0hynxclQNYEdF0kxmWeTqnRyAejt1oEXIcgWc7BFM
         mOabxo8uY6F24qND4gxaJpafo5+rweOi8LCIYV0TtIkS6kvXaNIv91/Gjz0amReW2alA
         PrmETMbMR25SboppWmKBj/JaLcIse2uBiK5G+d7n19QhRvd7SYagRTUii8y9/PDRJCrU
         PltrzXQqz3uzvn42VFAyUjVoNJfo6rj/AVrq3PoeMO/BfsiCKTTLcTjGeHrLDENJGXzr
         6Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bSTKtlz5vNtVKimr2bFb/fQDhWY54+Y9NMMcBs2WGw4=;
        b=vTexEiyUBgjFeCv/FIzt8Oi9cvj684Bji1TEHsbFJsRFtfzkgFCoSvxK8VGa9W8ujb
         4SCyYzVNhEY0IZ5+tAg2kxWKAut9XMtvMPFCsjDqIWMdKP2LnpEp5l0CFyOc7J45LN70
         lnXzncFL8VJJRoYkEAyv4+tZCcOnCcuBauZk34PA29BKgPvayEzay8q6EYxMicBSyoA1
         Z1gX1gFSBEHfArnqJuqJA/M59Dzq6Gv1YFjAJqphyJoysjawTB/njt8waNzY605mtHbk
         dwlhNvO3iq8sI6yiGDqYmSFDUKjp7/6UpljvfsZYC7v2JbXyV3wiZa2GfOA4FOIg4TkM
         F7hA==
X-Gm-Message-State: AOAM5325VnE5ZZ/cks0plABBiN/eIi8qEb7rpltgNJz2B/vZ0GcdnqZA
        XWzUxEDKxYtPifeYSPxg+v9MwJzGSw==
X-Google-Smtp-Source: ABdhPJwQ5Je8nwY9tzaKcsKe5dMu6MzJFIb8KutO7phtgxvT7cF3sx8B6Pv3NcXy6K3w8ofGZGPAn/j1Sg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1f19:d46:38c8:7e48])
 (user=elver job=sendgmr) by 2002:a05:600c:3203:: with SMTP id
 r3mr10555555wmp.175.1631532981131; Mon, 13 Sep 2021 04:36:21 -0700 (PDT)
Date:   Mon, 13 Sep 2021 13:35:43 +0200
Message-Id: <20210913113542.2658064-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] mm: fix data race in PagePoisoned()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PagePoisoned() accesses page->flags which can be updated concurrently:

  | BUG: KCSAN: data-race in next_uptodate_page / unlock_page
  |
  | write (marked) to 0xffffea00050f37c0 of 8 bytes by task 1872 on cpu 1:
  |  instrument_atomic_write           include/linux/instrumented.h:87 [inline]
  |  clear_bit_unlock_is_negative_byte include/asm-generic/bitops/instrumented-lock.h:74 [inline]
  |  unlock_page+0x102/0x1b0           mm/filemap.c:1465
  |  filemap_map_pages+0x6c6/0x890     mm/filemap.c:3057
  |  ...
  | read to 0xffffea00050f37c0 of 8 bytes by task 1873 on cpu 0:
  |  PagePoisoned                   include/linux/page-flags.h:204 [inline]
  |  PageReadahead                  include/linux/page-flags.h:382 [inline]
  |  next_uptodate_page+0x456/0x830 mm/filemap.c:2975
  |  ...
  | CPU: 0 PID: 1873 Comm: systemd-udevd Not tainted 5.11.0-rc4-00001-gf9ce0be71d1f #1

To avoid the compiler tearing or otherwise optimizing the access, use
READ_ONCE() to access flags.

Link: https://lore.kernel.org/all/20210826144157.GA26950@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a558d67ee86f..628ab237665e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -206,7 +206,7 @@ static __always_inline int PageCompound(struct page *page)
 #define	PAGE_POISON_PATTERN	-1l
 static inline int PagePoisoned(const struct page *page)
 {
-	return page->flags == PAGE_POISON_PATTERN;
+	return READ_ONCE(page->flags) == PAGE_POISON_PATTERN;
 }
 
 #ifdef CONFIG_DEBUG_VM
-- 
2.33.0.309.g3052b89438-goog

