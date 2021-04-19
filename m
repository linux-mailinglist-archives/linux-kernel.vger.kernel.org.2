Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F153D3646C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhDSPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238717AbhDSPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618845016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hI87sxdqJ16RBIdh2vHXEls0wMx3i8lFsif1UQW1tq0=;
        b=IEt0eAOK3UTNvDybHTg+83IuRbcWu9/72Ndhfv8/ld2umqPtEV9K/7m40qxWtdiIx7jWiI
        7+SbnqhzsoVuLhKQDHSGIPSek9d2yEcfJRGcaAjL5v6UmwGZcFzMRqzfunYtj81Zfw8FzJ
        veNEL+Gymtt+iC7AZRABIh0JD53iPJk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-sQD-Dnt-O6ea-qYNivKJUA-1; Mon, 19 Apr 2021 11:10:15 -0400
X-MC-Unique: sQD-Dnt-O6ea-qYNivKJUA-1
Received: by mail-ed1-f71.google.com with SMTP id o4-20020a0564024384b0290378d45ecf57so11458504edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hI87sxdqJ16RBIdh2vHXEls0wMx3i8lFsif1UQW1tq0=;
        b=Db3ijcfPHJI7FH7XIUKCDAsHKhKlLDAwS2U/MbcKSwx8DSWu4NEaTKNEXtZ2sFyL/H
         yWYMQBFc/DZX3f1qA0vQqaAQxhamayqnwLFvcqEq+ciS4/A9C6kqv1YP5tynyoU7ETzu
         WOH8hNcoJ6Tr+7TL9PPcmF3x8vs5MrnH6Gulhe/iT0mHPytUy3bSPcXjCFAloJYsBtjh
         PjNMha3hL9ad/9nnpQdk5CBtvvpFBTEfySnMg0hcs+mo/IIDMc1egkyWMmTCCnxIuCS1
         B29/yDKkjWhhO6BRWpSRoWPqPF3rlNA7mza4Jp4bxsZ89+uf+ARbOJyjj8imQW1cSDwd
         Phlg==
X-Gm-Message-State: AOAM5316DkgTjz7nqDB6pSKCphlZRKJvuzvT2iRnqcDBZcqCWtd88K0f
        nLcKiOWbumlsIAshoF1qLfM52EPtYRoR7VDgAA6RH74mWq2wx7yAHImaaH4Jiab1wq8oT0hYcw2
        pCXnd875aYF2tbjwPsllqWBGt
X-Received: by 2002:a17:906:c08f:: with SMTP id f15mr22774814ejz.318.1618845013552;
        Mon, 19 Apr 2021 08:10:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ1I7YAcUkAcUeW3VvI6Nfwos1rSwmYuqT8hvgJUrALLpnVMjlixToES3p/bGy6wencJmMCA==
X-Received: by 2002:a17:906:c08f:: with SMTP id f15mr22774799ejz.318.1618845013404;
        Mon, 19 Apr 2021 08:10:13 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id w6sm10589579eje.107.2021.04.19.08.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:10:12 -0700 (PDT)
Date:   Mon, 19 Apr 2021 17:10:10 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Vishnu Dasa <vdasa@vmware.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] vsock/vmci: log once the failed queue pair allocation
Message-ID: <20210419151010.7r52ckkxptiaa5gr@steredhat>
References: <20210416104416.88997-1-sgarzare@redhat.com>
 <5096E853-EB1A-40C0-B0E5-BDF2F8431998@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5096E853-EB1A-40C0-B0E5-BDF2F8431998@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 12:06:18PM +0000, Jorgen Hansen wrote:
>
>
>On 16 Apr 2021, at 12:44, Stefano Garzarella <sgarzare@redhat.com<mailto:sgarzare@redhat.com>> wrote:
>
>VMCI feature is not supported in conjunction with the vSphere Fault
>Tolerance (FT) feature.
>
>VMware Tools can repeatedly try to create a vsock connection. If FT is
>enabled the kernel logs is flooded with the following messages:
>
>   qp_alloc_hypercall result = -20
>   Could not attach to queue pair with -20
>
>"qp_alloc_hypercall result = -20" was hidden by commit e8266c4c3307
>("VMCI: Stop log spew when qp allocation isn't possible"), but "Could
>not attach to queue pair with -20" is still there flooding the log.
>
>Since the error message can be useful in some cases, print it only once.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com<mailto:sgarzare@redhat.com>>
>---
>net/vmw_vsock/vmci_transport.c | 3 +--
>1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 8b65323207db..1c9ecb18b8e6 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -568,8 +568,7 @@ vmci_transport_queue_pair_alloc(struct vmci_qp **qpair,
>      peer, flags, VMCI_NO_PRIVILEGE_FLAGS);
>out:
>if (err < 0) {
>- pr_err("Could not attach to queue pair with %d\n",
>-       err);
>+ pr_err_once("Could not attach to queue pair with %d\n", err);
>err = vmci_transport_error_to_vsock_error(err);
>}
>
>—
>2.30.2
>
>
>Thanks a lot for fixing this.

You're welcome!

>
>Reviewed-by: Jorgen Hansen <jhansen@vmware.com<mailto:jhansen@vmware.com>>
>

Thanks for the review!
Patchwork didn't like it, I think there was some problem with your email 
client putting `<mailto:...>` links.

I think it had to be:

Reviewed-by: Jorgen Hansen <jhansen@vmware.com>

Thanks,
Stefano

