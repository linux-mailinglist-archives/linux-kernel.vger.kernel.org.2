Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002E74195BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhI0OCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234708AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60AAA611C5;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=P91LSEK4AIStyHl5vuqjR4jtKLGpGSe6OXNnc/W3cas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBHOtpWnJctAwTlTpX5feGVf1hDNsrUghncyopFdA/vLGaWqyPrA0WInJI5CrzGrD
         HyWBhuTtT6u/bI8fyoWpG+twIHGgJYXLJj8ScB6sLr3ITTucjNLhFwHBasdDEGnER4
         /2Qsmrin8hhrvf+nyv3CTYBogahVoaAz83mtsj0iCVLsBWem7G8AObv17P0VFctIsf
         ULqXbAcIt0vZatbL3oZ7SgNwBirgrsEx67vTQFWWSMmM8ujuXHtZ5jEUWSxbG8uBvi
         c5I0NT+56rJF1ndHIn7ikbeVauLlf1agULIz8Zo8tYsLUVnbXisrJG9yZZbC2c2VKi
         MqXhcF/ZnddHw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000AuE-N6; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] ABI: sysfs-class-bdi: use What: to describe each property
Date:   Mon, 27 Sep 2021 15:59:44 +0200
Message-Id: <77e5904dfd275ed2670cd13779e5ef1da96e355c.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of listing all bdi entries inside the description, add
one entry for each, just like the remaining ABI files.

That allows get_abi.pl script to properly parse it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-class-bdi | 30 ++++++++++++++++-------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-bdi b/Documentation/ABI/testing/sysfs-class-bdi
index 5402bd74ba43..6d2a2fc189dd 100644
--- a/Documentation/ABI/testing/sysfs-class-bdi
+++ b/Documentation/ABI/testing/sysfs-class-bdi
@@ -23,14 +23,17 @@ default
 	The default backing dev, used for non-block device backed
 	filesystems which do not provide their own BDI.
 
-Files under /sys/class/bdi/<bdi>/
-
-read_ahead_kb (read-write)
-
+What:		/sys/class/bdi/<bdi>/read_ahead_kb
+Date:		January 2008
+Contact:	Peter Zijlstra <a.p.zijlstra@chello.nl>
+Description:
 	Size of the read-ahead window in kilobytes
 
-min_ratio (read-write)
-
+	(read-write)
+What:		/sys/class/bdi/<bdi>/min_ratio
+Date:		January 2008
+Contact:	Peter Zijlstra <a.p.zijlstra@chello.nl>
+Description:
 	Under normal circumstances each device is given a part of the
 	total write-back cache that relates to its current average
 	writeout speed in relation to the other devices.
@@ -39,8 +42,12 @@ min_ratio (read-write)
 	percentage of the write-back cache to a particular device.
 	For example, this is useful for providing a minimum QoS.
 
-max_ratio (read-write)
+	(read-write)
 
+What:		/sys/class/bdi/<bdi>/max_ratio
+Date:		January 2008
+Contact:	Peter Zijlstra <a.p.zijlstra@chello.nl>
+Description:
 	Allows limiting a particular device to use not more than the
 	given percentage of the write-back cache.  This is useful in
 	situations where we want to avoid one device taking all or
@@ -48,7 +55,12 @@ max_ratio (read-write)
 	mount that is prone to get stuck, or a FUSE mount which cannot
 	be trusted to play fair.
 
-stable_pages_required (read-only)
-
+	(read-write)
+What:		/sys/class/bdi/<bdi>/stable_pages_required
+Date:		January 2008
+Contact:	Peter Zijlstra <a.p.zijlstra@chello.nl>
+Description:
 	If set, the backing device requires that all pages comprising a write
 	request must not be changed until writeout is complete.
+
+	(read-only)
-- 
2.31.1

