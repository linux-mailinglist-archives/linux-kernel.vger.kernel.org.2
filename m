Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B18372712
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhEDIV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhEDIVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620116460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZduZH7uIcqDrcp+Id8iATABsMeFNx9WnKRzKVMxr/dA=;
        b=iJvl4/Gd/mKe2wwNNPNoQ4nFA55/bqeJSq6FdxTilELrniIRmtrHvrTV1sx0N9M+DbrjIT
        LFIJjne+qsm6BhzsWAlcb2DTw/vCOKsIyhPRHWtcsRcFmZZn4hhCo2nMWYX0nqkBoeGdmn
        5C/kF4b+z1e+qudTy4956BHtJS502pQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-OR1chIB2PgyX7nFRtThHsQ-1; Tue, 04 May 2021 04:20:57 -0400
X-MC-Unique: OR1chIB2PgyX7nFRtThHsQ-1
Received: by mail-wr1-f71.google.com with SMTP id l2-20020adf9f020000b029010d6bb7f1cbso5447579wrf.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 01:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZduZH7uIcqDrcp+Id8iATABsMeFNx9WnKRzKVMxr/dA=;
        b=Y1VWSyR/i8dAK5rAjhL60K6yx9yM4Zt/RS1cjsHPwnw8zz7eoK3TxQPJ52FwsJDHm/
         Nz4bUsS/a7aSz0ArxpnfTsFor+5vmyVQoANCfFBJ0P1wo2FWJUgT6bK6HewnsP7NYacL
         LdFl8A4wa4vBeOAXRhaYsCxonYG7qdiT2XkNZhGfinZ+qzHvTPt8T9S/Up+IgSXE1W9J
         dSQSkyDWSnW2hC8OCn5BbGuCLt0fnb/dUdnWu5vmSKUss5hFX5JenCgJMc0ly+kuf25o
         mvQ7dlhiYgmS1B6pYoueAYQ1NZ/BjFlvbph2CgG8ljAjvDdGwoBzWappIsisMnX1uRd4
         VM9w==
X-Gm-Message-State: AOAM532HEKPkT4L5v3mU4TR1K2cxtvY/Iq4ivDOg3GHbxG7XGsJiXkCO
        T5SfPXXFZAj0d/g6yeHkphXGTeF8aQBVbQ1OpgNY0i2EVYwXyumHGMAy7xPMikNaViKpr3p6iEE
        8Jt5Az+BO8Jw7st+xKAFMwAuCKZrFm4MstxHo6vJgsmwEkODfYxXPrIXmbOAQMlR7yR8FmQ==
X-Received: by 2002:a1c:4482:: with SMTP id r124mr2600002wma.42.1620116456258;
        Tue, 04 May 2021 01:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwio/Fcw9s4W5lDKZ/mtZxroSdSPwEkZaybadnCc9xMJ6LakGIrRp0EXSNfm8bUGh5UKO2N+A==
X-Received: by 2002:a1c:4482:: with SMTP id r124mr2599983wma.42.1620116455999;
        Tue, 04 May 2021 01:20:55 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
        by smtp.gmail.com with ESMTPSA id d127sm1633011wmd.14.2021.05.04.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 01:20:55 -0700 (PDT)
Date:   Tue, 4 May 2021 04:20:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 1/2] virtio_pci_modern: __force cast the notify mapping
Message-ID: <20210504082034.118581-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching virtio_pci_modern to use a helper for mappings we lost an
__iomem tag. We should restore it.

However, virtio_pci_modern is playing tricks by hiding an iomem pointer
in a regular vq->priv pointer. Which is okay as long as it's
all contained within a single file, but we need to __force cast
the value otherwise we'll get sparse warnings.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 7dca6c0ea96b ("virtio-pci library: switch to use vp_modern_map_vq_notify()")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 722ea44e7579..30654d3a0b41 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -224,7 +224,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				virtqueue_get_avail_addr(vq),
 				virtqueue_get_used_addr(vq));
 
-	vq->priv = vp_modern_map_vq_notify(mdev, index, NULL);
+	vq->priv = (void __force *)vp_modern_map_vq_notify(mdev, index, NULL);
 	if (!vq->priv) {
 		err = -ENOMEM;
 		goto err_map_notify;
-- 
MST

