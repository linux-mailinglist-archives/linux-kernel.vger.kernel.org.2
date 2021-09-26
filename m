Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0DE418617
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 06:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhIZEVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 00:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229744AbhIZEVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 00:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632629985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZEDO7VMzKEtqu4xff18CWZsV8ZjmqSpSP3cUSke6BmQ=;
        b=H05CB7yrM9TpbLICS+0+LpYrf4jDXhDyHgW6ZuNOFEBy+I90Mjqjk+6UyRy3A7yuZbT9sn
        oAjrGSaqn6oKab+ZW7xYAgEdwxkyOLc1HWlwHwB1JjbCIbzCakubgaCRN9eQvJJ9j2pjAC
        PV777N9rMQHD66H+EAITsLwNmka+ZcA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-p1pDwFSYO-yyqmlg96AdCw-1; Sun, 26 Sep 2021 00:19:43 -0400
X-MC-Unique: p1pDwFSYO-yyqmlg96AdCw-1
Received: by mail-lf1-f69.google.com with SMTP id r193-20020a19c1ca000000b003fc8f43caa6so12958500lff.17
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 21:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZEDO7VMzKEtqu4xff18CWZsV8ZjmqSpSP3cUSke6BmQ=;
        b=kLXzY71k/BP0YcYcmSEkvfmGxjVKzrJdUk2IrTKYOXpOh0aOlLqm8KMGYB03TaUbnW
         aUQUsPWZqexDNZZ9Fpm/IhzEro41rlodPqfaiCBVKEZfJ69FjSPYyid3NlTdtyMLlayn
         wH5VLiEu5aG/paCKS+PJOEGLfolnYZ9mdXjUcNKH1Nc0LwhDjskSqmcIAnD84Oj0tr1U
         4JZfH3yZ0o8EH+KCXWa+FPwJyGKO6qQVMgvjmwOMxlkkVceIUbXNBxGTMtm4ka1CVggK
         Ku01D9vgoy6/jkoff350xxsho7V5g8Sc6oH2ICCgcDVSmtxwAoWXPe3+KFHot4EycYUg
         ZSNg==
X-Gm-Message-State: AOAM531c8sHTbokzONCHkGKd4DUrSG+wLWiM0lQuYtB9RklhY8T0MahV
        GYpd149mjuzh/OTxeNBqMEXxHpDfXZDDQ9A3y5XJAeuKLMO7CHXhITWacA2ZA4V6JTQq9E/NWIq
        l/kSjI8L8WYRIrrsYYPSwlQ0Vh9+a0NAjNrEByeUk
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr8458820lfr.580.1632629981535;
        Sat, 25 Sep 2021 21:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/CKbYwbOzo/Ltc9/By093K0TKyiOcdFR8nOgIXFHTdVyaVR6RoQibvfJEuPPMTf+l1XbSCIjN1Q8g6eiam7o=
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr8458810lfr.580.1632629981391;
 Sat, 25 Sep 2021 21:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <cover.1632313398.git.wuzongyong@linux.alibaba.com> <296014fa3b765f2088a3183bf04e09863651a584.1632313398.git.wuzongyong@linux.alibaba.com>
 <8341d7ef-d31d-5536-864b-7d5127b7ec9f@redhat.com> <20210926032701.GA32606@L-PF27918B-1352.localdomain>
In-Reply-To: <20210926032701.GA32606@L-PF27918B-1352.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Date:   Sun, 26 Sep 2021 12:19:30 +0800
Message-ID: <CACGkMEuAfvAY8nc2fjHQ007bRPE=pUgDPPgMjhkeA34JTQKSfw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] eni_vdpa: add vDPA driver for Alibaba ENI
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 11:27 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> On Sun, Sep 26, 2021 at 10:26:47AM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2021/9/22 =E4=B8=8B=E5=8D=888:46, Wu Zongyong =E5=86=99=E9=81=
=93:
> > > +
> > > +#ifdef __LITTLE_ENDIAN
> >
> >
> > I think disable the device via Kconfig is better than letting user to m=
eet
> > errors like this.
> >
> > (Or if the device is always using little endian, we don't even need to
> > bother this).
>
> I prefer the second suggestion since there are no use cases that the
> device uses big endian

If this means the device will always use little endian. It's fine.

Thanks

> >
> > Thanks
> >
> >
> > > +static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_dev=
ice_id *id)
> > > +{
> > > +   struct device *dev =3D &pdev->dev;
> > > +   struct eni_vdpa *eni_vdpa;
> > > +   struct virtio_pci_legacy_device *ldev;
> > > +   int ret, i;
> > > +
> > > +   ret =3D pcim_enable_device(pdev);
> > > +   if (ret)
> > > +           return ret;
> > > +
>

