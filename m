Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA5B31EE18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhBRSQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhBRPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:50:11 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3326CC0613D6;
        Thu, 18 Feb 2021 07:49:29 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id z68so1403861pgz.0;
        Thu, 18 Feb 2021 07:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7ZqDu74I7s4QHSiTCiGk48DBodjMdCaiE76tGdwtC4=;
        b=nrHlxG8InwSr9OaqWtoOCZuwk4cda9K9cRCy3lymuWuM7wIyMzUkqsNycN8AAQ0m6Q
         fcQNLJKBoTtKMdiSrZN90o4s24veiXOTGSUeaIAqKaHEDC9+TwzR88oKyWgk63kDyAvR
         cEJMGmZgayF3NJ5sSiuaG481q6tV1v5mt9NlZL1vKZwU1tUMCljT4wfWCarEXmNJuUeV
         WQGqRLREORM1uraQPJ71fSXQSqW28ElzrnmtXeaUm0cAoUWiMw2GX67RfSpEtF5vHLKf
         kvB2B5i6uquhYMxm8cTmpHwuonokJ1mSuY00c0BYxrCtSYpSl0MhBSkvavOqTLyItczl
         EDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7ZqDu74I7s4QHSiTCiGk48DBodjMdCaiE76tGdwtC4=;
        b=USx1ZMmliW11GjwTgwbGKg7keTiv3PwcxrZT1HGybkHpnV79qMXR38sGUEmEzd0AMl
         xx16GKV/KgZ+RB5MeOiTGM3tyrXdIUEpPa1C9YLqPIC7oUlF4t0Lcvp/gJXu0j9bCSjP
         qRUSgyR7xSp5ya34Min8jrvCkfCbkiXF3wx2m46PFJPcmGwRTeqWn276IArXqFcJDVde
         jwjnSp332dtjLlJ9LfgAkJ6B+/Ur2oa7XNfL9OJEadbxOtDwgsKyWthG7JtkPWNl4XiV
         rIm+lCB/2nUgePiVbYDIMjh/DnMgvWRBB3fNtxHOarJ6iuM7n1/0NfvXsi/Qorj7U+cU
         liWQ==
X-Gm-Message-State: AOAM531Hsioj1C4Z37bAtE5j1ScNJqE9gdh6DvYW+9pUs5PWWlunYjz6
        IQWbLh7eT0kQbq5jBwx2Ozw=
X-Google-Smtp-Source: ABdhPJw7ZT2AO0U4ahlqJkQn5M2yWku9+GvK34RXuC/8ZNyZ8K8EzDOpzVTUiEYMpySrnPWNivZXLg==
X-Received: by 2002:a05:6a00:8f:b029:1e8:6975:395e with SMTP id c15-20020a056a00008fb02901e86975395emr4858185pfj.55.1613663368791;
        Thu, 18 Feb 2021 07:49:28 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id v1sm5869261pjh.29.2021.02.18.07.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 07:49:28 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1] Documentation: devres: add missing entry for pcim_set_mwi()
Date:   Thu, 18 Feb 2021 23:49:20 +0800
Message-Id: <20210218154920.799515-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcim_set_mwi() should be documented in devres.rst.
So add the missing entry.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 Documentation/driver-api/driver-model/devres.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index cd8b6e657b94..164c9cddc6d2 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -382,6 +382,7 @@ PCI
   devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
   pcim_enable_device()		: after success, all PCI ops become managed
   pcim_pin_device()		: keep PCI device enabled after release
+  pcim_set_mwi()                : enables memory-write-invalidate PCI transaction
 
 PHY
   devm_usb_get_phy()
-- 
2.25.0

