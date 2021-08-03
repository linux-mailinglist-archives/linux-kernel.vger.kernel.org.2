Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFBD3DE9D2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhHCJjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbhHCJjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:39:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E38C061381
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 02:38:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ec13so27666634edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QXQ5EvP/sNqFfx/lhQN+wsnZRMKa67ICv+oT5WdZOpE=;
        b=d9H53aWMga71ZSogCXHiF8qpa+uw6YSJZZLnbaXGojLmBu48pYHrN5FlH5t+zrb02N
         Y8gllvm+wxdYbG0zmDLk2trjQy8gwyDE6v4ZrLUoMhkPeGA9yPm7xn5NF+3Ek7lR4mwR
         zzIfBqdSHwydns6LOE3eadPk6Vd6b4SaOSlfoPNg7zsN657qccdvrtRHt7YGIW3Yh1YX
         XXy/mU3ExHLUoMRjlIjW22H5MtQh+mPSb9XuTXbaQNTyiC7iRMjb/ovohNYOoI4VQLFU
         878RKYupj/Diz+T3bCHHBTB7bvUpT/L8tT6CsI7OwqiPIV/dJpECcgn53okRlQaPuphy
         gA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QXQ5EvP/sNqFfx/lhQN+wsnZRMKa67ICv+oT5WdZOpE=;
        b=PcjfqOlEWWnH/Taq4/couXQYOkNXJCQ+lHJlL0P6D1Sj01j6x40mNBBcidQlYJKJ/h
         N/Mtz8UjO/GDFZXubnVa3IozNh/4SmCLuboc3cdMz20H7x3G2uJ1rHmBgRCQHcEuPeKa
         U1HmVRSZ7reXAnsSVr0vidQSpXxn0+2o+QLe7QVXzGDlgKfNbWw6lDQduZvBMj20Y98k
         M7W4t02v2OQNtQX491b9oLiTAlV93kWzz+TLlpAeksB1WcSOADWiyTMNYOsBbrteBJjF
         +SZhCT77T902lhejhzLlD3JrM3fKvnDh5YYEAzDZqhIrdKuEzeJXCgDoFu9VHW3GKEk0
         GG5w==
X-Gm-Message-State: AOAM531RWFp1gVeMWXmslZlyKX25VJesU8jfZv4ssDAlXPYYfKylC3Ao
        qpZcZQL4et16zx6Ym5DyyboeDgOaY2gYl+Etfhva
X-Google-Smtp-Source: ABdhPJzvDCZ7IM+d+eleUGoW8vFLGyxK6YWGr3cxlRwj4gkELxKZ80TChkbewe/R9lGSWrWBD7cinTUwyX8EuEgFvLI=
X-Received: by 2002:a05:6402:1d0d:: with SMTP id dg13mr24634764edb.312.1627983525876;
 Tue, 03 Aug 2021 02:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com> <20210729073503.187-11-xieyongji@bytedance.com>
 <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
In-Reply-To: <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 3 Aug 2021 17:38:34 +0800
Message-ID: <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
Subject: Re: [PATCH v10 10/17] virtio: Handle device reset failure in register_virtio_device()
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
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
        Greg KH <gregkh@linuxfoundation.org>,
        He Zhe <zhe.he@windriver.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Joe Perches <joe@perches.com>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 4:09 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/7/29 =E4=B8=8B=E5=8D=883:34, Xie Yongji =E5=86=99=E9=81=93=
:
> > The device reset may fail in virtio-vdpa case now, so add checks to
> > its return value and fail the register_virtio_device().
>
>
> So the reset() would be called by the driver during remove as well, or
> is it sufficient to deal only with the reset during probe?
>

Actually there is no way to handle failure during removal. And it
should be safe with the protection of software IOTLB even if the
reset() fails.

Thanks,
Yongji
