Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9839D38F18E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhEXQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233102AbhEXQaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621873728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rzVWT+hgucJulWTbb27JAU0YdQhBiQeXz3Y6dtzUOvc=;
        b=CKiOwBs86tuCfvZ7SLf2moKR38PHq5qGHiZvKIS4I0HbdKErjWSIIDZWzFHOU2MyJisjQ9
        opBa9uLXzW2UQgjil33c67UhdLJ+EPdY0Cit1KdQhvU4fU2MtrYZvXC0MhdjKp4U0EPTU7
        U79H4O4nBi0l3+NXGAdng1oxHu75g3Y=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-gxTNs0F1OI-VeaOA89P_Xw-1; Mon, 24 May 2021 12:28:46 -0400
X-MC-Unique: gxTNs0F1OI-VeaOA89P_Xw-1
Received: by mail-oo1-f70.google.com with SMTP id t19-20020a4ae4130000b029023950cb8d35so3349684oov.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzVWT+hgucJulWTbb27JAU0YdQhBiQeXz3Y6dtzUOvc=;
        b=Ufi3psgkzNSVUoLIIQNf/251s9x5vtPMJB7rG5C43P/ZCyE4stlo/5AjjKal+uJKNm
         LnFPgPBDZ9+ZlxaWifV+YHnHDpcOD+kyz/kbyE+UPNAOfN7avEbtJFwHgpUT3ol3i1OT
         u2bPe8Mh+F+F8Tkuefreq67MNa0iThjQEU1v0jMtwVTBlkMdCg9Dc4ki6A399aYhWf+z
         YRjV3rPQHfq0h3Q8nd+JJXkCdqJ2qu0oDux/CHhH23C/fo9FLP8gJcoIpXIsmLNutcAe
         M4wD0sxsHsIBNyvTBD9cIpm5N6cuEUZfXwmLNdp1w9m6eBxEXHokOQ/HMQDVk4dA9wz4
         9t3w==
X-Gm-Message-State: AOAM5326Bb/ABVtBxnHspRCbDcKv/FnGU6fHs0m2nLv1+YkGAAb1pXkF
        EYW2sieBcMaDeE6IuwXUqhXCkvBvn+TdpKM8uGUhwxtj1w39lwnvwHbTvrRFZehuKnbHHin3cIS
        MSAhU7o0O+0ewpKnw7sn8B/V4
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr11039792oif.17.1621873725927;
        Mon, 24 May 2021 09:28:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZCllVamKPDAcqNe9vkFb8F/MCgjRAEAJeL9eXqfRMBxwbIVKkyvMaaHJTDZ2qwSv/+R2VXg==
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr11039784oif.17.1621873725765;
        Mon, 24 May 2021 09:28:45 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q26sm3111066otn.0.2021.05.24.09.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:28:44 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v3 5/6] fpga: use reimage ops in fpga_mgr_load()
Date:   Mon, 24 May 2021 09:28:37 -0700
Message-Id: <20210524162837.2221590-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
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
index 5247703a3743d..34d251e87ca6c 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -369,6 +369,9 @@ int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
 	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
 
+	if (info->flags & FPGA_MGR_REIMAGE)
+		uops = &mgr->mops->reimage;
+
 	if (!uops->write_complete ||
 	    !uops->write_init ||
 	    (!uops->write && !uops->write_sg) ||
-- 
2.26.3

