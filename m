Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201F338A2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhETJn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:43:58 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54705 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233418AbhETJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:41:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 62A861AA7;
        Thu, 20 May 2021 05:40:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 20 May 2021 05:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=x2k0UiONZCObGpvODgZnHAg9eN
        EhLhqxabKrZsSDvjI=; b=slOL6qNSXs7we0zun5eCgQqDc4sDuaCxRsZDYeo4zh
        nvEfSxtYRo8mE/7Mgvb3uO4GLFSNk7rvmUuqsKj5XHpUg5LQ9B3Zy/Q1ZwVh5NZX
        NYNagULLZMVlQALqNZlxfHXcJex7KnQpkf921f9SlfQdXsxp+UUKHflC34C2MUJy
        ytnwBjdOoMVlCMaSXkTCTfZ8S5WkG+ViuDVCa9rIwwq36TRcnkLZ7GylXmZVDiEh
        8Qw40I3vtyLd2usEU5n8Ctfw576Uc1SfaeylFrcsdJtC5ycPrmFghhS1ejPVLVSG
        0qa9aL5ZTxOJLzRGovh55IHZH4odDYrSBMxLfaEEk2GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=x2k0UiONZCObGpvOD
        gZnHAg9eNEhLhqxabKrZsSDvjI=; b=IyGn/yUXBB4Bpz5cZSmPcI0f41zN6l8Nv
        URV5aWiFPa62Qk+CbttH+aVLnE0BJAtPXcbSppwFOfoPQ9ancllnaQsj5GO5gow3
        gFo0wEjnAx4oYv4YxRILCteMksdHyFG2Irf+IGwhr0lMD3sMa0Evt1u2mJkrJCWT
        oiHTH1NTDgM6EIbPeejn9M0DfeEqbYhnVASN66cYcbfbd0cpwc1q7DHtLlziLhQ1
        5C3AoRHQ8RZ98sT3EP0essqX1/2uxlCa/1+4cWqvkS7YMt7nacFYS842vDpcAyKY
        nJDr2gjDnXU4WWQ/v4Bqg1+K7/0LCvCat5ldj1KNZdlyqoox+0CkQ==
X-ME-Sender: <xms:cS6mYJ-olAe6v6nJ4uwn54DypilDqwyK4EsBKn_N5QHCrnKiimlCDA>
    <xme:cS6mYNvBVGZSri_6I2cEsad90RWtLHP3OvFtFs2JKXsZ-EHwm1xJQcG4ACsBf9diW
    hY4MLLYFhR9TKb5kQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejuddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgvficu
    lfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrghtthgvrh
    hnpeekhfeiffejveefveehtdeiiefhfedvjeelvddvtdehffetudejtefhueeuleeftden
    ucfkphepvddtfedrheejrddvudehrdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:cS6mYHCkhU8hukniFB3POLltZobtA5dPgKJ37BZiVWsyYViGcncrMQ>
    <xmx:cS6mYNcPx-nyCX9Fj2gdy4oFkhmCTAT_tD4zWZapYScaXhtvlkRbmw>
    <xmx:cS6mYOOsdKq-TgDmKbz9socMfMElcSZNPMt4oZyTm3Z8cCis6b26Iw>
    <xmx:ci6mYF0pmPR4exQRE7ng3ZtaMVj1MksP-UtC9jFYBYDouVFmli1krQ>
Received: from mistburn.lan (203-57-215-8.dyn.iinet.net.au [203.57.215.8])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 20 May 2021 05:39:58 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-doc@vger.kernel.org
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, joe@perches.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2] Documentation: checkpatch: Tweak BIT() macro include
Date:   Thu, 20 May 2021 19:09:49 +0930
Message-Id: <20210520093949.511471-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While include/linux/bitops.h brings in the BIT() macro, it was moved to
include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
Move some macros from <linux/bitops.h> to a new <linux/bits.h> file").

Since that commit BIT() has moved again into include/vdso/bits.h via
commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").

I think the move to the vDSO header can be considered an implementation
detail, so for now update the checkpatch documentation to recommend use
of include/linux/bits.h.

Cc: Jiri Slaby <jirislaby@kernel.org>
Acked-by: Jiri Slaby <jirislaby@kernel.org>
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

