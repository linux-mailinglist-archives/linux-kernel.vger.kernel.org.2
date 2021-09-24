Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98713417621
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbhIXNq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:46:59 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57705 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344509AbhIXNq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:46:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5A2EE3200E51;
        Fri, 24 Sep 2021 09:45:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 Sep 2021 09:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=0xALbrCxQCROpU5+x8EgRKlZBK
        WTfMALPXyRDOAxCr4=; b=VnuyIgvggL0YMShzDdbe8hSDD34m0SART0ebAL8UzT
        cg7z1n1sD9ccvlQSgsLSp65bK1KoWWQ2ijOWJ8zs3PGa4K684BkYSRzqnJxeuDSs
        ubC3cwdele7bR7wOEf4NIvcL/nVLs8uVGYVjDobrxK4nTI+Y+9NXWvevn/MNk1CL
        yOoWnv3TP6Bgb6h841immwEJrTBcDkXzyQH4Exmo1AYvQGfZgkWkmpanyMv43h91
        h5UWiPaydJr5S3Pls7Q2W7juWBOVj/h0L11sFef/aGxIV5Z1QHozupQjlGY6dw2y
        DAv74FRtIRIW6ZXOxtY5s524nKMfThrzYSiLrbFqP15w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0xALbrCxQCROpU5+x
        8EgRKlZBKWTfMALPXyRDOAxCr4=; b=nUfvGCN54DACYQaThUj9os043+JD9B7G/
        aNB63AWPJ8p/xP6nRgjzsoOxJWAKLm8D7718eh7UwFWKAEmcVuN68m3Qi5NHLKfp
        8F+P8PrKHCMbXmC3Lzlv6ITQpSnKEtzq90iXHFvO/Wcy35vml/LjSOck+7lhJ/Xm
        JmfKB0UQY4TqYXhPJKrB/WGiDA+4HRUlz0pZns0iQpf97oKaZ6w+xrotfAwrcsWf
        8S67hMmLa29KIe4nAYb8RPZ1JqS+7inneo0asusrB/mjqwm9FGWZIFv4ls1X1RJ0
        fba3kCi2uX2WYoA/Nd/1/TMvZbgX/yYe/tqkF1FmyNhVZjS6Q+N0w==
X-ME-Sender: <xms:c9ZNYdfQlQXL4uYZoplGvIY6zoo30dIF0V7lZ-9VDU2LyUV8_-JWPw>
    <xme:c9ZNYbMxlTrKtGJPrZmTSj7JWuN8K4VuYxs6O8mmdLnjL2UIqk-j5oPgqiIp3BvFr
    mAwbten_dB_aEOcpuM>
X-ME-Received: <xmr:c9ZNYWhTkf4XtSLODz1izmssfdZQSVMR58N_Xuvh4dk8K2qpZze8_fgJzncKsB0cxjy3On3czIwj3sY-3OnXpNIMIXJBrPJ8_6LyNFaX9KvRGZEgfn1p1rU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejuddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:c9ZNYW9fk00QsqHDbM_jfh7vp9WEfr9gvOcIb3x86JuYEkTlIaCZIQ>
    <xmx:c9ZNYZsgFegatREIOHxNwreBpcCKYfHSc0Jg0E2Zg-hqMYK2QwVPLA>
    <xmx:c9ZNYVHAFMbKT9LR98QKBqlqnP5WUsFLnim08br1LQcD9X118PkeLQ>
    <xmx:c9ZNYTLmV6RDBCM5KtPdi_Ho9DCo1SQ-R4wHSSjZzgKwJ1eoPyFXQg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Sep 2021 09:45:22 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/dart: Clear sid2group entry when a group is freed
Date:   Fri, 24 Sep 2021 15:45:02 +0200
Message-Id: <20210924134502.15589-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sid2groups keeps track of which stream id combinations belong to a
iommu_group to assign those correctly to devices.
When a iommu_group is freed a stale pointer will however remain in
sid2groups. This prevents devices with the same stream id combination
to ever be attached again (see below).
Fix that by creating a shadow copy of the stream id configuration
when a group is allocated for the first time and clear the sid2group
entry when that group is freed.

  # echo 1 >/sys/bus/pci/devices/0000\:03\:00.0/remove
  pci 0000:03:00.0: Removing from iommu group 1
  # echo 1 >/sys/bus/pci/rescan
  [...]
  pci 0000:03:00.0: BAR 0: assigned [mem 0x6a0000000-0x6a000ffff 64bit pref]
  pci 0000:03:00.0: BAR 2: assigned [mem 0x6a0010000-0x6a001ffff 64bit pref]
  pci 0000:03:00.0: BAR 6: assigned [mem 0x6c0100000-0x6c01007ff pref]
  tg3 0000:03:00.0: Failed to add to iommu group 1: -2
  [...]

Fixes: 46d1fb072e76b161 ("iommu/dart: Add DART iommu driver")
Reported-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 47ffe9e49abb..f82b2c46493a 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -636,16 +636,34 @@ static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return -EINVAL;
 }
 
+static DEFINE_MUTEX(apple_dart_groups_lock);
+
+static void apple_dart_release_group(void *iommu_data)
+{
+	int i, sid;
+	struct apple_dart_stream_map *stream_map;
+	struct apple_dart_master_cfg *group_master_cfg = iommu_data;
+
+	mutex_lock(&apple_dart_groups_lock);
+
+	for_each_stream_map(i, group_master_cfg, stream_map)
+		for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
+			stream_map->dart->sid2group[sid] = NULL;
+
+	kfree(iommu_data);
+	mutex_unlock(&apple_dart_groups_lock);
+}
+
 static struct iommu_group *apple_dart_device_group(struct device *dev)
 {
-	static DEFINE_MUTEX(lock);
 	int i, sid;
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct apple_dart_stream_map *stream_map;
+	struct apple_dart_master_cfg *group_master_cfg;
 	struct iommu_group *group = NULL;
 	struct iommu_group *res = ERR_PTR(-EINVAL);
 
-	mutex_lock(&lock);
+	mutex_lock(&apple_dart_groups_lock);
 
 	for_each_stream_map(i, cfg, stream_map) {
 		for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS) {
@@ -673,6 +691,20 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
 #endif
 		group = generic_device_group(dev);
 
+	res = ERR_PTR(-ENOMEM);
+	if (!group)
+		goto out;
+
+	group_master_cfg = kzalloc(sizeof(*group_master_cfg), GFP_KERNEL);
+	if (!group_master_cfg) {
+		iommu_group_put(group);
+		goto out;
+	}
+
+	memcpy(group_master_cfg, cfg, sizeof(*group_master_cfg));
+	iommu_group_set_iommudata(group, group_master_cfg,
+		apple_dart_release_group);
+
 	for_each_stream_map(i, cfg, stream_map)
 		for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
 			stream_map->dart->sid2group[sid] = group;
@@ -680,7 +712,7 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
 	res = group;
 
 out:
-	mutex_unlock(&lock);
+	mutex_unlock(&apple_dart_groups_lock);
 	return res;
 }
 
-- 
2.25.1

