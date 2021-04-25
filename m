Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B136A9F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 01:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhDYX6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 19:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhDYX6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 19:58:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04728C061574;
        Sun, 25 Apr 2021 16:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=z5G/dHyVh1dT5W5QVYbtCd25tzIkokFqAw96MLvxJV8=; b=AKZRrwvB48cKrrWpby4azeqrip
        mjTqOVC/L4lkiALke8ZeuKnZ7Nz0CidPxOcjaCbGRJP6Rvbj1DNfGIOUjABhGyz5zt0oA9cYpLsEa
        J9kjvJCuOwCNeknUWNGXUwSyRKBBehIpNFWb7D/4t57/3sn5+EW1GMAqrnCZYCqZj1xpqR//fB7M/
        DlTdnTTkgzKxzHpIZyy2IWTfAf86ARZ8kXhA8ULPWJ5VNIwzqyLQfRuQO/y8IgEevUdzxlKF7MKRA
        suY7/GHFf2Bi9YqdcuZ9/ECCzsX1kqE1K4VjNhdoQSMZYRsn14Bg8aOW1rseyyTvI/Hj9UjozxBQ0
        sYdpKD4g==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1laodO-006UVF-JN; Sun, 25 Apr 2021 23:57:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] alpha: csum_partial_copy.c: add function prototypes from <net/checksum.h>
Date:   Sun, 25 Apr 2021 16:57:49 -0700
Message-Id: <20210425235749.19113-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "no previous prototype" W=1 warnings from the kernel test robot:

../arch/alpha/lib/csum_partial_copy.c:349:1: error: no previous prototype for 'csum_and_copy_from_user' [-Werror=missing-prototypes]
  349 | csum_and_copy_from_user(const void __user *src, void *dst, int len)
      | ^~~~~~~~~~~~~~~~~~~~~~~
../arch/alpha/lib/csum_partial_copy.c:358:1: error: no previous prototype for 'csum_partial_copy_nocheck' [-Werror=missing-prototypes]
  358 | csum_partial_copy_nocheck(const void *src, void *dst, int len)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 808b49da54e6 ("alpha: turn csum_partial_copy_from_user() into csum_and_copy_from_user()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Adding the header file suggested by Al.

 arch/alpha/lib/csum_partial_copy.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210423.orig/arch/alpha/lib/csum_partial_copy.c
+++ linux-next-20210423/arch/alpha/lib/csum_partial_copy.c
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <net/checksum.h>
 
 
 #define ldq_u(x,y) \
