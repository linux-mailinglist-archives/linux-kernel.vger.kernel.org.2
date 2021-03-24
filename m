Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FAE347CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhCXPbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbhCXPbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:31:03 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D16C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:31:01 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id e13so11543279vsl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cc2uWcmOYHsuFaDaziuqmdBB7HXaAseMJtvKA68Mmns=;
        b=fgVNZ/IDRPoyZoHD31LkoInkXHTy1IwCgAtx21pvGa67w88TdtZKHj3DPqEmSFUBE7
         jxwQOpaCEFAmP+Z0CfkPSiblkqKw52T+DfiHYhYkoT1DBx1ZtPgKrozdMzxIURueDQWO
         i0zTqQ5yGF608We/Ym1CTK4nXTi0CJr2AXaSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cc2uWcmOYHsuFaDaziuqmdBB7HXaAseMJtvKA68Mmns=;
        b=GUfO0CRcCeiBWBVegyb/zEkjQXFvE2niLxEulxRZUp5YMgPBiPGjYxNzaWyHIop78u
         KJX8vrBf9KKqKgffurA9aCAvXsLOuBca9demhXiEjleSohkG/h9u8DpupFLOi6XpTnkT
         zmsV1hRKxsqbSGVGao9bkiHv8zcpCIfjGHDoiKIpDt0IVt8NDdh3e3DlYr3vDjYFQTpp
         3+Krcj/GxzUgzFDV5R38qi3lBvEBNtU/4VhnvnwzTknXQDtwDhYQmjsIFvvBiEvEQELW
         0g8YEkiqTYudP4fKSjdtNnUKQvt3al8lQDtbN6I0c6EjyHFIL8RptV5VpAJOQaSKmOdw
         OC+Q==
X-Gm-Message-State: AOAM532lFgplHwzOp39gs2rn7rh/o1SLj8PLiQlza2+DaAPeHx4Q2H7a
        iUzKM218igGPE5w9Wxjleve3B5nwU5TseRNs0sfAyg==
X-Google-Smtp-Source: ABdhPJwm579irBFtm4RC1b0MKE8RnV15CUYnl01EApVoeqFUk6shtoofjqWy/7jG4DVpJLbWCmm/Y2I+XyzB+kSlBj4=
X-Received: by 2002:a67:6786:: with SMTP id b128mr2413476vsc.9.1616599860174;
 Wed, 24 Mar 2021 08:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210318135223.1342795-1-ckuehl@redhat.com> <20210318135223.1342795-3-ckuehl@redhat.com>
 <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com> <04e46a8c-df26-3b58-71f8-c0b94c546d70@redhat.com>
In-Reply-To: <04e46a8c-df26-3b58-71f8-c0b94c546d70@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Mar 2021 16:30:49 +0100
Message-ID: <CAJfpeguzdPV13LhXFL0U_bfKcpOHQCvg2wfxF6ryksp==tjVWA@mail.gmail.com>
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     virtio-fs-list <virtio-fs@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 4:09 PM Connor Kuehl <ckuehl@redhat.com> wrote:
>
> On 3/18/21 10:17 AM, Miklos Szeredi wrote:
> > I removed the conditional compilation and renamed the limit.  Also made
> > virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.
>
> Hi Miklos,
>
> Has this patch been queued?

It's in my internal patch queue at the moment.   Will push to
fuse.git#for-next in a couple of days.

Thanks,
Miklos
