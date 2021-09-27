Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B411D4192E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhI0LNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233977AbhI0LMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:12:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 595DF611C2;
        Mon, 27 Sep 2021 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632741062;
        bh=9Jhi1X4iDKTpehtp5V1cElC47HVCmJWVqH3LiRVZlmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jX/meZEXmiNoSr4hoPlkylQ6W1c2e3fiJYK+dX2gtpjvAE+Uk2BujdKEEamF5S0+K
         d8xhVj3VWRKWag0+5B96LslaWnx6zCpfeCgi0O+ZIrp8noF9kN/5rk6tfYnXqeVoTM
         RGXzMPrpM5GCRfFfTnsw65r9iC7vWMXZv0/UUVnNSRTdCG3nBI/ISPwPFzvq4FFiBg
         D78MUH/ubnkWuPg1fUu9Vk95iGPen1H6sryU+u7uGFU8/3vd5gMkls7NwHSuFKAi/S
         1RF3IyQdMnYXHC/+ccuqFDNoGAYOjdd4fkQAd++OpkPZDu6ox6wQADbhDPOURi3hIe
         UNzVf1BltM9ZA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUoXE-0005yG-BI; Mon, 27 Sep 2021 13:11:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] ABI: sysfs-platform-dptf: Add tables markup to a table
Date:   Mon, 27 Sep 2021 13:10:52 +0200
Message-Id: <41b5bbac8a67a8c5bc1d3f84de38824e705dea5d.1632740376.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632740376.git.mchehab+huawei@kernel.org>
References: <cover.1632740376.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solve those warnings:
	Documentation/ABI/testing/sysfs-platform-dptf:130: WARNING: Unexpected indentation.
	Documentation/ABI/testing/sysfs-platform-dptf:130: WARNING: Block quote ends without a blank line; unexpected unindent.
	Documentation/ABI/testing/sysfs-platform-dptf:130: WARNING: Definition list ends without a blank line; unexpected unindent.

Fixes: 668ce99e4ed4 ("ACPI: DPTF: Additional sysfs attributes for power participant driver")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/7] at: https://lore.kernel.org/all/cover.1632740376.git.mchehab+huawei@kernel.org/T/#t

 Documentation/ABI/testing/sysfs-platform-dptf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
index 53c6b1000320..620fd20434a5 100644
--- a/Documentation/ABI/testing/sysfs-platform-dptf
+++ b/Documentation/ABI/testing/sysfs-platform-dptf
@@ -133,7 +133,10 @@ Contact:	linux-acpi@vger.kernel.org
 Description:
 		(RO) Presents SSC (spread spectrum clock) information for EMI
 		(Electro magnetic interference) control. This is a bit mask.
+
+		=======	==========================================
 		Bits	Description
+		=======	==========================================
 		[7:0]	Sets clock spectrum spread percentage:
 			0x00=0.2% , 0x3F=10%
 			1 LSB = 0.1% increase in spread (for
@@ -151,3 +154,4 @@ Description:
 		[10]	0: No white noise. 1: Add white noise
 			to spread waveform
 		[11]	When 1, future writes are ignored.
+		=======	==========================================
-- 
2.31.1

