Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A088338D390
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 06:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhEVEjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 00:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhEVEjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 00:39:32 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17062C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 21:38:08 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id g11so16049229ilq.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 21:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KUva5so8tvqa3u/bAg29D00qgXZAHP7FewiaIUPW1o=;
        b=U94TiT/Ud4OtQ0d3GQ3jfKnrLSWUF8g8j3QF32s1hHGmBVKMChgKZkaHSfPjxFvsHU
         KTZ+bbDAejkKFYWabqtnUWuy5KnJmNcaKEusKgGrNOKf7mHIODjxVvewrStDLRwi1xeR
         SDElGQmRfuXb33JWYIVY6tOF3LgGOKpSQLEFGbszIJiRbE8hEpic1kszQ05DSww68IjL
         zG22IReN83lmGriyBLaw1L5BdhFa30dpfz+mk8SINx1NXK2IRecqxpIE2vAyvPTjurOo
         Vaqfhe2wHCxuQd+YUtKYmb3DRC92R2LBrkNyCIKopzmkdDV54wwA858jAI2mqhBMZ6N+
         3cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KUva5so8tvqa3u/bAg29D00qgXZAHP7FewiaIUPW1o=;
        b=I/9ALicmLRrcyqrkt161KK68M/fecK8RaB9yk7TefAT679YH750ejYh02Dykd3qCCy
         JUtcys6UL0eKWQoMtq+BmrwM6j4vmSTq5qvglM76DzCZk6pSAuqfcX1CrPVzZCZACzfq
         uzwTHM5aFTIsUZWJenUuVuGtcfGBMr4EmHiBdQNYlS0m42XuASBX4lOpzD3DhboMOmT/
         TXW3FzDFl7N90I1MFEHY1L0YEo+r/2iUJPcfPkSIcBcxW0zMJDbBKH2tPF1XQ+UVgz9e
         Vgp8IoQAHLYTXNH11Nv0oW9jbbJWZTOxNAxAvdguMrgYE+TRsaVen2r1GTIB3HyyiIQ9
         qgVg==
X-Gm-Message-State: AOAM530eRy+14Tz5NkKXXA7oLqv8UMkDGafy+ErwxPx/7BdilFCN6qqp
        FQx9C6XBES0q7aTO5iraNRM=
X-Google-Smtp-Source: ABdhPJxFZP4/EM89poikvtI+fofml0Jpx/WsFay2XL5K2g7GnXiYML/u5eVJ+JX7aU5q43hTP8QyHw==
X-Received: by 2002:a92:d4c7:: with SMTP id o7mr3316371ilm.130.1621658287039;
        Fri, 21 May 2021 21:38:07 -0700 (PDT)
Received: from tong-desktop.local ([2601:647:4200:13:89bc:2022:e601:c75c])
        by smtp.googlemail.com with ESMTPSA id r5sm7140660ilb.1.2021.05.21.21.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 21:38:06 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>
Subject: [PATCH v1] misc: alcor_pci: fix inverted branch condition
Date:   Sat, 22 May 2021 00:37:25 -0400
Message-Id: <20210522043725.602179-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YKerHVMuqnRQmhMz@kroah.com>
References: <YKerHVMuqnRQmhMz@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a trivial mistake that I made in the previous attempt
in fixing the null bridge issue. The branch condition is inverted and we
should call alcor_pci_find_cap_offset() only if bridge is not null.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 3ce3e45cc333 ("misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge")
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/misc/cardreader/alcor_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index 0a62307f7ffb..de6d44a158bb 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -144,7 +144,7 @@ static void alcor_pci_init_check_aspm(struct alcor_pci_priv *priv)
 	 * priv->parent_pdev will be NULL. In this case we don't check its
 	 * capability and disable ASPM completely.
 	 */
-	if (!priv->parent_pdev)
+	if (priv->parent_pdev)
 		priv->parent_cap_off = alcor_pci_find_cap_offset(priv,
 							 priv->parent_pdev);
 
-- 
2.25.1

