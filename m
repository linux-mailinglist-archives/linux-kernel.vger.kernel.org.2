Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9123236AEA6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 09:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhDZHp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233413AbhDZHj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:39:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87A42613BF;
        Mon, 26 Apr 2021 07:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619422646;
        bh=BHo8Y/q9N5KHhRNXIGOttEK+yJ1aSnqYGHabYwvl/Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPTKtDH+QJibs5B1T+UyUGPGF5QrdJH1EV0U+TrLqGJ+H18tHLN+TE6y9aEB3zeq0
         bb9/S8Y1m582R2GunvpKEGMgYb2HkIYHEsmlksbhTWSEFYbAQa5I0JzzSg2sPpnKdK
         w7eppEZNwBgNIH2d00izjFNGDZ9wENDA4uqMnWmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 49/57] HID: wacom: Assign boolean values to a bool variable
Date:   Mon, 26 Apr 2021 09:29:46 +0200
Message-Id: <20210426072822.233261105@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426072820.568997499@linuxfoundation.org>
References: <20210426072820.568997499@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

[ Upstream commit e29c62ffb008829dc8bcc0a2ec438adc25a8255e ]

Fix the following coccicheck warnings:

./drivers/hid/wacom_wac.c:2536:2-6: WARNING: Assignment of
0/1 to bool variable.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index db8ee5020d90..10524c93f8b6 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2496,7 +2496,7 @@ static void wacom_wac_finger_slot(struct wacom_wac *wacom_wac,
 	    !wacom_wac->shared->is_touch_on) {
 		if (!wacom_wac->shared->touch_down)
 			return;
-		prox = 0;
+		prox = false;
 	}
 
 	wacom_wac->hid_data.num_received++;
-- 
2.30.2



