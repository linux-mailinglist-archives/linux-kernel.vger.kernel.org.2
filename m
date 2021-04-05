Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0347354143
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhDEKtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhDEKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:49:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8EAC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 03:49:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s2so8130798qtx.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 03:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxUwJprpafXvqxQ24FtKstnVbwXECMiYhwtxCk/m/jg=;
        b=j1ty3emBVvnFgCvhvjXQUKjAU3HVfVcYr096YrKiyFHT/9+3oGPoZw3C6n45YtE4Vs
         e3XZWQmDM802UXjOug6OStyB6vWQv2MxH+Htu3YBTdRtCIfBBeheP8iSZQHoaG5Yg6Xi
         PbfyNhxCgy5+3fMOP6//RUhE3J17ck7hinaNlVmHUKXfI2XWsktmKSOgwTyFRUEsuZDh
         O+lwL0uDtc002hNIuLtW+DhzBn+VaPk9P96kMORm9SwzFUnbtrrG/p8pwmSSEJrfoXlv
         laLdzNWrIWbkVCsiFSiBhjlseIxFyS1U5zqM9ZKrm7bYrj/vyz7KHULo84TxxaCck+Op
         XvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxUwJprpafXvqxQ24FtKstnVbwXECMiYhwtxCk/m/jg=;
        b=NHVuwmZaoLMDuxQbVBqzlYL1BvM6oMsd+JLU8QgZ8oTmLnMs2SIWAan847eQfUWEo7
         GTLQBMFsIrwZj4X9RQv8PR0OYco3sRhkeRgCcBl8q/9yR2pDYDthafGWIm27q3/BUzSn
         wz+yySM7tiohUeH0IfrxB9QCzEKhx1UHQk4i9+IyELq9E0Vb/yG8Ja/5hna77mjp4yYI
         ELfDLrnbtVo9myC7ltv3dzf5+vJKuztY2mIcrwm6XUWD+jkP7Xo3XvctZ+aIwZcJLQob
         hX6XTbCVzE5TpMuGwi09dpVOsHm11a81QMtWjhEnrcM53FkKxAO4outvAa0MnIeVRuk1
         KIJw==
X-Gm-Message-State: AOAM532/LZ1wyETwmNBr2BY8YqjSn7FcU43I9UCoo3n02/emTT/MSCSZ
        TNr+rp17ZnZ6RNI3vT+5m+w=
X-Google-Smtp-Source: ABdhPJwbUyMPDf+UfYDxDXYxBpXUQwLl++72S+ZU/tjZMTgc6X+DWyh5bwkJalpllmf5E/NbsxkkKw==
X-Received: by 2002:ac8:d87:: with SMTP id s7mr21799459qti.32.1617619768593;
        Mon, 05 Apr 2021 03:49:28 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8290:6b95:72bd:5607:9b84:56df])
        by smtp.gmail.com with ESMTPSA id p66sm13349634qka.108.2021.04.05.03.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 03:49:28 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v4 2/9] w1: ds2438: fixed a coding style issue in iad_read
Date:   Mon,  5 Apr 2021 07:50:02 -0300
Message-Id: <20210405105009.420924-3-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210405105009.420924-1-sampaio.ime@gmail.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is only one statement inside the if clause, no brackets
are required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 148921fb9702..a5bb53042c93 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -287,9 +287,9 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_current(sl, &voltage) == 0) {
+	if (w1_ds2438_get_current(sl, &voltage) == 0)
 		ret = snprintf(buf, count, "%i\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
-- 
2.30.1

