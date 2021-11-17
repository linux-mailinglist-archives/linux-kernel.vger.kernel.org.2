Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95552454F30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhKQVSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:18:45 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56117 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232585AbhKQVS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:18:27 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B07525806CF;
        Wed, 17 Nov 2021 16:15:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 17 Nov 2021 16:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=6Npdq0g1uutbB
        Z9rJk6TgIsiQnFffMQoa5oYcoXUq4Y=; b=loVGdIYH0RXWcIuL8+DFCdvcL9Ytu
        kWFWTopXKNdJwlCN/9vvounhYbXmDHlKshsvxcS3pQ10iR5efqy/iuyURjo3HbSu
        4/4SQA0LczuBpstNXuC3CHtrJ70seY9rwlWOChyyrei2QZNjr7kzALasLowXDBZP
        iPUw58yiB/34vgvOF3POlYHyEnYxkxwte5vq4RQ90sMCMbxv+llWwIUwKxq+lBok
        M5oDHiVgXmn58Td1y4f7CjdJEO+B/TAlsXpunyBOVspfxrOnaxvMyYO2wBsnwdlF
        vmFH/aWqx2YQC4bPfe1ZNV+JlvOiG/zSxtDygbI9sEhS+Zg9LyienDRmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=6Npdq0g1uutbBZ9rJk6TgIsiQnFffMQoa5oYcoXUq4Y=; b=c62a+hD0
        5cXn2bSqK3hK3xmvXKk4kGZ7PJOjNjACG0KRQhN5zRSElF82P63Jsfe8gt0BUb58
        S4RAmgchW6JQAIfB8zWZsbLC8sVDWT1BlHgpjdgeZXXQPXKkgPMKax5tTN5Heelp
        8NP6vsGPsFPQ8QoQxrUUqeXctcpOujmam362wdDnBXUXaJpKUMpzVcc3zFyXUKxU
        91FfQZZSaebV2KMbEvYHamZ/SlE4fO3pkLp6b3s3eowEgequODNdbCp83lpuMOid
        xy8WysYbfjC4lJP+o3a3kaxdKEeCHrPLCNFg5tqsAP7+vYPh/FckxuDq0RjRqtHa
        OsrwtKlR+I+vRg==
X-ME-Sender: <xms:73CVYa9hRUdz8YCAp5B69Ok-hOEi6s0cTiQtTGgYBfFsz8XrMOIAog>
    <xme:73CVYavtl8UcmR_4lL8OR0YvO_PMuJuct-NsxTHoFFf1gYu0g6Q_VP1UX5ZzkInLa
    qQVZju6ozYtIUI31S0>
X-ME-Received: <xmr:73CVYQAsPPxsYMSfvVW3PGZySsYLSA7rt5_0j9lAMJ07CVCOaNyoQE7f7hZWN3zrCPG3fuQYNDhLEWwRDXXDRdPl7HJeJh7-MbC2puONYrXQV2zehcdZsZ0xfhkhKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:73CVYScoCkox3JemQOqxYIHk01ZYFyTCFejmk2KqUkUgGpPnxsEXBg>
    <xmx:73CVYfPmnbhcDr_g690PZvwP6GKr0uotMBqNus21vQKpdROd3Xa4gA>
    <xmx:73CVYclDpJvFQ5K871bPZWXFOChOR1CFcrFqgMSEneyNiFUFE6R-4g>
    <xmx:73CVYQEcaHLnYp3fyz8bRYGITHIRv_Fqp_lOYdF3lkAel3-ET95Z7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 16:15:25 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Janne Grunau <j@jannau.net>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <robin.murphy@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: iommu: dart: add t6000 compatible
Date:   Wed, 17 Nov 2021 22:15:06 +0100
Message-Id: <20211117211509.28066-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211117211509.28066-1-sven@svenpeter.dev>
References: <20211117211509.28066-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The M1 Max/Pro SoCs come with a new DART variant that is incompatible with
the previous one. Add a new compatible for those.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 94aa9e9afa59..ca2cbde9f3c9 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -22,7 +22,9 @@ description: |+
 
 properties:
   compatible:
-    const: apple,t8103-dart
+    enum:
+      - apple,t8103-dart
+      - apple,t6000-dart
 
   reg:
     maxItems: 1
-- 
2.25.1

