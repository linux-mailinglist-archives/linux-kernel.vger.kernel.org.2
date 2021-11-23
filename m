Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3970D459A12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhKWC2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:28:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229776AbhKWC2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637634334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJKXXo5huA3qTYjotBCmHop1H83ADBgZQCZurCS2VDU=;
        b=cg0lTPzm+mEC5eu38gi6bP9oqeeC2FBQvlDJW+HrsvaVZqfYpcH2id0bPSL2kZ/BzZ/Ys+
        BIcSt7m5oktyTnM5J6p++74jUgFjTbhZORbK3qA5KCedDpOPZiB0fdUqJuY3Zr5imfai9P
        eCwJRa73lghX1yAgyGWNAgIxw4abEP4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-TvUTrP8FMCa_-swqrYNaEg-1; Mon, 22 Nov 2021 21:25:33 -0500
X-MC-Unique: TvUTrP8FMCa_-swqrYNaEg-1
Received: by mail-lf1-f72.google.com with SMTP id m1-20020ac24281000000b004162863a2fcso5270511lfh.14
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJKXXo5huA3qTYjotBCmHop1H83ADBgZQCZurCS2VDU=;
        b=zKS3ctW95KxG1qdnDE1qy0ekNDd2eRDgDCAZiIamTTDo7pZR2rGOKjhL12MwdH9wod
         +0hhj8gujARBGMCRWKGOZ7F1asHQsq6eZ3tFuViZ7JmBbHrQWCzqHWEKjZHicL6RitSO
         1HCqhdd9YOfVuUKlpPNzyfVaMTCbQFFIRmOsr9DVoQDdhXHnyayJQs3qtWDu0RpBZwAa
         jJJQIeQ9nVTTRJXkgQm66lyYoRVJ3yZ6n1/T1Dc4bE8q1vLXNioQClPgPYFhkEDN8zNy
         64puT5jPrSNUMBArFz5H3lOntaKIQyGl0m+roBMsWU69EyAtbgLX5ypOvt1t7NpRafll
         4q5A==
X-Gm-Message-State: AOAM533Ji+wlu787cho+AhUZIUCsanURViAfucP3rLFfxDY/Sp6CdAL0
        wQ1MmWAMJoca3WrrZM61DzVcE6BAn96blnSefKIHKlJRndzrdx+CrhlGdIQyE+NyDi9Fn2PgJSu
        2TCpmEoWFrQxNdDYwUGuG/jIpAwMFTqJ5oBcB/JQt
X-Received: by 2002:a05:6512:2081:: with SMTP id t1mr1184066lfr.348.1637634331797;
        Mon, 22 Nov 2021 18:25:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhbzfSpkWV2xGy6ErJZl4ZYscE/G0X2n8DtA51zeavG44zfVZ65TNtG3E6AVCF6h+nqefVVGDXVmsuTXxrt4w=
X-Received: by 2002:a05:6512:2081:: with SMTP id t1mr1184043lfr.348.1637634331603;
 Mon, 22 Nov 2021 18:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20211027022107.14357-1-jasowang@redhat.com> <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com> <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com> <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com> <20211122212352.4a76232d.pasic@linux.ibm.com>
In-Reply-To: <20211122212352.4a76232d.pasic@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 23 Nov 2021 10:25:20 +0800
Message-ID: <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 4:24 AM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Mon, 22 Nov 2021 14:25:26 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > I think the fixes are:
> >
> > 1) fixing the vhost vsock
> > 2) use suppress_used_validation=true to let vsock driver to validate
> > the in buffer length
> > 3) probably a new feature so the driver can only enable the validation
> > when the feature is enabled.
>
> I'm not sure, I would consider a F_DEV_Y_FIXED_BUG_X a perfectly good
> feature. Frankly the set of such bugs is device implementation
> specific and it makes little sense to specify a feature bit
> that says the device implementation claims to adhere to some
> aspect of the specification. Also what would be the semantic
> of not negotiating F_DEV_Y_FIXED_BUG_X?

Yes, I agree. Rethink of the feature bit, it seems unnecessary,
especially considering the driver should not care about the used
length for tx.

>
> On the other hand I see no other way to keep the validation
> permanently enabled for fixed implementations, and get around the problem
> with broken implementations. So we could have something like
> VHOST_USED_LEN_STRICT.

It's more about a choice of the driver's knowledge. For vsock TX it
should be fine. If we introduce a parameter and disable it by default,
it won't be very useful.

>
> Maybe, we can also think of 'warn and don't alter behavior' instead of
> 'warn' and alter behavior. Or maybe even not having such checks on in
> production, but only when testing.

I think there's an agreement that virtio drivers need more hardening,
that's why a lot of patches were merged. Especially considering the
new requirements came from confidential computing, smart NIC and
VDUSE. For virtio drivers, enabling the validation may help to

1) protect the driver from the buggy and malicious device
2) uncover the bugs of the devices (as vsock did, and probably rpmsg)
3) force the have a smart driver that can do the validation itself
then we can finally remove the validation in the core

So I'd like to keep it enabled.

Thanks

>
> Regards,
> Halil
>

