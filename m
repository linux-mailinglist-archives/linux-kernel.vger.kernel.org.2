Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C00F43B0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 13:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhJZLUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 07:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233262AbhJZLUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635247089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rGwdwajHmPeO4BJPz1S3ZGt6jC32SKD30PM7BnISZb8=;
        b=Pa7+jwT6jovaWUqBsJgoPeQFpMAgXOrf+/ikwulSr82RJ1P+x4JfC68MkW0VkS83/u3Eco
        bbUORRQqp9X4RhppzPIVU3pOGzXywgtU1oP5JLkrpnBtnxvt+DdMrSk3xTv+xDKw5SQ1AV
        40rBtgjXFdg++9s1t1mdbFqKOAet3gg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-5xrAdXUCMxuLyd_OnzBlTQ-1; Tue, 26 Oct 2021 07:18:06 -0400
X-MC-Unique: 5xrAdXUCMxuLyd_OnzBlTQ-1
Received: by mail-ed1-f72.google.com with SMTP id z20-20020a05640240d400b003dce046ab51so12670176edb.14
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 04:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rGwdwajHmPeO4BJPz1S3ZGt6jC32SKD30PM7BnISZb8=;
        b=3uRXu0c36TaRpz7TGhnhNFj9RGR5iUW+imFuZXzRqbn1eN5x1Q/0yDAjWUOWJYFeiH
         wqXz59lIl3G4vxy/QjgEC7FzJt7kVVjABEInxd+5pPubbHFR4qCH8VYKCRLapBYm5hoh
         9VMlIuZ2ZrFbUrOVc1+4X7+CW5QGNYzIIWZC1pjUtvJtSAHKSTLA9VRzfWMGcU2jzHiB
         qScT/YquEBmkdoB74zYjotBNVI8ewNVgLDXK508cY2edAqBUzf/+YQx3BWBNl8+H908U
         t7VGJ8b3CjjQXjlPzmEe3R4bVKZN9+ESd1xSHSqr83M82tkp7ses9lO4eRMGeR0Yz5lz
         eRfA==
X-Gm-Message-State: AOAM533O24pjfNK3eatbWLAKrn43duon/fFYrUiUpox00F8UbX2l+xBs
        YIzufUb5PiXSNwiVq0sFcdk7G3zcNkJ3oq1uVE5E3fMFZ4E5tGm8hLfpcEhZ/O05vurwP7sLw+D
        yvlI0+q2RFjlG295VRUvNAEQY
X-Received: by 2002:a17:906:7f8e:: with SMTP id f14mr29844806ejr.267.1635247085375;
        Tue, 26 Oct 2021 04:18:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcgmc28vzIaCUk+jEbgNhCEFwvjTtlbpZ3chKtHCtz4k0ZlZ2BdshPzsog8NoCkhXBRNz1EQ==
X-Received: by 2002:a17:906:7f8e:: with SMTP id f14mr29844788ejr.267.1635247085237;
        Tue, 26 Oct 2021 04:18:05 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it. [79.30.88.77])
        by smtp.gmail.com with ESMTPSA id y26sm3644850edv.88.2021.10.26.04.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:18:04 -0700 (PDT)
Date:   Tue, 26 Oct 2021 13:18:01 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org
Subject: Re: [PATCH 06/10] vsock: set socket peercred
Message-ID: <20211026111801.vrz4ofs42udz2n52@steredhat>
References: <20211021123714.1125384-1-marcandre.lureau@redhat.com>
 <20211021123714.1125384-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211021123714.1125384-7-marcandre.lureau@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:37:10PM +0400, Marc-André Lureau wrote:
>When AF_VSOCK socket is created, the peercreds are set to the current
>process values.
>
>This is how AF_UNIX listen work too, but unconnected AF_UNIX sockets
>return pid:0 & uid/gid:-1.
>
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> net/vmw_vsock/af_vsock.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 1925682a942a..9b211ff49b08 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -760,6 +760,7 @@ static struct sock *__vsock_create(struct net *net,
>
> 	psk = parent ? vsock_sk(parent) : NULL;
> 	if (parent) {
>+		sock_copy_peercred(sk, parent);
> 		vsk->trusted = psk->trusted;
> #if IS_ENABLED(CONFIG_VMWARE_VMCI_VSOCKETS)
> 		vsk->owner = get_cred(psk->owner);
>@@ -770,6 +771,7 @@ static struct sock *__vsock_create(struct net *net,
> 		vsk->buffer_max_size = psk->buffer_max_size;
> 		security_sk_clone(parent, sk);
> 	} else {
>+		sock_init_peercred(sk);

IIUC in AF_UNIX the sock_init_peercred() is called only when the 
connection is established, so I think we should do the same.

In the single transports or in some way in the core when the transports 
call vsock_insert_connected().

Thanks,
Stefano

