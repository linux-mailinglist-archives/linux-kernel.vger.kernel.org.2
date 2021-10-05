Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2822A422300
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhJEKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhJEKEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:04:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 714D16124D;
        Tue,  5 Oct 2021 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633428143;
        bh=yak11g9SHPypS4HfvMTcMsZg68jwQslG7tBrG/Xbdy4=;
        h=From:To:Cc:Subject:Date:From;
        b=tGAdpg78wkWg4OZqJ+1qTGaBRvRgZryQh8VWZ6PZTR7NJqdMBTx9vhsVh2+IQB9TC
         84pViX8J/HcfTpg7weCNQJVgs3dfkuLC2V2tlLFjuvOzctBYX7GV+E3h2HwB2O3bpV
         2zeFO2WjFxQ9Q4aKo+dUotfvLGMxlWMrTmBkS27Kk7ENIuDcj5+ruk5xDXengbHfbl
         qBmfORkh1WC9+2Or8xio4pXOlb8SFa3N9GIjeZ0XI28a1H3afZIEYLB0zVhWyrRm/D
         v7krCsUHBLJuXt3ojjgN4n0eyAFn8TlR3GXy3dG4k/UTq8eOjX4yyoXdKB3Mmu++CT
         sf+rdjLTlu/RA==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Documentation: remove reference to now removed mandatory-locking doc
Date:   Tue,  5 Oct 2021 06:02:22 -0400
Message-Id: <20211005100222.5499-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I removed the document on mandatory locking from the tree, I missed
removing the reference to it from the index file.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index c0ad233963ae..bee63d42e5ec 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -29,7 +29,6 @@ algorithms work.
    fiemap
    files
    locks
-   mandatory-locking
    mount_api
    quota
    seq_file
-- 
2.31.1

