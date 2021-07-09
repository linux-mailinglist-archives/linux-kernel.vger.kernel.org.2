Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129323C223E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhGIKd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhGIKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:33:26 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A526C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:30:43 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z25so4507684qto.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:mime-version:subject:from:in-reply-to:cc
         :date:message-id:references:to;
        bh=R4f9OcyVi0mET/bLtkBejNC17JCe88k19yLDC/kZYfM=;
        b=YxFxU691lXnAutW0FnLeCUrTs7YqGJranfETBjNtErjwPseDxpmnyG3ak7tViCtCat
         ejDmRzA2SiHzqVP7XNGe5Lmo2v8lwnUwrqyAs2BbjyxdEToaxZd3MkmBEmzmSBcZDUSP
         I7/QT+rGLSWFCzoqJVOoPFhvKZlsRQGMYbw91JBVptpCbqLL5tM5RiycKB8Ybx7490Ms
         IgfHd2RNtBu4k1QKnHuSQOBD/5ctjLwksQqjEfQARfyjsy8Jx8oUGuQUY0mixi7A+EJw
         9v7NBwr2XlD70wUcFqIWUxPiyWlAeKdZ3FOjnWVd8J2QKpP1BArzDX1gqBhImV0tiKW+
         LgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:mime-version:subject
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=R4f9OcyVi0mET/bLtkBejNC17JCe88k19yLDC/kZYfM=;
        b=TsyROindn/gp7YkA28WQaEk1oX0QyOcYve4NOrsepD9bAkFzPBk6VOpd4uqKfBkdOy
         zwjUGRSFRnN4UfthRhTtHz/WRYDTG3JfxXfboxvxe28XSNWX1CWn1pbK0DRwNrH6af5W
         sfD4BiB4qrCj1iJXHpdeAO28hznwszREKYh3Zs19qW+DXFnF448ahey5oLT60DYnLq5l
         jISmsaqr7jbrbtrbgo/iYAAXOSC8H9ggXwWVuzoSJvCG6syHKmtgnjhBSSKHVkcG6jCw
         r8RS2QHV3Fm4RbzKjFkRPU/A4Mewvi6ZX65LNSf1hy8vuh7KA+xh3y26SU2wgPkmrtci
         p8pw==
X-Gm-Message-State: AOAM532Fb0hpsYAyy8AVTDqJF+hvV+J7a6nR5wM0VrqHMZKCziy3bxWj
        42L7g8n6Ohqq8ZfyyZO1EbiiXw==
X-Google-Smtp-Source: ABdhPJx9xhE/6m1aZxxmq1DNh+zIf4kZefCaNDjFiHxrVVTjqM9Y7DKV6r8cjUfVbqK76mG6mINRPw==
X-Received: by 2002:ac8:5bc8:: with SMTP id b8mr33190118qtb.386.1625826642154;
        Fri, 09 Jul 2021 03:30:42 -0700 (PDT)
Received: from smtpclient.apple ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id bm42sm2209496qkb.97.2021.07.09.03.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 03:30:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] drivers: Follow the indentation coding standard on printks
From:   bilbao@vt.edu
In-Reply-To: <6ce9de29-2669-deb5-ea0e-895992240bea@gmx.de>
Cc:     Rolf Eike Beer <eike-kernel@sf-tec.de>, gregkh@linuxfoundation.org,
        davem@davemloft.net, kuba@kernel.org,
        James.Bottomley@hansenpartnership.com, netdev@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 9 Jul 2021 06:30:40 -0400
Message-Id: <2693E7F6-4D6D-4EF4-B2B4-102C044AB2AC@vt.edu>
References: <6ce9de29-2669-deb5-ea0e-895992240bea@gmx.de>
To:     Helge Deller <deller@gmx.de>
X-Mailer: iPhone Mail (18F72)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helge,

I would like to finish what I started and take care of this, yes.

thanks,
Carlos.

> On Jul 9, 2021, at 2:43 AM, Helge Deller <deller@gmx.de> wrote:
>=20
> =EF=BB=BFOn 7/8/21 11:25 PM, Rolf Eike Beer wrote:
>> Am Donnerstag, 8. Juli 2021, 15:10:01 CEST schrieb Carlos Bilbao:
>>> Fix indentation of printks that start at the beginning of the line. Chan=
ge
>>> this for the right number of space characters, or tabs if the file uses
>>> them.
>> [...]
>>> --- a/drivers/parisc/iosapic.c
>>> +++ b/drivers/parisc/iosapic.c
>>> @@ -633,7 +633,7 @@ static void iosapic_unmask_irq(struct irq_data *d)
>>>     printk("\n");
>>> }
>>> -printk("iosapic_enable_irq(): sel ");
>>> +    printk("iosapic_enable_irq(): sel ");
>>> {
>>>     struct iosapic_info *isp =3D vi->iosapic;
>>> @@ -642,7 +642,7 @@ printk("iosapic_enable_irq(): sel ");
>>>         printk(" %x", d1);
>>>     }
>>> }
>>> -printk("\n");
>>> +    printk("\n");
>>> #endif
>>>     /*
>> This is also debug code. It is basically unchanged since it has been impo=
rted
>> into git. So it may be time to remove the whole block. Helge?
>=20
> I'd prefer to clean it proper up and keep it.
>=20
>=20
>>> diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
>>> index dce4cdf786cd..c3381facdfc5 100644
>>> --- a/drivers/parisc/sba_iommu.c
>>> +++ b/drivers/parisc/sba_iommu.c
>>> @@ -1550,7 +1550,7 @@ static void sba_hw_init(struct sba_device *sba_dev=
)
>>> #if 0
>>> -printk("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n",
>>> PAGE0->mem_boot.hpa,
>>> +    printk("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x
>>> 0x%x\n", PAGE0->mem_boot.hpa, PAGE0->mem_boot.spa, PAGE0->mem_boot.pad,
>>> PAGE0->mem_boot.cl_class);
>>>     /*
>> This is equally old. It should be either also removed, also this seems at=

>> least worth as documentation. Maybe just switch it to pr_debug() or
>> dev_debug() while fixing the indentation.
>=20
> Yes, I'll clean it up too.
>=20
> @Carlos:
> Instead of just removing or fixing the indentation, I'll fix it for both p=
arisc
> drivers. Unless you want to try...
>=20
> Helge
