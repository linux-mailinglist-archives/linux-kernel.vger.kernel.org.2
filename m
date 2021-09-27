Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D788418DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 04:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhI0ChO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 22:37:14 -0400
Received: from unicom146.biz-email.net ([210.51.26.146]:54247 "EHLO
        unicom146.biz-email.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhI0ChN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 22:37:13 -0400
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((LNX1044)) with ASMTP (SSL) id UBK00128;
        Mon, 27 Sep 2021 10:35:28 +0800
Received: from localhost.localdomain (10.200.104.119) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2308.14; Mon, 27 Sep 2021 10:35:09 +0800
From:   Kai Song <songkai01@inspur.com>
To:     <linuxppc-dev@lists.ozlabs.org>
CC:     <ruscur@russell.cc>, <oohall@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>, Kai Song <songkai01@inspur.com>
Subject: [PATCH] powerpc/eeh:Fix some mistakes in comments
Date:   Mon, 27 Sep 2021 10:35:07 +0800
Message-ID: <20210927023507.32564-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.119]
tUid:   20219271035284565ae0be1f099392af88d8d14853da9
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of warning:
arch/powerpc/kernel/eeh.c:774: warning: expecting prototype for eeh_set_pe_freset(). Prototype was for eeh_set_dev_freset() instead

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 arch/powerpc/kernel/eeh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index e9b597ed423c..4cd4acb049ec 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -761,8 +761,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 }
 
 /**
- * eeh_set_pe_freset - Check the required reset for the indicated device
- * @data: EEH device
+ * eeh_set_dev_freset - Check the required reset for the indicated device
+ * @edev: EEH device
  * @flag: return value
  *
  * Each device might have its preferred reset type: fundamental or
-- 
2.27.0

