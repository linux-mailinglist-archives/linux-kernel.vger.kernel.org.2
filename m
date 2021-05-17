Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8506382989
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhEQKL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231658AbhEQKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621246238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6A0XM46+U1xV6XUwh0pcSDkTEcBAHjYNGDBCWlYZWfU=;
        b=OtsSMUxkIZu9+gr2L6dPUBZLJaCN0XAjovK2LOw+PhnFFkwzrrO6tdKxxteXW6WqLrvF45
        umzDwjlraEjCJUoLShE8GKtcVrFHUV98FSK1DB/8OdL0LMkLlT/puMgPE0nuCv2A0ZYAq2
        aM6s2p8IfJwmLQ1sk4t62LXdwbu05y8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-S1vgPZX_NQWX-aUcwPBpHA-1; Mon, 17 May 2021 06:10:34 -0400
X-MC-Unique: S1vgPZX_NQWX-aUcwPBpHA-1
Received: by mail-ed1-f72.google.com with SMTP id i19-20020a05640242d3b0290388cea34ed3so3612255edc.15
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6A0XM46+U1xV6XUwh0pcSDkTEcBAHjYNGDBCWlYZWfU=;
        b=aZuVMRKYwKW8j0B733nQfzR73FaqMsVUtB4HTNd1A79emkvCt4WDGmkaICiqhghIMK
         O0EJ0TIWeASw4fbR7bz4MgEVX87QuATLN+PQpkyLknawKgetSaTxdvSzZgzZ+shysYxh
         ltSSEC1+MdcLowOsNoQTyZ104EtGgcMxt4prGj97NxnlgEVNoOuEZRbeA9V7O4yxjNSq
         I2KMiLJl29YWFlSX3kHCuyTosIwYDDXchIGhueY+csX+lHOpoGC7mfjOZydANVKCD4+i
         GtSuF0nBidK7/+9H+6tCW/+IQlAXGCHp497wION0//WPMGlmOoVNdstnnH9df3jUq9jl
         UGYA==
X-Gm-Message-State: AOAM531nlBoXnaNCZ60LeZluiLM0L985cf2gnWK9ugw1DN19mKQCg9Gb
        tPTKWOFvRRgyjVBpERA8yCz6dK7rMbq7dSpXZtzbJjhxqSd/CKiDN72ZVcbPLgHaHz8cNXK7wmM
        ArpkHBlUBlVaszEVaRHgOHMed
X-Received: by 2002:a17:906:2dd3:: with SMTP id h19mr4735503eji.520.1621246233746;
        Mon, 17 May 2021 03:10:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqlLkH+gDYYvTAUTlp87qWEwL903KJ3qvJC8eOMJstLQUpWFA2M8AcEtt0mPPMh3cfZkbN1g==
X-Received: by 2002:a17:906:2dd3:: with SMTP id h19mr4735486eji.520.1621246233524;
        Mon, 17 May 2021 03:10:33 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id m13sm5280478eds.21.2021.05.17.03.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:10:33 -0700 (PDT)
Date:   Mon, 17 May 2021 12:10:30 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "Subo (Subo, Cloud Infrastructure Service Product Dept.)" 
        <subo7@huawei.com>, "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        "lixianming (E)" <lixianming5@huawei.com>
Subject: Re: [RFC] vsock: notify server to shutdown when client has pending
 signal
Message-ID: <20210517101030.ks2r66pyws7w7cae@steredhat>
References: <20210511094127.724-1-longpeng2@huawei.com>
 <20210513094143.pir5vzsludut3xdc@steredhat>
 <558d53dd31dc4841b94c4ec35249ac80@huawei.com>
 <09562f9b35c3419f9b5844b35b4276ae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <09562f9b35c3419f9b5844b35b4276ae@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 02:18:51AM +0000, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
>Hi Stefano,
>
>> -----Original Message-----
>> From: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
>> [mailto:longpeng2@huawei.com]
>> Sent: Thursday, May 13, 2021 6:36 PM
>> To: Stefano Garzarella <sgarzare@redhat.com>
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Gonglei (Arei)
>> <arei.gonglei@huawei.com>; Subo (Subo, Cloud Infrastructure Service Product
>> Dept.) <subo7@huawei.com>; David S . Miller <davem@davemloft.net>; Jakub
>> Kicinski <kuba@kernel.org>; Jorgen Hansen <jhansen@vmware.com>; Norbert
>> Slusarek <nslusarek@gmx.net>; Andra Paraschiv <andraprs@amazon.com>;
>> Colin Ian King <colin.king@canonical.com>; David Brazdil
>> <dbrazdil@google.com>; Alexander Popov <alex.popov@linux.com>;
>> lixianming (E) <lixianming5@huawei.com>
>> Subject: RE: [RFC] vsock: notify server to shutdown when client has pending
>> signal
>>
>> Hi Stefano,
>>
>> > -----Original Message-----
>> > From: Stefano Garzarella [mailto:sgarzare@redhat.com]
>> > Sent: Thursday, May 13, 2021 5:42 PM
>> > To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
>> > <longpeng2@huawei.com>
>> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Gonglei
>> > (Arei) <arei.gonglei@huawei.com>; Subo (Subo, Cloud Infrastructure
>> > Service Product
>> > Dept.) <subo7@huawei.com>; David S . Miller <davem@davemloft.net>;
>> > Jakub Kicinski <kuba@kernel.org>; Jorgen Hansen <jhansen@vmware.com>;
>> > Norbert Slusarek <nslusarek@gmx.net>; Andra Paraschiv
>> > <andraprs@amazon.com>; Colin Ian King <colin.king@canonical.com>;
>> > David Brazdil <dbrazdil@google.com>; Alexander Popov
>> > <alex.popov@linux.com>; lixianming (E) <lixianming5@huawei.com>
>> > Subject: Re: [RFC] vsock: notify server to shutdown when client has
>> > pending signal
>> >
>> > Hi,
>> > thanks for this patch, comments below...
>> >
>> > On Tue, May 11, 2021 at 05:41:27PM +0800, Longpeng(Mike) wrote:
>> > >The client's sk_state will be set to TCP_ESTABLISHED if the server
>> > >replay the client's connect request.
>> > >However, if the client has pending signal, its sk_state will be set
>> > >to TCP_CLOSE without notify the server, so the server will hold the
>> > >corrupt connection.
>> > >
>> > >            client                        server
>> > >
>> > >1. sk_state=TCP_SYN_SENT         |
>> > >2. call ->connect()              |
>> > >3. wait reply                    |
>> > >                                 | 4. sk_state=TCP_ESTABLISHED
>> > >                                 | 5. insert to connected list
>> > >                                 | 6. reply to the client
>> > >7. sk_state=TCP_ESTABLISHED      |
>> > >8. insert to connected list      |
>> > >9. *signal pending* <--------------------- the user kill client
>> > >10. sk_state=TCP_CLOSE           |
>> > >client is exiting...             |
>> > >11. call ->release()             |
>> > >     virtio_transport_close
>> > >      if (!(sk->sk_state == TCP_ESTABLISHED ||
>> > >	      sk->sk_state == TCP_CLOSING))
>> > >		return true; <------------- return at here As a result, the server
>> > >cannot notice the connection is corrupt.
>> > >So the client should notify the peer in this case.
>> > >
>> > >Cc: David S. Miller <davem@davemloft.net>
>> > >Cc: Jakub Kicinski <kuba@kernel.org>
>> > >Cc: Stefano Garzarella <sgarzare@redhat.com>
>> > >Cc: Jorgen Hansen <jhansen@vmware.com>
>> > >Cc: Norbert Slusarek <nslusarek@gmx.net>
>> > >Cc: Andra Paraschiv <andraprs@amazon.com>
>> > >Cc: Colin Ian King <colin.king@canonical.com>
>> > >Cc: David Brazdil <dbrazdil@google.com>
>> > >Cc: Alexander Popov <alex.popov@linux.com>
>> > >Signed-off-by: lixianming <lixianming5@huawei.com>
>> > >Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> > >---
>> > > net/vmw_vsock/af_vsock.c | 1 +
>> > > 1 file changed, 1 insertion(+)
>> > >
>> > >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > >index
>> > >92a72f0..d5df908 100644
>> > >--- a/net/vmw_vsock/af_vsock.c
>> > >+++ b/net/vmw_vsock/af_vsock.c
>> > >@@ -1368,6 +1368,7 @@ static int vsock_stream_connect(struct socket
>> > >*sock,
>> > struct sockaddr *addr,
>> > > 		lock_sock(sk);
>> > >
>> > > 		if (signal_pending(current)) {
>> > >+			vsock_send_shutdown(sk, SHUTDOWN_MASK);
>> >
>> > I see the issue, but I'm not sure is okay to send the shutdown in any
>> > case, think about the server didn't setup the connection.
>> >
>> > Maybe is better to set TCP_CLOSING if the socket state was
>> > TCP_ESTABLISHED, so the shutdown will be handled by the
>> > transport->release() as usual.
>> >
>> > What do you think?
>> >
>>
>> Your method looks more gracefully, we'll try it and get back to you, 
>> thanks.
>>
>
>As your suggestion, the following code can solve the problem:
>
>                if (signal_pending(current)) {
>                        err = sock_intr_errno(timeout);
>-                       sk->sk_state = TCP_CLOSE;
>+                       sk->sk_state = TCP_CLOSING;
>                        sock->state = SS_UNCONNECTED;
>                        vsock_transport_cancel_pkt(vsk);
>                        goto out_wait;
>
>This will send shutdown to the server even if the connection is not established, but
>I don't see any side effects yet, right ?

Should we set TCP_CLOSING only if sk_state was TCP_ESTABLISHED?

>
>The problem is also in the timeout case, we should fix it together ?
>

I'm not sure, if we reach the timeout, it should mean that the other 
peer never answered, so why take care to notify it?

Thanks,
Stefano

