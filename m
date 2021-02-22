Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E85321068
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhBVFXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:23:41 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:47795
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229567AbhBVFXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:23:39 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgC3BEGWPzNg8yoUAw--.27007S3;
        Mon, 22 Feb 2021 13:22:30 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] mm/kasan: remove volatile keyword
Date:   Mon, 22 Feb 2021 13:22:27 +0800
Message-Id: <1613971347-24213-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgC3BEGWPzNg8yoUAw--.27007S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3Kw1rAr1DuFW8ur45Jrb_yoW8JFWrpF
        9xJ3yxJr45t34j9Fyjyrs5Z3WrGas7JayxtF13CayfZwn5Wr1kXryIg34rAF48GrWkG3W3
        Za4rGFyrZF1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4r
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
        WxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb-zV5UUUU
        U==
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like volatile, the kernel primitives which make concurrent
access to data safe (spinlocks, mutexes, memory barriers,
etc.) are designed to prevent unwanted optimization.

If they are being used properly, there will be no need to
use volatile as well.  If volatile is still necessary,
there is almost certainly a bug in the code somewhere.
In properly-written kernel code, volatile can only serve
to slow things down.

see: Documentation/process/volatile-considered-harmful.rst

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 mm/kasan/shadow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 7c2c08c..d5ff9ca 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -25,13 +25,13 @@
 
 #include "kasan.h"
 
-bool __kasan_check_read(const volatile void *p, unsigned int size)
+bool __kasan_check_read(const void *p, unsigned int size)
 {
 	return check_memory_region((unsigned long)p, size, false, _RET_IP_);
 }
 EXPORT_SYMBOL(__kasan_check_read);
 
-bool __kasan_check_write(const volatile void *p, unsigned int size)
+bool __kasan_check_write(const void *p, unsigned int size)
 {
 	return check_memory_region((unsigned long)p, size, true, _RET_IP_);
 }
-- 
1.8.3.1

