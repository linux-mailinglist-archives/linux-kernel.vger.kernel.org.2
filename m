Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC23592DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhDIDPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhDIDPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:15:07 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71595C061763;
        Thu,  8 Apr 2021 20:14:54 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y5so4533806qkl.9;
        Thu, 08 Apr 2021 20:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F86TDcQI2C3Cssq5MXK7JmPSjc1rrNaIPzNs30SZWr8=;
        b=K2azzavYx9rXGW6P2ebF5nr2mfntQ1Hu5NP4QElJp9NVSOdJciQh7gYEGn+A9+7qbG
         mpXlL/SvgLtnJnlv6pc1q1kENf9fqcFFlqeLkhuyLs+D63YltpK7F0E6AZuLkEK38s3I
         UwwaNNIE87GqeJ4/JTzO/2Ov4+GKLhxj2evhWVF30OQuzYcQ7J298mb5A/5HVrvpHOPI
         6GrLbVaAoIOS3lfZ9csvof6eLf5A9yVX+v3efrsoX6ULUj2siu3PfEzjdgGgFyxK3rZm
         LTqcfwOJ/prcxuT0i6co0zs7tpANyHMlrcl/0jkEGVFMOdYVu2KGNh8aoM7ZqIg9A8eG
         PsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F86TDcQI2C3Cssq5MXK7JmPSjc1rrNaIPzNs30SZWr8=;
        b=Wv/tOQIyf9Y9ceDFPTvOe69CANkynQMnYZtl5jPcZ2hhMQQC9zSotMWPA6FZovq5wD
         +GEQwsqrTP4AiBAhUw4hbjJ8G2Gsfm9zYV4QBHjZEu1pETINdNZmjCq3fzakKjNn8O38
         UEiQIeC0Le7+nDMVzbnUyo7wuAcBfj2R/vBcnVxco1tu0V7BdV40KoIbVs256OVFDl3V
         pbMrZMjSAYetiWnbogmqosZoZlQ20JwXoH39SgBKg4rcC8TIs7OWP37VEMXmpFOLqiuQ
         PL49W2qSP8cy/Rj8CV3/Zb5uc0yeSqHCsnxBWjCKsE/q2WRQun7o9nfPt1oGLnDKXyh8
         VYFw==
X-Gm-Message-State: AOAM531LhIhz2napxy1M70BXHLqWWJE70ZFxDmc8phvZ/T9J/BNTBWkj
        /VLIGN65WjKRrG+4iCyqrPE=
X-Google-Smtp-Source: ABdhPJxOL4sQbgPt7+0yyr5peGEoBHzu7WCp7XoXMMpd/mc3oLivf39bQCGSVm1luX+G6z/WkcuJiw==
X-Received: by 2002:a37:8905:: with SMTP id l5mr12130414qkd.321.1617938093703;
        Thu, 08 Apr 2021 20:14:53 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id x1sm1003167qtr.97.2021.04.08.20.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:14:53 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v6 3/6] w1: ds2438: fixed a coding style issue
Date:   Fri,  9 Apr 2021 00:15:30 -0300
Message-Id: <20210409031533.442123-4-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409031533.442123-1-sampaio.ime@gmail.com>
References: <20210409030942.441830-1-sampaio.ime@gmail.com>
 <20210409031533.442123-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed the permissions to preferred octal style.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 56e53a748059..ccb06b8c2d78 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -388,7 +388,7 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 	return ret;
 }
 
-static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, iad_read, iad_write, 0);
+static BIN_ATTR_RW(iad, 0664, iad_write, 0);
 static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
 static BIN_ATTR_RO(temperature, 0/* real length varies */);
 static BIN_ATTR_RO(vad, 0/* real length varies */);
-- 
2.30.1

