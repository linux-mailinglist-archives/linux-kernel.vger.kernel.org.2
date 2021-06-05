Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8C039C648
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFEG3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:29:39 -0400
Received: from mail-m964.mail.126.com ([123.126.96.4]:37604 "EHLO
        mail-m964.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFEG3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=f9Wj/cFcMSLEZt3a7k
        mUO3fOZsRQwFcAJUxx6KOO8rY=; b=hNR3nK60/UvwRNhsHINMLLlMwJK+/6k8CD
        lFe4lKlznRBAMZT4s41NhGs5hrU6hqZdDn//22B/ienNpRgd+ZgmRgxEBHfhu5fL
        eO1y9FpP/Fwt4wd2F6SHoOvWWS5pp0b1zR7JJ+k4AhXdHfMIUL3PM9zdUTvuR6AH
        3zA9JTSgs=
Received: from localhost.localdomain (unknown [122.194.9.184])
        by smtp9 (Coremail) with SMTP id NeRpCgDHQTIOErtg28trXA--.18188S3;
        Sat, 05 Jun 2021 13:56:30 +0800 (CST)
From:   chenxb_99091@126.com
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Kailong <wkailong1993@163.com>
Subject: [PATCH] MIPS:Loongson2F:delete mutex defined but not used
Date:   Sat,  5 Jun 2021 13:56:27 +0800
Message-Id: <1622872587-6873-1-git-send-email-chenxb_99091@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NeRpCgDHQTIOErtg28trXA--.18188S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4UKrWrWry8Xry7tr43ZFb_yoW3JFXEgF
        y2kw48urWrAF1fu3sruF15Kw429a4ruFnxCF93Gr95Za1FvF9xCF4vvry8Wrn0gFnIv34r
        WF48Cr45uF47tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0OJ55UUUUU==
X-Originating-IP: [122.194.9.184]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbifg+oxVpEDhH5nwAAs7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailong <wkailong1993@163.com>

For 4.19.X, mutex clock_list_sem defined in
 arch/mips/loongson64/lemote-2f/clock.c never be used.  So delete it

Signed-off-by: Kailong <wkailong1993@163.com>
---
 arch/mips/loongson64/lemote-2f/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/lemote-2f/clock.c b/arch/mips/loongson64/lemote-2f/clock.c
index 8281334..aff58b0 100644
--- a/arch/mips/loongson64/lemote-2f/clock.c
+++ b/arch/mips/loongson64/lemote-2f/clock.c
@@ -19,7 +19,7 @@
 
 static LIST_HEAD(clock_list);
 static DEFINE_SPINLOCK(clock_lock);
-static DEFINE_MUTEX(clock_list_sem);
+
 
 /* Minimum CLK support */
 enum {
-- 
2.7.4

