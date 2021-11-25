Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F43045D85B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354470AbhKYKqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:46:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347736AbhKYKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637836851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5he1m6t1NdCQczldB6T9Fxva3O0cBowXGHxSUlbIFDo=;
        b=ifPLRJzxVpNGXMXoSEQWJrl8vRcNLyf8e+H2WFp51leB9LHXOKuSA27zdGxUbRcP5TswmJ
        rgK9f9aZGl8JMFbWrpEtYnichmfT6JjbX6VCb0ngKg7fTq5liM9fdjzztC8amXizSipBgp
        XC4O1dtfDjyvkaLIZtLyEP77xx2E0aM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-VfE0PeheNHCqzyZ90m5ieQ-1; Thu, 25 Nov 2021 05:40:50 -0500
X-MC-Unique: VfE0PeheNHCqzyZ90m5ieQ-1
Received: by mail-ed1-f71.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso5091476eds.22
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 02:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5he1m6t1NdCQczldB6T9Fxva3O0cBowXGHxSUlbIFDo=;
        b=jfR4qfJG1KtHHDkUwC4R78B7iGhin9BhSabh8v981NNhU7ayfz4lJeQWc5KQg0lMOE
         k+04qKncd6YkCtl8WZWF8wOPLS08JygYpx7iDsOEk3ciAGh2yiE+lu0A4RwAe0t+TIUS
         q7KGDEs2+f1hD5QySBNeua6Nc73l/7hJAdajSoZaL1smwnJ5lF9lijnzhnct4Kd4dFjP
         l1NsBhtUnutALX4p0vxsN0isP/c/1sIv03hx5BxU9/1GgyCRrKNV+R290g8ZQPuv+TTz
         nupfk4pqnPnJkCIPFVjtM3YngwlaGl0jOYu7NZ2RL5uAbeIzKPUhsLGhyl1u336sJ6SA
         RWRA==
X-Gm-Message-State: AOAM530NAUknLejIB6a5kKW0ayG5nEuOyZzQkDF6URz6CvLoNAmYwkpz
        BVHvK/TO1mQvmepY9IDs0sxD3qeGXvKs5b+vHMjeSPMI+kXTUv2Hl9Pn1e8HA7g0d2az80fjKGi
        vBkmaCfdvyJhv48j8Lt/3qhNH
X-Received: by 2002:a50:d68e:: with SMTP id r14mr36818818edi.5.1637836849026;
        Thu, 25 Nov 2021 02:40:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/TqPG4ycF6Z2EBWtkjQfr+eSy5n2rbj86EKdj5a+Yk7xMya6qCElb5hQyhaQ0YbKZ5BTbvA==
X-Received: by 2002:a50:d68e:: with SMTP id r14mr36818794edi.5.1637836848851;
        Thu, 25 Nov 2021 02:40:48 -0800 (PST)
Received: from steredhat (host-79-46-195-175.retail.telecomitalia.it. [79.46.195.175])
        by smtp.gmail.com with ESMTPSA id ho30sm1297351ejc.30.2021.11.25.02.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 02:40:48 -0800 (PST)
Date:   Thu, 25 Nov 2021 11:40:46 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "asias@redhat.com" <asias@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Message-ID: <20211125104046.wxupkn6uogvohioi@steredhat>
References: <20211125071554.16969-1-wei.w.wang@intel.com>
 <7992566c682b46dc9ec2502e44a2fb04@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7992566c682b46dc9ec2502e44a2fb04@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 09:27:40AM +0000, Wang, Wei W wrote:
>On Thursday, November 25, 2021 3:16 PM, Wang, Wei W wrote:
>> -	/* Update CID in case it has changed after a transport reset event */
>> -	vsk->local_addr.svm_cid = dst.svm_cid;
>> -
>>  	if (space_available)
>>  		sk->sk_write_space(sk);
>>
>
>Not sure if anybody knows how this affects the transport reset.

I believe the primary use case is when a guest is migrated.

After the migration, the transport gets a reset event from the 
hypervisor and all connected sockets are closed. The ones in listen 
remain open though.

Also the guest's CID may have changed after migration. So if an 
application has open listening sockets, bound to the old CID, this 
should ensure that the socket continues to be usable.

The patch would then change this behavior.

So maybe to avoid problems, we could update the CID only if it is 
different from VMADDR_CID_ANY:

	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
		vsk->local_addr.svm_cid = dst.svm_cid;


When this code was written, a guest only supported a single transport, 
so it could only have one CID assigned, so that wasn't a problem.
For that reason I'll add this Fixes tag:
Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")

Thanks,
Stefano

