Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE2A4603F5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 05:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350033AbhK1E3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 23:29:45 -0500
Received: from smtpbg511.qq.com ([203.205.250.109]:50831 "EHLO
        smtpbg515.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233809AbhK1E1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 23:27:44 -0500
X-QQ-mid: bizesmtp50t1638071067tq8fm8q1
Received: from kali.lan (unknown [182.148.14.187])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 28 Nov 2021 11:44:26 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000B00A0000000
X-QQ-FEAT: 2anfE2eVO982IXslQaS4kYVkTvbi7PfCYwEz5naq+ufJKYczgAgi4GIIvvpIB
        p6UXQghuOCm8sCUAe6zsdT2ZY/PozPzz+gw15CnzBNj5G1VIXD+TA+sbBHtMShq6lB5vAXK
        mb/XvMtODhocoIY5i2a3JHWaPsObktv2rKP0KS/VvNDKeh1P6bvLv8OUw8R3a0jootC/wQ4
        8TVAT6pXFx2XDk9p4v/sXPeqYoeODTjipj5sJJW3Bh4Lia9LW94Ws0dOudu4eiCj08wR3US
        l6qLWiPvYpvBFfy+CVh9OPJkmcweK3CeAwT5tIFXSR/omUhweM0Y8iUAcPS8rL4opCX06iS
        fZvvl6OEAg6Loxtn2c=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     rth@twiddle.net
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] alpha: fix typo in a comment
Date:   Sun, 28 Nov 2021 11:43:48 +0800
Message-Id: <20211128034348.5900-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `and' in a comment is repeated. Consequently, remove one
`and' from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/alpha/kernel/irq_i8259.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/irq_i8259.c b/arch/alpha/kernel/irq_i8259.c
index 1dcf0d9038fd..db574dcd6675 100644
--- a/arch/alpha/kernel/irq_i8259.c
+++ b/arch/alpha/kernel/irq_i8259.c
@@ -147,7 +147,7 @@ isa_no_iack_sc_device_interrupt(unsigned long vector)
 	 */
 	/* 
 	 *  The first read of gives you *all* interrupting lines.
-	 *  Therefore, read the mask register and and out those lines
+	 *  Therefore, read the mask register and out those lines
 	 *  not enabled.  Note that some documentation has 21 and a1 
 	 *  write only.  This is not true.
 	 */
-- 
2.33.0

