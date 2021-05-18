Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0087C38741B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347481AbhERIbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbhERIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:31:14 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282F8C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 01:29:57 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id k4so4725159ili.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXiJrh+p9s0WWsTLQQadzlpiuPrT1XSgZ2/ewYgHYsY=;
        b=x/yXG9ffYBn4zTOLXh2qn9eeSklSdoqOtqeUbitOM+WxGczCVKioKWHMMUnUkSiEb0
         K8GGhabg2gIMrxojjGMibQhguuQe/YOq73sWxSarfR0Na7OSzYkKFWMG+P27XUocwkf2
         M/UhOHRVw+rBEcHUnzsCOvfnPVvlpdq3SeKK9nZGN8X6c7pUX7moxvYDe8DhQltFKnUa
         rqI3s6RX0wGb3dQoWGAB2WPUysuJJDIKl193Cq1oREY4PNF0WbUqqDi4Ou5ti8vw0TRp
         kMFQmaS1zBUnPXc3+LZOTMEy/724NP2q2Uq9yvwJQM/ewgjan6Vw9fY4bUUoK2aBxYce
         yOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXiJrh+p9s0WWsTLQQadzlpiuPrT1XSgZ2/ewYgHYsY=;
        b=rSyG/qdpC6B2+Ii5V+QQgSzFt13YULdiC8JGsOefznFrkfGooVxoMuYiR06eyjwgsY
         kfm4RO3HLl588BV1ys+/x3BD9Jhuyspef+poBoIWTwJ9Rf0aKAYzdzjf5TN/3BcYYJLj
         xFPuVA3eU8gXM0f5wrH6DVYQPvhBB01vTnJCntDotNxKZauWU9A4kUGpQPH9A/GKrVMp
         BPbh1NzcuvAq5jiGey+/mIQssufe4Oz8Ce1CHwkd+YVg/aBrcVfh57AKHhbJBWlzjhps
         l7bjN8vfwOTawERLUb9VVG9ST2CNeJZ/t7HLmBfXmdxgVKiF2I+O6u57FzC7FVYoKzRD
         4N4g==
X-Gm-Message-State: AOAM5301nh+r+qh+yuCnq5r5Y8d5nayKonLYSKStlM/6grToCrZncmYa
        23i3xa7x/TDaBJBFqAfkjeWlX55I7uT7bBZeXupa
X-Google-Smtp-Source: ABdhPJxI7fzDt1/9x3wfDORWMw82Vc3ei6SQuYvygrFNo3PQKQvxZB2aRi2tjX+cveh7eTEl1nIacherxYZCgrJP9Aw=
X-Received: by 2002:a92:c94a:: with SMTP id i10mr130560ilq.290.1621326596637;
 Tue, 18 May 2021 01:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210517090836.533-1-xieyongji@bytedance.com> <20210517193912-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210517193912-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 18 May 2021 16:29:44 +0800
Message-ID: <CACycT3uWexPNTiroO5EBT9q8YOorvvVaY_kymapWkLZ078J7aQ@mail.gmail.com>
Subject: Re: Re: [RFC PATCH 00/17] Add validation for used length
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, amit@kernel.org,
        arei.gonglei@huawei.com, airlied@linux.ie, kraxel@redhat.com,
        dan.j.williams@intel.com,
        Johannes Berg <johannes@sipsolutions.net>,
        Ohad Ben Cohen <ohad@wizery.com>, bjorn.andersson@linaro.org,
        David Hildenbrand <david@redhat.com>, vgoyal@redhat.com,
        miklos@szeredi.hu, Stefano Garzarella <sgarzare@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 7:40 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, May 17, 2021 at 05:08:19PM +0800, Xie Yongji wrote:
> > Current virtio device drivers may trust the used length returned
> > in virtqueue_get_buf()/virtqueue_get_buf_ctx(). But the used length
> > might come from an untrusted device when VDUSE[1] is enabled. To
> > protect this case, this series tries to add validation for the
> > used length.
> >
> > Since many legacy devices will also set the used length incorrectly,
> > we did not add the validation unconditionally. Instead, we will do
> > the validation only when the device driver needs the used length.
> > A NULL len passed to virtqueue_get_buf()/virtqueue_get_buf_ctx()
> > will mean the used length is not needed by the device driver.
>
> Can we be more specific? Which drivers have problems when used len
> is incorrect? Maybe there's an easier way like validating the length
> in the driver ...
>

It's ok to me. But this means all future new drivers need to remember
to do the validation.

Now only virtio-net and virtio-console drivers have this problem. I
can send some patches to fix it.

Thanks,
Yongji
