Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BAB454F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhKQVSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:18:44 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:58419 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232172AbhKQVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:18:25 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id AEBA55806CC;
        Wed, 17 Nov 2021 16:15:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 17 Nov 2021 16:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=rDJmmzVKF8xgYuniWddaY4KG6e
        sEwkL+aJ6zJYHAFWM=; b=UJMItec/TlKbyg/Whl5WDkHIh9rMWnpzxMWgb2+J4n
        SlsxUz4WWwIF3wRG6RVkwOMrUmeffwyLrynIOcEgkzHouz1ITe4BzmttLM1xT0c3
        OrxKrlNv25+4ynyGi2e5Sw+fko+9X8laH1TDFDcAMQGxzS5p+Ytf8I1aCskNt0B9
        WqjvJhOuL8Mz1hWbYuDyZjTJU9p2VtC+60UXgweMQUNvwOk+mWWQ7U68dS0UwKtj
        05T7DmSLoiw3y+zzQXMVdxD5nrxf91J1BGocD8p8rMsGOHxJJIpKuBcyzDUXi7ir
        3TPTRjBFhqzKD1J71/XEkT6qAOQz9VJ6eVzdOzlUaowg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rDJmmzVKF8xgYuniW
        ddaY4KG6esEwkL+aJ6zJYHAFWM=; b=V4ZRFYTOs8f8/cNkvBdYERMmRvrGypksj
        kxaBFJDI+i7k4aXbH3vzgaXZjVlgtkMUFN5uLDndjxnZU/HEKOZlxXE2EFegvIZN
        DDQO0CAdsKLItUlHY0b7hGHyOPf9mu1dn9hV0uQ/aSyDms2pZFLQDozBImwAbcZt
        25r75XTtAlNZEP9nMD1ftMVBpNGk7odZ9Cf/BlrYCz1opxl27eZz+g/fevV9FPQf
        4Oq2tyC9r5cDDie0CCgmkusHjr1cgtPjYDKOoAeq2OZqqeRPxT0ouwZxSHanUcjf
        8mAgwLRLMo6fBKwkMVwlJVXu6KXTbWq5G6ttytbgz1ZqWyfwkhEHg==
X-ME-Sender: <xms:7HCVYcuDbdUVTi9gIpm9GUil_VFisDtWxUtozlREtr-5Ac8s4WxcyQ>
    <xme:7HCVYZebIxWzdBaQR9xeKvxgcADmbGYBLMjsAxWGMUfxcaUcuIZ9hNhn-VgEOM0Bx
    yVHRiIJufnO5rlhyC8>
X-ME-Received: <xmr:7HCVYXxBh1ZXu515jKoaCnBfoqWAccalLbBMvFyEbR_hSWxp1nk3fg2ICc8lAuSEFwpteDOf5vnJbfTJlf4dexOSul6hZqgL3xHx2eFas67vcPjmRedCpNqrdLyd3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epfeehudeftddvhfehvdduhedtjeejheeuudfftdfgvdekvdelleeuveelgfeflefgnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:7HCVYfO1n4fSJz0zYGXvuHeMoycQqLmNHerqF8Ztmyq595UNwodSyw>
    <xmx:7HCVYc-OwO5NCUE0bVblKpfRreeD9-yxh7OWSUt1LfiU4RVSp991aw>
    <xmx:7HCVYXVkBVJuZBRqWRpxChZc8YiB9oqZB3a5PQf-QoRxKptBid4b9A>
    <xmx:7XCVYd1yNAaGYXtUGoSuOxYNwhVg6Rot3ZtLdFbbe3JK5b8ffc3Gmg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 16:15:22 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     iommu@lists.linux-foundation.org
Cc:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Janne Grunau <j@jannau.net>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <robin.murphy@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] iommu: M1 Pro/Max DART support
Date:   Wed, 17 Nov 2021 22:15:05 +0100
Message-Id: <20211117211509.28066-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a fairly brief series to add support for the DARTs present in the
M1 Pro/Max. They have two differences that make them incompatible with
those in the M1:

  - the physical addresses are shifted left by 4 bits and and have 2 more
    bits inside the PTE entries
  - the subpage protection feature is now mandatory. For Linux we can
    just configure it to always allow access to the entire page.

Note that this needs a fix to the core pagetable code. Hector already
sent a first version separately to the mailing list since the problem
is (at least in theory) also present on other SoCs using the LPAE format
with a large physical address space [1].

Sven

[1] https://lore.kernel.org/linux-iommu/a2b45243-7e0a-a2ac-4e14-5256a3e7abb4@arm.com/T/#t

Sven Peter (4):
  dt-bindings: iommu: dart: add t6000 compatible
  iommu/io-pgtable: Add DART subpage protection support
  iommu/io-pgtable: Add DART PTE support for t6000
  iommu: dart: Support t6000 variant

 .../devicetree/bindings/iommu/apple,dart.yaml |  4 +-
 drivers/iommu/apple-dart.c                    | 19 ++++++++-
 drivers/iommu/io-pgtable-arm.c                | 40 ++++++++++++++++++-
 include/linux/io-pgtable.h                    |  2 +
 4 files changed, 61 insertions(+), 4 deletions(-)

-- 
2.25.1

