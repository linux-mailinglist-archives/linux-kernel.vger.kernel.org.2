Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6D141DD45
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245695AbhI3PWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245411AbhI3PWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633015264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0abga0D1u/IdQg9y3krLjrNSALXarJfiwXawsFlevdE=;
        b=YKvgW0DWUCMgYS+Gr1kmGd05vFueryaRhz3gUj5F7LhyGxGn3sMV6+7ki6FWmmnp5L+Eqs
        c7KZe82vNubLo/Cinxbuv0kwLva4j3qdlTxgICKA7VN3vPkKuoU5ItMiEqae41xH11FvyN
        1rcfDb1F5DPJkkT2RJxmzhme7YPT6k8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-XQV2Gj7fOJaYhTwUnpVxsQ-1; Thu, 30 Sep 2021 11:21:03 -0400
X-MC-Unique: XQV2Gj7fOJaYhTwUnpVxsQ-1
Received: by mail-wr1-f70.google.com with SMTP id k16-20020a5d6290000000b00160753b430fso1795074wru.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0abga0D1u/IdQg9y3krLjrNSALXarJfiwXawsFlevdE=;
        b=T1bZ/hbpbiN3oHfi1T6D6rxgODJhNSDXQw2xrw6LwWvQ1glQPHBH3/zK9cwgTuHmqV
         GopOFoFRBy71xAVAqJuITUOYOwVDNZqOwd1LmybMVwMJXsOS8d3t61vc4EIoreDwo1Ru
         ChZiEcl2dXBE7ZWbM2oIIfAiKqZKuQZX2Exxzx55bm2YJdQ4MQHY0yI1jaROMcWd1oMg
         Hd+YzK+1AUoSAAo0WSyetlPnqeRzyDXQ0U1kanZf6gY0mVvLXHd5Naz4nU1CG3hIp9He
         9UZLAQ+AmZ0gf7GVrLF7qfS5NpylITXlgjE1j2Ph3MAzsBkjVqGzJroE2TonfYVFyY2b
         7lOw==
X-Gm-Message-State: AOAM531rIlF5dDEUAzevWzgL5QMC/2FNwLV1ItqyN8fMlodAI45UTjmt
        qVecYbQewkzGCVDQpKzhj44CrMiLJng2UbvOzHAFFgmpe00m21x/cgrkIffFu6c059KFv5jmTop
        HqmWfTNQj0md1VNWNm5jLl+tO
X-Received: by 2002:adf:8b47:: with SMTP id v7mr6750093wra.321.1633015261084;
        Thu, 30 Sep 2021 08:21:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyixcUuc+JnWbDfw8P1vGJjmgwF6F7FsHdgfu/4LhDBVO7PYY7/qogrpldeQ6XDAuFJuHmFBA==
X-Received: by 2002:adf:8b47:: with SMTP id v7mr6749726wra.321.1633015257068;
        Thu, 30 Sep 2021 08:20:57 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
        by smtp.gmail.com with ESMTPSA id z79sm3332530wmc.17.2021.09.30.08.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 08:20:56 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:20:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <20210930112029-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 08:18:18AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 9/30/21 6:36 AM, Dan Williams wrote:
> > > And in particular, not all virtio drivers are hardened -
> > > I think at this point blk and scsi drivers have been hardened - so
> > > treating them all the same looks wrong.
> > My understanding was that they have been audited, Sathya?
> 
> Yes, AFAIK, it has been audited. Andi also submitted some patches
> related to it. Andi, can you confirm.
> 
> We also authorize the virtio at PCI ID level. And currently we allow
> console, block and net virtio PCI devices.
> 
> { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_NET) },
> { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_BLOCK) },
> { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_CONSOLE) },

Presumably modern IDs should be allowed too?

-- 
MST

