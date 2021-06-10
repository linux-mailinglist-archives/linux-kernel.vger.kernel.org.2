Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95873A366F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhFJVrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231264AbhFJVrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623361534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TSv9PvVn6D8P1hr2HASl5EPE56aRrWalXa3WhtLcjzQ=;
        b=cU6yn79nOFJPuuLOo17nWSv7pPg7YWom4odjPVqIEj/gg1lOVlJLF4H+N1oOL1hzMBEzl2
        Pu/Z80Nb7O0Iaz+plLnMR6K1ZJsniglTk5lhNuyt7dQBKUyUynNRKnVKDQeVd1R9VvmbeB
        9hzRZloFAtGxuJuVaM19uxGBN56OMsA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-SFYpV_3rPsq5vmFR5TcIOQ-1; Thu, 10 Jun 2021 17:45:33 -0400
X-MC-Unique: SFYpV_3rPsq5vmFR5TcIOQ-1
Received: by mail-oi1-f200.google.com with SMTP id v142-20020acaac940000b02901f80189ca30so753410oie.22
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 14:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSv9PvVn6D8P1hr2HASl5EPE56aRrWalXa3WhtLcjzQ=;
        b=LRSbQQn+ebybR6oh9pL6aiMw2qAo1LwnyhTgx2hh3Gz/Pkf7lbRmxVATXp/usHzvuO
         5A7LwuyUPptJB+tqmcoV/t5ZHDCEaD/C7iBg4b//ZzwEAwYZfQ5XMzs+HCFl6hxlNg6A
         S0Ke38NDxMtyFxau0u40RBhAqZxS29XC/d3E6pHSXEc2pM02d0iMjOPKCuDg+btgP+BI
         JFFyXByElYB4iJpq++gnt+r3c0bdlnZjdpho7gYFEFDvc/WZddiFTg/fWItmrB3DaKUu
         YhmabYOB8ay65SwBbxIVHj+X7wKHpfAwLmoMOpZxYO1nTSED4/CjKLll66Ey61vbnorc
         BmTw==
X-Gm-Message-State: AOAM531af3DgksOxdpuP4kC1N4LtIwvpFeP5Qrjm9C7TM0inzMQ0tcZd
        dzmQeiD7JBhoppG1y/vNNPUp3R0DrAHeWGSEHpPFDgE9D2IUNg2pcfphhr5YsVgIJEbebkdEIAv
        lbrSu/rxu3aB+LnOj+Nt4n1NX
X-Received: by 2002:aca:b506:: with SMTP id e6mr361790oif.178.1623361531513;
        Thu, 10 Jun 2021 14:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLkOYqEPHROAavZ+GqUoBa88evwWu8hew7OzFYwlCFApTMasrs2l9HZneVNx3WKlokSV6LKQ==
X-Received: by 2002:aca:b506:: with SMTP id e6mr361752oif.178.1623361531370;
        Thu, 10 Jun 2021 14:45:31 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i15sm881839ots.39.2021.06.10.14.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:45:31 -0700 (PDT)
From:   trix@redhat.com
To:     robh+dt@kernel.org, tsbogend@alpha.franken.de, jic23@kernel.org,
        lars@metafoo.de, tomas.winkler@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, nbd@nbd.name,
        lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        matthias.bgg@gmail.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        zhangqing@loongson.cn, jbhayana@google.com, sean.wang@mediatek.com,
        shayne.chen@mediatek.com, Soul.Huang@mediatek.com,
        shorne@gmail.com, gsomlo@gmail.com,
        pczarnecki@internships.antmicro.com, mholenko@antmicro.com,
        davidgow@google.com
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, Tom Rix <trix@redhat.com>
Subject: [PATCH 2/7] mei: hdcp: SPDX tag should be the first line
Date:   Thu, 10 Jun 2021 14:44:33 -0700
Message-Id: <20210610214438.3161140-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610214438.3161140-1-trix@redhat.com>
References: <20210610214438.3161140-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

checkpatch looks for the tag on the first line.
So delete empty first line

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/mei/hdcp/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/mei/hdcp/Kconfig b/drivers/misc/mei/hdcp/Kconfig
index 95b2d6d37f102..54e1c95269096 100644
--- a/drivers/misc/mei/hdcp/Kconfig
+++ b/drivers/misc/mei/hdcp/Kconfig
@@ -1,4 +1,3 @@
-
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2019, Intel Corporation. All rights reserved.
 #
-- 
2.26.3

