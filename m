Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC13D6A34
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 01:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhGZWsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 18:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233843AbhGZWsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627342114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGmsTgcyIKG5lma+qo/IbpdoduVKh2eYr03LqB0JH4c=;
        b=EhXz8GJZQn9Oxw2BBdNcRLXI3Z7Qfo8R/Eb4Cwnnw1SEtx0DG30a/b8PtEhs+j5JvHCTYK
        TqX3fkhg3nhcmzVYn5Oh7cJ3saWrQriNFcQD0fViGTSUzjh6tfZxH/hqZdcqChYCOPMpyM
        EykmwM1M73LbAujM6n+3MqtPcLooZew=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-8wy8naKYNFOr5IytlBUtMA-1; Mon, 26 Jul 2021 19:28:33 -0400
X-MC-Unique: 8wy8naKYNFOr5IytlBUtMA-1
Received: by mail-oo1-f70.google.com with SMTP id r15-20020a4aea8f0000b029025ec20a413eso7356159ooh.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=zGmsTgcyIKG5lma+qo/IbpdoduVKh2eYr03LqB0JH4c=;
        b=R0Hu6gAybJGw06ukQTwjYK2e1oAn9MxSRhIDSsjnij+Cs6lwmVljiadsr97wYAVHgG
         GYyhYCgIJ+mhg4kY8gTITD0elJvO9Gsrgy/x4m/jSK4huGkYZOHp6t0O5UA+kcnTJ6BM
         SMgFeIhzp237i/CYCLgxNhmjCkgfKPWeLVq2N3OzD6QZipn/e81wAMFUZTuNPgWdYi/G
         cwkIyDvvQpOhF50UWRYHsSuou0Rqt7kPHzf2Tc6RwbiR5uMFppgRgddInpEAGqeIXE1s
         iMzmiUZ22i1lgX7SVlYfYyYmhKpBJvscv4MDEZJef9ovsndWVEbiTGlu9zdBGUbP94sL
         AqCQ==
X-Gm-Message-State: AOAM531CU6f/bOOopzlVPk85hUiSxtfFqGUJK9pbRi0CrkDjqlZ8yVBs
        wep+t+jJIICeMAdPNOHryGyrqxdHC7euszTtFLJpFRX32yGvsV+UFVnGqmppDdTnI5+7bkdIaQ1
        1MIkxEOV4x7Nk6RfnwJRPrl+3
X-Received: by 2002:aca:a887:: with SMTP id r129mr1016705oie.128.1627342112662;
        Mon, 26 Jul 2021 16:28:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3GADjIuORJLkoHf1pSPqO4kcuqx8II3jB98Pxdt6mv3Z6DUajXj/STasL7XqN3HL0GlGG5A==
X-Received: by 2002:aca:a887:: with SMTP id r129mr1016693oie.128.1627342112452;
        Mon, 26 Jul 2021 16:28:32 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id p4sm219061ooa.35.2021.07.26.16.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:28:32 -0700 (PDT)
Date:   Mon, 26 Jul 2021 17:28:31 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vfio/mdev: don't warn if ->request is not set
Message-ID: <20210726172831.3a7978fd.alex.williamson@redhat.com>
In-Reply-To: <20210726230906.GD1721383@nvidia.com>
References: <20210726143524.155779-1-hch@lst.de>
        <20210726143524.155779-3-hch@lst.de>
        <87zgu93sxz.fsf@redhat.com>
        <20210726230906.GD1721383@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 20:09:06 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jul 26, 2021 at 07:07:04PM +0200, Cornelia Huck wrote:
> 
> > But I wonder why nobody else implements this? Lack of surprise removal?  
> 
> The only implementation triggers an eventfd that seems to be the same
> eventfd as the interrupt..
> 
> Do you know how this works in userspace? I'm surprised that the
> interrupt eventfd can trigger an observation that the kernel driver
> wants to be unplugged?

I think we're talking about ccw, but I see QEMU registering separate
eventfds for each of the 3 IRQ indexes and the mdev driver specifically
triggering the req_trigger...?  Thanks,

Alex

