Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5791D3D2C34
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 20:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhGVSRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 14:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhGVSRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:17:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 473CD60E74;
        Thu, 22 Jul 2021 18:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626980300;
        bh=5vu0b9lYuAjY8fr38513tee2OorycS/I8EZCgpNkDmg=;
        h=From:To:Cc:Subject:Date:From;
        b=xXbYe9/iPLl/DfKkWe7zf//d/LRQRvHnRLNqQVIEfj9mQaESIEBIlP6lW0lx/splw
         yYNympA7hWLXvp8O2lNOEdSNj4O4QGduQvw4T2SrY4kdWPivcxo9zfW0zta3HKoq2H
         nFRvG4OxrRyBjJaoHoNdDlIF8UsrfrZ69xjLmFvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] percpu: remove export of pcpu_base_addr
Date:   Thu, 22 Jul 2021 20:58:14 +0200
Message-Id: <20210722185814.504541-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; h=from:subject; bh=5vu0b9lYuAjY8fr38513tee2OorycS/I8EZCgpNkDmg=; b=owGbwMvMwCRo6H6F97bub03G02pJDAk/9x8SWua9b13WnU2HCjcs2W4Q5v3Te8+pYyd9F8sH5BX9 XXMioCOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAm4jWPYb6X6aupyz8kfGW9yC2qs/ fOpgC226sZ5qco7ZT0kl71Ol84oP3O9xem/86lLQYA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not needed by any modules, so remove the export.

Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/percpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 7f2e0151c4e2..a43039629aa4 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -146,7 +146,6 @@ static unsigned int pcpu_high_unit_cpu __ro_after_init;
 
 /* the address of the first chunk which starts with the kernel static area */
 void *pcpu_base_addr __ro_after_init;
-EXPORT_SYMBOL_GPL(pcpu_base_addr);
 
 static const int *pcpu_unit_map __ro_after_init;		/* cpu -> unit */
 const unsigned long *pcpu_unit_offsets __ro_after_init;	/* cpu -> unit offset */
-- 
2.32.0

