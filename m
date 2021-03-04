Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4C32CA9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 03:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhCDC6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:58:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231664AbhCDC54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614826591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27t46XHebLzRKwK6kiEaa5rYWovZp6L1OdarLDSHed8=;
        b=BOfRJWt/UcbkBkVojuk64kA1oZLT8Wn8rdXEndAj17UeYooYI7F1Bqu0d2UwvPia7w26zd
        MIrHevbpKF0f04ffLa13D2PZwbJz9s9H4+6R8SAIukopl3vph25cZKOjzDejqRD+bfuTIS
        6r6KQEFgUMK1bczduPElOZ99P8p+PLw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-Np_ryvL3MMu9rqLrkHrRuA-1; Wed, 03 Mar 2021 21:56:27 -0500
X-MC-Unique: Np_ryvL3MMu9rqLrkHrRuA-1
Received: by mail-pf1-f200.google.com with SMTP id b12so17066693pfb.15
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 18:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=27t46XHebLzRKwK6kiEaa5rYWovZp6L1OdarLDSHed8=;
        b=VN6NSn0UWYP9GaNNN/D+GG6BPgBkMjigpRNUms5JvDRPROwxxOjNnp5khWKEOpRVrd
         ejh0WGTDqbpaN4UhY+EGqAlu7Khl0YpveXRVfQUJjBqK1Xjjxx7MmZSuwPQe/DDbDw6h
         P8NHBmYo0Z4VVzeGPx/eDkJbZVgMkUk7YKnfJl9PGuuJVqMRUmLomDXFjyVsPhERSNdo
         p5V3cK0uETENFDeqIYKKyvumpMWvC8JnMytvYBQoc7CRZGLYr0jAchsE16/K0Eg4So41
         QKtygeShZGBDTVkcofu5Cq/+yboOvhhJGiVQWsaRA7F+dP2NzcjmPgksc/pNADcSFHtH
         SxYg==
X-Gm-Message-State: AOAM532iZb7sOA/YERFsyvRby0QIrho8tVxf63IMIHhgWapPxa7EPRrp
        U38oXy4foRQUY3OyeZYDTuy9Xou1E0XkaKFR663vjbeA6dcPspzt0/SUFvem1P/klOk/A+dnngf
        N6GSpoemaMUqvcNYw7F0Dz1hF
X-Received: by 2002:a63:511:: with SMTP id 17mr1722712pgf.173.1614826586229;
        Wed, 03 Mar 2021 18:56:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5O+3/Y8estRnruVL7Uuv/wewORRlTvTGikebpvnF1FMcUf9zFn3m1kmHhqr7CddFgmmra6A==
X-Received: by 2002:a63:511:: with SMTP id 17mr1722704pgf.173.1614826586086;
        Wed, 03 Mar 2021 18:56:26 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w188sm25973503pfw.177.2021.03.03.18.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 18:56:25 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     netdev@vger.kernel.org
Cc:     kexec@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 2/3] i40e: use minimal rx and tx ring buffers for kdump
Date:   Thu,  4 Mar 2021 10:55:42 +0800
Message-Id: <20210304025543.334912-3-coxu@redhat.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304025543.334912-1-coxu@redhat.com>
References: <20210304025543.334912-1-coxu@redhat.com>
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
index 77bf8c392750..d6868c7aee05 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11029,6 +11029,11 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
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
2.30.1

