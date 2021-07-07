Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0093BE576
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhGGJWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhGGJW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:22:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C3DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 02:19:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i20so2189770ejw.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ntF5ShiMpxZzH3NgDCu0lj/qLit/wsTznB+iv/n6Jts=;
        b=EkUktZhVW6Hw0D3CwFrVu6SPtBCLkJYy2M7BJM1xaa8T71w3Am8UIGnGLzZ7sZjGBy
         oJPZFOsWMkQsg1Eor8GYHzrS0gvtg/qEnI+kjIYCFKEPoLzQIQX6UgYFrffMXB7uW8ud
         DAJeTUNRxqnYoE0JTnNDRQ4iWBS+hwKVMh6CzB8D/Nd7MUwmVBFXb/1DGoN5IcQxOlxA
         XEcMYCGgJ6/e1b9/F4uGKBE66Lafq27VxOH+bGLgnrQlIyePfFxmfVAzA2OsUgePTZRJ
         T3ukDS1lDG6sIQr7dau/XyarH0KZbl27sp8FmAm/INCn+Zavbu6Ds2cG23H+ZLiJNIkK
         nv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ntF5ShiMpxZzH3NgDCu0lj/qLit/wsTznB+iv/n6Jts=;
        b=W2gCE12emIy3Ypme+0C52MxH1hOPG3356+X8qK7q9OGMDeDyzEvj0jljnv9dnyawqq
         efumeLAjsLMsIr/h5TMtPEq5IsLG6Ne5lr05Fq+io7PR3BzKWtKMDKECkm98AcpNPvnv
         uFSXEpKlX7sL5Jq7SmqO8L5XxxbDjaiFhnMI4PDoooLdcdvJWczd8A/sjX5Hjq8aKDoE
         pVzXhOSD19gx+nBZUcPKYT0xcwlkuNmxqBIEq8gDFEJAwIbbGFAK0XgRkppNJOBWal2t
         wfixbVL+oMWXRcYCaCTFCtHBIQUWHlLUjWaowFoS2XsmfV5VRYLwZsohZmF++lmOg/Zq
         HEtw==
X-Gm-Message-State: AOAM533gPHZeHfoOI6S1S99TN9J2LIN4GOjug6wIkhnWeQYjkSAcWhqr
        6VwD+lSzGyUjEtIF2eS8EY4NeIBzkRskgHbzmOZQ
X-Google-Smtp-Source: ABdhPJwfUSLvIX93bY45nGlunKheveZx2mGwfBnicH+p8nMulhsjVrxLC9+PoE5I/qwuA5U0XX93SwRw5wHXZDNyzBo=
X-Received: by 2002:a17:906:cb93:: with SMTP id mf19mr20870738ejb.427.1625649585892;
 Wed, 07 Jul 2021 02:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com> <20210615141331.407-10-xieyongji@bytedance.com>
 <YOVrZtGIEjZZSSoU@stefanha-x1.localdomain>
In-Reply-To: <YOVrZtGIEjZZSSoU@stefanha-x1.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 7 Jul 2021 17:19:35 +0800
Message-ID: <CACycT3tvvMpsjmJGhY5duNCXt5YyyWqQ2MpxRuMKQwmtpgF0Aw@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 4:53 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Jun 15, 2021 at 10:13:30PM +0800, Xie Yongji wrote:
> > +static bool vduse_validate_config(struct vduse_dev_config *config)
> > +{
>
> The name field needs to be NUL terminated?
>

I think so.

> > +     case VDUSE_CREATE_DEV: {
> > +             struct vduse_dev_config config;
> > +             unsigned long size = offsetof(struct vduse_dev_config, config);
> > +             void *buf;
> > +
> > +             ret = -EFAULT;
> > +             if (copy_from_user(&config, argp, size))
> > +                     break;
> > +
> > +             ret = -EINVAL;
> > +             if (vduse_validate_config(&config) == false)
> > +                     break;
> > +
> > +             buf = vmemdup_user(argp + size, config.config_size);
> > +             if (IS_ERR(buf)) {
> > +                     ret = PTR_ERR(buf);
> > +                     break;
> > +             }
> > +             ret = vduse_create_dev(&config, buf, control->api_version);
> > +             break;
> > +     }
> > +     case VDUSE_DESTROY_DEV: {
> > +             char name[VDUSE_NAME_MAX];
> > +
> > +             ret = -EFAULT;
> > +             if (copy_from_user(name, argp, VDUSE_NAME_MAX))
> > +                     break;
>
> Is this missing a NUL terminator?

Oh, yes. Looks like I need to set '\0' to name[VDUSE_VDUSE_NAME_MAX - 1] here.

Thanks,
Yongji
