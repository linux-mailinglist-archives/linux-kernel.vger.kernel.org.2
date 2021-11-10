Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E3044C007
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhKJLUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:20:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhKJLUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636543044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSYkdLrFMduO4+IhFpw7zHlUTHCpQ25RS8J86dyqNl4=;
        b=Mj8h6nteu8o7YUs29V5DRAjQbTq2CV6UrTZaJ2HOQ5ox/dLlJLyKm3olUpN5GeYmQgGIhq
        5/gCdthrmbicYocy9s/PxC1yhxlfnDRP5RvTOPh6mgYK6v/tzGqmJSwp8LGqrI5Xcelyba
        J6+cGoVMg+9uTBR+QUu2PGNlyP5BUrc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-KjTI7_ekMuORtnTSvcH6UQ-1; Wed, 10 Nov 2021 06:17:23 -0500
X-MC-Unique: KjTI7_ekMuORtnTSvcH6UQ-1
Received: by mail-ed1-f72.google.com with SMTP id y12-20020a056402270c00b003e28de6e995so2023096edd.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KSYkdLrFMduO4+IhFpw7zHlUTHCpQ25RS8J86dyqNl4=;
        b=D7oK1OrID74V7atgjuNtROQP/LbLrsSG1Tnvx9L6pQQV0P4ln0nruF8RjupPzypBre
         +SDXavwQptDsjZlTijg6joN39Y4J5cbFuKUqxDZJefjsilc03WGsZDKMBCsmPEzN2bRN
         ApdtdVOtU/6J3NSqF8+GYiOC2CbCgSw2b+AU42d/DUbyqkHQYM/E2BMqglU9aSM6OjrS
         IigIrzWmExStqHSvOdvM5FzPVvmpn8SsztDURwHWYP1T7U6uN8o3XkSI1BZmbyEtL8qR
         mZh/LCUDhv3n7raXNvdoE/7Kvv/PKQkGvzwed0/fq4WYCILzMz5xP3UORhenVnYU7lIR
         dggQ==
X-Gm-Message-State: AOAM533pAeE3AaoEV3g/GrfpM/jSI13iS1O9hJyLpEu8QNKxDpnOZann
        PLKu1SdxyBYeH2+b0eP5cAHa9qJ6tHWaQdvAYnqpdOm+BDLsNfsZJxXBn4FvHLa0XVFl272SUHq
        3kmS5AxVgBhj01bR5HqRy43UO
X-Received: by 2002:a17:906:388f:: with SMTP id q15mr19532683ejd.145.1636543042060;
        Wed, 10 Nov 2021 03:17:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9Hggt89KbVq2bTsmJS1g2xxslDPz/3razPWPk36zSHvvckMwsFjUm1BPRAhX95CFlXwAUng==
X-Received: by 2002:a17:906:388f:: with SMTP id q15mr19532650ejd.145.1636543041872;
        Wed, 10 Nov 2021 03:17:21 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id ar2sm1973327ejc.20.2021.11.10.03.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:17:21 -0800 (PST)
Date:   Wed, 10 Nov 2021 12:17:18 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Message-ID: <20211110111718.5cvt6vgory3fzqld@steredhat>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 07:12:36AM +0000, Wang, Wei W wrote:
>Hi,
>
>We plan to add a new vsock transport based on hypercall (e.g. vmcall on Intel CPUs).
>It transports AF_VSOCK packets between the guest and host, which is similar to
>virtio-vsock, vmci-vsock and hyperv-vsock.
>
>Compared to the above listed vsock transports which are designed for high performance,
>the main advantages of hypercall-vsock are:
>
>1)       It is VMM agnostic. For example, one guest working on hypercall-vsock can run on
>
>either KVM, Hyperv, or VMware.
>
>2)       It is simpler. It doesn't rely on any complex bus enumeration
>
>(e.g. virtio-pci based vsock device may need the whole implementation of PCI).
>
>An example usage is the communication between MigTD and host (Page 8 at
>https://static.sched.com/hosted_files/kvmforum2021/ef/TDX%20Live%20Migration_Wei%20Wang.pdf).
>MigTD communicates to host to assist the migration of the target (user) 
>TD.
>MigTD is part of the TCB, so its implementation is expected to be as simple as possible
>(e.g. bare mental implementation without OS, no PCI driver support).

Adding Andra and Sergio, because IIRC Firecracker and libkrun emulates 
virtio-vsock with virtio-mmio so the implementation should be simple and 
also not directly tied to a specific VMM.

Maybe this fit for your use case too, in this way we don't have to 
maintain another driver.

Thanks,
Stefano

