Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652EA32A1EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347638AbhCBHId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:08:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:39032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577480AbhCBGW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:22:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6EBF7AC6F;
        Tue,  2 Mar 2021 06:22:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/44] MAINTAINERS: drop cyclades.com reference
Date:   Tue,  2 Mar 2021 07:21:32 +0100
Message-Id: <20210302062214.29627-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cyclades.com is a dead domain.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24abc010d177..7bfca0e2d5ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4885,7 +4885,6 @@ F:	include/uapi/linux/cyclades.h
 
 CYCLADES PC300 DRIVER
 S:	Orphan
-W:	http://www.cyclades.com/
 F:	drivers/net/wan/pc300*
 
 CYPRESS_FIRMWARE MEDIA DRIVER
-- 
2.30.1

