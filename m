Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B75A32112A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBVHJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:09:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229908AbhBVHJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613977663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAp2I2H4ORRdIzGQOTnp0OVejY1BSXenzSWMruiT71M=;
        b=dzq04eqZXhlutVjLsfdvIhDYCLYMIskdl2vpfC5eyu/B4W6JhfVIIhviRh+RYomYa7Gz9W
        F/6Eqqz3FMZ44b4ubEo7c23MZd0guG5Lqk0CxFz26930mCdHafkRGYwbMWTiubZXrtTsFU
        dGyvQxa4kYu6vF1JJ3InhyRo1H5iAt8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-8Aw5AxU9M6uwytb1Qv9seg-1; Mon, 22 Feb 2021 02:07:41 -0500
X-MC-Unique: 8Aw5AxU9M6uwytb1Qv9seg-1
Received: by mail-pf1-f198.google.com with SMTP id 185so3983099pfx.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gAp2I2H4ORRdIzGQOTnp0OVejY1BSXenzSWMruiT71M=;
        b=BB0A75KZTNr1Hgo6jVaCEQeMm6E8btGm1wWLxiSyNFmz6XEUW4VlniHBDPS9U3Mibj
         gZlmGvMKdZwrOtng5ynKpdGokD8VRHbgfmoZErISjGIIXYVILYOK8LbC85LcSROJzPCT
         u3HWTDhfPEXfDX4wWGejhO+BhWhj1kP22wZu3Dior3wb/6Jg3/6PRdgO3SfbHhcoEVTO
         MnvanZl6xSYW1iOuwczI14jDIkbO3LRHxQXEqNTKG3P7KBBxWlRjF57Qx9y0hTCXnLNf
         RmZLHHcz6Qs6CI7o04IEFjPGidQOU1rfr514Xwk8kZmIrtT0LSJKBjd1bFCtIhATgiPF
         lo6g==
X-Gm-Message-State: AOAM531lYn+IZEy0jYDcYDKQksEYknp+6R+k89owhzuYpkV4l8UaPvLX
        V3GnuZ5PItki7SqeEqcAZJgkXVJD0CwiTtK9OQtOqGGMgzUx+b59t+P6BbLE8w3O4rqU+RVQLC0
        9xDtIYbx1KYmIm9x20kyabihL
X-Received: by 2002:a17:90a:194b:: with SMTP id 11mr21935618pjh.100.1613977660050;
        Sun, 21 Feb 2021 23:07:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1p7DWcYJD3VbncV/CfHu7aM+wNHjZQUVuys68WjauioDf0PpZYeqnLQl9yRTiF9YT6Xnl0w==
X-Received: by 2002:a17:90a:194b:: with SMTP id 11mr21935603pjh.100.1613977659906;
        Sun, 21 Feb 2021 23:07:39 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h186sm13422121pgc.38.2021.02.21.23.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 23:07:39 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     netdev@vger.kernel.org
Cc:     kexec@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 2/4] i40e: use minimal rx and tx ring buffers for kdump
Date:   Mon, 22 Feb 2021 15:06:59 +0800
Message-Id: <20210222070701.16416-3-coxu@redhat.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210222070701.16416-1-coxu@redhat.com>
References: <20210222070701.16416-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the minimum of the number of descriptors thus we will allocate the
minimal ring buffers for kdump.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 069c86e2f69d..5307f1744766 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10552,6 +10552,11 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 		return -ENODATA;
 	}
 
+	if (is_kdump_kernel()) {
+		vsi->num_tx_desc = I40E_MIN_NUM_DESCRIPTORS;
+		vsi->num_rx_desc = I40E_MIN_NUM_DESCRIPTORS;
+	}
+
 	return 0;
 }
 
-- 
2.30.0

