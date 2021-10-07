Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB29424CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 07:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbhJGFhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 01:37:20 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:59593 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhJGFhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 01:37:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 818333201805;
        Thu,  7 Oct 2021 01:35:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Oct 2021 01:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=mNDEvjZ5miiO4QhZEitKq1COfb
        fTTaSgIQ/hDpA879w=; b=Xn/xmmbj/CYFMXHexKfWNWg55HBPhQZWUS4wqD2hFB
        oQQ7UOQ+c+EO5+3BDu8nCpMjc3usA/ts5xki1rsCLoiq04NNtwnMBhAMWHX2/s4P
        Yj9nyt2ezYlxKb0vVjA/Up7C9HY9/XVj+jyTAMBsRgmnYyT7SAknWxSDjB9+7a8L
        WESs7gTjjSfzd95VOoGecYmAcEPtm+X+g2wm3psnZeyQS4k9BUqSeUk+B0a/iPA2
        Dm1gge78v3AgDYhxVFFsxbZ/s3C73WOkINwJyb01MYO88lz75U+01pGA3BGjl+aI
        qTAHcvOTS5Vy4toHpNDfOQg5aTz/q3SsYrhA8RFFA0DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mNDEvjZ5miiO4QhZE
        itKq1COfbfTTaSgIQ/hDpA879w=; b=Tw6jWD3yAT0mx4HbY7t+RD0k4y2ckD1f5
        XDSEabvRAYxCzd5Nm/zjNfLMKnvGIGd5f6aopXbM2f+4cDk1cyvUcLPLTphqYCa2
        vHnJ8ZY0RjBeEwe+TWrl2rzY5XZOo09Z+eFz7JeiXnztHhQAxipWF+fnc5AXltM4
        soQYsDDQFJr4cZGPz0daIlfJG+LuDl7KrkzC4bHFGejaUHJh1K4ngPIARG1XRCwN
        CB9SS342etB6g5RC9wOlwxCj4lOXx9H4Syr/e7j+abiDw+quz9HY5AIQUm7cMdrF
        DzzbVV4oYGZDdhOlA4nzb3dfJuXnAXKEC+fICB+izNSZfuU+RLSdQ==
X-ME-Sender: <xms:F4deYYkrcILycUKkJeQ5JPyH44QVtLRXntnB2ko-ii6gqZpOjbgA8A>
    <xme:F4deYX27IYkG0szKqVw0GSDtcbLVRwT4FKHAj6dt05WWWmLNyhfPjCgtO5HeD64JU
    VDkPs5cSw0N-pxGpUE>
X-ME-Received: <xmr:F4deYWp6a-atwFTGZDUCnDcYqO7qVjqsQbcgd8sDS2NQzYGj3IwNr1iP3-5w-fmYp1aDsyftABr5ZiKAtemcwrXerg6gZXH5yrx8-_LHApWI0a-9-AWRmj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeljedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghr
    rdguvghvqeenucggtffrrghtthgvrhhnpeejleegfeejheekieevueevteevgfdvjeelhe
    ehkeefheelheejhfdtffejudevtdenucffohhmrghinheprghsrghhihhlihhnuhigrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:F4deYUnHWba8mEtslPB-Pt1fYfsyo6Jne4nhFaKngkW4qfhLwKOe5w>
    <xmx:F4deYW001Y72qZvdlADW08jspncYrU5P0FTUu-fPadmtDZK1Zbsa9g>
    <xmx:F4deYbvcQ7mZOvTZvjcPE6Hx-xHRFaCutMREVG2o4SGHCXjG2fBqRw>
    <xmx:GIdeYUCCl9gmBNfLZd7xkUwdO59svjDoU_FfAkWcH4I_TjPMxiQo1Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Oct 2021 01:35:18 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add myself to ARM/APPLE MACHINE
Date:   Thu,  7 Oct 2021 07:34:30 +0200
Message-Id: <20211007053430.51319-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hector suggested I should add myself to help him maintain the
platform.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 329d3a0a9fdb..448e82566d63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1727,6 +1727,7 @@ F:	drivers/*/*alpine*
 
 ARM/APPLE MACHINE SUPPORT
 M:	Hector Martin <marcan@marcan.st>
+M:	Sven Peter <sven@svenpeter.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	https://asahilinux.org
-- 
2.25.1

