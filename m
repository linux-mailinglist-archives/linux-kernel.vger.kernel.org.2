Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBFF3C359F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhGJQtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 12:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGJQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 12:49:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE68C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 09:46:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hc16so22970835ejc.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FgRxku6Kq/BTQ7x6pg4bh4zbCPE8YN3oFjzx7M3K7qs=;
        b=WgKlXYRcVOBD9y9PjMK9fKUTZsFPTbCVkhHuMCzUc96hMYva0qJioWThSmG0JfMMGe
         qhPKm1C8s5HbOMag0/sloe9WZxglxXKQX58W6gL9DWZrTeRfCBaN9M8tFkRgiQeyQz59
         1eqkGdlQw8ZuaU9EamXvm/Vk0YXpGJtk/RrQFlSlDB18edcbJ5fsPGxdaLAKIkuNlsEo
         YymcPnt6rZLm1HEd7YOkRN7T0hZcBAQ8n5MD38SsQUMksMOTZ99P+PziiBofQJTrpKXL
         WQR+xZWWV5zjHWE8Kfu5Z2q6xrEhwbJGdQHzTv9q19j5i9VQyZw+ZqXWX2Y6eTKfZc8d
         YcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FgRxku6Kq/BTQ7x6pg4bh4zbCPE8YN3oFjzx7M3K7qs=;
        b=YmBsGMsQwyn11FOlxOjAlnQ9eAMzZ7F/97mEqP2PvGftJ/BPJA8aR3KYdNcwyNzRFe
         6vqHUqr2OkOXsIrJQ7dvdy2IL1mXvMWjJkgHi9Fsb5RmSQd6yMjUvVtEODhnB9DF7+1d
         wF46sOF6I7i2wuK3C9ggFD/TMAKL118mPerQClpzya2ucFMe5tS6oghmaj9nYHW1Vrtl
         3h/AXSQxWPrN4fBE2qDaoMFLxnGyejM1CqG0Dlj5bOGUxBJsAnVh2Ga7drEeqHmeKO81
         MdtW+9Uqe/wIUBl/vMQZb6iECIoZfOgetBqSU/D3GyEbDU0uqb1kKcRhE6gF0H/PN5Rx
         5jXA==
X-Gm-Message-State: AOAM533R92YrjffQKe+w51sOFaXgYdOpjE1m1yXfaduOerZPiPd4Czjs
        xG1+p7hrhJy8HizCrxh2QlqQ/k8sKIA=
X-Google-Smtp-Source: ABdhPJwXNTFFablO4CB8vDpeLj4bBJB6IRJnqeT+134PmSKx88Q059C81g1pEL5wedTRgpU9XmU+mQ==
X-Received: by 2002:a17:906:3181:: with SMTP id 1mr44566282ejy.36.1625935577303;
        Sat, 10 Jul 2021 09:46:17 -0700 (PDT)
Received: from pc ([196.235.212.194])
        by smtp.gmail.com with ESMTPSA id o26sm3994026eje.96.2021.07.10.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 09:46:16 -0700 (PDT)
Date:   Sat, 10 Jul 2021 17:46:15 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] dax: replace sprintf() by scnprintf()
Message-ID: <20210710164615.GA690067@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace sprintf() by scnprintf() in order to avoid buffer overflows.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 5aee26e1bbd6..bcae4be6ae76 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -76,7 +76,7 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
 	fields = sscanf(buf, "dax%d.%d", &region_id, &id);
 	if (fields != 2)
 		return -EINVAL;
-	sprintf(devname, "dax%d.%d", region_id, id);
+	scnprintf(devname, DAX_NAME_LEN, "dax%d.%d", region_id, id);
 	if (!sysfs_streq(buf, devname))
 		return -EINVAL;
 
-- 
2.25.1

