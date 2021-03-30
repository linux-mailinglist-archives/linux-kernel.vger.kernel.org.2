Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2811234ECB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhC3Phg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhC3Pha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:37:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D74C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:37:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ap14so12358356ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8QVueR2J4MG452uSvhDqbSnDmvlg2Lkj4kwKpUq0Ag=;
        b=JC9HzvaCN6/0Ezka753cn0ntDqupiz9J5lCvt7eKMBgZMSAAjfglM+ppRcOE81ssun
         jI0A7lYOev6YGjf22yjxPzi9iHoWg70Jl6kEBLVH0M9LP28bx1EQcbmJAZ1JNEBZ6SBC
         NQBU52jNtek5CJLli0h4K3ettWmsKxizHz59JCcxHViufUp/Twziq9olbE/2HZKCPSfQ
         BIp9kDzBD5tR68MyRzZxycmLgSpNoV6LKvDG9gOiTqcjDUg11I1q+3EF94d1TaMUuRW+
         JcjyG/yVyJF2iOXuVkxMLdqCFBzov9l4WyPOnbK5a+z6R8glPMyW3rHu6FgxdCPSQqrS
         aEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8QVueR2J4MG452uSvhDqbSnDmvlg2Lkj4kwKpUq0Ag=;
        b=pH4J9UMd2NMwYL7IH0y5+wCV8bh/fnamhTxeDv7CNY7jG6/JtkR7IrppkUaa9oaQVZ
         Yb+ad+T0zzINs5xQ7inz/0U8WkZcddT/i+pFzXijmvwOGMj2RgBFhY64+TCNYijFYNHR
         b0d5B6JccQR857k16nnwKqvNrSxv6dAN2xDZxFmxpB+Wl7dNEHeFp8uBR0beL52BpblW
         1FgDMjjIhcPQo5N2ipQ2axZvuL7Wz9kBxXtvsIGdgjvjNCrf8aUS4l0M9W2PKtYWZBVo
         gJo7MuzijsrA+u6hSshy9eulwCvBmJBpoysFJ8EK/ZWj7mKZX22Aq+kJC4chOSlJ8IR5
         w09g==
X-Gm-Message-State: AOAM533SPEcyJHc3DwG2xHaMus6yEPJlNFy/vVEjnDvJQDarlcLE984v
        sw4n36JR5FZ3sJwBvNBDA6mqkiA/54caqyoQRLX9AA==
X-Google-Smtp-Source: ABdhPJx/6s9iYOeW5br47lgE1qFLbKm3qI/FVFrtxTDlYTEtW43HlM1qGYwq4bN1JpZGXJvdMUv2lYVFG/6v36DyvWU=
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr34155158ejg.418.1617118648892;
 Tue, 30 Mar 2021 08:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com>
In-Reply-To: <20210330111620.GK2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Mar 2021 08:37:19 -0700
Message-ID: <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 4:16 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Mar 29, 2021 at 07:47:49PM -0700, Dan Williams wrote:
>
> > @@ -1155,21 +1175,12 @@ static void cxlmdev_unregister(void *_cxlmd)
> >       struct cxl_memdev *cxlmd = _cxlmd;
> >       struct device *dev = &cxlmd->dev;
> >
> > -     percpu_ref_kill(&cxlmd->ops_active);
> >       cdev_device_del(&cxlmd->cdev, dev);
> > -     wait_for_completion(&cxlmd->ops_dead);
> > +     synchronize_srcu(&cxl_memdev_srcu);
>
> This needs some kind of rcu protected pointer for SRCU to to
> work.. The write side has to null the pointer and the read side has to
> copy the pointer to the stack and check for NULL.
>
> Otherwise the read side can't detect when the write side is shutting
> down.
>
> Basically you must use rcu_derference(), rcu_assign_pointer(), etc
> when working with RCU.

If the shutdown path was not using synchronize_rcu() then I would
agree with you. This usage of srcu is also used to protect dax device
shutdown after talking through rwsem vs srcu in this thread with Jan
and Paul [1]. The syncrhonize_rcu() guarantees that all read-side
critical sections have had at least one chance to quiesce.

So this could either use rcu pointer accessors and call_srcu to free
the object in a quiescent state, or it can use synchronize_srcu()
relative to a condition that aborts usage of the pointer.

[1]: https://lore.kernel.org/lkml/20180408031113.GO3948@linux.vnet.ibm.com/
