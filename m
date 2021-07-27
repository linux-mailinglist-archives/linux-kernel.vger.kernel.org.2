Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA93D7ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhG0QPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:15:38 -0400
Received: from [43.250.32.171] ([43.250.32.171]:8635 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229899AbhG0QPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=as8+fYIENYmvb8WnOx6zBgQA6+MIUEE7ArsaN
        gmzVgw=; b=jrHtqJWP6RMRMPCW/q7KofLL2WEZj9qxcPT1MKgf+7ObONVJid2Dd
        kEZ+z3oTL7YvnubVyTF/ChfB3TZ9KOCeTVbQsLhHRSlCcjEn+jv/h9wo4aCnwPTs
        pV0BDaG2bWNpRBXcnkfQmYQdIVvROTgkplP4bDFyNOQetXdjsgy2d8=
Received: from localhost.localdomain (unknown [113.251.14.68])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgDH1AMFMQBheZ4JAA--.34457S4;
        Wed, 28 Jul 2021 00:15:31 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     corbet@lwn.net
Cc:     panyunwang849@gmail.com, linux-doc-tw@groups.io,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] MAINTAINERS: add entry for traditional Chinese documentation
Date:   Wed, 28 Jul 2021 00:15:01 +0800
Message-Id: <20210727161501.13030-3-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727161501.13030-1-src.res@email.cn>
References: <20210727161501.13030-1-src.res@email.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgDH1AMFMQBheZ4JAA--.34457S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF15Jw4fWry8Xr15ZF17Awb_yoW3Zrc_Jw
        4UJayIqr1fGFyIkrs5Za97KrWav393Jr1rZ3Z5t34DXa4DJ398AF1ktwn3Cwn5ur4Uu34D
        AF9xJrWFqrnxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbnAYjsxI4VW3JwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1U
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMx
        AIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUjDGY
        DUUUU
X-Originating-IP: [113.251.14.68]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer information for traditional Chinese documentation.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66d047dc6880..de9370bcb226 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18829,6 +18829,14 @@ F:	arch/x86/mm/testmmiotrace.c
 F:	include/linux/mmiotrace.h
 F:	kernel/trace/trace_mmiotrace.c
 
+TRADITIONAL CHINESE DOCUMENTATION
+M:	Hu Haowen <src.res@email.cn>
+L:	linux-doc-tw@groups.io
+S:	Maintained
+W:	https://github.com/srcres258/linux-doc
+T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
+F:	Documentation/translations/zh_TW/
+
 TRIVIAL PATCHES
 M:	Jiri Kosina <trivial@kernel.org>
 S:	Maintained
-- 
2.25.1

