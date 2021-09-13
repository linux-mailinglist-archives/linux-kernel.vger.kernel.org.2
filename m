Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48DD408955
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhIMKtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239098AbhIMKtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631530075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=jW3RSfCiVG035tkP4VV2MK7HMp8Gx524MEf00frh+Is=;
        b=LHPBXU5uIMV3lvi85Sg2rtrloI2LH/wPCm+bHqMUfAgKL8qt0VlKPMCH76lCSfzUgQmmV1
        8OU18Q7lfc95w/+vrJb09FyrjU3HYqxzJDIK+Nz4PjPsTL+OtaZSOb75ItgeR0ktpesB2e
        x4A8yNUDHX0MfecAqWOH+8L3bJrxJxk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-7ZGVaP-vOWKhxT7c-mzChA-1; Mon, 13 Sep 2021 06:47:54 -0400
X-MC-Unique: 7ZGVaP-vOWKhxT7c-mzChA-1
Received: by mail-ej1-f70.google.com with SMTP id r21-20020a1709067055b02904be5f536463so3505143ejj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 03:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jW3RSfCiVG035tkP4VV2MK7HMp8Gx524MEf00frh+Is=;
        b=a2cwyslQfttBhfcIvY4ejoJDhNmyg0b16upC6MkXTP6Er39Qrbccp1xH4qnOhiXBuI
         jqqCZfTyEBXmu26ZnfJJqpKSbpJD61rZn1ns/w7piIDH3azq9bAv8qVKQlbCxaVOhk+Q
         cS1P4NbRkOR1dEYIhXKzOiv5MvW4gPOhl51wKzAtsYQGMeOzhR+4AG03Gb9Yle9sLjXP
         j5xBwDJmceGM4j+VJtYOY3mirAmDyrgrOe0+UcWNgJrBi3hCKMMNMZxa5yo/ce0/0f6U
         1+bGMOB0fXT/BXcOO641zt4ii8ZP9r2Iz3KyHHy1hT5lmoVTqX3E43l2ao9XvGNZJXDD
         zWrA==
X-Gm-Message-State: AOAM530HT7ZQb8BsQiT6H2UZ/Ggca4iwnBSs7DXn/kfMmTlIcF1LfFF8
        dFgzge2Q8F2qGD74RO0p9as+xCUlzqcPN1McrLs4n+++srEp8+y+CTegq63bNQq/5ekNDqlBW9h
        A5lMypA+qVkGkt75yaWCxrR1o
X-Received: by 2002:a17:906:269a:: with SMTP id t26mr7121203ejc.20.1631530072840;
        Mon, 13 Sep 2021 03:47:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUzxkOpFlkukF5bylBkxuLJ8coUNDVC3dmW/I3lxI4GHhcqqXeIdferB5ZUa/gtf5ATObe8g==
X-Received: by 2002:a17:906:269a:: with SMTP id t26mr7121179ejc.20.1631530072612;
        Mon, 13 Sep 2021 03:47:52 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207f:418b:5703:fd4e:73dd:1986])
        by smtp.gmail.com with ESMTPSA id o15sm3258041ejj.10.2021.09.13.03.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 03:47:52 -0700 (PDT)
Date:   Mon, 13 Sep 2021 06:47:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] virtio: don't fail on !of_device_is_compatible
Message-ID: <20210913104640.85839-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change checking of_device_is_compatible on probe broke some
powerpc/pseries setups. Apparently there virtio devices do not have a
"compatible" property - they are matched by PCI vendor/device ids.

Let's just skip of_node setup but proceed with initialization like we
did previously.

Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Arnd could you help review this pls? Viresh is on vacation.

 drivers/virtio/virtio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index c46cc1fbc7ae..19a70a2361b4 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -347,8 +347,13 @@ static int virtio_device_of_init(struct virtio_device *dev)
 	ret = snprintf(compat, sizeof(compat), "virtio,device%x", dev->id.device);
 	BUG_ON(ret >= sizeof(compat));
 
+	/*
+	 * On powerpc/pseries virtio devices are PCI devices so PCI
+	 * vendor/device ids play the role of the "compatible" property.
+	 * Simply don't init of_node in this case.
+	 */
 	if (!of_device_is_compatible(np, compat)) {
-		ret = -EINVAL;
+		ret = 0;
 		goto out;
 	}
 
-- 
MST

