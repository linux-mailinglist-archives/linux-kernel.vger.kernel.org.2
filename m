Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045BE389B12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhETB6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:58:41 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40947 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230148AbhETB6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:58:39 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D6E825C0100;
        Wed, 19 May 2021 21:57:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 19 May 2021 21:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=4vXhzPog5Hq6J2WjXtfPxmrVmg
        cr+QWujQxLvvNjAkI=; b=DdUZOQwhbNWXyG8+9enS3VN5uJabtxxlR5Ow4cqmh3
        nGABF0S0dTRbmafFRKwi05XGpDBe+LlVNJeGPKORnA/bo8MjQHwprehGyEq9r8vy
        dzDUMCupoGSkNjf6xha5ENNw4SgU9nkuX/3ejKU6FjYaTyI7D9fCAVmjKvF8KF8P
        UcIpszabiJwbEuWi0PMqIBY84y7W4XD+gBl/MRj19CjooNKvmZtNeAlcl2JmzU5D
        D623endwKDSoe2vxm9jULF+iN9W83N7CIkkxXexeYT4uWvMwuipItW5GJNXl2hnH
        zpNioZc6NgPYApSuMvSgFoMr8UXqhmyHUHF1tFIhT5Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4vXhzPog5Hq6J2WjX
        tfPxmrVmgcr+QWujQxLvvNjAkI=; b=mAb3vvv7RK8zpepBxqyeYwXusc1YU5PcX
        DbcnT1fULGJX8oykZu1mj0wa4twQrokHV7XppyW0IN6rWtcqWUKmZHpqUmD0zm7F
        SoBPFmtYGFwR12p87/vagaAZ3mL5B5T32rhMC9SZrGNy8p07SX//3e3Abn/DunOK
        YwrIljYOdljwTdBOxhSB6sCRRsFcTIqXeT2ZPOYYV3E4rzkWRZM44mfRxF0TCzO9
        5DkQBXL6wy/mhKSye5MawbsEc93hQ5sVVHK0yy27cAN4EIHc0BaMFC9IM8tZrqZf
        4v3AiqiSohxUAAsa9bvalQUVuL/6WAGMFHrp0hXxNYjn+/047kCkA==
X-ME-Sender: <xms:_cGlYMvNl6KRyP76dIWZL8w8w1LKuFAGfLmsHVc5wxV1yVPDuZkeZQ>
    <xme:_cGlYJcdoaZ_99PFAJoYnTxEn08Fs2frPzH4clQXBcE8MglhosDUo_thUE1sGZ7yN
    NZneNodln1tAoB5LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejtddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgvficu
    lfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrghtthgvrh
    hnpeekhfeiffejveefveehtdeiiefhfedvjeelvddvtdehffetudejtefhueeuleeftden
    ucfkphepvddtfedrheejrddvudehrdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:_cGlYHybw-PO72-DkqA_K55jZBW4oa8VS3Sg6cAzZ86TvmhQyw621A>
    <xmx:_cGlYPMHLtuBnWNUviYHMTrS-lnuKLQikuyT2gVul0OpXcVxU_-hJw>
    <xmx:_cGlYM94BfhUZ5aKskDV-HIcN7q76xbjAITQllmfAdE36GU3zux5zA>
    <xmx:_sGlYLlmBDnYI5MRF0Y6ADIZK-m_21I7KXTMUZViswwhtHVkh-uMWA>
Received: from mistburn.lan (203-57-215-8.dyn.iinet.net.au [203.57.215.8])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 19 May 2021 21:57:14 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-doc@vger.kernel.org
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, joe@perches.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] Documentation: checkpatch: Tweak BIT() macro include
Date:   Thu, 20 May 2021 11:27:04 +0930
Message-Id: <20210520015704.489737-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While include/linux/bitops.h brings in the BIT() macro, it was moved to
include/linux/bits.h in [1]. Since [1] BIT() has moved again into
include/vdso/bits.h via [2].

I think the move to the vDSO header can be considered a implementation
detail, so for now update the checkpatch documentation to recommend use
of include/linux/bits.h.

[1] commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file")
[2] commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")

Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/dev-tools/checkpatch.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index 51fed1bd72ec..59fcc9f627ea 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -472,7 +472,7 @@ Macros, Attributes and Symbols
 
   **BIT_MACRO**
     Defines like: 1 << <digit> could be BIT(digit).
-    The BIT() macro is defined in include/linux/bitops.h::
+    The BIT() macro is defined via include/linux/bits.h::
 
       #define BIT(nr)         (1UL << (nr))
 
-- 
2.30.2

