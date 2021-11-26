Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1257A45E9B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359631AbhKZI7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:59:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359668AbhKZI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637916826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CaUZGIbLdBQv+xSVNcxZeXO0Rrr3XbXIVmiKg++vUEg=;
        b=TLfIlXUKKGWG5IZgcZS2olj1a8r+/+C9pXmGT5EGDj4Q4GDdk/BEFY/lPNl/CnrGwrEse2
        Jkm9EodrRLQblIYZHEB2Fjkrf5fRe+/+n50bdCYQWbdYMGq6eB8YKvvv/WM8QXU/G2p/LC
        SdYT70muxtwCRvCFMg1yLAFpDXNJCls=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-5PKIOl4HOwa12y9NX2RC5A-1; Fri, 26 Nov 2021 03:53:45 -0500
X-MC-Unique: 5PKIOl4HOwa12y9NX2RC5A-1
Received: by mail-ed1-f70.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so7460480edq.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 00:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CaUZGIbLdBQv+xSVNcxZeXO0Rrr3XbXIVmiKg++vUEg=;
        b=jV5X6a4yjFDcLKMG2wlc109XXPYc6VNE5IIdyje1MZ8Yr+dAvekgaQHJdMXfBrfKZD
         w+3fhr14guub42umb4FA3ctFUsilfIugIzL4kt6Khfq8huNxS9GjJUHFO1K6u2o3QV84
         oNX9SJCqJ+Md3GVo7q2nXLEcAAg+fBGzUCcwxwnJ9mvXkpuQPVn4KVqtJOVi2ttLqlGG
         LENTOW83IxjjWsGsKJYuWRjVglgc9MHZLDPwHZjlBKxxV+RQdZ7RPqP2fC3wUqcfA27N
         WqjId4yWCa03B0cEDolpwMh4axkwrOltlUzjp62d5h+x3SFj8C6IKMh8l6wVDPYdiXII
         7ekg==
X-Gm-Message-State: AOAM531WAn4sUlYMG/uDI0rNAFZ/nW2wpSLPSgzbWKwTguqRIRvj7ylU
        Q8gbLj6QELHU9Gsd9ZufmTYyku2xailnnq97Z3UZ45iiStzFapzWjolWAiQc3DSJYy7KyGHQDa+
        /5YYXw/FK4FVyGDqV4dN8+Y8H
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr46576153edu.237.1637916823725;
        Fri, 26 Nov 2021 00:53:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynBNBQYN4uVWk4F98nCH01OPXWR80eaHC0GF284fqeGM0GYz3eAtEIKkZwxdcR6T714EoA9w==
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr46576143edu.237.1637916823589;
        Fri, 26 Nov 2021 00:53:43 -0800 (PST)
Received: from steredhat (host-79-46-195-175.retail.telecomitalia.it. [79.46.195.175])
        by smtp.gmail.com with ESMTPSA id d1sm3608298edn.56.2021.11.26.00.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 00:53:43 -0800 (PST)
Date:   Fri, 26 Nov 2021 09:53:41 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     mst@redhat.com, stefanha@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Message-ID: <20211126085341.wiab2frkcbmkg4ca@steredhat>
References: <20211126011823.1760-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211126011823.1760-1-wei.w.wang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 08:18:23PM -0500, Wei Wang wrote:
>The VMADDR_CID_ANY flag used by a socket means that the socket isn't bound
>to any specific CID. For example, a host vsock server may want to be bound
>with VMADDR_CID_ANY, so that a guest vsock client can connect to the host
>server with CID=VMADDR_CID_HOST (i.e. 2), and meanwhile, a host vsock
>client can connect to the same local server with CID=VMADDR_CID_LOCAL
>(i.e. 1).
>
>The current implementation sets the destination socket's svm_cid to a
>fixed CID value after the first client's connection, which isn't an
>expected operation. For example, if the guest client first connects to the
>host server, the server's svm_cid gets set to VMADDR_CID_HOST, then other
>host clients won't be able to connect to the server anymore.
>
>Reproduce steps:
>1. Run the host server:
>   socat VSOCK-LISTEN:1234,fork -
>2. Run a guest client to connect to the host server:
>   socat - VSOCK-CONNECT:2:1234
>3. Run a host client to connect to the host server:
>   socat - VSOCK-CONNECT:1:1234
>
>Without this patch, step 3. above fails to connect, and socat complains
>"socat[1720] E connect(5, AF=40 cid:1 port:1234, 16): Connection
>reset by peer".
>With this patch, the above works well.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Usually fixes for net/vmw_vsock/* are applied through the net tree 
(netdev@vger.kernel.org) that seems not CCed. Please use 
./scripts/get_maintainer.pl next time.

Maybe this one can be queued by Michael, let's wait a bit, otherwise 
please resend CCing netdev and using "net" tag.

Anyway the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

