Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4070D4330A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhJSIH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234721AbhJSIGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7AA6613D0;
        Tue, 19 Oct 2021 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630667;
        bh=FlR2r6mdGqg7+t6CjRRwR3VZXBGAizXLDmVYnKbLWm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRYnZzOasqRKACRZgFeUAufs+Z4aHkktkYAEMLVOapDVzT5+/i9CyRxdnA8b8NLlq
         fx98VfLnPQo5E/WJ62x2EH2paytvOBliXIbF83vBQNvteEntjvAs4Fufu3JueuJw8D
         nOP9APW2s1t1Mo07S1gaUJUkl85bzi5w1ym8Zv0feOeCg4VYLU2P/WkZSl/D4Z7Z70
         AjcE2/eU3hv+YyaVarGoKnx29PRNEfBDtjp2R3ak2GAx8IjX8NFSx3eCHeUtNqawHk
         2XzJFdgU05RQlN/Vd0wH8DICwuIr9sjUdsZ1d8Rss3UhoEqCHddPFXcLpMGTb76XJZ
         MZUyyzXTCEKrw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJX-7h; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/23] docs: translations: zn_CN: irq-affinity.rst: add a missing extension
Date:   Tue, 19 Oct 2021 09:04:14 +0100
Message-Id: <22eadbe9fc99fffbd440714f2e4423a5519392a3.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without .rst extension, ./scripts/documentation-file-ref-check will produce
a warning, and auto-generating cross-references by automarkup.py may not
work.

Fixes: 8137a49e1567 ("docs/zh_CN: Modify the translator tag and fix the wrong word")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 Documentation/translations/zh_CN/core-api/irq/irq-affinity.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/core-api/irq/irq-affinity.rst b/Documentation/translations/zh_CN/core-api/irq/irq-affinity.rst
index 7addd5f27a88..36b085226d0b 100644
--- a/Documentation/translations/zh_CN/core-api/irq/irq-affinity.rst
+++ b/Documentation/translations/zh_CN/core-api/irq/irq-affinity.rst
@@ -1,6 +1,6 @@
 .. include:: ../../disclaimer-zh_CN.rst
 
-:Original: Documentation/core-api/irq/irq-affinity
+:Original: Documentation/core-api/irq/irq-affinity.rst
 
 :翻译:
 
-- 
2.31.1

