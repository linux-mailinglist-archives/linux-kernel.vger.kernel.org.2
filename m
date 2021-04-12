Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EDC35C293
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbhDLJpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbhDLJ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:28:04 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D139BC06138D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:27:46 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id g20so6305359vst.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hKUVtRAYKksa4g4Z/SOXZ+I+SLzgB72dysIQbYZhlk=;
        b=CitFYvjqQpJous7ooVmqfhnFsbgLlnpEDxsDp/0RahdDGBuwdMycdneGcKTEi88ZzZ
         icSfVdFS15Oe9zZx8G7npVnJ3yX5/NnRtCizxLwUgVHWsSjMKS/xvGkHJqooZ72EEjTl
         XCQwB/3XWLH1ObPZxWsIpNdO64fsA4CPgZjc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hKUVtRAYKksa4g4Z/SOXZ+I+SLzgB72dysIQbYZhlk=;
        b=KL9lTeoquTLcKts1E/zRTuxkupQyXkNyXM1qrKtby2O30Z/nVeqcAHExOlRTr22RdB
         r2ECTJ0jInA/3qsyaUnITx/qDwoFiWJYPrkf9qcHvaxNrHrSOjIqtizYopLQHut6+77J
         SygRtvBE3W0HXtA2/JGlrQfFq1DQ2QCt0+INAwdTRAdoOmItnTmOOK1/8VmNb27RPpt2
         SZy4If2oOqa7S7A37o9l87Hf77mqvSRCYFOI/VVaH6F5Rh1Yd1hXUcAQmKmco4Clyqp2
         O43WTQvht11IQc2qFv/Y60gYxIFj95IdBBBynj5BcGxZ7fLApd0VyUtZBsVNMOYJ4JtA
         CWiQ==
X-Gm-Message-State: AOAM5310PboV1Gt4BvxwyNVvDnT5Rg5k5IsNqjDU9yRa8lI/UpyzFYqY
        D6N+/Qog2nspp4g2pCaIgMMaOM2qNo5M0YCq74rZaBARQqc9mcO/
X-Google-Smtp-Source: ABdhPJygb7TprYuqHMJbs7kZzi/RZ6+3XCz0tKtXIbFxyF52PMynCUJXHei8d09eoHLmkJRmeM3KYqSm+zCP8mXN81k=
X-Received: by 2002:a67:f487:: with SMTP id o7mr19224439vsn.7.1618219664676;
 Mon, 12 Apr 2021 02:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210323160629.228597-1-mszeredi@redhat.com>
In-Reply-To: <20210323160629.228597-1-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 12 Apr 2021 11:27:33 +0200
Message-ID: <CAJfpegv4ttfCZY0DPm+SSc85eL5m3jqhdOS_avu1+WMZhdg7iA@mail.gmail.com>
Subject: Re: [PATCH] vfs: allow stacked ->get_acl() in RCU lookup
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        garyhuang <zjh.20052005@163.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 5:07 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Overlayfs does not cache ACL's to avoid double caching with all its
> problems.  Instead it just calls the underlying filesystem's
> i_op->get_acl(), which will return the cached value, if possible.
>
> In rcu path walk, however, get_cached_acl_rcu() is employed to get the
> value from the cache, which will fail on overlayfs resulting in dropping
> out of rcu walk mode.  This can result in a big performance hit in certain
> situations.
>
> Add a flags argument to the ->get_acl() callback, and allow
> get_cached_acl_rcu() to call the ->get_acl() method with LOOKUP_RCU.
>
> Don't do this for the generic case of a cache miss, only in case of
> ACL_DONT_CACHE.
>
> Reported-by: garyhuang <zjh.20052005@163.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Hi Al,

Could you please apply this patch?

It's fairly trivial, but unfortunately adds a fair bit of API churn.

Thanks,
Miklos
