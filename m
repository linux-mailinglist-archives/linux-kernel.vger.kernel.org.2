Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F7D315234
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhBIO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:57:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230181AbhBIO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612882541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WSsdPlcWLs4B7/MYVeVITkDmFpb6BsySsmx2wFDfjIg=;
        b=RNL/CcDL+IAKBwA0EISQhdXGo6HzhQ1YzsL7iIrDlgqlcUCzqV4aKvaskaqqThhdmCKZ5v
        xvBPcOLRJhWWnrYLAEjC6n1jSBrTG0jmYyd2izIB+KLCe2dBf0Jn5t2n37k8dZkalkpkas
        fP2vA7J6ykQ/3EFodGn8cmgOXMm4uy0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-qxzcJTbyMRiJk3HLMxvefQ-1; Tue, 09 Feb 2021 09:55:39 -0500
X-MC-Unique: qxzcJTbyMRiJk3HLMxvefQ-1
Received: by mail-wr1-f69.google.com with SMTP id m7so17658734wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WSsdPlcWLs4B7/MYVeVITkDmFpb6BsySsmx2wFDfjIg=;
        b=oKWt9sj/hiXAFXeDHYhNSS7s39rFrdqkClMRzeKbm5LG+DK/rJ8lRpc5g+ZQyghOfv
         fAEjRpFIOJALp/I0S97WYOltkXIgrGtHBD+58BEz0St/8EjdKdwD/K8SAja38NCNkcaV
         90t2Xj27byfe2dYw0u9j5nWLunaUAyCSdIIrVZk8SEOtaFS3M1NWLi3b7SZ7VnEynTUT
         p1crsFh+X+P1KeO4z/qk+CjPgSxqLVB43In1+wzEaAL9mhZR8QA9kMMglgHI8wwg6v+i
         Ag8Tqx2I+HWRRl6bZgED8PHB0Sjf8DBiMQmyM/ivH6pghz+JXcC1HP/YgLQfVEg10EJF
         oMlQ==
X-Gm-Message-State: AOAM532rpcaveo/P1Kki7967cP03U+rzHViuV8dxaU4pMcVt+dmkZAVR
        6Sj+wYiPhk1KTQPfWP8inAj/G/cvpnRdH/+/mecMC3bMRXLlZhnkFEJ5IEIkcNgzuvjcWksOhuD
        l3dBK/Z4aTXm0OjKD647+rHe/
X-Received: by 2002:adf:eb82:: with SMTP id t2mr13792163wrn.231.1612882538073;
        Tue, 09 Feb 2021 06:55:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGiyD0i/pTC5CRicHdOTkBxICTMpZX9F+ZX+9eu4fC4Ozi+Yen5iR0i1cuW6uuuaqb68GylQ==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr13792098wrn.231.1612882537862;
        Tue, 09 Feb 2021 06:55:37 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id x15sm19731236wro.66.2021.02.09.06.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:55:37 -0800 (PST)
Date:   Tue, 9 Feb 2021 09:55:32 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Adrian Catangiu <acatan@amazon.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, gregkh@linuxfoundation.org,
        graf@amazon.com, rdunlap@infradead.org, arnd@arndb.de,
        ebiederm@xmission.com, rppt@kernel.org, 0x7f454c46@gmail.com,
        borntraeger@de.ibm.com, Jason@zx2c4.com, jannh@google.com,
        w@1wt.eu, colmmacc@amazon.com, luto@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, dwmw@amazon.co.uk, bonzini@gnu.org,
        sblbir@amazon.com, raduweis@amazon.com, corbet@lwn.net,
        mhocko@kernel.org, rafael@kernel.org, pavel@ucw.cz,
        mpe@ellerman.id.au, areber@redhat.com, ovzxemul@gmail.com,
        avagin@gmail.com, ptikhomirov@virtuozzo.com, gil@azul.com,
        asmehra@redhat.com, dgunigun@redhat.com, vijaysun@ca.ibm.com,
        oridgar@gmail.com, ghammer@redhat.com
Subject: Re: [PATCH v5 2/2] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20210209095350-mutt-send-email-mst@kernel.org>
References: <1612200294-17561-1-git-send-email-acatan@amazon.com>
 <1612200294-17561-3-git-send-email-acatan@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612200294-17561-3-git-send-email-acatan@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +The ``vmgenid`` driver uses ACPI events to be notified by hardware
> +changes to the 128-bit Vm Gen Id UUID.

That's ok, problem is ACPI event processing is asynchronous.
What we need is thus to flush out ACPI events whenever userspace
does a read, otherwise the value it gets will be stale.

-- 
MST

