Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF9534FD58
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhCaJm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbhCaJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8725BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x21so21517575eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZP4wKbMRMwqEeI/UoxGUOokmbbP4VYk3spjExIgzybg=;
        b=l1bzxHwwJnzka9akVrlKhaHYgMplPypRD7IacQjOm5Z/EEepraymXszXE05bDnKHUx
         e4G9oWHpr1BUOumvSXAFlK/N71vYTWsNLBTUxEMyA/X54QqD2lgETSkkebborceaGKlp
         U08IKFKKT8xXzudulCXYCOhHBnhLUXNxtfGPUPT5npX/nQtlig0FqVrtP1BRMXR4jERN
         qsrAIZ64oJ4HuoODz+AlupyFUUWjUPw/Ks7cv7Hgw9lH39hyVWu0qyK5m8uP1zsoAK5E
         iLMtFljk5t489wu4x9ja62Lb6lgdJq8MPrKnO5JsqCJWPp4S4/y/HMQr9sTSxEOqMfzv
         q+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZP4wKbMRMwqEeI/UoxGUOokmbbP4VYk3spjExIgzybg=;
        b=iI5vN6NHTc2UoCzIT+PVFG8WfGlKF2oh4Hh8Z5GS80/KIRohX2bRxiAcS0zRwhrxBD
         CeT/NH42t0y60AlKQ7JKsP0ChaUimVCNR0pjrlRVuoKv92Ozdk/zQpgMdLoua1kqdQtK
         Zjtz6/E9GEQZoW0+PfBRCAdkMoHXPiG3Crn9H68tS/GIFA247XWrRE8HusFQw6b4v474
         cLkNF7JCNr287gkW8B80C7kDL4297dqCr30m8KYjIqtI0qUV1JK2LqiXlNA3ar6m1B3n
         fCJTanZrNl/mf4SFoZlAqZVuZ2Qgo4VbI5zyFBb6k9kM0cY2WZCtqQJCDnyfmnGrnJXT
         mbDw==
X-Gm-Message-State: AOAM533XNo/dWraikbZUDybMuR0cA3LC6QXc56ApIHEXVyUZJwubSF1Z
        mN0ywxE1mubacUsu7sam090=
X-Google-Smtp-Source: ABdhPJzEKiS21NiHDfR3O3pGswNk9U99uTj9g3bbAAqC+X5cuy5KzsfcImZxu6dUHDWbORBP4WlamQ==
X-Received: by 2002:a05:6402:3487:: with SMTP id v7mr2597732edc.302.1617183684332;
        Wed, 31 Mar 2021 02:41:24 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id ak20sm814955ejc.72.2021.03.31.02.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:24 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 39/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in os_dep/osdep_service.c
Date:   Wed, 31 Mar 2021 11:40:07 +0200
Message-Id: <de95a0740d468cb8e3f9a646c91ef79dccc93ec2.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 843003b91ea2..db979403e16a 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -161,7 +161,7 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 		ret = register_netdevice(pnetdev);
 
 	if (ret != 0) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("register_netdev() failed\n"));
+		pr_err("%s register_netdev() failed\n", DRIVER_PREFIX);
 		goto error;
 	}
 
-- 
2.20.1

