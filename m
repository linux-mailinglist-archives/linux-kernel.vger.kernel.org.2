Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236703D9151
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbhG1Oyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbhG1OyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:54:21 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2119BC06179E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:54:02 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 185so3288593iou.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3gMnfS3ZVPibbkuXLiFXnyctHVfxY7ctQKEATYt20pA=;
        b=pfmsI8yptPK+F+zbmH/P7nV1g0VhxrPr4niolekbbZBhxJKGiaFoWV2z2gtp8YBtC7
         PKMaIyED6eHRroP2XLWVBXV5hAF+lKLqHegvbZHaC/fAmPL/JBtUjhFxawliGMz0+EJx
         Mj8QAwJGOBXV9qnQ7Ua/11wG+BDQfvKf9eXDFp2JLKJT9YKO2vz6vcoxgaNaDTXVXmfz
         l6rvfe2XRfLurX73zSvO0YRTdc7F7p+AgGlaSeYUkCcQVPodx6KwUYdWmnR8G/FBPWm2
         LlFGgGgEl4/WVjDxN+67QjYe8llra2D5rWRw9fnFmVvn4lQ80dXid0o7OKrAbMqR40U8
         Dk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3gMnfS3ZVPibbkuXLiFXnyctHVfxY7ctQKEATYt20pA=;
        b=QER3eUNOg2tssi3BPJ2aJinNMxVclRlUGM8ScWcr5lBTeCx6Di8SyHPej3gSwS5n5d
         n+GZ9kHsVjYvf35PgjuLybornppCLA/6k/YSi2srM9uYxeDjAerO5khBSUwH1za9xW3u
         bAWM9BtJKbUewv/pJg47Cq/kQaPovbiCctBM+PaWm9pR2+8EVrmh30jI/r+4zH25VK9t
         Dh6InSVDdDPAzV8s67HKIch4K5gK8t6vFC3dLctxw4VnpCa/fXt6O4vn5Bilh/SYrYy1
         bhFXGqsvPh4Tt7qe+qqF+HPeTKPYc01Sfm/hhXYysn5BtUzGgDUYamw6xxQAT1Jm6Scq
         f+Kw==
X-Gm-Message-State: AOAM532JLJRGsPMHrmqQ40Ir/8W8G00STHkGKPSohbme1fl8/MQyT2O3
        BDbPzVa12Lf1OjWq0dp3jGQ=
X-Google-Smtp-Source: ABdhPJzpQUvdbUtjfJxPYliS4bX5IStD7eNoTlr0g9fri9SnONMUP20BEeUNbq8EbE2zJltLlDmmmw==
X-Received: by 2002:a6b:b24e:: with SMTP id b75mr24185896iof.94.1627484041557;
        Wed, 28 Jul 2021 07:54:01 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id a1sm79496ilp.1.2021.07.28.07.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 07:54:01 -0700 (PDT)
Date:   Wed, 28 Jul 2021 07:53:59 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, linux@rasmusvillemoes.dk, rafael@kernel.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com, sbrivio@redhat.com,
        jianpeng.ma@intel.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v7 0/4] use bin_attribute to break the size limitation of
 cpumap ABI
Message-ID: <YQFvhyAggX1fUm2t@yury-ThinkPad>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <YQFebNhDUD4VPN/P@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQFebNhDUD4VPN/P@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 03:41:00PM +0200, Greg KH wrote:
> On Thu, Jul 15, 2021 at 11:58:52PM +1200, Barry Song wrote:
> > v7:
> >   - update doc in code for new APIs according to the comments of
> >     Andy Shevchenko;
> >   - other minor cleanup and commit log fix according to the comments
> >     of Andy Shevchenko
> 
> I'm lost to tell if this is the latest version or if there are more
> changes?  Can you send this again with the latest changes so I can
> review it?

Barry, Greg,

If you decide to keep bitmap_print_to_buf in lib/bitmap.c, could you
please add the following patch to the series.

Thanks,
Yury


From 58602766dc2877d2103a334db6c2c2e1e6b8c89b Mon Sep 17 00:00:00 2001
From: Yury Norov <yury.norov@gmail.com>
Date: Wed, 28 Jul 2021 07:39:30 -0700
Subject: [PATCH] bitmap: extend comment to bitmap_print_to_buf

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
+ *    may be broken, so bitmap_parselist() may fail parsing it.
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

