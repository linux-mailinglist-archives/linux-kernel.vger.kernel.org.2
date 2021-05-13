Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3546237F6F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhEMLnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231414AbhEMLna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620906140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+xpriwoqMR4hMxYIDQ9tzTIIOzNsv7iGskqwPCMAtI=;
        b=OI27jo8NIxgomqRr60ykXGsCjDHgwrGm6G0QX0rLYa7GqsbaWTFZBEyG2DSoBKKFUH4mDT
        fvl90ygMZEZH9fjAwXot8JUE1E6HdyYmdmBLyfdu+kELMjMPqK3XRN965emRnKKApcYXaR
        wsT+QkA80iJTLKt3zc29VpCMlHUYNCo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-3XUODv0BMMCcyP-do_bO4A-1; Thu, 13 May 2021 07:42:18 -0400
X-MC-Unique: 3XUODv0BMMCcyP-do_bO4A-1
Received: by mail-ej1-f72.google.com with SMTP id bi3-20020a170906a243b02903933c4d9132so8283570ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 04:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+xpriwoqMR4hMxYIDQ9tzTIIOzNsv7iGskqwPCMAtI=;
        b=ePibLjYc68s4gO6NhKEHUl5LHNrcGoqGvSMz2quRof4dKkU/8Kl76vcNp5kIpEWBu8
         travReUWV/iuw82hU2oZ/VImqvEUyzUuDfb5hxl9Gjs/NKOGyJCiZHZ/ZB1CrAjxFISd
         eGcwAmLlU5kIMckIKUwXWrkwYC8a+wsUW2xZyUKi2PHWMQhpL7y3New0v35a7Bt7wrDk
         yyJ/qyTRAfXyj65jzJtcppLi0dQlHOcAMd1aysu2juQomi+kGeGyc7U22SO94GPPcRIn
         uBLH7OlFxuJg5qNzYDaQHQYOQFlBQxeS6CrLKMSS2C7G1RgOCWpriVXzlXnIcmE0+jWB
         2M9g==
X-Gm-Message-State: AOAM5332yTY7wWuObmqJRSGjA344jiiboficgfaYT2H9GQck6DNtUJOs
        v/oyKBpJT+fqu5SJTuqFgUOUkhu5Zuj90KyW8061aEfJpOra7Jz0mqBvndlg5tcDnSQEBd2Vj/2
        HYirJdAuNAPBiL2aO6Tm/j4//
X-Received: by 2002:a17:906:11d5:: with SMTP id o21mr39425182eja.176.1620906137651;
        Thu, 13 May 2021 04:42:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4evvrqMGAM5r4UR85o5vJGUe4V1rA7BD2JGHOAS51E0jB0311f1ua3YMBd6FJgtBjiTezpQ==
X-Received: by 2002:a17:906:11d5:: with SMTP id o21mr39425159eja.176.1620906137418;
        Thu, 13 May 2021 04:42:17 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id q25sm1704765ejd.9.2021.05.13.04.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 04:42:17 -0700 (PDT)
Date:   Thu, 13 May 2021 13:42:14 +0200
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
Subject: Re: [RFC PATCH v9 06/19] af_vsock: rest of SEQPACKET support
Message-ID: <20210513114214.66mfm76tp65af5yq@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163350.3431361-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210508163350.3431361-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 07:33:46PM +0300, Arseny Krasnov wrote:
>This does rest of SOCK_SEQPACKET support:
>1) Adds socket ops for SEQPACKET type.
>2) Allows to create socket with SEQPACKET type.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

This patch is changed, so usually you should remove the R-b tags.

>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 36 +++++++++++++++++++++++++++++++++++-
> 2 files changed, 36 insertions(+), 1 deletion(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 5860027d5173..1747c0b564ef 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -140,6 +140,7 @@ struct vsock_transport {
> 				     int flags, bool *msg_ready);
> 	int (*seqpacket_enqueue)(struct vsock_sock *vsk, struct msghdr *msg,
> 				 size_t len);
>+	bool (*seqpacket_allow)(u32 remote_cid);

I'm thinking if it's better to follow .dgram_allow() and .stream_allow(),
specifying also the `port` param, but since it's not used, we can add
later if needed.

So, I think this is fine:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

