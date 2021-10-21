Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A841436C81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhJUVPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:15:48 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:56861 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhJUVPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:15:45 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Hb0ZZ6NJmz6R;
        Thu, 21 Oct 2021 23:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1634850807; bh=dDydSpeRtBQ2KCV21NBW7nUXbIsqrLCNlPHHRPFs19A=;
        h=Date:From:Subject:To:Cc:From;
        b=hubNOxj7ypCWe0KWMcQkqJcrwOmPSrHGhVDIxZHEB4GbnfVdJG4h1VswI+rYf5lcy
         TXJBzBEzQTjWPsPEnj/BL2OckfG0kp+qBxt7lVqLmCA9uxqcMjkU/4Wa/ZxxJwOksD
         Tsph/1jLXIdxUhbXF9bDjVTHam5e/1Pxb7vb3eZjA2wVAD/xe0QpB8yWa9KCRc/SJw
         TJrwkv3jTZ5Zh4v4ioWhm6+Y+QE8OKXxx975SXvztgXEA2qutFHPj4t89E7G4glltH
         JK7BBGlPXnDzT1fNKY5CiDvh9+w8avugXbhhTI9iTUYPYaZeueVmIvliTuPthXFapy
         meQ9PFGa7KM8A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Thu, 21 Oct 2021 23:13:25 +0200
Message-Id: <cf80c4bae90f587cac975d69905f6dc7642a05e3.1634850725.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] dm: make workqueue names device-specific
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device number to kdmflush workqueue name to help debugging CPU usage.

Resulting `ps axfu` snippet:

root        3791  0.0  0.0      0     0 ?        I<   paź19   0:00  \_ [kdmflush/253:7]
root        3792  0.0  0.0      0     0 ?        I<   paź19   0:00  \_ [kcryptd_io/253:7]
root        3793  0.0  0.0      0     0 ?        I<   paź19   0:00  \_ [kcryptd/253:7]
root        3794  0.0  0.0      0     0 ?        S    paź19   0:00  \_ [dmcrypt_write/253:7]
root        3814  0.0  0.0      0     0 ?        I<   paź19   0:00  \_ [kdmflush/253:8]
root        3815  0.0  0.0      0     0 ?        I<   paź19   0:00  \_ [kdmflush/253:9]
root        3816  0.0  0.0      0     0 ?        I<   paź19   0:00  \_ [kdmflush/253:10]

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/md/dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 76d9da49fda7..30830f737a9c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1800,7 +1800,7 @@ static struct mapped_device *alloc_dev(int minor)
 
 	format_dev_t(md->name, MKDEV(_major, minor));
 
-	md->wq = alloc_workqueue("kdmflush", WQ_MEM_RECLAIM, 0);
+	md->wq = alloc_workqueue("kdmflush/%s", WQ_MEM_RECLAIM, 0, md->name);
 	if (!md->wq)
 		goto bad;
 
-- 
2.30.2

