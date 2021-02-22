Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA5732102D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBVFLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:11:55 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:48647
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229473AbhBVFLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:11:52 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgCnrsLVPDNgmiIUAw--.49101S3;
        Mon, 22 Feb 2021 13:10:46 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] mm/kasan: switch from strlcpy to strscpy
Date:   Mon, 22 Feb 2021 13:10:47 +0800
Message-Id: <1613970647-23272-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgCnrsLVPDNgmiIUAw--.49101S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4rAFyDtw4UArW7Ww4Durg_yoWfWFgE9w
        n7tay7G395Xr9xZ3ZrK3yrJFyS93WFgr1kuFy5JF90ga1aqws0gF93J34akrW8XwsI9asI
        yrZ09r1rJw4a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
        W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GrWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYPEfDUUUU
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy is marked as deprecated in Documentation/process/deprecated.rst,
and there is no functional difference when the caller expects truncation
(when not checking the return value). strscpy is relatively better as it
also avoids scanning the whole source string.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 mm/kasan/report_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 8a9c889..fc7f7ad 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -148,7 +148,7 @@ static bool __must_check tokenize_frame_descr(const char **frame_descr,
 		}
 
 		/* Copy token (+ 1 byte for '\0'). */
-		strlcpy(token, *frame_descr, tok_len + 1);
+		strscpy(token, *frame_descr, tok_len + 1);
 	}
 
 	/* Advance frame_descr past separator. */
-- 
1.8.3.1

