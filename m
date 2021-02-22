Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D98321132
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBVHJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:09:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230077AbhBVHJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613977680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cGC74PMCnaWbBAWCVUBDXRxKgEXEKkWJtgVHkIGS/0=;
        b=S+iIP6z44zesW//YgNL3eQwctMEzhHoB1uj4rMgtoI887OYm5wdnxGgaCkDdG6uN1UGHeu
        Y5kYhATBdh4ZfvHBp+9Jyw32I4SqLAliERLmDYdKSw4huPFIixxXwuN3JZPMcMk+YsB6Oz
        7ZDoeL3gDMA5OFaCPMZImVPhoeJ/C18=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-UcZMj1g5O_iXahSfecKrtQ-1; Mon, 22 Feb 2021 02:07:59 -0500
X-MC-Unique: UcZMj1g5O_iXahSfecKrtQ-1
Received: by mail-pg1-f200.google.com with SMTP id m5so7603170pgu.21
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cGC74PMCnaWbBAWCVUBDXRxKgEXEKkWJtgVHkIGS/0=;
        b=tSaXTNVn7CAeo5JRi2QaDoRvZr0ndocEldGrs0DhwgoYYll+W/eGrnX5HjMuspRnqp
         yd+d0aho6E+bae3px6N9m+eBiGJbhIHFtTT5wNtusSxhONjPiYiJrN22onAGQJ2Dy7M8
         J8tK18V+o7Pz6xfzZh/ljV1lVwTP4+Fxmn8BEsplBiG1NTPXOdy8DR4IWttY+Ud4HemO
         rkNOVKMf8aN8YimkKDtuQ3KvOanpBf9+FLW45k2xGzayLVz7GB7K2d17aomii4FeWkV1
         6VOgsqUxdZRHX1H7hQhAsVBzku3KUoHlcYKvkflmX3msisaZ4MPV76qxSHhL7x5EmVWR
         +PBw==
X-Gm-Message-State: AOAM531Cr6YS6EtsMa7qBsDWHRVUrrpdqoFQbKSX2kG7p+1eVhuJZX0s
        WxeVgZJHUlcnMA+uSg0Z9Fw+aGeuuryR3sZQQcNwQc/ABY2SQ5C+PrWvZfLi1s9hifotyDRR8zw
        HGL3mRvjjzajY+ftmYS0KhBh9
X-Received: by 2002:a63:3602:: with SMTP id d2mr18862396pga.81.1613977677766;
        Sun, 21 Feb 2021 23:07:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzG0zRT+B2eqBSHJCG+woLse614WOgfmD0XJ5e3O9heRqpM5jj6GbtUXuwOa2JP1tEgm2+OsA==
X-Received: by 2002:a63:3602:: with SMTP id d2mr18862385pga.81.1613977677597;
        Sun, 21 Feb 2021 23:07:57 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ig12sm8527195pjb.36.2021.02.21.23.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 23:07:57 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     netdev@vger.kernel.org
Cc:     kexec@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 4/4] i40e: don't open i40iw client for kdump
Date:   Mon, 22 Feb 2021 15:07:01 +0800
Message-Id: <20210222070701.16416-5-coxu@redhat.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210222070701.16416-1-coxu@redhat.com>
References: <20210222070701.16416-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i40iw consumes huge amounts of memory. For example, on a x86_64 machine,
i40iw consumed 1.5GB for Intel Corporation Ethernet Connection X722 for
for 1GbE while "craskernel=auto" only reserved 160M. With the module
parameter "resource_profile=2", we can reduce the memory usage of i40iw
to ~300M which is still too much for kdump.

Disabling the client registration would spare us the client interface
operation open , i.e., i40iw_open for iwarp/uda device. Thus memory is
saved for kdump.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index a2dba32383f6..aafc2587f389 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/net/intel/i40e_client.h>
+#include <linux/crash_dump.h>
 
 #include "i40e.h"
 #include "i40e_prototype.h"
@@ -741,6 +742,12 @@ int i40e_register_client(struct i40e_client *client)
 {
 	int ret = 0;
 
+	/* Don't open i40iw client for kdump because i40iw will consume huge
+	 * amounts of memory.
+	 */
+	if (is_kdump_kernel())
+		return ret;
+
 	if (!client) {
 		ret = -EIO;
 		goto out;
-- 
2.30.1

