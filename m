Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204A032CAA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 03:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhCDC6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:58:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231645AbhCDC5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614826578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FA6BZuyV38c3YF27I/4JJzwcZMi3L5CohRcD+JgR934=;
        b=cac8VT6up9ErW0wwTBrDthCIhOzfD5hsnW3wGbCLbC25IOpwcDfe6jlwfYDwvBlIwGALVf
        G2buUWjlzZ/tbsOGgVHfWzYrJaY7HxxPZWqlDt5KNiuBIFedve63Q2G0NoTqbxf8QddrqF
        fUZccZhk9H77dwX/dA6EuAUMlkfFjwQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-w9Ak51T9NDiUmskljOEAmQ-1; Wed, 03 Mar 2021 21:56:16 -0500
X-MC-Unique: w9Ak51T9NDiUmskljOEAmQ-1
Received: by mail-pj1-f69.google.com with SMTP id w34so6076133pjj.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 18:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FA6BZuyV38c3YF27I/4JJzwcZMi3L5CohRcD+JgR934=;
        b=Tby1hH2oMygq54zntugc7y2wJk5IASInFteeMgMdSmEhYRVYTx/mdseJehdy6fRMku
         JZXZkC+XAO9vVL2EoRv6+GWe0l+hjB9ehCIegxulx6GV30MDY+DuBOZ6cSlZLo79MvZb
         7KMWOmxSrDLoiBaFJQrPJU7JAYMMDTqvg7unVJ12CHOjUlEnmd/P4oQmK2/y1IEvgeC8
         8g6dRSI+pi3QEAoj2n4Ei/P7QQ0Mpmfqh7tMrGQpX8HcGn9YsPW7QPR9uBRkJROtnbVl
         JjV8O653It6bkM/9LkOfwv8+EaCXIZ66wOXXLW/SMIDWehJqroYLXmJPyEH3AVDdC6VE
         BfJA==
X-Gm-Message-State: AOAM531ZCoGMBAjRos1krmElF8Au1WKYb6pxPn0ubKfl2aKs8Y4m9oRB
        92w1YFbLTwJghp/kg6i1+Dp9rfjEfukjKrIoupxbIjAoJkXmIezCSbuD1et6OrNgQ+rNFHf1IIg
        D2SrNbSJEfYXHz6DhYXKD9A9i
X-Received: by 2002:a65:5c44:: with SMTP id v4mr1744689pgr.362.1614826575665;
        Wed, 03 Mar 2021 18:56:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1bASs2zrVWtBHAHrTSx94w1A1x/eQEswXocM9aF31cnI8Y/v8xm2wnwLv/SjOD2bhlB1lfg==
X-Received: by 2002:a65:5c44:: with SMTP id v4mr1744680pgr.362.1614826575451;
        Wed, 03 Mar 2021 18:56:15 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u17sm701808pgl.80.2021.03.03.18.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 18:56:15 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     netdev@vger.kernel.org
Cc:     kexec@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 1/3] i40e: use minimal tx and rx pairs for kdump
Date:   Thu,  4 Mar 2021 10:55:41 +0800
Message-Id: <20210304025543.334912-2-coxu@redhat.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304025543.334912-1-coxu@redhat.com>
References: <20210304025543.334912-1-coxu@redhat.com>
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
index 353deae139f9..77bf8c392750 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/bpf.h>
 #include <generated/utsrelease.h>
+#include <linux/crash_dump.h>
 
 /* Local includes */
 #include "i40e.h"
@@ -15485,6 +15486,14 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
2.30.1

