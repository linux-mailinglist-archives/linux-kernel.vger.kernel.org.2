Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307B045D510
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349478AbhKYHIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:08:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352620AbhKYHGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637823782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKZ4W8dUJsff2qgbh+MXcvWMXfjgct4ziZKazp/bmHw=;
        b=P3RlUHdZlcRiKYCMnZ91BuS2PfbBkeIhSenWW+0eaufeJGCBmFO1FfYMfJyyxD6IP5Qk7F
        Dk9qqRtsXS1nVW3CU+pzMzA31ZWTyUpxyqENfcCzWkSIvprVgj6mnkxF6C8P1AaSp3/aTY
        WvMtiAbt1FeNwcR5W7K+MBVfkr/PUIk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-CEf7u3jWMhK1wQcWogNXqg-1; Thu, 25 Nov 2021 02:02:59 -0500
X-MC-Unique: CEf7u3jWMhK1wQcWogNXqg-1
Received: by mail-ed1-f69.google.com with SMTP id t9-20020aa7d709000000b003e83403a5cbso4603229edq.19
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VKZ4W8dUJsff2qgbh+MXcvWMXfjgct4ziZKazp/bmHw=;
        b=MyZ3/gSO3lQmlG0xSJtFZ1+U5JTtkGXhblr6brP+b/rIRZTWe0B3jX4VsNmSztNHSm
         B/6fLSslnB3iGAZQeGdgGSklXiY4cmkm6gIdwZNzrbm5eEWFdKAwL8H1yQ2A6qwW1DZw
         Pyl8GEvpidlwl8P1dyZFxFTcWHfpxnOqHabLRGBzCsWrbqZ9rUDVONCrKW8C4g/j9i+X
         T7owYes8I0k5cK7JQnnwvwuezsDssT8r03y9Favpk5Tm97UVCMqfdwtCkHjIOxWRS8D5
         G3SwAW+X3uWYsiOY1fjZBcBhTQFF776LhqAHq+u6aufTWJXlw1zBVuNDQmZ4vbhDZ27y
         BzoA==
X-Gm-Message-State: AOAM531LlkyIJDm2tyFbCA8XoNKFjQ8LR4jx/t8cGkHLkB2XdGTH3Ycz
        ocgxPISDDB158ixgYA6ANLhMB8eZ4DCvTqdYqUjTuR8+gBQD+9MdvfC/ob9gjW06bccnLMd6Z7T
        vZZO63CfOi9XOZye34wMg1Shy
X-Received: by 2002:a05:6402:5156:: with SMTP id n22mr36646990edd.222.1637823777782;
        Wed, 24 Nov 2021 23:02:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYcHfM0EP+0ZsTjbg+b2mmor3qHoBJ/QIj7HfoEGeddfE30NFvqno9TE2xCMsIv67T6XnoKg==
X-Received: by 2002:a05:6402:5156:: with SMTP id n22mr36646962edd.222.1637823777600;
        Wed, 24 Nov 2021 23:02:57 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
        by smtp.gmail.com with ESMTPSA id aq14sm992371ejc.23.2021.11.24.23.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 23:02:56 -0800 (PST)
Date:   Thu, 25 Nov 2021 02:02:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>
Subject: Re: [PATCH 1/2] eni_vdpa: Fix an error handling path in
 'eni_vdpa_probe()'
Message-ID: <20211125020139-mutt-send-email-mst@kernel.org>
References: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
 <CACGkMEvN0cgFQhJmLF3xDXHt_EyZ-TnfBM8CnpNwA9sKcwpzBg@mail.gmail.com>
 <393fb7b7-653b-eae6-16bd-5ffc7d600619@wanadoo.fr>
 <CACGkMEt3yA+fkFJxKfrXyui-rYVSk78=1AqrT0TYQqzcqTJVyg@mail.gmail.com>
 <069ed3fb-ef99-ff36-136d-a0221ba85a96@wanadoo.fr>
 <20211124185834-mutt-send-email-mst@kernel.org>
 <131b9250-f338-c931-39e6-ca3c1e3a9b66@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <131b9250-f338-c931-39e6-ca3c1e3a9b66@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 07:34:02AM +0100, Christophe JAILLET wrote:
> Le 25/11/2021 à 00:58, Michael S. Tsirkin a écrit :
> > On Tue, Nov 09, 2021 at 10:21:44PM +0100, Christophe JAILLET wrote:
> > > Le 09/11/2021 à 03:54, Jason Wang a écrit :
> > > > On Tue, Nov 9, 2021 at 3:32 AM Christophe JAILLET
> > > > <christophe.jaillet@wanadoo.fr> wrote:
> > > > > 
> > > > > Le 08/11/2021 à 06:55, Jason Wang a écrit :
> > > > > > On Mon, Nov 8, 2021 at 12:15 AM Christophe JAILLET
> > > > > > <christophe.jaillet@wanadoo.fr> wrote:
> > > > > > > 
> > > > > > > In the error handling path, a successful 'vp_legacy_probe()' should be
> > > > > > > balanced by a corresponding 'vp_legacy_remove()' call, as already done in
> > > > > > > the remove function.
> > > > > > > 
> > > > > > > Add the missing call and update gotos accordingly.
> > > > > > > 
> > > > > > > Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> > > > > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > > > > ---
> > > > > > >     drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
> > > > > > >     1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> > > > > > > index 3f788794571a..12b3db6b4517 100644
> > > > > > > --- a/drivers/vdpa/alibaba/eni_vdpa.c
> > > > > > > +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> > > > > > > @@ -501,7 +501,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > > > > >            if (!eni_vdpa->vring) {
> > > > > > >                    ret = -ENOMEM;
> > > > > > >                    ENI_ERR(pdev, "failed to allocate virtqueues\n");
> > > > > > > -               goto err;
> > > > > > > +               goto err_remove_vp_legacy;
> > > > > > >            }
> > > > > > > 
> > > > > > >            for (i = 0; i < eni_vdpa->queues; i++) {
> > > > > > > @@ -513,11 +513,13 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > > > > >            ret = vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queues);
> > > > > > >            if (ret) {
> > > > > > >                    ENI_ERR(pdev, "failed to register to vdpa bus\n");
> > > > > > > -               goto err;
> > > > > > > +               goto err_remove_vp_legacy;
> > > > > > >            }
> > > > > > > 
> > > > > > >            return 0;
> > > > > > > 
> > > > > > > +err_remove_vp_legacy:
> > > > > > > +       vp_legacy_remove(&eni_vdpa->ldev);
> > > > > > 
> > > > > > Won't vp_legacy_remove() be triggered by the put_devic() below?
> > > > > 
> > > > > Hi, I'm sorry but i don't see how.
> > > > > 
> > > > > My understanding is that:
> > > > >      - on "put_device(&eni_vdpa->vdpa.dev);", the corresponding release
> > > > > function will be called.
> > > > > 
> > > > >      - This release function is the one recorded in the
> > > > > '__vdpa_alloc_device()' function.
> > > > > 
> > > > >      - So it should be 'vdpa_release_dev()'.
> > > > > 
> > > > >      - This function, AFAIU, has no knowledge of 'vp_legacy_remove()' or
> > > > > anything that could call it.
> > > > > 
> > > > > 
> > > > > Unless I misread something or miss something obvious, I don't see how
> > > > > 'vp_legacy_remove() would be called.
> > > > > 
> > > > > 
> > > > > Could you elaborate?
> > > > 
> > > > I think the device should release the driver (see
> > > > device_release_driver()) during during its deleting.
> > > 
> > > Hi, I still don't follow the logic and I don't understand how
> > > 'vp_legacy_remove()' will finely be called, but it is not that important.
> > > 
> > > If it's fine for you, it's fine for me :)
> > > 
> > > CJ
> > 
> > So pls post just patch 2?
> 
> Patch 2/2 should apply cleanly with or without patch 1/2.
> Do I really need to send a v2 just for dropping the first patch? :/
> 
> CJ

It is preferable, yes. A patch in isolation is not the same as a patch
in the series.

> > 
> > > > 
> > > > Thanks
> > > > 
> > > > > 
> > > > > CJ
> > > > > 
> > > > > > 
> > > > > > Thanks
> > > > > > 
> > > > > > >     err:
> > > > > > >            put_device(&eni_vdpa->vdpa.dev);
> > > > > > >            return ret;
> > > > > > > --
> > > > > > > 2.30.2
> > > > > > > 
> > > > > > 
> > > > > > 
> > > > > 
> > > > 
> > > > _______________________________________________
> > > > Virtualization mailing list
> > > > Virtualization@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > 
> > 
> > 

