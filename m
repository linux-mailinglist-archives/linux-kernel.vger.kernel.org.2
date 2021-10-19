Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29C8433C06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhJSQZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:25:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56253 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231495AbhJSQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:25:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 526685C010E;
        Tue, 19 Oct 2021 12:23:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 19 Oct 2021 12:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=tmiWcW1U2H7HD7ZqjARSJDD89e
        tBKl7zqS3q5UFeQW8=; b=GgSDP4yzzqrXdJCTO3IzT6b+dw0FWxdVZj7vubJw9v
        ygV8QvgwBr/TFHrxKbsGEBdhVw6ZwlY79LFjRR7r+i91PSrcMTBlK0k1eZneE3VK
        mtS+ey16k63aTAnLEFnl6SxRREBruq4whCOUOQcB/6slYJHyBkVHapMjwnj/AHI8
        pKI8RGsT10X66hn1l02wxZ3TTHzw4VkMwqlhB97WEtD4Od0B0gA80mis6DkRUDGx
        zJVSdJZBlCgpgOpgDK9rIISzv1J9rYRAgVtaebpKrR7RxxtKPIgEoOh0WfVoj1rf
        TldFo+P1vL6Fo0hfB7eg8gJXb8IELv0gmq6DnaQfiDwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tmiWcW
        1U2H7HD7ZqjARSJDD89etBKl7zqS3q5UFeQW8=; b=EACkSxiEcdtJsunW1aiL4t
        1uKch5SVjndL8BY1nXBJKjF2p01rm02vLBoXFZONla9v2OWuXd+Br3gTUqRDd4fM
        REuyv8E0fZxyQ0eKKBwowK5Yzu8pygIORlTf7eSR16K5y/cnziebBqJKcwkdCZSm
        hNkzQuVj3eClI3FpLo6QRGjcP3vDxiWIJ7FsstVGNRDOa2vbRVxFIttjPt5vGXyl
        ZUpQgW6NxTnG9s8oMf78k3h+HbWuXSe6+E730QYEs4Yp/vdxT7rNuqmTezNLZwSR
        L6uf0LEG2WVAUzLkINAo1FuJ99uMoWxIeCT3NLDQF58vilk4EeIZofoQYwXu0Qtg
        ==
X-ME-Sender: <xms:CPFuYez-x0h7JmJyfNRvnugKRkj58IiDPanAh8f8O30-PCwAiUVOjw>
    <xme:CPFuYaSutZ0mcq7JlVgVVjWwE6pzioOxihRm5vx7ye0ziCdY9Umt2hAaUI06Dc-dd
    usk7CapvZCAdE8AVJI>
X-ME-Received: <xmr:CPFuYQUM04-ztrYu-Ne0HQxVKI8UeCvcI6-ynmrCqn1eKQN7_KlYTpugcy9cpZjhH3bhkX15V7tMlKJkEXfGoooEZOLOII6AjyjlEZcvUopfbMkJTueuaSU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeduheehieetkeejfffggfelkeeivdefvdeuvdeihedvveekvdetgfejieeikefhieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:CPFuYUgIKIm4bP8Mmw67iKaBcTpYQw2DYbg2R8c30CHVXD9CzS07Ag>
    <xmx:CPFuYQD7H6wejsKieYgASxV_MB4AqMyfHSZYUwE5EoySKfK0OesJAw>
    <xmx:CPFuYVJ7BurBPjwyU_JF690ga4nBzO6LiaqYkedFmPqrVixyi3LJ4w>
    <xmx:CvFuYS33IrnCmcVFoCmCnvQ1h1gXM2kymW5SGyke5zPplgwkuIG9YQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:23:35 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik@protonmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/dart: Initialize DART_STREAMS_ENABLE
Date:   Tue, 19 Oct 2021 18:22:53 +0200
Message-Id: <20211019162253.45919-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DART has an additional global register to control which streams are
isolated. This register is a bit redundant since DART_TCR can already
be used to control isolation and is usually initialized to DART_STREAM_ALL
by the time we get control. Some DARTs (namely the one used for the audio
controller) however have some streams disabled initially. Make sure those
work by initializing DART_STREAMS_ENABLE during reset.

Reported-by: Martin Povišer <povik@protonmail.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---

While this could technically count as a fix I don't think it needs to go to
5.15 since no driver that requires this is in there. The first driver
that needs this will likely only be ready for the 5.17 merge window.

 drivers/iommu/apple-dart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index ce92195db638..6f8c240d8d40 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -70,6 +70,8 @@
 #define DART_ERROR_ADDR_HI 0x54
 #define DART_ERROR_ADDR_LO 0x50
 
+#define DART_STREAMS_ENABLE 0xfc
+
 #define DART_TCR(sid) (0x100 + 4 * (sid))
 #define DART_TCR_TRANSLATE_ENABLE BIT(7)
 #define DART_TCR_BYPASS0_ENABLE BIT(8)
@@ -299,6 +301,9 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
 	apple_dart_hw_disable_dma(&stream_map);
 	apple_dart_hw_clear_all_ttbrs(&stream_map);
 
+	/* enable all streams globally since TCR is used to control isolation */
+	writel(DART_STREAM_ALL, dart->regs + DART_STREAMS_ENABLE);
+
 	/* clear any pending errors before the interrupt is unmasked */
 	writel(readl(dart->regs + DART_ERROR), dart->regs + DART_ERROR);
 
-- 
2.25.1

