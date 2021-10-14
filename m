Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C1342D06B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhJNCcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229496AbhJNCcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634178605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IynqbknfdhAtpAsTc+n5KzLs0d2B4KuFYlrAM62Za7c=;
        b=UgG4XrQZnB2sFhsU3i7kadw8cxUjNGVaCc/MmLqHRF/jgtLHMU4FFFltQb6upyZveb1w6X
        oRLejPbadkX1qft8rHCVJdrSLhwvRfDhPEo6CwUNB3amOf5xWnLYd03VBUixnCYeORuqfx
        z1Znq5NvBog7nRtc1AemxWRC78vry5U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-BdrU1tU_OiK84Ot3KdvePA-1; Wed, 13 Oct 2021 22:30:04 -0400
X-MC-Unique: BdrU1tU_OiK84Ot3KdvePA-1
Received: by mail-lf1-f70.google.com with SMTP id i6-20020a056512318600b003fd8c8c2677so3339884lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IynqbknfdhAtpAsTc+n5KzLs0d2B4KuFYlrAM62Za7c=;
        b=Bw7nxItwleOtdj0STKIcXRunCnGYd9/AiYSTIWOYbzreAQYsevQ+VlhHOIfSsc4o4b
         UpwcAVjrkqh3gWX1L/pVL4Z8a0mELS0WHH1LIsVzk6tF7tisQp9G3jUxqPjDIg5BW71f
         myCN8sRBbCIcSi8cJemKyEKY+hpgCMCIlD2+CNNFxU8WOLAmNFSzt9VkTmkO9AwX3aiY
         sDr2qLUU0wTVPoE4UE2nj8Dn0sIEL3HPDv3XUR0kIKa6LhxB/w72lgnv9ElPVDO5geia
         ovlN3D75E1RJNHa3MuD9MUzAOWu7Ng5gMnx122cEVBE295vDDXDoTtkVWZqUWSpCLTkU
         pWdg==
X-Gm-Message-State: AOAM533fBEz4IKwU7sWIfA8UBe/1Pr03gjF79OnNm7c5XuKVJ+25XILS
        45AIrBUHV68Es8HWrRDzAXBohuvmya++ndTdfAVYwQ0IyQ/C+mkq97jm7ifFirN+od2/Ynu9dQj
        D47Wb7GXygjyb338Slj5txeo46yTMf8rQfL0RgsqZ
X-Received: by 2002:a05:6512:110d:: with SMTP id l13mr2432426lfg.199.1634178602848;
        Wed, 13 Oct 2021 19:30:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCBnldX41BfPregta5x39FHwsgQm6jJf2AND+80Y0yMuBE60tF0GZs4V1GmdAp+U7WPN/6sjW2EZGHISIZvPc=
X-Received: by 2002:a05:6512:110d:: with SMTP id l13mr2432414lfg.199.1634178602690;
 Wed, 13 Oct 2021 19:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com> <20211012065227.9953-7-jasowang@redhat.com>
 <20211013055752-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013055752-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 14 Oct 2021 10:29:49 +0800
Message-ID: <CACGkMEtZB7y=OVcCvLWkdOyPrifAKJOU_tHLSyfMNGMkPspp4g@mail.gmail.com>
Subject: Re: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 5:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:52:21PM +0800, Jason Wang wrote:
> > We used to synchronize pending MSI-X irq handlers via
> > synchronize_irq(), this may not work for the untrusted device which
> > may keep sending interrupts after reset which may lead unexpected
> > results. Similarly, we should not enable MSI-X interrupt until the
> > device is ready.
>
> You mean until the driver is ready.

RIght, I will fix it.

Thanks

