Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9253B4992
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 21:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFYUBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 16:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229962AbhFYUBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 16:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624651154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TgS1W0YkxnAj8zzimJEJj0dUofXVg1iWDV0xL3ii1c4=;
        b=HrD7nyrrY8V+GAO8TXHbO55UFtViM2QzsL8sXHT8CAtM6gUC5ZJ8gDoPidexnu2adwJ2hK
        Zm+M/S9KRludspwAw9q7J5U0IP8HV+fonrAf/i0lzm092cJjl8BjAo8HBzYy87WrUKdqPx
        SEbk13T4Nx/HOEZZcJIz0i+ZD5RGRxM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-25wtRvjvNk63DCLBv_2lXA-1; Fri, 25 Jun 2021 15:59:10 -0400
X-MC-Unique: 25wtRvjvNk63DCLBv_2lXA-1
Received: by mail-oi1-f200.google.com with SMTP id t185-20020acac3c20000b0290239f91b62c6so5307442oif.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 12:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgS1W0YkxnAj8zzimJEJj0dUofXVg1iWDV0xL3ii1c4=;
        b=ieZNo0aKmBxng8rW8xdeE9fWADkrZLRaO6rOMtObRs9uT9NYWJMPWIEK77KWzEDYR7
         iMK9BCdXg6Rnt8QkiH9Y/9namz75enmUj+kEp9fC/rWr02e638O77SzUFUWtSFjoyKjt
         uv/YwaY41xyNJU4RmYJ1OWja7ncmvbOnx/dahD34sQsaXhpBsRxgA4Mams2yRbj67jAi
         LHK3NNFNkyJHg3j2WpoGX90Pwsi/tcYU169+rR0fYiP7GWjtFa77hlwHakmnJ3LBiOYg
         JFIbbe0+ZL2F0Um314qdtFwfEp5oIBjrk9rujKbN2Qpwq+eLpzh5tHhzsRW+BMSuP4vQ
         x01Q==
X-Gm-Message-State: AOAM532LFqCy4QE2EPKiRowvgy/DjkQPnEz32lXF3erpeJWNaHuXRMVb
        vKNG2eWOxOrwkDhqF7FEeHeNdRJRent++rw7uX6i/XFNcSjPd+LZloHKF+p3zblJPEXh8IvHSbx
        /CSKV5jokOEmRX91tHlA5tR/T
X-Received: by 2002:a05:6830:1e55:: with SMTP id e21mr8941886otj.29.1624651149615;
        Fri, 25 Jun 2021 12:59:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK16sNuDxGos3d6wDWJs1xw8YcqRzRff8x/NSugHYZvhWkQA++qMFqI3SoPwY6dhVGg3zmTg==
X-Received: by 2002:a05:6830:1e55:: with SMTP id e21mr8941875otj.29.1624651149422;
        Fri, 25 Jun 2021 12:59:09 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r204sm1467374oih.11.2021.06.25.12.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:59:09 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v5 4/4] fpga: use reimage ops in fpga_mgr_load()
Date:   Fri, 25 Jun 2021 12:58:49 -0700
Message-Id: <20210625195849.837976-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195849.837976-1-trix@redhat.com>
References: <20210625195849.837976-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

If the fpga_image_info flags FPGA_MGR_REIMAGE bit is set
swap out the reconfig ops for the reimage ops and do
the load.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index c8a6bfa037933..5e53a0508087a 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -419,6 +419,9 @@ int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
 	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
 
+	if (info->flags & FPGA_MGR_REIMAGE)
+		uops = &mgr->mops->reimage;
+
 	if (info->sgt)
 		return fpga_mgr_buf_load_sg(mgr, info, info->sgt, uops);
 	if (info->buf && info->count)
-- 
2.26.3

