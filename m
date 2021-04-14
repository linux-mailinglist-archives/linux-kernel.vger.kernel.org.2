Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231A035F30A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348987AbhDNL5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhDNL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:57:35 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E888C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:57:12 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id l8so10192792vsj.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzbLJJzdVatWgDfJz2ZZ1Lv5UzxGtXQuOI1FrNqTbkE=;
        b=VQ4gp9rlip34pGr7jx9IKm0jVOGMV7Ht8tFoasoB90S6Pub2HPVW88RmORxiXeJjFM
         S/rWcMWz3pUoLB6h+5VLnps7dA94+o03/0V25Jy/QX5i5YAfzXQEEoLyCr+nj03HDoFL
         yiUZfx8PatrfT6Xt9BQx6h/2/nIXy1nNZ4BbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzbLJJzdVatWgDfJz2ZZ1Lv5UzxGtXQuOI1FrNqTbkE=;
        b=N8me9KC4Q3gRmlToq0FiEAB4wVp8gC4zBOTHjFNeDLZDNLy3CD/S1GBegT2upQh8Mw
         h94nSRh43cEZvFkytNCHrq5cLipnvqRcy/D/XV1MDuPsFlZKKkebTdmla0PCSMXws97B
         kAITmLeE/uPdRWk83/hnUllKtc0LiSYAW4n/nu3IED+Rv7WHQ57/W2/TqisyoVdKALN2
         /pciVbc3vAVgwV9TTQ0UYTY5xZUXwXQNF1qQRhqvgvMM0CSD8gErHc/SZCmx3rttj1MU
         IiOzH5E4fMjKKjLWAjPhMFfZ/tH1JVc3ST9vqm2HIAq0lqglqR79BUdLd/88zk3Bpv89
         nWYA==
X-Gm-Message-State: AOAM532tQSrgwbGmoHdFppD0C43p9PxxR08Y6sT3FGNTnuz9YsjGVFeu
        iaMJf6AWDfa703aUb4piYEklqhclLw9tgfUImxXGRw==
X-Google-Smtp-Source: ABdhPJydu9VDVLIxO1JsC2e18nwwFO5YtRyww3UMaWYWTS+xXWf4ATouL7wCLTlL/8nyvW7zHu+kF2ww7AeQDXWMvL0=
X-Received: by 2002:a67:6a85:: with SMTP id f127mr27341297vsc.9.1618401431913;
 Wed, 14 Apr 2021 04:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210325151823.572089-1-vgoyal@redhat.com>
In-Reply-To: <20210325151823.572089-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 14 Apr 2021 13:57:01 +0200
Message-ID: <CAJfpegvU9zjT7qV=Rj4ok4kfYz-9BPhjp+xKz9odfSWaFxshyA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: Fix clearing SGID when access ACL is set
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Luis Henriques <lhenriques@suse.de>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 4:19 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
>
> Hi,
>
> This is V2 of the patchset. Posted V1 here.
>
> https://lore.kernel.org/linux-fsdevel/20210319195547.427371-1-vgoyal@redhat.com/
>
> Changes since V1:
>
> - Dropped the helper to determine if SGID should be cleared and open
>   coded it instead. I will follow up on helper separately in a different
>   patch series. There are few places already which open code this, so
>   for now fuse can do the same. Atleast I can make progress on this
>   and virtiofs can enable ACL support.
>
> Luis reported that xfstests generic/375 fails with virtiofs. Little
> debugging showed that when posix access acl is set that in some
> cases SGID needs to be cleared and that does not happen with virtiofs.
>
> Setting posix access acl can lead to mode change and it can also lead
> to clear of SGID. fuse relies on file server taking care of all
> the mode changes. But file server does not have enough information to
> determine whether SGID should be cleared or not.
>
> Hence this patch series add support to send a flag in SETXATTR message
> to tell server to clear SGID.

Changed it to have a single extended structure for the request, which
is how this has always been handled in the fuse API.

The ABI is unchanged, but you'll need to update the userspace part
according to the API change.  Otherwise looks good.

Applied and pushed to fuse.git#for-next.

Thanks,
Miklos
