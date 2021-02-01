Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA930B039
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhBATR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhBATRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:17:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E15C061756;
        Mon,  1 Feb 2021 11:16:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id i8so9678579ejc.7;
        Mon, 01 Feb 2021 11:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DUZ2th2akMgZXbhWAwF/Rtcar/hbaUZaN5WHosC7d0E=;
        b=RtXwwowHX3yfKgD+ZnKVEKPYu6VxOSHT2i06dKyO5Qe/QPuh82VhWaZuFzbG65NGxV
         Fj9khMkJ7JpVdW02Zhr+a7tTxDgoWgCeW4cSzU8FxwE4eO5tQdou6Osn0pMgLBmu57Vo
         dST/W9TzxJEpZ/ugfTAx9S6Z80iutmAEHSDiMDLK5YtozOYCTnPdsesNEA35uY+Nqh6Y
         HObgLwk3lsXHqc8f2zVMtknj9OJT6ubtfLRdC6LnG9IGrupkWRMlH2UGAjFG2cVLngsD
         0mARA+eNCct1De7Jn3PGnbQVOr0cqRnbelKY9zgn8JukDLlKc1FWhe5RwQWzBmXw+VLg
         q2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DUZ2th2akMgZXbhWAwF/Rtcar/hbaUZaN5WHosC7d0E=;
        b=JxPQcnJdbB7dqC4A0yBj7nwlvv9/sm/I6+uc4GNH0KCUb3+vZC05vE4DDNiqOOGoqw
         5lr7grwOzXDKza7zdrYn7Hv+16LVDRRIUd+1PvhoCtSEqUGDzqVN2Tk1GE9nsnb7GE6p
         SErHQRZ0+k1ZiYjAWTuZqL7MWkA7mod2T5DSWKgaVa9gaKEEi0vK/vu7yIeY3n5LjV6Z
         XADufnWcftisX/gn6LHvzvkZKPY5U6jzf6eMjAHiSpNiDstTTDpwY20NrnOMjuQz/y1I
         oasnxARFNfyRz05m5oqvPuXcrOzlp+ruyS11gIEHFkg+Z/TaO78Dcb2aGeDmLkqjlbK3
         a5ag==
X-Gm-Message-State: AOAM531Nxli2nL/RDZ8X3bFznjELAFwQd0Sp+Bh/RD9Ze2Vh5Cf12ccp
        Zq52kEHTiXI5g53pwbz28wE=
X-Google-Smtp-Source: ABdhPJyhN8CrusHD92pZSzVbBjMiSaukdEjDjPVVJCL0Yfd0yknHk18anfLy69xGsyIR8F82Rx28Pg==
X-Received: by 2002:a17:906:7687:: with SMTP id o7mr19434775ejm.209.1612206988433;
        Mon, 01 Feb 2021 11:16:28 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a11sm8243630ejc.64.2021.02.01.11.16.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:16:28 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] usb: dwc3: of-simple: add compatible for rk3328
Date:   Mon,  1 Feb 2021 20:16:17 +0100
Message-Id: <20210201191619.32353-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210201191619.32353-1-jbx6244@gmail.com>
References: <20210201191619.32353-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

Add a compatible to be hooked into by the Rockchip rk3328 device tree.

The rk3399 compatible cannot be reused because the rk3328 SoCs may
require a specialized driver in the future and old device trees must
remain compatible with newer kernels.

Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index e62ecd22b..93bc34328 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -171,6 +171,7 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
 };
 
 static const struct of_device_id of_dwc3_simple_match[] = {
+	{ .compatible = "rockchip,rk3328-dwc3" },
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "xlnx,zynqmp-dwc3" },
 	{ .compatible = "cavium,octeon-7130-usb-uctl" },
-- 
2.11.0

