Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1E413BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 22:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhIUUxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 16:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhIUUxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:53:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB29C061574;
        Tue, 21 Sep 2021 13:52:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d6so408615wrc.11;
        Tue, 21 Sep 2021 13:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=L66QhiZcUuwlRKorNm9Yc4Tr9VadEmevichCsHyMvjU=;
        b=DeThqqKIqz0+ijJFStlvltj0n+pX12EMofg6z2zKHIxA4eOPVCJqHGT8r9C6B2w7Dx
         riZSEIi81OvVJMbPiz4zGYvruPbq2Wk/NIIK8+pt5FfyLlZ3otZevCnlFoXsgGIO8t3o
         0I3J91YkTlDmq+gRQPWfN9TUEsRhmk1D2PS1FJTTY7FR6plQNGOhOeLE7i4OVpZJE5Md
         CJ8PcpG/Ue7k0C76Y634kdpnjMDWsdEjtAupdRloK9vfJ++xK2PARS3ztOUKQz2YLtN2
         YfiEaJvcpLd2ySNY37aHhBZHhSRWC9xcFFKLJlraeO+LGY5RTStUWqe2M2aHA8e1AR9s
         M0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=L66QhiZcUuwlRKorNm9Yc4Tr9VadEmevichCsHyMvjU=;
        b=YDtVqC7X6JfvrmL99b0a0rgGmLlGPftcf4DSv7CMlPeSvofAaGFoWus+cAk9j+blK2
         /O/VuF3vZXb0IdFVOv4Jyuiwza0wgyoEVGxpyj3FJskuf05Lj5l6GGB0moPxmN4QKKL/
         jxNyLDs0J41OZ9LxX472TYZSUBNSkD6lyzWX/L2PGNiY4dpkM74+rc66QiIAXO5NcwBT
         1enTfH/JRkYxZFbePJtrU+v8gaDg10C08BgT+N63oWgwP6Mgr+E59QsWtjw/2sa6dipe
         CLppChF2Mida9HfH23NUugYd5ySfP2YONstAYuYtkOmZf5YV3plUz5r0DWO1xTiqFEdv
         /NlQ==
X-Gm-Message-State: AOAM532CfdrFsEhcPqXSbQBn9OahgBrPE4qz6WzU2jaaQkhdPfqRzlXW
        HNzKqbxA2pIKIrA07m0dcXjFeFoLjhA=
X-Google-Smtp-Source: ABdhPJy1CFKxlE3RZVvlblinxGQcMEPWS2moN/XHUkffr8EQNzJgsOqyIAMzlaD9DploankGPz48VQ==
X-Received: by 2002:a05:600c:b42:: with SMTP id k2mr6872197wmr.134.1632257534855;
        Tue, 21 Sep 2021 13:52:14 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0664d2c35468e13948d7.dip0.t-ipconnect.de. [2003:c7:8f4e:664:d2c3:5468:e139:48d7])
        by smtp.gmail.com with ESMTPSA id 23sm5490wme.27.2021.09.21.13.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 13:52:14 -0700 (PDT)
Date:   Tue, 21 Sep 2021 22:52:12 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: usb-skeleton: Update min() to min_t()
Message-ID: <20210921205212.GA8669@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:
WARNING: min() should probably be min_t(size_t, count, MAX_TRANSFER)
+	size_t writesize = min(count, (size_t)MAX_TRANSFER);

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/usb/usb-skeleton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index 2dc58766273a..d87deee3e26e 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -363,7 +363,7 @@ static ssize_t skel_write(struct file *file, const char *user_buffer,
 	int retval = 0;
 	struct urb *urb = NULL;
 	char *buf = NULL;
-	size_t writesize = min(count, (size_t)MAX_TRANSFER);
+	size_t writesize = min_t(size_t, count, MAX_TRANSFER);
 
 	dev = file->private_data;
 
-- 
2.25.1

