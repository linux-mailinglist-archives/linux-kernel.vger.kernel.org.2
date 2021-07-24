Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DD3D478D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 14:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhGXLbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 07:31:53 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21348 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbhGXLbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 07:31:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1627128733; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IEByUCooav9mPLmqbmo/8t2xH5NNltXcSta7Ut3LW+6xEYi8uDfJceR9Um0fXHR+w/j2D/AVhZBDanq/P/TL0qtrbRonph+nnkNdBeURyebm2UFM4nu/7bzPtTlq27EmBRusNqLShUyUoE6VPM0nG/AqFeq7dov7PQKgU1NTaOc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1627128733; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vIjY2fpXV0SCCDz1yCqG7n2aKYPkuWYL6qrV1nbEmmg=; 
        b=lnBREQbvcRmAxZfvduVfX03omyFZScmnP1ppdbySxFWrdYtSu3xg+n2l8cFpu3gtOx/PfEmV0Jxl/zUKxdV+LCRX8gwO8HPyKsyLYAEThkUMd352qqwo53HRa3TjJZZYj1+TCd1h+DbBESPFqXZuBesv1sY/s9jimS4K2lbt/i8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1627128733;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=vIjY2fpXV0SCCDz1yCqG7n2aKYPkuWYL6qrV1nbEmmg=;
        b=weNTpLxhhDi19rWEHw3oCvre03W+YIRURG5M7GayGVGJ9q//QV8GKqkD71DN9nfs
        nl9VmZSjY3INaSRH9ccZiD/BW5VqPMmaKcWdlgs0fRybZ055Z7GI28Io74RdwzrBdNt
        0opvMMTu2gBp1RfQQJ0JAWFbtcm0iM1Q9TaRWTPU=
Received: from localhost.localdomain (106.51.107.3 [106.51.107.3]) by mx.zohomail.com
        with SMTPS id 1627128721398315.2124753449539; Sat, 24 Jul 2021 05:12:01 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v7 1/2] firmware_loader: use -ETIMEDOUT instead of -EAGAIN in fw_load_sysfs_fallback
Date:   Sat, 24 Jul 2021 17:41:33 +0530
Message-Id: <20210724121134.6364-2-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210724121134.6364-1-mail@anirudhrb.com>
References: <20210724121134.6364-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only motivation for using -EAGAIN in commit 0542ad88fbdd81bb
("firmware loader: Fix _request_firmware_load() return val for fw load
abort") was to distinguish the error from -ENOMEM, and so there is no
real reason in keeping it. -EAGAIN is typically used to tell the
userspace to try something again and in this case re-using the sysfs
loading interface cannot be retried when a timeout happens, so the
return value is also bogus.

-ETIMEDOUT is received when the wait times out and returning that
is much more telling of what the reason for the failure was. So, just
propagate that instead of returning -EAGAIN.

Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---
 drivers/base/firmware_loader/fallback.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 91899d185e31..1a48be0a030e 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -535,8 +535,6 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 	if (fw_state_is_aborted(fw_priv)) {
 		if (retval == -ERESTARTSYS)
 			retval = -EINTR;
-		else
-			retval = -EAGAIN;
 	} else if (fw_priv->is_paged_buf && !fw_priv->data)
 		retval = -ENOMEM;
 
-- 
2.26.2

