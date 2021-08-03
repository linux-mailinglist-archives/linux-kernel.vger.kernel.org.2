Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC223DE9A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhHCJSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhHCJSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:18:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF43C061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 02:18:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id nd39so35361279ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bNa7n1tZtuJcEEYiLTNeGKslKTEJs+rtFT0YV9yNlew=;
        b=Jd+UZ5AGs0Ooq/66KM+jA4m9HwVi+MRm7XqkaGbn4V3hh5RUeGnjXO4FB7ez9GAPYi
         tgsVUEl0qxA7yF00ZHW+ZQiwCQ+LlBhQO7XW9c8IihoDB7j2kIzgHGgN0wPJWzhpaSye
         JNwP1w89B3rYkEiXk/GkfLl0DR/lZ5VVGVH+IgILe+GxDSLM0KE2pbBO9vokfAg1Y2DJ
         4RPjt/85Mviy7n69snrUtKkUS9Z6/N8O0sY0KgvcM19Hi4Hbb6ldZkvVVYKFbXNgIOAM
         fo/TUivWwXaMC+0AFsFKUL9/T5bEBtf2ZUMRUza95oSJ9q2/NCozwY/+6bIvFMxUfevT
         EO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bNa7n1tZtuJcEEYiLTNeGKslKTEJs+rtFT0YV9yNlew=;
        b=D6Kr1SMfGXMt39SAjn70cZf9eTgHCMCa0/Dw/oz0oWwNeaNZUhxe31xTrpHLMF3lZF
         XlOAsJRJBgDoMRRbHP7aBabVismnMQlRSf1rg8ggUYtIf0ZL02WIWIBjM5T9ZmZuY+db
         wWlIYrYwftDani8b7m4zuQqSECBbl1aZlR0LLuP4xmOs66S1hGvziml0HEmvZas7igf6
         KeI7DSqolcgkS12PfMzovJVsxHIXJMTE9jLEeyIz+BFRgiAC6m4YTs7tDnEEuxhYYMaf
         TZXgncxs9siFY+y5kGznaxVhbu+ZnjHq2ctE0csUmVJiJN7RCGq5SRqZhXp80qYqhDBV
         ZvxA==
X-Gm-Message-State: AOAM532i+TQMo5u66YCThHCi4il8jw+6uR7fBKEFInnFUZ974P8ngMod
        kx3sv55rUtcTLeu/73rDZtTkVRNUUbpRGTRnRmDz
X-Google-Smtp-Source: ABdhPJz+l/RWTi/cEp9hIjcvn9xzMhjrwXVoQzQni85Wf2XRf3qnbCHSQTs5k/IZl5rLuZZ4G+B/tk85r0HL53eNKZg=
X-Received: by 2002:a17:906:af77:: with SMTP id os23mr19120305ejb.427.1627982285614;
 Tue, 03 Aug 2021 02:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com> <20210729073503.187-8-xieyongji@bytedance.com>
 <487ed840-f417-e1b6-edb3-15f19969de51@redhat.com>
In-Reply-To: <487ed840-f417-e1b6-edb3-15f19969de51@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 3 Aug 2021 17:17:54 +0800
Message-ID: <CACycT3ujOQ84mNMEjE-H93cgVvrWeKaDcAabg7GPvMzU-rSPYw@mail.gmail.com>
Subject: Re: [PATCH v10 07/17] virtio: Don't set FAILED status bit on device
 index allocation failure
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

On Tue, Aug 3, 2021 at 4:03 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/7/29 =E4=B8=8B=E5=8D=883:34, Xie Yongji =E5=86=99=E9=81=93=
:
> > We don't need to set FAILED status bit on device index allocation
> > failure since the device initialization hasn't been started yet.
> > This doesn't affect runtime, found in code review.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
>
> Does it really harm?
>

Actually not. I think I can remove this patch if we don't need it.

Thanks,
Yongji
