Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB8361C54
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbhDPIs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241105AbhDPIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618562864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2r7NGmqheP2GV+6A/LiwNG2tOhjWpE+ouB1t/RVmSe4=;
        b=FUhgS5DsuE9li4xMlFG9nF2S4BrL+uOfeU8Cwf5Es7/eZ22UJGXVILczvaPcWcHvtbunbU
        77xXP4Ox9Atq3lLNIW1H1VQx8Bk6kW0iUgYpfPqn/o0BEh/IPLij5ONUcAqTvuF0lRRZet
        /j0lRhQa0q9aRVYVvrA/slWu+49x1Xs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-006IJkopPluMmfVFsoWBOw-1; Fri, 16 Apr 2021 04:47:42 -0400
X-MC-Unique: 006IJkopPluMmfVFsoWBOw-1
Received: by mail-ej1-f70.google.com with SMTP id k5-20020a1709061c05b029037cb8a99e03so1791332ejg.16
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2r7NGmqheP2GV+6A/LiwNG2tOhjWpE+ouB1t/RVmSe4=;
        b=dTLdVly+hhIugnJOIxAzBOm720ndTNKoAnmWD5zKOeMPWO7q8XVQMxx5KeBt5/pKml
         FDF781XgkwTvooZNXwB7JJB1uNtFw8nqea1AgSh4rqlkOzJG3tfHAm57SpGKP4pEwaR8
         g1+d8e7QzsiOY1tLJjKQnJ4439ItgNs3SzGJWv2y5E/uthTS0Re16jqvQUbjY95ucEBm
         1z4anIhFHEblRvLpHLdu3Cogq2QpQNr9WH4A/uXIsfzwQj9+4MdAIbaeX3MhIgN79ift
         6Kgbu1AqHE3rPvY+Rh2Gudw4d6OSVQlYkMhqPvP4LTk8GvyBZM/pqegmftKE6ZeAud5k
         rb0Q==
X-Gm-Message-State: AOAM532X61V8+QE/E3AL5O06G4WSdbp1L5B9kzn05B+wn4JGM1URXxf8
        mSBTkMHV038w6TB9be/bzQAmJh/pPcUhQXp+CD/a2n+3V8EoKBl/strU8+jzg5irgTihMUdobQw
        ufeSqWtcwhcCTayO8QAgEqeag
X-Received: by 2002:aa7:db87:: with SMTP id u7mr8433901edt.16.1618562861496;
        Fri, 16 Apr 2021 01:47:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB2d7tIaEFMBWd3DwYN1KfiOebKxLZRxhbIvY5dtME0hUSHkW/0SULGJHTws6pnnflB3CeaA==
X-Received: by 2002:aa7:db87:: with SMTP id u7mr8433888edt.16.1618562861323;
        Fri, 16 Apr 2021 01:47:41 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id m14sm1016232edc.18.2021.04.16.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:47:41 -0700 (PDT)
Date:   Fri, 16 Apr 2021 10:47:38 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Zhu Lingshan <lingshan.zhu@intel.com>
Cc:     jasowang@redhat.com, mst@redhat.com, lulu@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] vDPA/ifcvf: get_config_size should return dev
 specific config size
Message-ID: <20210416084738.k2xr7m6rdhrvoqr2@steredhat>
References: <20210416071628.4984-1-lingshan.zhu@intel.com>
 <20210416071628.4984-4-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210416071628.4984-4-lingshan.zhu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:16:28PM +0800, Zhu Lingshan wrote:
>get_config_size() should return the size based on the decected
>device type.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/ifcvf/ifcvf_main.c | 19 ++++++++++++++++++-
> 1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>index 376b2014916a..3b6f7862dbb8 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>@@ -356,7 +356,24 @@ static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
>
> static size_t ifcvf_vdpa_get_config_size(struct vdpa_device *vdpa_dev)
> {
>-	return sizeof(struct virtio_net_config);
>+	struct ifcvf_adapter *adapter = vdpa_to_adapter(vdpa_dev);
>+	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>+	struct pci_dev *pdev = adapter->pdev;
>+	size_t size;
>+
>+	switch (vf->dev_type) {
>+	case VIRTIO_ID_NET:
>+		size = sizeof(struct virtio_net_config);
>+		break;
>+	case VIRTIO_ID_BLOCK:
>+		size = sizeof(struct virtio_blk_config);
>+		break;
>+	default:
>+		size = 0;
>+		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", vf->dev_type);
>+	}
>+
>+	return size;
> }
>
> static void ifcvf_vdpa_get_config(struct vdpa_device *vdpa_dev,
>-- 
>2.27.0
>

