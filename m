Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A8E3F5BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhHXKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235935AbhHXKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629799528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=acXZTsv+ZGRCIMsgyzotp4JqHaREWpj8Vd1U498dQK8=;
        b=WjwNCwr8K1nqqWbWHHfhLtIeigItP/QyG3TKHyE30g8rkYtAsT7TA4Pz1EjX0fu5hD7gVU
        9DxL3zj+8FiH/fU56jx6UCJnQ5sajvGAk18Nw1aqRmbYOJ9ZEsTmCSG4mnVbWQB1yOOdcI
        7ODbpDYzyiYu9hJnsRx/FC+TuYQQN+Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-rE7HSiR9PQ6sSA3vlDmG9g-1; Tue, 24 Aug 2021 06:05:27 -0400
X-MC-Unique: rE7HSiR9PQ6sSA3vlDmG9g-1
Received: by mail-ej1-f69.google.com with SMTP id bi9-20020a170906a24900b005c74b30ff24so132447ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 03:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=acXZTsv+ZGRCIMsgyzotp4JqHaREWpj8Vd1U498dQK8=;
        b=XhWmC+haG+udtyEWMZCaZ7LA8VZQ2AxOnBPDPErpcTkUooevsvxnSVJ31pYDyeoSke
         LcTeNQGKAWSwRXIDaiF10WlT2W8UslLaSAkrxkhpNh0p6i8KEgh2cevgo2sAV/yLgWtn
         3wrEMyy+XYHxcDGN0g6OJuZ6YO7RbgnYDHucEIoClvjLkvAlno7RQLYoaafvXMrq/os/
         qj433o6q+U0PqmvqfAav80bju9bAenrd4SqiJhm74FWqVYzdF1MwbJN4FNjZ1joVJSsC
         98vyFs1TYURzXd4GVBiXPKwyo43s7pnSDKOUJG19PaV71dGPRS9lPqHr+n3abjCESXm4
         VMFA==
X-Gm-Message-State: AOAM531FQJZLrEJi6tBbkBJWeZy6Sfqk2fNTbbnER8+Yi3I3rXEKDUXN
        JilnQSib4kQiF+P/D1Pi1EFQjS0UxK+bzVur785Yt7AWVNNigxa8CfpT2qgyn1MrMOZJs4qv4hg
        MLQC3CtlW65+MkcaboRxo2B/X
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr42111211edd.151.1629799526280;
        Tue, 24 Aug 2021 03:05:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI44Z4judGCzN7R2zpOlFSwZBSbEmkd/UBfNZmHvvZCXJIff7B6uB+tsb4YfaMzeFQo6RVNA==
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr42111185edd.151.1629799526106;
        Tue, 24 Aug 2021 03:05:26 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it. [79.45.8.152])
        by smtp.gmail.com with ESMTPSA id k21sm8853122ejj.55.2021.08.24.03.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 03:05:25 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:05:23 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stsp2@yandex.ru" <stsp2@yandex.ru>, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v3 0/6] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210824100523.yn5hgiycz2ysdnvm@steredhat>
References: <20210816085036.4173627-1-arseny.krasnov@kaspersky.com>
 <3f3fc268-10fc-1917-32c2-dc0e7737dc48@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3f3fc268-10fc-1917-32c2-dc0e7737dc48@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseny,

On Mon, Aug 23, 2021 at 09:41:16PM +0300, Arseny Krasnov wrote:
>Hello, please ping :)
>

Sorry, I was off last week.
I left some minor comments in the patches.

Let's wait a bit for other comments before next version, also on the 
spec, then I think you can send the next version without RFC tag.
The target should be the net-next tree, since this is a new feature.

Thanks,
Stefano

