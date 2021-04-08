Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64DC358F33
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhDHVcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:32:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:38042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232236AbhDHVcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:32:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF31DB034;
        Thu,  8 Apr 2021 21:31:50 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: add pattern for dummy-tools.
Date:   Thu,  8 Apr 2021 23:31:40 +0200
Message-Id: <04385380bee4847a8541c35418ff266b82d9cc13.1617917438.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <f6218ac526a04fa4d4406f935bcc4eb4a7df65c4.1617917438.git.msuchanek@suse.de>
References: <f6218ac526a04fa4d4406f935bcc4eb4a7df65c4.1617917438.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/get_maintainer.pl does not find a maintainer for new files
otherwise.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c80ad735b384..ce631ec44e1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9690,6 +9690,7 @@ F:	scripts/*vmlinux*
 F:	scripts/Kbuild*
 F:	scripts/Makefile*
 F:	scripts/basic/
+F:	scripts/dummy-tools/
 F:	scripts/mk*
 F:	scripts/mod/
 F:	scripts/package/
-- 
2.26.2

