Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36CE4165C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbhIWTNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbhIWTNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:13:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8ACC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:11:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so30193364lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVf3/4XKMQKBuwBr06BL1/Ve3VhkMA/hr+uNiyHS84A=;
        b=YvDVp37vVxfNZi0SCz4KocEd+ShswH5dqIxhflhCaY9uhjMAT45jigVZaztB1s+VBr
         wMV8lLeFgqYnYgsN+ovYWDzL3MGgOBM01YbTHn04IRjD+exx44EjeYzmw8LPn682c2Bu
         g2PbcVBgVStKxesF34POP2LKZrD0OSURDEdQyJ+inEZKXFyNq6O7oiO9cUM28PY4/vY/
         8S0wJ8fp+YJUjq8RxVhRTNhAXPNxVkoLxjXTJoRI/w9RZpDRomMVAr9TtoTTi7Ha0RUG
         paTuQUxm/W0iXWrcbxCiatLql+eIIm9ACFvDPbW5r4RfTUZCg+WHQvELINN9TBtEAwZv
         6D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVf3/4XKMQKBuwBr06BL1/Ve3VhkMA/hr+uNiyHS84A=;
        b=ZfEC8hsfypL3RJORHXyY/bLZLZnctjLyf+TK1hPP/B0V6KcqezBE2RPHWnZ7AcUxy4
         qNgyvgQzqHFsH5LYJkk1fTs7+3F9b8OfvH+CYcnnY30LBQ7QNstatSle+i39Wnc058ks
         w2yrPpQCJQYGfxSi+bkxJrNZm8lCyRHnpszrAF3+efUvMGAOZN/7nx3bJEKfFDGN92r8
         V9/ufvYRmSvhiwIvIw41OsEzGZ5vFcgh+KH/0LvP71ToL5Q+IkyqWjZtX/sFcSEprW9q
         A57Y+1GHwUHdhi2lCV1kNiFiiviT16O918JZzcai4ZlTkZgnlsIg4ro1Q2o9xz34D0EU
         CrPg==
X-Gm-Message-State: AOAM531uM0rSGzs+DnvVUwAD3eWpiKrSMtkTB311L/dOGGtNxtIEKAdm
        jlcy3b26XKYHhpMVPOpqBNMy7g==
X-Google-Smtp-Source: ABdhPJzetSQdnCUaYPv/+A43IpTTG9/NnXH1JTYgZGKtcpRTcudAz0RUrYleB4SFJbPjbGc9kwJkTg==
X-Received: by 2002:a05:6512:39c1:: with SMTP id k1mr5730424lfu.390.1632424299415;
        Thu, 23 Sep 2021 12:11:39 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id i4sm533263lfo.13.2021.09.23.12.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:11:38 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] iommu/ipmmu-vmsa: Hook up r8a77980 DT matching code
Date:   Thu, 23 Sep 2021 22:11:16 +0300
Message-Id: <20210923191115.22864-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add r8a77980 (R-Car V3H) to the list of supported devices. The hardware
is the same as on already-supportred V3M and other R-Car Gen3 chips.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/iommu/ipmmu-vmsa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index d38ff29a76e8..8455db3704ef 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -953,6 +953,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
 	}, {
 		.compatible = "renesas,ipmmu-r8a77970",
 		.data = &ipmmu_features_rcar_gen3,
+	}, {
+		.compatible = "renesas,ipmmu-r8a77980",
+		.data = &ipmmu_features_rcar_gen3,
 	}, {
 		.compatible = "renesas,ipmmu-r8a77990",
 		.data = &ipmmu_features_rcar_gen3,
-- 
2.30.2

