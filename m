Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5933D359A77
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhDIJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233409AbhDIJ5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:57:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62AED611BF;
        Fri,  9 Apr 2021 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617962221;
        bh=Mutaf/l//cjTnf5ww/mgqigexYN26XxY39BM9zOOWOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTspBqzuf3ASIdPMDXsM2qPHFx7b3I9TAi8yESiW97lGxQHBcBv+upE5+HI5dELiK
         j9r7kcGllbmpREUAE32EC/H5/eSvX0+FClNaXLamEEwVbeh4EDS/F5Ika03zNGO7LA
         HNsbBypO6gCSWQSsYc5dZq3GP1ZAG3aCKPtIlKcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 02/18] bus: ti-sysc: Fix warning on unbind if reset is not deasserted
Date:   Fri,  9 Apr 2021 11:53:30 +0200
Message-Id: <20210409095301.606177901@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210409095301.525783608@linuxfoundation.org>
References: <20210409095301.525783608@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit a7b5d7c4969aba8d1f04c29048906abaa71fb6a9 ]

We currently get thefollowing on driver unbind if a reset is configured
and asserted:

WARNING: CPU: 0 PID: 993 at drivers/reset/core.c:432 reset_control_assert
...
(reset_control_assert) from [<c0fecda8>] (sysc_remove+0x190/0x1e4)
(sysc_remove) from [<c0a2bb58>] (platform_remove+0x24/0x3c)
(platform_remove) from [<c0a292fc>] (__device_release_driver+0x154/0x214)
(__device_release_driver) from [<c0a2a210>] (device_driver_detach+0x3c/0x8c)
(device_driver_detach) from [<c0a27d64>] (unbind_store+0x60/0xd4)
(unbind_store) from [<c0546bec>] (kernfs_fop_write_iter+0x10c/0x1cc)

Let's fix it by checking the reset status.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 54c8c8644df2..b6a278183d82 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1814,7 +1814,9 @@ static int sysc_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	reset_control_assert(ddata->rsts);
+
+	if (!reset_control_status(ddata->rsts))
+		reset_control_assert(ddata->rsts);
 
 unprepare:
 	sysc_unprepare(ddata);
-- 
2.30.2



