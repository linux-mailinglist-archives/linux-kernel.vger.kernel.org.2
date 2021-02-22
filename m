Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF406321125
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhBVHJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:09:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229908AbhBVHJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613977656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDuXO5zUJ4skk3u4UbGFqeIktbCo8MisQ81CqMl1/44=;
        b=Qe0ZZtDgIHcmf3X92JOaLc0RMrpGrvEvnU3y42faHYj5geppSqxJ1JnTq3fOoeLKZ368Cz
        jAWgR/vNwmLMRqdPui0+mrATGdg5bPClDeHQVb7GYxr8REbLGqLNV3VNuWN9l8N8IgEVPZ
        v05aAelkdhWy+RSHQZRMq3r/LuxwJAo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-M8VFg8ZbMhOztS6OKo-ITA-1; Mon, 22 Feb 2021 02:07:31 -0500
X-MC-Unique: M8VFg8ZbMhOztS6OKo-ITA-1
Received: by mail-pg1-f197.google.com with SMTP id m5so7602670pgu.21
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VDuXO5zUJ4skk3u4UbGFqeIktbCo8MisQ81CqMl1/44=;
        b=fTWnzOD/S0iX6RY4ZSEwUnAC5vup+oR7If7LBWEzYJdSNnTKsu1P35aRKwpxc/JBo7
         RlltGqPQQIPJX2O2Uf8V++DhL1NEFoe/QxxeRbtM6Jpp3GS7SXqpkrCiCSP3lhxGlzm3
         RCw4n1K6lNBxUnrnPNA+0ejnBYeKZvx1v9gE6BzepYalfOzgf/35Vhjk5Op/HBDmgse5
         JFzwpeYemxvzQ7aWhrph3Y/S+BIy7tOdBjQG2+De7NdifAZw5s3djaTF6v+nyUvRzd83
         tm94P/+1+xxYBot1vrt3ETDMhGQAXiKSKjjbv+JOtfcIbuBpg2HR7CrrCuNlHWi38BEm
         jmVA==
X-Gm-Message-State: AOAM530eksOAyblxqraUwS2JBhAWxbxpXj1bnisSXO2AOSgIGP+YEO0u
        odCQPH7ot1xlIXhgtY7X4loiJUdkvrOT/p1C9ZK4wOLTl36HkWsSRwfjd+7xN9KZIUIpy10yrm3
        Q45TtkkW1Voaxuwx9TDT6OjUQ
X-Received: by 2002:a17:90a:cd06:: with SMTP id d6mr4867752pju.138.1613977650543;
        Sun, 21 Feb 2021 23:07:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz79OrKbRrtAfiD6Esm6oEGGKH8K+mEKBsf+u12b+o9o8Q4Qyg003s3d36qBlqAERFQrUMlJA==
X-Received: by 2002:a17:90a:cd06:: with SMTP id d6mr4867739pju.138.1613977650377;
        Sun, 21 Feb 2021 23:07:30 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g65sm16855068pfb.20.2021.02.21.23.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 23:07:29 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     netdev@vger.kernel.org
Cc:     kexec@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 1/4] i40e: use minimal tx and rx pairs for kdump
Date:   Mon, 22 Feb 2021 15:06:58 +0800
Message-Id: <20210222070701.16416-2-coxu@redhat.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210222070701.16416-1-coxu@redhat.com>
References: <20210222070701.16416-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the number of the MSI-X vectors to 1. When MSI-X is enabled,
it's not allowed to use more TC queue pairs than MSI-X vectors
(pf->num_lan_msix) exist. Thus the number of tx and rx pairs
(vsi->num_queue_pairs) will be equal to the number of MSI-X vectors,
i.e., 1.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1db482d310c2..069c86e2f69d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/bpf.h>
 #include <generated/utsrelease.h>
+#include <linux/crash_dump.h>
 
 /* Local includes */
 #include "i40e.h"
@@ -15000,6 +15001,14 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_switch_setup;
 
+	/* Reduce tx and rx pairs for kdump
+	 * When MSI-X is enabled, it's not allowed to use more TC queue
+	 * pairs than MSI-X vectors (pf->num_lan_msix) exist. Thus
+	 * vsi->num_queue_pairs will be equal to pf->num_lan_msix, i.e., 1.
+	 */
+	if (is_kdump_kernel())
+		pf->num_lan_msix = 1;
+
 	pf->udp_tunnel_nic.set_port = i40e_udp_tunnel_set_port;
 	pf->udp_tunnel_nic.unset_port = i40e_udp_tunnel_unset_port;
 	pf->udp_tunnel_nic.flags = UDP_TUNNEL_NIC_INFO_MAY_SLEEP;
-- 
2.30.0

