Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B363F0A84
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhHRRty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhHRRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:49:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A313C061292
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:49:01 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so9467680pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHmTsQdU7KuN/XtvGUVKPpwurNSYz6PXrWrKJdVLujA=;
        b=gdlOiNEvaBd8syF+UyAdQamEuZevfhSagivxujwAjkcgGWlQ4N9lmhdRyqNWEEvloN
         YZS7yVakWd5A8a4T2WIqfKA9Pz6k/G7szM/9Rb4cJMGhIYehK22YFTD705ddPe2UhmZh
         zLAwlblgTURmQYHXkYsa4tO+/lhGyNdOnWRKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHmTsQdU7KuN/XtvGUVKPpwurNSYz6PXrWrKJdVLujA=;
        b=PriAjsdp5vgwKuDfnnQFo945bYZeXkkG86EmYYgT8vEjc2//KL/093D/smPPpY7aac
         5uhvaSjUGhpNYG8KTWhwn0PY5OWDTUfR55kjvVLzUnzDTgs/6bRv47xe71xQf1qgLauP
         4bEeHYFlbl/N1t9kPEDRMVnDH4RjJ1WxC17gnrGtcjbx0bUs+DfWq0KAqwBcp4JSH6WG
         0kC7Q94z5TEbM8lqV0fSC/gB/u5MzRT/9NBTU4+8kpgpIRYCryJpTsaK+dOs5wJLg1WL
         cALY6viR8ob6k7ExUnlOgdcje9fiafLAe3OEebVEIZSx4pxtEw9Pc7ye2+b/NmDuxcuI
         ONwQ==
X-Gm-Message-State: AOAM531hX64Mdfo3T4MrdrOkA0syIPMYezzwxfwTc2GZIXNYOG4GbMqL
        YSHWD6eS02TWKRlrtraXyWfVxA==
X-Google-Smtp-Source: ABdhPJz7hwDBbVejgmN2cAL4PuRkHPIZdKRXP+wNeblDTZXNmEaryjgNQimYWqo0SwYsSVe+cBSwIA==
X-Received: by 2002:a17:903:2303:b0:12d:d5d8:7497 with SMTP id d3-20020a170903230300b0012dd5d87497mr7045802plh.60.1629308940843;
        Wed, 18 Aug 2021 10:49:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i11sm419356pfo.29.2021.08.18.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:48:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/4] lkdtm/bugs: Add ARRAY_BOUNDS to selftests
Date:   Wed, 18 Aug 2021 10:48:52 -0700
Message-Id: <20210818174855.2307828-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818174855.2307828-1-keescook@chromium.org>
References: <20210818174855.2307828-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892; h=from:subject; bh=DOYOqZV2Q+UGJKZkToQtyhtlYGp8Wu9ehFVapQblCWI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHUgFZCr5VVGQzdkNXiPZUJ8p/WI0XYxFqAyjv4Tz fR0Wg56JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR1IBQAKCRCJcvTf3G3AJk/QD/ 46oKDZ6UwgsHHF4mJW+4mfPhBUiEhtaEfkQxAuFjD9Lrul+zHQgsm43l/BAamshKopp7z8FTdl8249 x4qZ5lhrVo3Z5+gzxk5vtUkwwO2U+2kJvZhNGDX8VsbhGZdwXk4szHuwzA3sQAOPnkz51PUMoF82sr iehEHwfEtEc8w3Ux+KuGiTZ4KanKOmvyhKnQDZO8cmW8sYVk+pxSXkz6go+7HWy+gK0YMnKidKs1fX VXcznGC/0YD0rmUPrU6iRBjst+DDXr+VzyzWJChZD+m0cxudDSJpdey0fABTOAkl8Xt5mqR0JUfv5I qLqfhrYqk1HTxDDNT6qIwRMoyw0mnSsSBKni/3OsNw0SF3lz64N872mlXozKtun4HNp093p+lktIoe qThiyfdaySnIOhvQgWiFKdcokNhoFNP8puj/A76U9qnT815CIIb9Yw9LN4vsIvtGF0VI6EwblwpVu1 3BdbUFh8Hp9VU1Z65NxMIEf53bMvQWAKrCGQIKmjvqddpxPiB162q8RFtguTpOT2dLbqHil5oDXslV sGeoIyRFuiNuJg5GgjhWCxvb+V7zlJGzDb4OtQqXooP26JOb8sP4Vt9Wh0bFo4egqiOVf1KDHJaF/l 7rQdHpvn1ADOrDbpcAcIxnx6X5UlNWT7mn30/9q/kum3zwYN3oY3WL4DqLcg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG hints about why the ARRAY_BOUNDS test might fail, and
similarly include the CONFIGs needed to pass the ARRAY_BOUNDS test via
the selftests, and add to selftests.

Cc: kernelci@groups.io
Suggested-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c               | 1 +
 tools/testing/selftests/lkdtm/config    | 2 ++
 tools/testing/selftests/lkdtm/tests.txt | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 88c218a9f8b3..03171e412356 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -267,6 +267,7 @@ void lkdtm_ARRAY_BOUNDS(void)
 	kfree(not_checked);
 	kfree(checked);
 	pr_err("FAIL: survived array bounds overflow!\n");
+	pr_expected_config(CONFIG_UBSAN_BOUNDS);
 }
 
 void lkdtm_CORRUPT_LIST_ADD(void)
diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index 013446e87f1f..38edea25631b 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -6,3 +6,5 @@ CONFIG_HARDENED_USERCOPY=y
 # CONFIG_HARDENED_USERCOPY_FALLBACK is not set
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
+CONFIG_UBSAN_BOUNDS=y
+CONFIG_UBSAN_TRAP=y
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 846cfd508d3c..6a33dbea8491 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -7,6 +7,7 @@ EXCEPTION
 #EXHAUST_STACK Corrupts memory on failure
 #CORRUPT_STACK Crashes entire system on success
 #CORRUPT_STACK_STRONG Crashes entire system on success
+ARRAY_BOUNDS
 CORRUPT_LIST_ADD list_add corruption
 CORRUPT_LIST_DEL list_del corruption
 STACK_GUARD_PAGE_LEADING
-- 
2.30.2

