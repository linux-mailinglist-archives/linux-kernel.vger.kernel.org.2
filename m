Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9813734F639
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhCaB3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:29:24 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:21094 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCaB3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:29:18 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id E94BC9801DF;
        Wed, 31 Mar 2021 09:29:15 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] arch: parisc: Remove duplicate struct task_struct declaration
Date:   Wed, 31 Mar 2021 09:28:50 +0800
Message-Id: <20210331012857.2799385-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTx1IGRgYQxlKTx9KVkpNSkxKTk9KTk1JSkJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pwg6Sgw5UT8XQzZKLBFNCTIX
        KzhPCRhVSlVKTUpMSk5PSk5NTklOVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTUtINwY+
X-HM-Tid: 0a7885e62653d992kuwse94bc9801df
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct task_struct is declared twice. One has been declared
at 154th line. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/parisc/include/asm/processor.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 11ece0d07374..b5fbcd2c1780 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -272,7 +272,6 @@ on downward growing arches, it looks like this:
 	regs->gr[23] = 0;				\
 } while(0)
 
-struct task_struct;
 struct mm_struct;
 
 /* Free all resources held by a thread. */
-- 
2.25.1

