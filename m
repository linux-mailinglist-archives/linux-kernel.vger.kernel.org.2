Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D40369FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 08:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbhDXGzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 02:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237227AbhDXGqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 02:46:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFF5E61959;
        Sat, 24 Apr 2021 06:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619246734;
        bh=CBbCf8lLczURo0R8ANC6iiJbxWCN1ESFz/X/hIdzJFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y22p7EEht89HqGCobieU0gYu8QJWechaRxocbE5Ovi/ewgoX/XGnd+ZJ+8CE4H8ES
         YYvfobCK80m2jgSB8ekwJ5H6jRO7l0+RbuqOJV+K3d/UAv9R8kkma0Ijp9NFRh1CAw
         Tx2Yv4XjEefQ4/TZ0yiwB1oG+kdisZu/llPL83OffHrV3+ECbNXr8yKTtjbe2zj2UV
         mC6v29p6F5rgXYvJ3qQgadSPH5px9q45cNcXh760oEVW7SH909WE15/n50ERnWpEzA
         po8TKK5ICwaN4BBkjcYGLKgUg71UM4bCiB6wnlugHGeEX+bNewM/DsJ1k1IqxHlxfM
         TjKFO3D9IA0mg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1laC2m-004JgE-Ch; Sat, 24 Apr 2021 08:45:32 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 52/78] media: i2c: ov9734: use pm_runtime_resume_and_get()
Date:   Sat, 24 Apr 2021 08:45:02 +0200
Message-Id: <0bfb7b72201ccfe443d90e4301ce2c24428610ca.1619191723.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619191723.git.mchehab+huawei@kernel.org>
References: <cover.1619191723.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
added pm_runtime_resume_and_get() in order to automatically handle
dev->power.usage_count decrement on errors.

Use the new API, in order to cleanup the error check logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/i2c/ov9734.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov9734.c b/drivers/media/i2c/ov9734.c
index b7309a551cae..ba156683c533 100644
--- a/drivers/media/i2c/ov9734.c
+++ b/drivers/media/i2c/ov9734.c
@@ -644,9 +644,8 @@ static int ov9734_set_stream(struct v4l2_subdev *sd, int enable)
 	}
 
 	if (enable) {
-		ret = pm_runtime_get_sync(&client->dev);
+		ret = pm_runtime_resume_and_get(&client->dev);
 		if (ret < 0) {
-			pm_runtime_put_noidle(&client->dev);
 			mutex_unlock(&ov9734->mutex);
 			return ret;
 		}
-- 
2.30.2

