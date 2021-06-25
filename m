Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CC83B496B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 21:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFYTyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 15:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230003AbhFYTyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 15:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624650739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjAdCEfiqEm9c0Ynsebg4BWNbSDpcr72TwU3P0oRZpc=;
        b=VSF5jgK+HMRUdpnVfJO8GcCW2SspgeM/uGFcNANNoFl/zGsjkHZanx4ZfGxxgcu2If9p3E
        olgb3eUcOUl2eI9SHZTr05sfDxR7hQVFY9Z0YmoYIeBlx4nRmIrs/SUq1Rjc8A9bR373nO
        Pg5XeMdqFj7n4B0Z/ajacxBbSJuN/5M=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-28D7XJ5rPlGyCS90rQioZg-1; Fri, 25 Jun 2021 15:52:18 -0400
X-MC-Unique: 28D7XJ5rPlGyCS90rQioZg-1
Received: by mail-ot1-f72.google.com with SMTP id a60-20020a9d26420000b0290448d2be15e6so6521146otb.23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 12:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjAdCEfiqEm9c0Ynsebg4BWNbSDpcr72TwU3P0oRZpc=;
        b=OFjoD4uE0O0yYcH5AJ6xotmD3YnN8OhTVV/SkXvvrT74Qp7XacLDuL0ATbx3xwJ8dl
         FzGqywWAZCRG4yWvpoWF/XoswkFi24UFbE+xsPagXojxwSZ+AKTnl+KNNRjcopXYXEEu
         REHjEKlg35PqGuT3UKUIx70EBd+MidMjS29olvtiu182FH/VkvqH2mZec5h695H+pv1Y
         JxdwYjAxRhKFU4FJTGiALa0qJNUJHgd4FtwDPm1q7IR5pzcNbGfzU9HxzgS8wUnGiNev
         C3I21I5w3SLXlX8aDAhHNfZfNAJA7UnVPuvjzbLOy4tAzH9MHnymWyCGYEqsfvuV9xT3
         culQ==
X-Gm-Message-State: AOAM533mZ9dcMb0Elg5/E1Nm5kspPLhpldHvgS2deGiC75zxhpbA5dn9
        argUneF3lja9VKxkad6u6CUqIW+7M6Jr7no2JNRqqbH5zBvcD0+oZpw9qOy89ckjXVX8jSWRU5J
        nzMtpKnAzjvlEHexVXeEU7J+s
X-Received: by 2002:aca:e107:: with SMTP id y7mr12990074oig.11.1624650737409;
        Fri, 25 Jun 2021 12:52:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF1c4CKnAxDSoTM1uv3ouUh/l8z5JnAQLTGazp+4FQ/B0la7C6C13aQqkvGpjE5+63AdBssw==
X-Received: by 2002:aca:e107:: with SMTP id y7mr12990063oig.11.1624650737263;
        Fri, 25 Jun 2021 12:52:17 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm1535446ood.20.2021.06.25.12.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:52:17 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 6/7] fpga-mgr: wrap the fpga_remove() op
Date:   Fri, 25 Jun 2021 12:51:47 -0700
Message-Id: <20210625195148.837230-8-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195148.837230-1-trix@redhat.com>
References: <20210625195148.837230-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager is not required to provide a fpga_remove() op.
Add a wrapper consistent with the other op wrappers.
Move op check to wrapper.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index b3380ad341d22..077c0f9edbe4c 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -25,6 +25,12 @@ struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
 };
 
+static inline void fpga_mgr_fpga_remove(struct fpga_manager *mgr)
+{
+	if (mgr->mops->fpga_remove)
+		mgr->mops->fpga_remove(mgr);
+}
+
 static inline enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
 {
 	if (mgr->mops->state)
@@ -745,8 +751,7 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 	 * If the low level driver provides a method for putting fpga into
 	 * a desired state upon unregister, do it.
 	 */
-	if (mgr->mops->fpga_remove)
-		mgr->mops->fpga_remove(mgr);
+	fpga_mgr_fpga_remove(mgr);
 
 	device_unregister(&mgr->dev);
 }
-- 
2.26.3

