Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DCC31DADC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 14:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhBQNmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 08:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhBQNmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:42:31 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49959C061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 05:41:51 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id k1so2302242vso.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 05:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ly958inOST0pP7jzRe2oCPSSNut3M8TU4VjAxfrHOwE=;
        b=WLj3sy3V/SDwShWnwzqrbW89euQ2E5aFxLm8iO3Etru7zcEaITsaSo4I+wylLSo7mH
         dJqedk8DQWs2M8Jbq4g/8lyN6AtJn3EInw4CtdLDMi7J73eyHcUbJXN57PHKHeXwVmpR
         9f2GnoWQAnA3LHFPVgjVga5CCAZs3IW1j617E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ly958inOST0pP7jzRe2oCPSSNut3M8TU4VjAxfrHOwE=;
        b=hrAb6EAFKvgda4k40j+joevSGh+kiAYzVFHAQNZpkUZe1KPh/GdI8um6RT99Vw5ElT
         v2cRuGa92CWA2iMhw/DAhPr69U/fnm+Lo7Kkd9kZ/XOBQ0OtTkSYofcSPgkoAwrSkIYF
         58TT7gPXGX+w2GN31599lBQILYQfQNMEEfBXRrWUi51uWsi3nrZGU+xd4xzwfFgacE13
         08BYcoxNXtIszkuWR81feL4B7n+GqjZkJWaaOzC60onDyM/0m1Esnq/sOPxPrJDQC4FG
         aA2HOWpx081z8dvRaOtmAx+CGsqgnS3GD8JgiBAMadCx4zNAPkKsfK9+gs2t6U18bypK
         6Hiw==
X-Gm-Message-State: AOAM533Z+GlppmCG/Q47e37AVeA9UPU82f3m0onyyBJJNUZ0MWfTrtqC
        C84rxjFtAfBQQRTYIuGxOXynmRBpTK0VtuEw5ysBUA==
X-Google-Smtp-Source: ABdhPJynDEfaANbx2gks6pSbaCic+0inbbd2EiWPq5us1ivnsmy4vjysulZpX7fZyN7xDt8nirUazPK5ySAcJwtTjyE=
X-Received: by 2002:a67:a404:: with SMTP id n4mr1223397vse.0.1613569310259;
 Wed, 17 Feb 2021 05:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
In-Reply-To: <20210125153057.3623715-4-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Feb 2021 14:41:39 +0100
Message-ID: <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Alessio Balsini <balsini@android.com>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 4:31 PM Alessio Balsini <balsini@android.com> wrote:
>
> Expose the FUSE_PASSTHROUGH interface to user space and declare all the
> basic data structures and functions as the skeleton on top of which the
> FUSE passthrough functionality will be built.
>
> As part of this, introduce the new FUSE passthrough ioctl, which allows
> the FUSE daemon to specify a direct connection between a FUSE file and a
> lower file system file. Such ioctl requires user space to pass the file
> descriptor of one of its opened files through the fuse_passthrough_out
> data structure introduced in this patch. This structure includes extra
> fields for possible future extensions.
> Also, add the passthrough functions for the set-up and tear-down of the
> data structures and locks that will be used both when fuse_conns and
> fuse_files are created/deleted.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>

[...]

> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 54442612c48b..9d7685ce0acd 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -360,6 +360,7 @@ struct fuse_file_lock {
>  #define FUSE_MAP_ALIGNMENT     (1 << 26)
>  #define FUSE_SUBMOUNTS         (1 << 27)
>  #define FUSE_HANDLE_KILLPRIV_V2        (1 << 28)
> +#define FUSE_PASSTHROUGH       (1 << 29)

This header has a version and a changelog.  Please update those as well.

>
>  /**
>   * CUSE INIT request/reply flags
> @@ -625,7 +626,7 @@ struct fuse_create_in {
>  struct fuse_open_out {
>         uint64_t        fh;
>         uint32_t        open_flags;
> -       uint32_t        padding;
> +       uint32_t        passthrough_fh;

I think it would be cleaner to add a FOPEN_PASSTHROUGH flag to
explicitly request passthrough instead of just passing a non-null
value to passthrough_fh.

>  };
>
>  struct fuse_release_in {
> @@ -828,6 +829,13 @@ struct fuse_in_header {
>         uint32_t        padding;
>  };
>
> +struct fuse_passthrough_out {
> +       uint32_t        fd;
> +       /* For future implementation */
> +       uint32_t        len;
> +       void            *vec;
> +};

I don't see why we'd need these extensions.    The ioctl just needs to
establish an ID to open file mapping that can be referenced on the
regular protocol, i.e. it just needs to be passed an open file
descriptor and return an unique ID.

Mapping the fuse file's data to the underlying file's data is a
different matter.  That can be an identity mapping established at open
time (this is what this series does) or it can be an arbitrary extent
mapping to one or more underlying open files, established at open time
or on demand.  All of these can be done in band using the fuse
protocol, no need to involve the ioctl mechanism.

So I think we can just get rid of "struct fuse_passthrough_out"
completely and use "uint32_t *" as the ioctl argument.

What I think would be useful is to have an explicit
FUSE_DEV_IOC_PASSTHROUGH_CLOSE ioctl, that would need to be called
once the fuse server no longer needs this ID.   If this turns out to
be a performance problem, we could still add the auto-close behavior
with an explicit FOPEN_PASSTHROUGH_AUTOCLOSE flag later.

Thanks,
Miklos
