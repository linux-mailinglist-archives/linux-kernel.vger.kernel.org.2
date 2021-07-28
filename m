Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529F13D8A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhG1Ivq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:51:46 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21399 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhG1Ivo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:51:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1627462300; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=etyTHkf6ruUhF+bcxVT9Q9jyciX7h3wwPJnmEliaxL4iimLU25NWtkQkzCc0/MOvY+VxC3Ua7ka3UBuzPV8ykp6LF5NFIshefqYAqRQo7XvG0r6MBuNVq51nBwU3jyRy7AZFum004jcPL3rk7qN5M8CGnZPU/plTIR0Hkxa0VQ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1627462300; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ZcFwrVmA+7WMk1YyBYuw9PdFVUVusynLo8gvPJM70uc=; 
        b=L6SFJ8pnvhfxfyWWQZe2n/eZRTd5xBIvL3oFVrQ++EKLB358As/jfIO+PMUEvEC8Yn4zEQeWYaojlCkFnxTeK4BOGK1l5rbp76+v93lbL/OO92AGp91ZW7+lFAfFcCU5uBjXmwKZF25XEAWcn/xvRucEforOK7diGgoorq9N6nw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1627462300;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=ZcFwrVmA+7WMk1YyBYuw9PdFVUVusynLo8gvPJM70uc=;
        b=mIuIsBLLekvP2UUSuttPriuB1PkyZso/Q2REpLDnqaoGauGS8QgoxWQBaxGZiHUS
        cj6Uld6FEnOS8q5CGVttQBmqLjZ6PczkgUa9jBxRNjle4+sZhi4T3uWuV1I4WO47Io1
        kCiysrfoWogfB/3KtlmY9FTK48Fg0S/ZfKu3i2YI=
Received: from localhost.localdomain (49.207.59.170 [49.207.59.170]) by mx.zohomail.com
        with SMTPS id 1627462297395939.3960961262604; Wed, 28 Jul 2021 01:51:37 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v8 1/2] firmware_loader: use -ETIMEDOUT instead of -EAGAIN in fw_load_sysfs_fallback
Date:   Wed, 28 Jul 2021 14:21:06 +0530
Message-Id: <20210728085107.4141-2-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210728085107.4141-1-mail@anirudhrb.com>
References: <20210728085107.4141-1-mail@anirudhrb.com>
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
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
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

