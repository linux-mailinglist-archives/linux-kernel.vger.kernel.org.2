Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F943963A3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhEaP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 11:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhEaOR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:17:29 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA68C061346
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 06:42:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t9so4638892pgn.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 06:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXH51W1Ix3Bhx2ZHzM7vpDgXhk2IvqzWQ3xGcMdutpE=;
        b=EQvVzBSaj+89LR2aJ422SXnwPm+iWVMzVQ1sW4MSqDtXuBYMEXHMYZ1R3UPiCeiytS
         08FFucrBKJvWjMvBthT5aqmVjSC2RzaDgKWqM7Lkvpluoc7j3Mw35NmegWt6AWVnRaDH
         SZmxW4pS3m9TTY1Z/Ci0FI4D8Lo3yZOJ9hgIZpZSyaEp3tambM8e+tD881Lz6RmSrP/y
         k2Bmb0uKn9WhmC55WUJFDt0rn58Tl4PUYnyGER26IYk0Hk+KkiVJVJnyiWyoU8+Ezfn6
         Ms0Qm4HK7+f3KAqOKJPE1q0gVFdBo0T2Z2ePp2kBUUpvIKVyxTAmOYSGnMCKY9C2IZwW
         PKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXH51W1Ix3Bhx2ZHzM7vpDgXhk2IvqzWQ3xGcMdutpE=;
        b=FFmPQbq6ss4cdEYB2KoGIsm2FEa7Itcb6OSzH0drkJUNYd8PCYAM8+HqS2X/GTQxsj
         RT1xMXHcIFOvqbDmfk9NYdp+47HbrAf8LK4w5UP5cWumxX2CLKB2utG36w8ZDFrz5UtG
         LKyLVDmsJwAG9W9B5K+tp/f3xL3tpfE2r+wMHwx0BFRcsQhuk7fkXnQEsyQxdarMgCtq
         45oSppoZq9rmzZwLWyZJ1jepRt7ha6BB/K+/HDY2Ec4NikLznHWGGDU7vbpHzs72bsj0
         K/yfeBvhMwo+G1k0zQDqfNz4G+L+EnWY9D0IyoUhwWGXh920aNbqMUdI1ZRrWYGIsPeP
         LNSg==
X-Gm-Message-State: AOAM533N5HN+k4njiTN/s3/3A+mEl2OlcxANvln62xL303/R1FSdrY/7
        0zs9wvdgcLpyX5E0WKtXlLV9spdBXIef
X-Google-Smtp-Source: ABdhPJz9Y3LZ2nejC+u23ZMDk5NTDzjSBATptAYUVyWxSbtSiOCv41jzhIVjHZPyH0THy9Vnxi2D5g==
X-Received: by 2002:a65:58cf:: with SMTP id e15mr18964984pgu.269.1622468566127;
        Mon, 31 May 2021 06:42:46 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id x190sm6738618pgd.41.2021.05.31.06.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:42:45 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] docs: Fix typo in Documentation/arm/marvell.rst
Date:   Mon, 31 May 2021 22:42:35 +0900
Message-Id: <20210531134235.720351-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the documentation, changed from 'comatible' to
'compatible.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 Documentation/arm/marvell.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index c50be711ec728d..db2246493d1827 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -259,7 +259,7 @@ Storage family
 	https://web.archive.org/web/20191129073953/http://www.marvell.com/storage/armada-sp/
 
   Core:
-	Sheeva ARMv7 comatible Quad-core PJ4C
+	Sheeva ARMv7 compatible Quad-core PJ4C
 
   (not supported in upstream Linux kernel)
 
-- 
2.30.0

