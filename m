Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD73D95A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhG1S6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG1S6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:58:40 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662AAC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:58:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y9so4084568iox.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UgJXRf6+3XgHXOkAGVUradMJnX44XHUoXK+yva5PRVE=;
        b=uFfF3Lrh7g1ukNwto85c0hdyiTUJS1UM8jDHog2VUbqYksEJTzgSJ6abpmImv9Fg2o
         eMyEA99KGMF5ZQF1+63ClOc8Sxll+fVILTgZmJVMsMSb9vR9KwinHX0nL+Sb6bQzgtC8
         Dn+obQNVEFHqagS6WTMttmhg4WzLdXDV/BI/dRj+s5LedU4+LgANuMwEbh9EEh9842Qv
         f82tH6lgvaRWDOo0r1jK8a2Kn30N4pVqe/h3L8tXgndFs78t5kytwkE/UFYBIWBKrqv0
         8GJM4rI9jQC+JOByUWW3YU79ZCyXyFT/E2/AGk1PSKiPy+7kq2XU2zlMy3PPnTK2VaDm
         DNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UgJXRf6+3XgHXOkAGVUradMJnX44XHUoXK+yva5PRVE=;
        b=Qz+ioDtFoi2gT1SFqWeOEoMn0cd6/zWTlBLN487uoCyCH+2r+IWtmbMPEBVDUzPBnS
         lHKWf7f/4tV9NPZfLIeLodDNpcQ8MUM9Hy/JuiX67tZFmMuT/iBBBALpvrfh4KesUFZ1
         OUv3wO6uVAQ4mr3AjLf9CkxQBY+5XBuHaV74vSZJo4cWNZwnpufICU9FaoVgNFPu2WRN
         zO+xoCEZov7a0HPeePyVEpQJTAGTkjJrpftl5Y5RCkGl6Infb6vfxo+lhKHiPJXoS1Yr
         +PRnEyfFw7doSHJgSGWSu9peip8dTcWGlS4nLku9li607nPS8Js4M6Vyd1DZUVGupEoL
         N0Qw==
X-Gm-Message-State: AOAM530S0MU0rLz7T4o8BhqBgfXPj8gTYWORgdDCVog/Y/m7n1IF3aZ1
        BDH6wTextDVfXr8QZv/dPTS4LRa6skfSIQ==
X-Google-Smtp-Source: ABdhPJyHUZgrAPEWeHqkAKF9fca84iwYaaQ4RsDOJvzRW1pi1GnHABNXm18YGtCSfOFtxa0PY3aLXw==
X-Received: by 2002:a5d:8b8b:: with SMTP id p11mr742421iol.77.1627498717698;
        Wed, 28 Jul 2021 11:58:37 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id p8sm538846iol.49.2021.07.28.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:58:37 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     Yury Norov <yury.norov@gmail.com>, dave.hansen@intel.com,
        linux@rasmusvillemoes.dk, rafael@kernel.org, rdunlap@infradead.org,
        agordeev@linux.ibm.com, sbrivio@redhat.com, jianpeng.ma@intel.com,
        valentin.schneider@arm.com, peterz@infradead.org,
        bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        linuxarm@huawei.com, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com
Subject: [PATCH] bitmap: extend comment to bitmap_print_to_buf
Date:   Wed, 28 Jul 2021 11:58:31 -0700
Message-Id: <20210728185831.215079-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend comment to new function to warn potential users about caveats.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 56bcffe2fa8c..b9f557ca668c 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -545,6 +545,24 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
  * mainly serves bin_attribute which doesn't work with exact one page, and it
  * can break the size limit of converted decimal list and hexadecimal bitmask.
  *
+ * WARNING!
+ *
+ * This function is not a replacement for sprintf() or bitmap_print_to_pagebuf().
+ * It is intended to workaround sysfs limitations discussed above and should be
+ * used carefully in general case for the following reasons:
+ *  - Time complexity is O(nbits^2/count), comparing to O(nbits) for snprintf().
+ *  - Memory complexity is O(nbits), comparing to O(1) for snprintf().
+ *  - @off and @count are NOT offset and number of bits to print.
+ *  - If printing part of bitmap as list, the resulting string is not a correct
+ *    list representation of bitmap. Particularly, some bits within or out of
+ *    related interval may be erroneously set or unset. The format of the string
+ *    may be broken, so bitmap_parselist-like parser may fail parsing it.
+ *  - If printing the whole bitmap as list by parts, user must ensure the order
+ *    of calls of the function such that the offset is incremented linearly.
+ *  - If printing the whole bitmap as list by parts, user must keep bitmap
+ *    unchanged between the very first and very last call. Otherwise concatenated
+ *    result may be incorrect, and format may be broken.
+ *
  * Returns the number of characters actually printed to @buf
  */
 int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
-- 
2.30.2

