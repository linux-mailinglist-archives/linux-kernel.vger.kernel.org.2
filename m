Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4274241B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhJFPsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhJFPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:48:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56504C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:46:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r10so10169292wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Mt4hVpDDLiJFsnMiqpoJ5N43/Wwws8Ndb8qPcKFmxw=;
        b=f0AVYTcoxBUvDB+PZ28jxbJWZJAypXAwPJqhaXZfm/Uime5f/Yhmgfbr2vxhsWmhYl
         LiUOvxCM3o2JmesOltJ9yeJdvVQCbfYIViMDm06IxV5ywXDD2YRQ5pJfj4pvTaRYFBgz
         j81BNp6w8n7dISmaxYFQ8VxezlnL3h/c0MLv4TeRb9NHiB1eh0TabmPYrwpNdPbYJkTQ
         udhRaUwC2CqjtX6v2wRsHuHBc2fuGGLC5SOIrjoPO/C+btc99Z5vTF6sk7BDlui3TztC
         Mwj1oWYXon3bqMeHS9d0GQxqWACJWc96A4OSookRus8HzLS4zXG5+LlYf4f/AM8LqlEo
         uE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Mt4hVpDDLiJFsnMiqpoJ5N43/Wwws8Ndb8qPcKFmxw=;
        b=OAmkJRaTRFtA7e2OWKWlrtbOvsrR1dEmzF5Rntk32WwVo+cKGOVPEn7JFIB8F5uXFT
         0ObGLfx/U2Kd+8nUT4I5ycqvfguUxGWP0LoQdRiV7/tJ0FBLxK1TgmhFvn9mfYDMwb12
         ZoVtmX26bvvGjquPB5JFyQA+NnedmPeLWzfH0bxyTp6c9sw5b/qmEbGF2VWcDSC48vNR
         6Q+zzwGSwqQeIhWuUM+8QMeG87OmOm5b+58AQ7dQy8k34dcq00Q0Nzuwsrnnpz6f7xNb
         1x/nHxGVkOoFkNRZSzPRiZa0tShIENsYGeX8DSWUMIgRM6ScBjUdWmoqHhRAVT7p9yRj
         /Fow==
X-Gm-Message-State: AOAM532fJe2giIIrTtHqssW1o5uGb6YmlvYjvgj9VO9FiGZZmxn2M9WB
        3kXl689AmhUHPUREDQFi0n6DPHI4JOBSVQ==
X-Google-Smtp-Source: ABdhPJyI30sTsalaSH1M4b+oD0ejZDsI5TTr4n3hmyd9xdp8QX634Rs1+6R3TcQ4AD2CpwDf//gwQw==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr29904565wrs.121.1633535211935;
        Wed, 06 Oct 2021 08:46:51 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id r205sm2007276wma.3.2021.10.06.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 08:46:51 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in stable/sysfs-module
Date:   Wed,  6 Oct 2021 17:46:48 +0200
Message-Id: <20211006154649.134924-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated word: "the the source"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/stable/sysfs-module | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 560b4a3278df..41b1f16e8795 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -38,7 +38,7 @@ What:		/sys/module/<MODULENAME>/srcversion
 Date:		Jun 2005
 Description:
 		If the module source has MODULE_VERSION, this file will contain
-		the checksum of the the source code.
+		the checksum of the source code.

 What:		/sys/module/<MODULENAME>/version
 Date:		Jun 2005
--
2.25.1

