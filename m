Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F24E40CA24
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhIOQeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229665AbhIOQeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631723563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHkGOnRH445M1d9hLlLUWfMXPA2J8M8wItfcEOw5gl8=;
        b=H58BILloeWUdLpi3dd7EBmiqxZsj2HXtYwWSd3C8+n1JV5kw7QDn1pdM3itUYYoYr+RfBy
        on3W8H97vqljaH3pPsw3d/bCRXHP0sMfGbJqvUPivIQd0PqMRbzLI2hE7pypQ+ezHL0npC
        4ASfoYSkzrt7AaIR1B8FksBPj5BXSQ4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-0YkB5H4mMmucOe1lRJOTKw-1; Wed, 15 Sep 2021 12:32:42 -0400
X-MC-Unique: 0YkB5H4mMmucOe1lRJOTKw-1
Received: by mail-oo1-f71.google.com with SMTP id bc36-20020a05682016a400b0028c8e8a2746so3629938oob.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHkGOnRH445M1d9hLlLUWfMXPA2J8M8wItfcEOw5gl8=;
        b=eraJVGKl/xGhTGt5FPtLh0Jr4MwQd3x6t5DTwXwZlBR0t2RChya59CbcgtKNOUpliJ
         nj6fvvDKLff8QpBBZUc3+ow4KrcIalayBI8hAEQQviSXb2l/VQUM1P0TwIUGiNG0Fqsu
         HdoAhLXMPJHeNIHXey8l3mls1T7tzkCTYetUsaNDYezuDK/t8TCwR39QVDWreW6R1hgs
         U1G6TKp8VmQp9OMeJF7TLtbvlQO8fXcVoGFn8mnGW2ezY/IKb8Z6N761uI7h0SjjxMdE
         xuewEnhKMbsPBPN5u55kZYU/CrGcf3zEkAf72Y+w4aZKPC1ERLDGpgLMP4TcT6qQzM3R
         gDBA==
X-Gm-Message-State: AOAM532vVQZ/XI+jzmWpeW5843yZT23wk5PZWJXb/djbr+e5j6viVjq/
        bKbqIdSXgxL5WQPFf359yLIesM+vEWa7mKLbfVyjH9QtoqEcf340Ut4VZ5uSRnOIqBaJ+/PbT2D
        O+xrs1+50pWHkU4d2PISG1m6B
X-Received: by 2002:a9d:6398:: with SMTP id w24mr777170otk.140.1631723557705;
        Wed, 15 Sep 2021 09:32:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEqEMq5Emx3QGBfkQ0rbyCrZIePE3tj2f7Z2WEi4Rv/KLV4WT4gXmfCPEt+bUaapt3BePG7Q==
X-Received: by 2002:a9d:6398:: with SMTP id w24mr777147otk.140.1631723557449;
        Wed, 15 Sep 2021 09:32:37 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id q131sm122216oif.44.2021.09.15.09.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:32:37 -0700 (PDT)
Date:   Wed, 15 Sep 2021 10:32:35 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Ruffell <matthew.ruffell@canonical.com>
Cc:     linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, nathan.langford@xcelesunifiedtechnologies.com
Subject: Re: [PROBLEM] Frequently get "irq 31: nobody cared" when passing
 through 2x GPUs that share same pci switch via vfio
Message-ID: <20210915103235.097202d2.alex.williamson@redhat.com>
In-Reply-To: <9e8d0e9e-1d94-35e8-be1f-cf66916c24b2@canonical.com>
References: <d4084296-9d36-64ec-8a79-77d82ac6d31c@canonical.com>
        <20210914104301.48270518.alex.williamson@redhat.com>
        <9e8d0e9e-1d94-35e8-be1f-cf66916c24b2@canonical.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 16:44:38 +1200
Matthew Ruffell <matthew.ruffell@canonical.com> wrote:
> On 15/09/21 4:43 am, Alex Williamson wrote:
> > 
> > FWIW, I have access to a system with an NVIDIA K1 and M60, both use
> > this same switch on-card and I've not experienced any issues assigning
> > all the GPUs to a single VM.  Topo:
> > 
> >  +-[0000:40]-+-02.0-[42-47]----00.0-[43-47]--+-08.0-[44]----00.0
> >  |                                           +-09.0-[45]----00.0
> >  |                                           +-10.0-[46]----00.0
> >  |                                           \-11.0-[47]----00.0
> >  \-[0000:00]-+-03.0-[04-07]----00.0-[05-07]--+-08.0-[06]----00.0
> >                                              \-10.0-[07]----00.0


I've actually found that the above configuration, assigning all 6 GPUs
to a VM reproduces this pretty readily by simply rebooting the VM.  In
my case, I don't have the panic-on-warn/oops that must be set on your
kernel, so the result is far more benign, the IRQ gets masked until
it's re-registered.

The fact that my upstream ports are using MSI seems irrelevant.

Adding debugging to the vfio-pci interrupt handler, it's correctly
deferring the interrupt as the GPU device is not identifying itself as
the source of the interrupt via the status register.  In fact, setting
the disable INTx bit in the GPU command register while the interrupt
storm occurs does not stop the interrupts.

The interrupt storm does seem to be related to the bus resets, but I
can't figure out yet how multiple devices per switch factors into the
issue.  Serializing all bus resets via a mutex doesn't seem to change
the behavior.

I'm still investigating, but if anyone knows how to get access to the
Broadcom datasheet or errata for this switch, please let me know.
Thanks,

Alex

