Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919F730720E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhA1Iwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhA1Ivw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:51:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28CEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:52:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c127so3900159wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JeE+HbaafVkKfih7p0z7E9ku5YsWbBC+6e08j8tXuz8=;
        b=THmBkwHDpmlIMcIq1MbnoaiuIl9JWr7JizK6c3nmX7xPtQzWP+ibbH/4EO/9bxMvIP
         HD5ecHLFkBGUTFWXkfDcVtAkazv7l/Dmz05o5HrN4tHjPlpdPU4tsuTGxJgvnhqbLcuk
         v9ZqK8loP4UB+lOplIwXrzrEASjCDw2ScKBBEGy8hMzPWzIK0UpoV5QF14yejhniHsYE
         89BMVovqWUhFvPxUVJ0jqWbSC9Tj118GQtqnQF/ZVHw73SgBoRgTRYfSZND4NRfsGESu
         yuZaCsxuWw1EIvUTpaEMXDlQdZdSiPjSI93ULKI9e/Mn2mpv77i9NgVuiMf0TYMHUwXz
         /zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JeE+HbaafVkKfih7p0z7E9ku5YsWbBC+6e08j8tXuz8=;
        b=dAQbn9RsRLBgy5UY/oGKi0tCRaUOXY/X/hiv5y3oXB70i6nuRNRduuVc6rX4cBiHdU
         7yA5fp7U8eLJ5YdrQZrQrOaORpfqn4jsI1RgmRcIT09O9ERmWmnUJDjTU+RvqosWSRLH
         BDDmkz8OVryzccFh43BQFIt0KCnY0UHPDpZhM/ZOyy+n1oPLxMXGQdXcv/cPLFq4eZh1
         vZ1gde7b5f6Yv9yg7hv4d9BSTKr2ie9PUQLEMtGz6eOeE373Vn/P9JgzMm/JYOhaixEU
         px4ZvhcrQNCqhGzHruOFUCkoh9NKQwwBOTeV9rhXy6M15mHJYB8NIkYYRilmluSONhu0
         co4A==
X-Gm-Message-State: AOAM532cwBumFTRgrrrfS47atD6MQjDbwbnJTE81lpe7EOG9OotHcksc
        sqQRmWJmTxa6E9rXI73oIcPZz417xn2bgzhL
X-Google-Smtp-Source: ABdhPJzqG0ZU+51XYG70xds+4EhFBCMVLdt2BVmQiFUfztL68ShvGKIujUQSBaFcHlUOba/5ONRSBA==
X-Received: by 2002:a1c:28c2:: with SMTP id o185mr1968277wmo.7.1611823956140;
        Thu, 28 Jan 2021 00:52:36 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id v126sm5424616wma.22.2021.01.28.00.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 00:52:35 -0800 (PST)
Date:   Thu, 28 Jan 2021 08:52:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH V2 01/12] thunderbolt: dma_port: Check
 'dma_port_flash_write_block()'s return value
Message-ID: <20210128085233.GE4774@dell>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
 <20210127112554.3770172-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210127112554.3770172-2-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... and take the error path if it fails.

Fixes the following W=1 kernel build warning(s):

 drivers/thunderbolt/dma_port.c: In function ‘dma_port_flash_write_block’:
 drivers/thunderbolt/dma_port.c:331:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

v2: Different approach: actually handle the error.

 drivers/thunderbolt/dma_port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thunderbolt/dma_port.c b/drivers/thunderbolt/dma_port.c
index 847dd07a7b172..7288aaf01ae6a 100644
--- a/drivers/thunderbolt/dma_port.c
+++ b/drivers/thunderbolt/dma_port.c
@@ -335,6 +335,8 @@ static int dma_port_flash_write_block(struct tb_dma_port *dma, u32 address,
        /* Write the block to MAIL_DATA registers */
        ret = dma_port_write(sw->tb->ctl, buf, tb_route(sw), dma->port,
                            dma->base + MAIL_DATA, dwords, DMA_PORT_TIMEOUT);
+       if (ret)
+               return ret;
 
        in = MAIL_IN_CMD_FLASH_WRITE << MAIL_IN_CMD_SHIFT;
