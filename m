Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26952380386
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhENGIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhENGIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:08:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAFAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 23:06:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t15so5762569edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 23:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ardcHHy4HMFsCCm362jCRSfkYTJCg6gBa+dhQsSbY4=;
        b=A2CJn1llgWZrjHBlQvOTdwAXuSCV6nI6+uHLtxIqI1lc6b5Mfjpn1D2FZHksL2XDxh
         IxK7s3C+aKefX2AbMa3aES0aFy9SLNXWof9I88eLl6JikgIr9j09QeqVEaWrq7vLyA4B
         OL0NeiNgBg6jUZDnn0KQN4twb4FjRzLzjQCS2b9BzERy+Ha22YPIWqo9yB1LOARy/f72
         +Vv0A3HL0z4gEpZZPmBJW8EqFxv0m59H5j0sZIo5/0sijpY4IM7z+ShPqwtNd5jkXnpJ
         vNbw9626XR5Dk6BjUbcPn+Bt/8C7jmfnqXFczd/4Chs8jcvY4AnWbvcE4+kWG6zMzOGt
         2HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ardcHHy4HMFsCCm362jCRSfkYTJCg6gBa+dhQsSbY4=;
        b=XNXyokuJrnUHzFjfpem4GUAkcmHkb58n84shrIInGd0/4k7BSWwmzVibbCo4BZNxwT
         Ngff4nfiUlmGBbj9gIOMutc/wHvWq2GUs0o21SEo6HOh7VG/8gMlsjEcxoc/Bw9H61jK
         lohh9L6Dgf20A5obnEVsMa745hg3CTFhGnK/iBZbgQnPII+tI2WpQ/bC32CIvG9S6k5f
         OBEiBxllci4g8CL4xJg18ehtlH2azMfr4lGDJC6E8nFIfwTrejLOskEWO0tINXkfx7Zp
         dZSWx6zRUQfE4Lckh6gKsfKAlYWpvyz6LyJLFNIN1Ok4LL1geLJHZF9E2zEv4M0lgVqP
         afRw==
X-Gm-Message-State: AOAM53173qJohdixas3QzN3hCkjIEFoVOExVi5Mq+ctlGCi3j0izudQa
        6Ac7pL/XIiPARZXTxFOS0Hymxg2ssHtzehM5uG4+IX1xTw==
X-Google-Smtp-Source: ABdhPJx8zWAZvQGB56hc0obGyyDbHeOZdzmhzmfag1lcuRNMlgwhfMXWhR+ruV7hndA1hetFLuQU+LEwADsM8kfH9rg=
X-Received: by 2002:a50:8a99:: with SMTP id j25mr53348075edj.253.1620972409303;
 Thu, 13 May 2021 23:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210423080942.2997-1-jasowang@redhat.com> <YJ1TgoFSwOkQrC+1@stefanha-x1.localdomain>
In-Reply-To: <YJ1TgoFSwOkQrC+1@stefanha-x1.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 14 May 2021 14:06:38 +0800
Message-ID: <CACycT3v-2naEaXEtPqaKcGz8qpfnmp4VzrHefqLNhO=9=57jdQ@mail.gmail.com>
Subject: Re: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, file@sect.tu-berlin.de,
        ashish.kalra@amd.com, konrad.wilk@oracle.com, kvm@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 12:27 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, Apr 23, 2021 at 04:09:35PM +0800, Jason Wang wrote:
> > Sometimes, the driver doesn't trust the device. This is usually
> > happens for the encrtpyed VM or VDUSE[1].
>
> Thanks for doing this.
>
> Can you describe the overall memory safety model that virtio drivers
> must follow? For example:
>
> - Driver-to-device buffers must be on dedicated pages to avoid
>   information leaks.
>
> - Driver-to-device buffers must be on dedicated pages to avoid memory
>   corruption.
>
> When I say "pages" I guess it's the IOMMU page size that matters?
>
> What is the memory access granularity of VDUSE?
>

Now we use PAGE_SIZE as the access granularity. I think it should be
safe to access the Driver-to-device buffers in VDUSE case because we
also use bounce-buffering mechanism like swiotlb does.

Thanks,
Yongji
