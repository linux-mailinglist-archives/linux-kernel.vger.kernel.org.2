Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89423423D85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbhJFMRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238434AbhJFMRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633522516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qnmDIGptsktOkioDWWXCssVddVdWstmqHBWueCna4kc=;
        b=cKiG+WOybh2sZ2ZsquOVXREOamLakQY0NRF5kFPQpIHmLAar0SumRuYLGIjv4rjBwgZ1Et
        gHXDMaFILOaRQLrS39E0aScUeTgvnUgqIoJYuKrhdH8LsqWTo7i++0Q/wte9m262C6g2Fz
        cGVnXJuOXLIvsaCRD2dWgl8Ph3UPXmM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-AkyZYqABP22FBI5hwOCAvw-1; Wed, 06 Oct 2021 08:15:15 -0400
X-MC-Unique: AkyZYqABP22FBI5hwOCAvw-1
Received: by mail-ed1-f69.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so416695edy.14
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 05:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qnmDIGptsktOkioDWWXCssVddVdWstmqHBWueCna4kc=;
        b=JLSQ2sKv6KIiJS+XbtPGCMTjseLFxDBykVDXgtcfVcWBxGBO2vxm1vegmoOW46L12j
         fW882XOUCgX+qlrJRe6uaiRB5FmNlATozwkuszRIfE67P82kLcWer3RfUHJiddlVmJ+8
         f1NYqdzfOSj23yfgMoGpHMxLFWSJ2iB/QJOpkMSkyAkVrKNzuUCNRCRZ+2JfZsDfO3xd
         miP3gYlZgkLgp0nG+AcjrPcmqtSyYAhSmRxZ3xJZa5vLxRqkrW+Tr8q4jx4nwigDhlR5
         2GCbTS7n1N2RnKRNU88E+/dgWf8c2cjjq/4dpfhN1Qe7xvXbAGDpNQ7xB1SR2tlCHxV2
         OqXA==
X-Gm-Message-State: AOAM532w9lTt9zFwSUCw+24C5bgB0H2avzNfMSWn77yrpEg7d/8dt6R0
        KafSCTF27az2RMnPPGlwLpy7NZyEpdPXlGLxXapmYMoyw9YFBCIiHvbrfEO8lvF9TAOG+b4kFVf
        xi/qWhL0L0AJljScY+4P2nHSo
X-Received: by 2002:a17:906:f208:: with SMTP id gt8mr21806752ejb.522.1633522513833;
        Wed, 06 Oct 2021 05:15:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG9wllx9y16DQrS76uUlfwpX+3oqTEzh8ajeSft32BLV8/8AcXlKmgVAU0xygywoNNmIYASA==
X-Received: by 2002:a17:906:f208:: with SMTP id gt8mr21806715ejb.522.1633522513589;
        Wed, 06 Oct 2021 05:15:13 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id k20sm8795905ejd.33.2021.10.06.05.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 05:15:12 -0700 (PDT)
Date:   Wed, 6 Oct 2021 08:15:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211006081430-mutt-send-email-mst@kernel.org>
References: <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <875yuc3ln2.fsf@redhat.com>
 <20211004110537-mutt-send-email-mst@kernel.org>
 <87wnms23hn.fsf@redhat.com>
 <20211004151408-mutt-send-email-mst@kernel.org>
 <87sfxezcjp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfxezcjp.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 12:13:14PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 05:50:44PM +0200, Cornelia Huck wrote:
> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Mon, Oct 04, 2021 at 04:33:21PM +0200, Cornelia Huck wrote:
> >> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> 
> >> >> > On Mon, Oct 04, 2021 at 02:19:55PM +0200, Cornelia Huck wrote:
> >> >> >> 
> >> >> >> [cc:qemu-devel]
> >> >> >> 
> >> >> >> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> >> 
> >> >> >> > ok so that's a QEMU bug. Any virtio 1.0 and up
> >> >> >> > compatible device must use LE.
> >> >> >> > It can also present a legacy config space where the
> >> >> >> > endian depends on the guest.
> >> >> >> 
> >> >> >> So, how is the virtio core supposed to determine this? A
> >> >> >> transport-specific callback?
> >> >> >
> >> >> > I'd say a field in VirtIODevice is easiest.
> >> >> 
> >> >> The transport needs to set this as soon as it has figured out whether
> >> >> we're using legacy or not.
> >> >
> >> > Basically on each device config access?
> >> 
> >> Prior to the first one, I think. It should not change again, should it?
> >
> > Well yes but we never prohibited someone from poking at both ..
> > Doing it on each access means we don't have state to migrate.
> 
> Yes; if it isn't too high overhead, that's probably the safest way to
> handle it.
> 
> >
> >> >
> >> >> I guess we also need to fence off any
> >> >> accesses respectively error out the device if the driver tries any
> >> >> read/write operations that would depend on that knowledge?
> >> >> 
> >> >> And using a field in VirtIODevice would probably need some care when
> >> >> migrating. Hm...
> >> >
> >> > It's just a shorthand to minimize changes. No need to migrate I think.
> >> 
> >> If we migrate in from an older QEMU, we don't know whether we are
> >> dealing with legacy or not, until feature negotiation is already
> >> done... don't we have to ask the transport?
> >
> > Right but the only thing that can happen is config access.
> 
> Checking on each config space access would be enough then.
> 
> > Well and for legacy a kick I guess.
> 
> I think any driver that does something that is not config space access,
> status access, or feature bit handling without VERSION_1 being set is
> neccessarily legacy? Does that really need special handling?

Likely not, I just wanted to be exact.

-- 
MST

