Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315143996BD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 02:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhFCAJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 20:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhFCAJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:09:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424A4C06174A;
        Wed,  2 Jun 2021 17:07:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l2so3967779wrw.6;
        Wed, 02 Jun 2021 17:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/40yrZEmTw38XoudCj0eBc6VFODfzqS8zSplLpV/s0w=;
        b=EJTd3e61YDXLsjBE2nXOAbobTa/siUvx1f9abZbY4kPnR+/RnRa+8FErcSG27kXNJB
         uorOw85lGzcNh3VPkuG2dEdAYQ2lmHoLhp7BDv3O8RlQiL3F8cnqk/CXU2qMikOL/GF2
         aie9Y8styq21wxwOZpWkK/TmdpQDtMsAgR7I6b+9AhURzIIJ2tGbURzV4BCBDx5dARUs
         2pNkoJFUWpqhkQbpILTb0vvx92SqGUrbe6zzZm7INCCzlbxsh460MuY6hV0L9pz2UOYe
         Ldq/odwZIdHJqkEWA63HIrNPT/Teanaj7nnV3SiDmYTYN/x/M0nYiPJ1UZwEmKBwGmRb
         gUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/40yrZEmTw38XoudCj0eBc6VFODfzqS8zSplLpV/s0w=;
        b=m3N2bsoYOO18rV7kJ/3RTkb5UvK55Zlrl4KsEG94s68IJkdioCbme0/jXvXGqajQwS
         hvarmQGCJZNrp3ecC/n1ghrox6bMOU/3uYd/YyJFKJVfPTh9TlPigyvmCIM/rDTm+W2Z
         1s3Tc1hlEOoTEEdVDejMl0tKnJ3R7ogLh5UByF7+rCDJCqcnbblrID2Pt6wtRl8Hp4//
         Sr6VCz5pd7pvZ55wqj/OYIc1xOCCB/kWNAoXo9XleAFsNBZ07w8qwU6igsHHmgbRBoWG
         9e8fwoZ98sp7ZKR5ST5xWKV2EA5ErIQfnrOoj9+UvXRKeRvtU2Rrw/FOWygysa0kOnOk
         CMhg==
X-Gm-Message-State: AOAM533rIj493w9GtongJoYvdJpM7KqlKn3YMDKvfCepUmh4Mkrxu85w
        JPDoVPXFvh8ad5ug9M6xmxQ=
X-Google-Smtp-Source: ABdhPJxGDaHJMbFUUo9VBs64Qar/iKTT63D+iFwFt75kYDv3+ppVG77NQPdjiRVIVuoIuvZ+4QOxng==
X-Received: by 2002:adf:a489:: with SMTP id g9mr23998174wrb.103.1622678819134;
        Wed, 02 Jun 2021 17:06:59 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id w8sm1471409wre.70.2021.06.02.17.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 17:06:58 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] platform/surface: aggregator: Fix event disable function
Date:   Thu,  3 Jun 2021 02:06:36 +0200
Message-Id: <20210603000636.568846-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling events silently fails due to the wrong command ID being used.
Instead of the command ID for the disable call, the command ID for the
enable call was being used. This causes the disable call to enable the
event instead. As the event is already enabled when we call this
function, the EC silently drops this command and does nothing.

Use the correct command ID for disabling the event to fix this.

Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 8a70df60142c..a06964aa96e7 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -1907,7 +1907,7 @@ static int ssam_ssh_event_disable(struct ssam_controller *ctrl,
 {
 	int status;
 
-	status = __ssam_ssh_event_request(ctrl, reg, reg.cid_enable, id, flags);
+	status = __ssam_ssh_event_request(ctrl, reg, reg.cid_disable, id, flags);
 
 	if (status < 0 && status != -EINVAL) {
 		ssam_err(ctrl,
-- 
2.31.1

