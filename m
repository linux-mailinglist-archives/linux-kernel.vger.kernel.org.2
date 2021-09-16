Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E0540ED50
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbhIPW2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:28:30 -0400
Received: from sym2.noone.org ([178.63.92.236]:52064 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234573AbhIPW23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:28:29 -0400
X-Greylist: delayed 105990 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2021 18:28:29 EDT
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4H9Wsj1sDTzvjfm; Fri, 17 Sep 2021 00:27:05 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpumask: Omit terminating null byte in cpumap_print_{list,bitmask}_to_buf
Date:   Fri, 17 Sep 2021 00:27:05 +0200
Message-Id: <20210916222705.13554-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes in the patch series [1] introduced a terminating null byte
when reading from cpulist or cpumap sysfs files, for example:

  $ xxd /sys/devices/system/node/node0/cpulist
  00000000: 302d 310a 00                             0-1..

Before this change, the output looked as follows:

  $ xxd /sys/devices/system/node/node0/cpulist
  00000000: 302d 310a                                0-1.

Fix this regression by excluding the terminating null byte from the
returned length in cpumap_print_list_to_buf and
cpumap_print_bitmask_to_buf.

[1] https://lore.kernel.org/all/20210806110251.560-1-song.bao.hua@hisilicon.com/

Fixes: 1fae562983ca ("cpumask: introduce cpumap_print_list/bitmask_to_buf to support large bitmask and list")
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/linux/cpumask.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 5d4d07a9e1ed..1e7399fc69c0 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -996,14 +996,15 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
  * cpumask; Typically used by bin_attribute to export cpumask bitmask
  * ABI.
  *
- * Returns the length of how many bytes have been copied.
+ * Returns the length of how many bytes have been copied, excluding
+ * terminating '\0'.
  */
 static inline ssize_t
 cpumap_print_bitmask_to_buf(char *buf, const struct cpumask *mask,
 		loff_t off, size_t count)
 {
 	return bitmap_print_bitmask_to_buf(buf, cpumask_bits(mask),
-				   nr_cpu_ids, off, count);
+				   nr_cpu_ids, off, count) - 1;
 }
 
 /**
@@ -1018,7 +1019,7 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
 		loff_t off, size_t count)
 {
 	return bitmap_print_list_to_buf(buf, cpumask_bits(mask),
-				   nr_cpu_ids, off, count);
+				   nr_cpu_ids, off, count) - 1;
 }
 
 #if NR_CPUS <= BITS_PER_LONG
-- 
2.33.0

