Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D030831A816
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhBLWxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhBLWvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:51:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0CCC061786
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 14:50:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id w4so1037268wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 14:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZIZJUfWDlLORZK0UXURRJwtXDOvF3/jQeszDnimKc2E=;
        b=rMe/f+6Wi0FPeWZA22QaFAmu9kaQhQ1C4+kXcJFAhQQgPt8r/YToV8xZiq/IKOXZU3
         ZQekgBLPss06rneV8ThwH5XSAoRzVQekXOdFxigbbkhQzuSVhs46AHq1dtED0VcWOtLG
         A9+G2BV/WrDJbvtxeaFLDyjgFwpQellcvuoQ2B+nIey/iH+JrmpzSiyXCxMjNYlerWDY
         2FpErKLulT/bPLUppXFkflcPkPu4tIJYON9+7tzEi89bi0jZj9TzFrTlnqH2a6Rlh0zl
         iWPQQwNVqU00Y5nGv10BLP8k4PTfW7v8hYAgm1Fym9Q5VvbUF5UOikz/WUDpMgpcpnKm
         JmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZIZJUfWDlLORZK0UXURRJwtXDOvF3/jQeszDnimKc2E=;
        b=buW03O2DX+1aE2OXxGWDHwLseMA0P4jltenXPOcWorwAV7v5kFVB8tRzdOY2qttkyh
         xbUS/vYbBbjkR93AJeX1CZCcx0GIvclVpNyHReK9DmWnflChXeKYp+8MoQ23OvUsEqrs
         kHg53+DXLK/mihE3lWk78+qNSuXGvfQmTQ/W2R6b/rs7CveAY48L+WzpukDsDvP6iIOg
         aMmEaxQWA66y76rww5sQjkfpHTKgPbMJxoafMwpoV1YkKUxaAe4nxyIp3yPUOSLn8/AT
         f777Q3uVfH3OjwIPwB7d7Nzg3FFwnU+trPZXYppYVOvgQycQ0GWuX2ljs7zldRJnY9HR
         0TWQ==
X-Gm-Message-State: AOAM53247IcX89aU0kzOj77g2Rr2LTWqQM3djWczGUjOjBcy5UYvJdy1
        S8Tg9yJbXoJfirLxmR/+MeMJEpsRikgWeQ==
X-Google-Smtp-Source: ABdhPJy0ReC4VJ99s5vEC716BPZHdpScjenDjhzBUx63wtqEwRYuxt+tNDimGWIcv+rec+H8dtjN3A==
X-Received: by 2002:a05:600c:4f46:: with SMTP id m6mr4476965wmq.160.1613170237116;
        Fri, 12 Feb 2021 14:50:37 -0800 (PST)
Received: from whach (x4dbd50ef.dyn.telefonica.de. [77.189.80.239])
        by smtp.gmail.com with ESMTPSA id l38sm14865052wmp.19.2021.02.12.14.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 14:50:36 -0800 (PST)
Date:   Sat, 13 Feb 2021 04:20:35 +0530
From:   Manikantan Ravichandran <ravman1991@gmail.com>
To:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: minor code style fix
Message-ID: <20210212225035.GA16260@whach>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch warning fix for string split across lines

Signed-off-by: Manikantan Ravichandran <ravman1991@gmail.com>
---
 drivers/staging/greybus/audio_manager_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_manager_sysfs.c b/drivers/staging/greybus/audio_manager_sysfs.c
index ab882cc49b41..fcd518f9540c 100644
--- a/drivers/staging/greybus/audio_manager_sysfs.c
+++ b/drivers/staging/greybus/audio_manager_sysfs.c
@@ -18,8 +18,8 @@ static ssize_t manager_sysfs_add_store(struct kobject *kobj,
 	struct gb_audio_manager_module_descriptor desc = { {0} };
 
 	int num = sscanf(buf,
-			"name=%" GB_AUDIO_MANAGER_MODULE_NAME_LEN_SSCANF "s "
-			"vid=%d pid=%d intf_id=%d i/p devices=0x%X o/p devices=0x%X",
+			"name=%" GB_AUDIO_MANAGER_MODULE_NAME_LEN_SSCANF
+			"s vid=%d pid=%d intf_id=%d i/p devices=0x%X o/p devices=0x%X",
 			desc.name, &desc.vid, &desc.pid, &desc.intf_id,
 			&desc.ip_devices, &desc.op_devices);
 
-- 
2.17.1

