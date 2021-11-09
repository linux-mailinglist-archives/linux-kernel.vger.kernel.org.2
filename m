Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E0944A831
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 09:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243966AbhKIIO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 03:14:27 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52815 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235389AbhKIIOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:14:25 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A071A5C01FE;
        Tue,  9 Nov 2021 03:11:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 09 Nov 2021 03:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nakato.io; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ehBF5Wy69Bh/k
        ZkJ7uMIKe19bB8uwhbi/yToEkQuFGM=; b=EpINqzgd9hrt+Ss+BZ5cHFTjQISNo
        djS56qf80j18n50zDKGEVSQ8B4RctOiAGMB/bjmxTvafxxZoQkI9BDGE0zrToHZ4
        4zftXLfhrvE8njxmJL7oi1oE5uEzdeEEfF+TsJbF+w/kgwwKKerw/caJjwk0YHwK
        vrPkfcvfelAPcEIiEg1W/DpCgL7NMKf1JU8H0EE7/2xpolcwedP0/yT5DozV9ovM
        vzH9dgiXtFq8kDGzA9qveM8pZjr2M3OtNK5XnIaI0b3XfALLAp/i3reS2bMkqNag
        KYvA62hvI1yTJWRlZ/mrTgrNwX4kO5aUaPvsnw1MYQQ/EgfQtCJieTsQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ehBF5Wy69Bh/kZkJ7uMIKe19bB8uwhbi/yToEkQuFGM=; b=HLCkzNR6
        06opqwLsHnbYCSod2Ccg2uuXBi5glOZAgC9l1MDChXvEcYe/Z1RCn5fd8VVbXbsv
        Sh8pLqUbF4nmhJK0xmxk+fTV37QOERaiTPkhYT64/NQS3QNwLnznbOPrh+seQCoC
        2cwxPE9CF19dMqA7YIgKE6qb/grJKnBssWUv0YAVc4sLlG4QIU4lWSWJie5DiXGg
        PH6+UhwxVvDJHh/NX+gp16bfBsQYUHBuje+9RfiedyEViZU/f7As+0Uf8jjp2J+U
        lYw/vgPRctv7jTwKs9n3jpTDNaTsndvlu1km+laC/xCVjNDgzyxiIayUyQwQ7ilw
        KAT/QxwTloLS0A==
X-ME-Sender: <xms:Oy2KYQajpDA4RrFFbydCIJkmK89If72ibbxWHAtiHnjjMmcH2pMk8A>
    <xme:Oy2KYbbpDmbxmmEsbYmMvT_dd94DB8tKfAFFsVG8GFLfcZPWr4DxC0hZKM2CcDygo
    ym4kd_8NfkOnDYuig>
X-ME-Received: <xmr:Oy2KYa9eexmfsWokvzioJDQyPR2ceeAch_zRQCdaj-pZk3nIaNaFt-cqUNBWVzh5OvGJud8YBoqhAnBdcFpCOv5MPx4Czt_Wr8eucLyi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurggthhhi
    ucfmihhnghcuoehnrghkrghtohesnhgrkhgrthhordhioheqnecuggftrfgrthhtvghrnh
    epudeftefhteegkedtuedvteeihfetffduudeludekkedthfdtfeduieehjefghffhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgrkhgrth
    hosehnrghkrghtohdrihho
X-ME-Proxy: <xmx:Oy2KYar2zwDlBgih5gK-FqOTpD4UxvkY5bCOUe5HkjZEzo54LpOruQ>
    <xmx:Oy2KYbqGJD3SpfRUwBhvNZD3vaCmVRvC9WKcEt29b-Z1pDjpohHuVQ>
    <xmx:Oy2KYYQV99nP_4Wq7O2Z-0W_vfvz3cji7kj7Fd4dmE-SeJKLa5ZYmw>
    <xmx:Oy2KYXJNfiBDfFCr3crxv6ssDUB-XhYDwyn4eq1fe66dJZ16p6EMFQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Nov 2021 03:11:35 -0500 (EST)
From:   Sachi King <nakato@nakato.io>
To:     Chen Yu <yu.c.chen@intel.com>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sachi King <nakato@nakato.io>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/surface: surfacepro3_button: don't load on amd variant
Date:   Tue,  9 Nov 2021 19:11:25 +1100
Message-Id: <20211109081125.41410-2-nakato@nakato.io>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109081125.41410-1-nakato@nakato.io>
References: <20211109081125.41410-1-nakato@nakato.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD variant of the Surface Laptop report 0 for their OEM platform
revision.  The Surface devices that require the surfacepro3_button
driver do not have the _DSM that gets the OEM platform revision.  If the
method does not exist, load surfacepro3_button.

Fixes: 64dd243d7356 ("platform/x86: surfacepro3_button: Fix device check")
Co-developed-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Sachi King <nakato@nakato.io>
---
 drivers/platform/surface/surfacepro3_button.c | 30 ++++---------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
index 242fb690dcaf..30eea54dbb47 100644
--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -149,7 +149,8 @@ static int surface_button_resume(struct device *dev)
 /*
  * Surface Pro 4 and Surface Book 2 / Surface Pro 2017 use the same device
  * ID (MSHW0040) for the power/volume buttons. Make sure this is the right
- * device by checking for the _DSM method and OEM Platform Revision.
+ * device by checking for the _DSM method and OEM Platform Revision DSM
+ * function.
  *
  * Returns true if the driver should bind to this device, i.e. the device is
  * either MSWH0028 (Pro 3) or MSHW0040 on a Pro 4 or Book 1.
@@ -157,30 +158,11 @@ static int surface_button_resume(struct device *dev)
 static bool surface_button_check_MSHW0040(struct acpi_device *dev)
 {
 	acpi_handle handle = dev->handle;
-	union acpi_object *result;
-	u64 oem_platform_rev = 0;	// valid revisions are nonzero
-
-	// get OEM platform revision
-	result = acpi_evaluate_dsm_typed(handle, &MSHW0040_DSM_UUID,
-					 MSHW0040_DSM_REVISION,
-					 MSHW0040_DSM_GET_OMPR,
-					 NULL, ACPI_TYPE_INTEGER);
-
-	/*
-	 * If evaluating the _DSM fails, the method is not present. This means
-	 * that we have either MSHW0028 or MSHW0040 on Pro 4 or Book 1, so we
-	 * should use this driver. We use revision 0 indicating it is
-	 * unavailable.
-	 */
-
-	if (result) {
-		oem_platform_rev = result->integer.value;
-		ACPI_FREE(result);
-	}
-
-	dev_dbg(&dev->dev, "OEM Platform Revision %llu\n", oem_platform_rev);
 
-	return oem_platform_rev == 0;
+	// make sure that OEM platform revision DSM call does not exist
+	return !acpi_check_dsm(handle, &MSHW0040_DSM_UUID,
+			       MSHW0040_DSM_REVISION,
+			       BIT(MSHW0040_DSM_GET_OMPR));
 }
 
 
-- 
2.33.0

