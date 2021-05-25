Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7473F39037F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhEYOJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233796AbhEYOJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621951701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C6JWIrp1X2QWT7DZ7p/eDKEr77BtjgN6Key1F3L5mgM=;
        b=f3AQB1bHkg5LrhYmjn5C8ikKaaBEJgO/ngnBvzZo1ocCmbrF409Pylcpqx9h5Ky0xgvgRH
        YGbVsYOYtPhKvd1GSxRYZb9ummfp1RhkwFe7mbPuxD1JvGEnQ62X5zusVi2olXagmTiWfw
        OrRnQ7XSH7wtLb22EHmAcZNTGcoa2J0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-Ff1kjsN6NRK499oDoi_5Ag-1; Tue, 25 May 2021 10:08:20 -0400
X-MC-Unique: Ff1kjsN6NRK499oDoi_5Ag-1
Received: by mail-ej1-f70.google.com with SMTP id dr20-20020a1709077214b02903db77503922so5204250ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6JWIrp1X2QWT7DZ7p/eDKEr77BtjgN6Key1F3L5mgM=;
        b=mchAQaLZFLN+hFiGX/227bJUwLyNECbWw9vcK90fVIstCk1c30tL02AJvR4zbGfY8s
         h1MQOmSI9X3JMjen2AvEQTLamnJkXNKaFPIWu0ME/GIitDfI/nEou+FlVMX8G7XX28Cp
         ApoR3xLfIrfsPKXRxGDJkmz1cQBGJlcA6YWtdKga+2Mlj8Tlo8nBkbz7OiQGAxAhDmAA
         NuqOR8s4zeYKXoAfsrF+AEe+of3e5WxniOHzW2XFx7kw4MKz3o+/DaKCvJWWdBNIE7NF
         MSv2B7JBX5I6rVZADxIMdItR1f8Se+oc6zYa0sL6exSjnH5CkBq2RPE1acNYEe24la+1
         sWZQ==
X-Gm-Message-State: AOAM5324TOg2Z5LQmTbMxdzXhdxTWo44dHH8CHiPB2TUARXC/kGNJiEk
        S/TMjlp8gunjAVknB4v01Ilr5awqOSSL74aGfagGyfzXjRr4s5iKSmxeWvUz137GDtAh52N1MvL
        pF9cjymmNq1VCr2Nb+l5F7p9b
X-Received: by 2002:a17:907:1b11:: with SMTP id mp17mr29324485ejc.1.1621951699033;
        Tue, 25 May 2021 07:08:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ8NCBc55GgItfBceAaBuINHwCsxN0ByhZnfYq7Pj5KNr0oNXheshEkj931t4BMHAxbsJicQ==
X-Received: by 2002:a17:907:1b11:: with SMTP id mp17mr29324460ejc.1.1621951698877;
        Tue, 25 May 2021 07:08:18 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id gt12sm9078897ejb.60.2021.05.25.07.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 07:08:18 -0700 (PDT)
Date:   Tue, 25 May 2021 16:08:16 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Norbert Slusarek <nslusarek@gmx.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, oxffffaa@gmail.com
Subject: Re: [PATCH v10 04/18] af_vsock: implement SEQPACKET receive loop
Message-ID: <20210525140816.btiv5v6e3vguxxun@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191611.1271204-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210520191611.1271204-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 10:16:08PM +0300, Arseny Krasnov wrote:
>Add receive loop for SEQPACKET. It looks like receive loop for
>STREAM, but there are differences:
>1) It doesn't call notify callbacks.
>2) It doesn't care about 'SO_SNDLOWAT' and 'SO_RCVLOWAT' values, because
>   there is no sense for these values in SEQPACKET case.
>3) It waits until whole record is received or error is found during
>   receiving.
>4) It processes and sets 'MSG_TRUNC' flag.
>
>So to avoid extra conditions for two types of socket inside one loop, two
>independent functions were created.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v9 -> v10:
> 1) Use 'msg_data_left()' instead of direct access to 'msg_hdr'.
>
> include/net/af_vsock.h   |  4 +++
> net/vmw_vsock/af_vsock.c | 72 +++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 75 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

