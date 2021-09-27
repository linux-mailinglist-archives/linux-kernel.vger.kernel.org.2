Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E47F4195A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhI0OBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234585AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A0E060F4F;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=F50MTT/rxZsuxDTh38T2DApPUX2Yj+mr2Gkz9vZYxyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqahauUDxz7X7KHPhQASrwcVL8JOQd0bfUI57OaQ19E80FOEfWgsN8uYbUAMHL2Ix
         +cZA6j00/8drQnsWhalJ4BGnSi1VQJ7+HKu8yG2z09N1sRsz/CQjs+aFQb2N4Bij/l
         YBruzGEo7/nVJ9Uxe7BMveaMvRTsNwKMQ7+zAq9Tlt+ydx5KEdgF3diqgEJ/GEepdo
         hldUsqxc+DZlZ9BicH4keNVtWfcfJIu6SG3XTt9EZ1L8ptrwutc5QkX4BBAOMZceoU
         0rvVIFlDO2Nwb0AOdtlQVgc0J53jPjrYCiwGUgsZ3WcZO8NGRRXWqmNfbL1KctxIgF
         C0tV0TUCfM9PA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000Au2-IH; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Christoph Lameter <cl@linux.com>,
        David Windsor <dave@nullcore.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] ABI: sysfs-kernel-slab: Document some stats
Date:   Mon, 27 Sep 2021 15:59:41 +0200
Message-Id: <8960435734c5aa918568ce7891171448c4d68709.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document three slab stats that were added in 2011 and 2017.

Fixes: 49e2258586b4 ("slub: per cpu cache for partial pages")
Fixes: 8eb8284b4129 ("usercopy: Prepare for usercopy whitelisting")

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-kernel-slab | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
index 77e5840b00a5..c440f4946e12 100644
--- a/Documentation/ABI/testing/sysfs-kernel-slab
+++ b/Documentation/ABI/testing/sysfs-kernel-slab
@@ -496,3 +496,24 @@ Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
 Description:
 		Writing to the validate file causes SLUB to traverse all of its
 		cache's objects and check the validity of metadata.
+
+What:		/sys/kernel/slab/<cache>/usersize
+Date:		Jun 2017
+Contact:	David Windsor <dave@nullcore.net>
+Description:
+		The usersize file is read-only and contains the usercopy
+		region size.
+
+What:		/sys/kernel/slab/<cache>/slabs_cpu_partial
+Date:		Aug 2011
+Contact:	Christoph Lameter <cl@linux.com>
+Description:
+		This read-only file shows the number of partialli allocated
+		frozen slabs.
+
+What:		/sys/kernel/slab/<cache>/cpu_partial
+Date:		Aug 2011
+Contact:	Christoph Lameter <cl@linux.com>
+Description:
+		This read-only file shows the number of per cpu partial
+		pages to keep around.
-- 
2.31.1

