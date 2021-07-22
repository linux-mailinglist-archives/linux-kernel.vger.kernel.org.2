Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7518D3D1E71
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGVGEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 02:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhGVGEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:04:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4342861279;
        Thu, 22 Jul 2021 06:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626936312;
        bh=QZPSIRT4SwJ3SMiLa3Kb8FHpGIV3OH9hIS3qt2cTOhY=;
        h=From:To:Cc:Subject:Date:From;
        b=Msn8bbeE5oHcK8ySpA4CLcQfMrHtBhNOjmSEeBMHgcHn6gAkxCBi191+UHx6HlZKc
         uD00W/waW5FldMJdOwIFZhItGoNcABNg0sijLV7HQpYntzYqYBYb5ED1V7OT2xpNAT
         RlcyV0bTIHm48EbE7O1bzfVwzZsoI6vms2/84/0ENjeLY+/36dCGmJkgWoEREertQY
         M/MJwYYPLI3AQb9O6qMxpiKje82hOjHVz3q8/NOuuzJ761Cq868aq27tyoYynue8W2
         Mjj69ScRrDn7xN4u/hNmY5el2HjhuvJB4AW1q4aUKMCz068ZAz11RDJOMi4mnzciXd
         8Yvl28bi6D95g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH rdma-next] docs: Fix infiniband uverbs minor number
Date:   Thu, 22 Jul 2021 09:45:07 +0300
Message-Id: <a1213ef6064911aa3499322691bc465482818a3a.1626936170.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Starting from the introduction of infiniband subsystem, the uverbs
char devices started from 192 as a minor number, see 
commit bc38a6abdd5a ("[PATCH] IB uverbs: core implementation"), but
the documentation was slightly different.

This patch updates the admin guide documentation to reflect it.

Fixes: 9d85025b0418 ("docs-rst: create an user's manual book")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/admin-guide/devices.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 9c2be821c225..922c23bb4372 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2993,10 +2993,10 @@
 		65 = /dev/infiniband/issm1     Second InfiniBand IsSM device
 		  ...
 		127 = /dev/infiniband/issm63    63rd InfiniBand IsSM device
-		128 = /dev/infiniband/uverbs0   First InfiniBand verbs device
-		129 = /dev/infiniband/uverbs1   Second InfiniBand verbs device
+		192 = /dev/infiniband/uverbs0   First InfiniBand verbs device
+		193 = /dev/infiniband/uverbs1   Second InfiniBand verbs device
 		  ...
-		159 = /dev/infiniband/uverbs31  31st InfiniBand verbs device
+		223 = /dev/infiniband/uverbs31  31st InfiniBand verbs device
 
  232 char	Biometric Devices
 		0 = /dev/biometric/sensor0/fingerprint	first fingerprint sensor on first device
-- 
2.31.1

