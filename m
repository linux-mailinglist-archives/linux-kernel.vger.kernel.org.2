Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F4B33913E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhCLP2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:28:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230388AbhCLP2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615562917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xKPy1yb09Ec6cKP/VPrLjTlUwinW20mVG1mfvMCm7HE=;
        b=KREKELFTH/UeB1sy+k58A4PvCYH7zkAPfXeBtYSAEXQbvjNA4HGjBBGKnx4vyVKd04p3Z5
        Gu6UXK+vzHrNJZEKAQl/11P2pwBMNwjAkztxp3tgdkSZb2QrRfgnYAFOjSC1DIWEtoQGOS
        xDNWEpmDL34SyaJPV4P9t1lQzltU9Tk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-z2ou-8z1O2KZIQJ1WaLyOA-1; Fri, 12 Mar 2021 10:28:35 -0500
X-MC-Unique: z2ou-8z1O2KZIQJ1WaLyOA-1
Received: by mail-wm1-f72.google.com with SMTP id c7so5484703wml.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xKPy1yb09Ec6cKP/VPrLjTlUwinW20mVG1mfvMCm7HE=;
        b=WeoD9qusmW7y7C85X/FV8jubvR2dOJNJ8XpEFE+Z8U4D/Fxm/L4eQJnpTPHpzUDbl9
         svAxVTIai2f+7+USHO29ym336qpMWnRkHLOIU7V0QBfhoJbo/LrziWStD6OQ4St7a+RV
         /RQKZnNNKAf45JuNlM8+VDLUP2/EuockVzFXyMd6b7dho5FeVgrlnPyqPq7ZUdya2uTS
         ejh5VifDGSmB4R4aIPvdXiFSzNxfyZNgHJUqdAGPMPxJ2t8fFgUBJx1+Ec8n3BwRe6Ln
         0n9bUNt0f/eQVOo48U8coPEYaGCH5lYqGu17vm1vDj6qk10o8e0HtNwNd72Qrp67K9jX
         axMw==
X-Gm-Message-State: AOAM530sEQcCn7O9Cwi3PH+DaxzoMZa/ZPJl4BUd/du8xBjPQTp9xGaB
        m0skRIdGxa08tjyWzn26VhQK7H+bB+I5r6GriUH+mNB/kTV2kr/6aogufifXCet8qsRP4KMQsGR
        Mwgg+1ydLapdHvXuBPuW2jinz
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr14224663wru.78.1615562914639;
        Fri, 12 Mar 2021 07:28:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSyMjIqtO+O1pkI/8s/85VaB5c4FEE2zwfH7noDtmrtsh2lsPEfFCvmwaYBZB8Js/rymbJRQ==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr14224645wru.78.1615562914451;
        Fri, 12 Mar 2021 07:28:34 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id p17sm2337705wmd.42.2021.03.12.07.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:28:34 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:28:31 +0100
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
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v6 07/22] af_vsock: rest of SEQPACKET support
Message-ID: <20210312152831.f37oxryffuohai3r@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180050.3465297-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210307180050.3465297-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 09:00:47PM +0300, Arseny Krasnov wrote:
>This does rest of SOCK_SEQPACKET support:
>1) Adds socket ops for SEQPACKET type.
>2) Allows to create socket with SEQPACKET type.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 36 +++++++++++++++++++++++++++++++++++-
> 2 files changed, 36 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

