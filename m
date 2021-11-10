Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E6A44BF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhKJKxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:53:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhKJKw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636541411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQFWW+sZksZzHviyH2TW0kFMCVfkj3PR573FB0zLgno=;
        b=PgWbKtJ0xBTcMe419IZprBsHZARH4kkHvZ9JKzFRQxymmr08olJSY9gzmzUGJncOOIFCHl
        vZ12Affoc5b06zrxUwy34D39RR7t1y3E2pGRhXBpVhKuNJEAVYTr0oxno1MrIHdBgcdHKG
        ERSjznEoXBnpU/n647j+x7e6uj/5y64=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-G6e_HqdJP5uFhByOStU-fg-1; Wed, 10 Nov 2021 05:50:10 -0500
X-MC-Unique: G6e_HqdJP5uFhByOStU-fg-1
Received: by mail-ed1-f71.google.com with SMTP id x13-20020a05640226cd00b003e2bf805a02so1930682edd.23
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xQFWW+sZksZzHviyH2TW0kFMCVfkj3PR573FB0zLgno=;
        b=wzsAHfLhsWO6UGh/4vCo/vbSh6Uoh3akMPsWSyIvrO6VhFPEvW+SRSXQ8YPijYhfPi
         eayAKH4lloOXl7mPdeFi+ntDJ1unG9BNs0dBelGE4SaFDBbC4scZN+JWzji7yM9V1HJN
         tM6LKgUHlalNLs2FhGNwhdKgl5isxBtQ+jp78Wxq/fBh/ccBt10aNbAqw/6RLgvp+Z9x
         gn0/2tWB9cjLkcDHYNcXq1r4/GSroi6BdxpPmHb9ldwppJUYqwvbP5NEwjLwmbzBe1/2
         wmqMQPJC1Icmg2Zh8YLAaKPYHqdjr1anMcJw7X2ayyu78WMoG6MICVMMn2vzoCgajtko
         8sDw==
X-Gm-Message-State: AOAM531dn/8Z2s7aMLQBB0E1ZqGXRLmsC27CkF+l6MSJ5PfJdncZ9y5g
        PF6xzz0QiWw80LmnmUexADtMKhzjr5maNzTz3DFncwyuWq4oljUSoday8e/RR4Ip6n9WIVVcNY7
        jnkA74ISEpDEfkxQ+1CqqqDUz
X-Received: by 2002:a05:6402:50d4:: with SMTP id h20mr20019869edb.80.1636541408867;
        Wed, 10 Nov 2021 02:50:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeT1zDnGo3NXhEoFr9pMWu5dF4RmCmR5eGCjSrmvQE09ovJLCuK0RgjGQCXT9xOJaoYx2OdQ==
X-Received: by 2002:a05:6402:50d4:: with SMTP id h20mr20019833edb.80.1636541408669;
        Wed, 10 Nov 2021 02:50:08 -0800 (PST)
Received: from redhat.com ([2.55.133.41])
        by smtp.gmail.com with ESMTPSA id cw20sm10928049ejc.32.2021.11.10.02.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 02:50:07 -0800 (PST)
Date:   Wed, 10 Nov 2021 05:50:04 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Message-ID: <20211110054121-mutt-send-email-mst@kernel.org>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 07:12:36AM +0000, Wang, Wei W wrote:
> Hi,
> 
>  
> 
> We plan to add a new vsock transport based on hypercall (e.g. vmcall on Intel
> CPUs).
> 
> It transports AF_VSOCK packets between the guest and host, which is similar to
> 
> virtio-vsock, vmci-vsock and hyperv-vsock.
> 
>  
> 
> Compared to the above listed vsock transports which are designed for high
> performance,
> 
> the main advantages of hypercall-vsock are:
> 
> 1)       It is VMM agnostic. For example, one guest working on hypercall-vsock
> can run on
> 
> either KVM, Hyperv, or VMware.

hypercalls are fundamentally hypervisor dependent though.
Assuming you can carve up a hypervisor independent hypercall,
using it for something as mundane and specific as vsock for TDX
seems like a huge overkill. For example, virtio could benefit from
faster vmexits that hypercalls give you for signalling.
How about a combination of virtio-mmio and hypercalls for fast-path
signalling then?

> 2)       It is simpler. It doesn’t rely on any complex bus enumeration
> 
> (e.g. virtio-pci based vsock device may need the whole implementation of PCI).
> 

Next thing people will try to do is implement a bunch of other device on
top of it.  virtio used pci simply because everyone implements pci.  And
the reason for *that* is because implementing a basic pci bus is dead
simple, whole of pci.c in qemu is <3000 LOC.

> 
> An example usage is the communication between MigTD and host (Page 8 at
> 
> https://static.sched.com/hosted_files/kvmforum2021/ef/
> TDX%20Live%20Migration_Wei%20Wang.pdf).
> 
> MigTD communicates to host to assist the migration of the target (user) TD.
> 
> MigTD is part of the TCB, so its implementation is expected to be as simple as
> possible
> 
> (e.g. bare mental implementation without OS, no PCI driver support).
> 
>  

Try to list drawbacks? For example, passthrough for nested virt
isn't possible unlike pci, neither are hardware implementations.


> Looking forward to your feedbacks.
> 
>  
> 
> Thanks,
> 
> Wei
> 

