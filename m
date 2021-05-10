Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48D9378230
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhEJKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231767AbhEJK3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:29:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D6236162D;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=iD07uWr3/TQh5SB3/i848EuMN2Yc2jSQfN+v3rzXjSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4ROkBQpio5nmKNZEcOcRaf6CdymzprnI6NpAYShIMjxnYrGfaY/WMvNHHNXpvFnk
         6SF1ga+4lRAVYWzDIdF2czBayc5YppznCjCheOb4Q/hgnmdBblQAfW6OI0d6G/AQNk
         ZGRu4THcCuFCmbbGFwY4YHyWUeXm3A7h/s6nx2r9p61faZwJWUNUYlkDiyZRJ4Em9y
         4A55fToBtsUF2g+u7HeOZjgpEOK2gli7YszC/mIrlDDdubW/NBtpTn4SfC7gCM0llG
         w0b4xzofKuBejJIjr7686fFEgdrOoAhNE9efx4FddGA7I3tnFUwvrQFti1Xia0emFk
         UVL4Ts19JUfNg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38C-000UOu-Ol; Mon, 10 May 2021 12:27:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.li@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/53] docs: admin-guide: perf: imx-ddr.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:21 +0200
Message-Id: <cb60f060f312534e5210a4fc1532e4a9a6245c0c.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/perf/imx-ddr.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/perf/imx-ddr.rst b/Documentation/admin-guide/perf/imx-ddr.rst
index 90926d0fb8ec..269d0b564903 100644
--- a/Documentation/admin-guide/perf/imx-ddr.rst
+++ b/Documentation/admin-guide/perf/imx-ddr.rst
@@ -9,7 +9,7 @@ control register which causes a large number of PERF signals to be generated.
 
 Selection of the value for each counter is done via the config registers. There
 is one register for each counter. Counter 0 is special in that it always counts
-“time” and when expired causes a lock on itself and the other counters and an
+"time" and when expired causes a lock on itself and the other counters and an
 interrupt is raised. If any other counter overflows, it continues counting, and
 no interrupt is raised.
 
-- 
2.30.2

