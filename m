Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0538446C37
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 04:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhKFD2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 23:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhKFD2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 23:28:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E672DC061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 20:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6/kWhbqRgRV86GqBXhUN/qe26HQfH+5fQJSNVsfmrLk=; b=saVTPC+PbCuS1zrwV+ABsc/N3N
        zAYDjp01Md4FsPC7tOIrByN4tbwpXTwSxYnFgen9t5L3Pz3/iiTV2sMzOBrhdI5PGDbrgasLqBIpJ
        /4ACwlxgm4jgjQuyrpIxYWL4Ft4w5h3v/TYTACGXmzUOflGnJgY7nxCbLFF9xPuI3ZHOlirTc7BAk
        9wCEATMv2uKFdakr/BfZTUyPC4Wc+rDCRlPlyPrEQzZGgT5T2uasyALTjxdL/pSCRfn00/LwZtgAn
        P6vx8Zt6GSst7PXv/K3r0ZgKv5L03uWqyeJo/6x9FGf4rDmGc1PeoESLTd7CPYZ4dT0WsV+uUpWFK
        620q9Hhw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjCKg-00CcF3-KT; Sat, 06 Nov 2021 03:25:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Fuad Tabba <tabba@google.com>, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH] arm64: kvm/hyp/nvhe: fix a non-kernel-doc comment
Date:   Fri,  5 Nov 2021 20:25:29 -0700
Message-Id: <20211106032529.15057-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use kernel-doc "/**" notation when the comment is not in
kernel-doc format.

Fixes this docs build warning:

arch/arm64/kvm/hyp/nvhe/sys_regs.c:478: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Handler for protected VM restricted exceptions.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211106.orig/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ linux-next-20211106/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -474,7 +474,7 @@ bool kvm_handle_pvm_sysreg(struct kvm_vc
 	return true;
 }
 
-/**
+/*
  * Handler for protected VM restricted exceptions.
  *
  * Inject an undefined exception into the guest and return true to indicate that
