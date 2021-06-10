Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3E3A368E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhFJVsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231365AbhFJVr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623361559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7i5e+OtT+7tpx8qfL0qW2Nid+sJzqzF/pZfWD+IYGk0=;
        b=AeRmnKhuFeAmLsFvwaGWi0wU8H83AVW2JiZcXgOHpWUAiM04/oOpjoe77yFOeB66b7jZ/k
        FMGREIb6+prMVnzgZ7TLgXutYJKdlrjVh2+EXQOFr5BRHpqlcl9dz4WclEg8kOf1wUiIBI
        HmhRnzJ6n1kuUJ4EVqG7QI8mRO4Vu9Y=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-ieJZFnH9OhGp-IgfBGryoQ-1; Thu, 10 Jun 2021 17:45:58 -0400
X-MC-Unique: ieJZFnH9OhGp-IgfBGryoQ-1
Received: by mail-ot1-f70.google.com with SMTP id r16-20020a0568301350b0290363e6a9392fso657156otq.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 14:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7i5e+OtT+7tpx8qfL0qW2Nid+sJzqzF/pZfWD+IYGk0=;
        b=kYM+GdmPFpIu5doHli+lyaDdMj/r7Y4BjLf1KhovOToOX0GF31qSfMbrR0dYAWQjjI
         DZwXcbakoqAf/2BnX5iEN3LP86MdmbmmZ3Ul6vtWWWeYelWOfp5InADJA9PS55aoj15s
         x0AU3FY1U/XNEvQlmKMjvu0MpPXCZ/FVuh3+pnJoJU4fwul0tgxI+1dxZTAD+EflybjC
         NTlhaZqSN5eA/BnrxJ5J+u6q3QEFMxS3k4Mm2PqHGV9D6llBfKL+CyIHbl4RPvHN/Ohm
         OGRe45MNXdQcEGGMMiaSRbfZ5RQK5V4n0fyk7IH0IPW0TBs+GE84hruUftKAPy8uj5EI
         /8JQ==
X-Gm-Message-State: AOAM532IwPnN3wdq18mu6qQg1k/1mrXY6vqFCvPPYxUEC+pfbTuV4cuV
        D42l0xU9B6oV9fYVOr6MGuldAGIGHN5DZgVrs0B7UFnSd4v3D02jTq6VdeF026P/zJ1RHyL1bWP
        vvFSlb5jflXs/qsHfTkj5ORCW
X-Received: by 2002:a9d:426:: with SMTP id 35mr375807otc.162.1623361557579;
        Thu, 10 Jun 2021 14:45:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGF5LvkW/bwE5nlK1SyjpSfDezjll8ZHnP0L9H/o8fCFKmkIJKYig7nd4MMYjIcR0HYassvw==
X-Received: by 2002:a9d:426:: with SMTP id 35mr375776otc.162.1623361557405;
        Thu, 10 Jun 2021 14:45:57 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i15sm881839ots.39.2021.06.10.14.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:45:57 -0700 (PDT)
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
Subject: [PATCH 5/7] iio/scmi: fix spelling of SPDX tag
Date:   Thu, 10 Jun 2021 14:44:36 -0700
Message-Id: <20210610214438.3161140-7-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610214438.3161140-1-trix@redhat.com>
References: <20210610214438.3161140-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

checkpatch looks for SPDX-License-Identifier.
Remove the extra spaces.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/common/scmi_sensors/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/scmi_sensors/Makefile b/drivers/iio/common/scmi_sensors/Makefile
index f13140a2575a4..645e0fce1a739 100644
--- a/drivers/iio/common/scmi_sensors/Makefile
+++ b/drivers/iio/common/scmi_sensors/Makefile
@@ -1,4 +1,4 @@
-# SPDX - License - Identifier : GPL - 2.0 - only
+# SPDX-License-Identifier: GPL-2.0-only
 #
 # Makefile for the IIO over SCMI
 #
-- 
2.26.3

