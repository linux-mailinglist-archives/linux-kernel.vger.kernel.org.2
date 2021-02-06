Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4481311CC6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 11:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBFKxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 05:53:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:52952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhBFKvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 05:51:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612608588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KP59jAs7saISZqMq/sKJ7ioUVrcML6xC9JkBIsqGnM=;
        b=TsFTkQEp8+BbnvC9FjNahPV9/OMDu5YaNXS+RFx2/56hsUmQ/m0XUeQohZt+9dc2pfi1Mn
        ZU+VYw6cMqbxpx1pFdD2FvUGZB/ZCLAbWKkk91aj4rxBdlcpSAkz8uFWYX1MaivEDbUOI9
        oCisMByJFL/PfB9JBHXl3fq+xzZFIRs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14272AEC4;
        Sat,  6 Feb 2021 10:49:48 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 7/7] xen/evtchn: read producer index only once
Date:   Sat,  6 Feb 2021 11:49:32 +0100
Message-Id: <20210206104932.29064-8-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206104932.29064-1-jgross@suse.com>
References: <20210206104932.29064-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In evtchn_read() use READ_ONCE() for reading the producer index in
order to avoid the compiler generating multiple accesses.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/evtchn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 421382c73d88..f6b199b597bf 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -211,7 +211,7 @@ static ssize_t evtchn_read(struct file *file, char __user *buf,
 			goto unlock_out;
 
 		c = u->ring_cons;
-		p = u->ring_prod;
+		p = READ_ONCE(u->ring_prod);
 		if (c != p)
 			break;
 
-- 
2.26.2

