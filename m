Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC5B37867E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbhEJLIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhEJKtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:49:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B98B6613D3;
        Mon, 10 May 2021 10:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620643089;
        bh=v7Y0wNr23gfihcKJRdFlfl9Db4iABnZHp/ley6aKNiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eRVa2aVbW25MMjX5r6I3qOiSJ/ZLphzBS4/fUbwRtim73Tw8/C7GxhSroICxOXzSp
         MfjzIFOjh3K+FUUJrojLEvbO3jtrLv6ImMDWFObQEaBmDVo4RfnuYlW5K7lkjSlPFR
         Fj0HubBPHwBg/AuYPwYY/uPpaQIlhXQnxhhDw7vU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 174/299] power: supply: generic-adc-battery: fix possible use-after-free in gab_remove()
Date:   Mon, 10 May 2021 12:19:31 +0200
Message-Id: <20210510102010.710547540@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510102004.821838356@linuxfoundation.org>
References: <20210510102004.821838356@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit b6cfa007b3b229771d9588970adb4ab3e0487f49 ]

This driver's remove path calls cancel_delayed_work(). However, that
function does not wait until the work function finishes. This means
that the callback function may still be running after the driver's
remove function has finished, which would result in a use-after-free.

Fix by calling cancel_delayed_work_sync(), which ensures that
the work is properly cancelled, no longer running, and unable
to re-schedule itself.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index caa829738ef7..58f09314741a 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -382,7 +382,7 @@ static int gab_remove(struct platform_device *pdev)
 	}
 
 	kfree(adc_bat->psy_desc.properties);
-	cancel_delayed_work(&adc_bat->bat_work);
+	cancel_delayed_work_sync(&adc_bat->bat_work);
 	return 0;
 }
 
-- 
2.30.2



