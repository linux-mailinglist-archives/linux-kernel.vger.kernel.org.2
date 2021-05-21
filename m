Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC60138C1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhEUI2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhEUI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:28:01 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E138FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:26:38 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id w3so4073774vkb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIarhh7kQdoMISCJccKY5DYZHHV1dh+rcFxZJNgKlb4=;
        b=A9wFJYohjkcV8tugshuuRX02q6IEX2iLWvkXjHmZ+HMZYQ5ZjqsxHKSGZ0NQtW/HO0
         /aJ1C6CAxtiLU0C/FihkgYxwvey7608acACMtPrx2wuCh5EiBhdfGfMhSni50J/fl/7M
         +ukT3crol2UW/Q6v9bF4TfORWQmK0DAQ4OAbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIarhh7kQdoMISCJccKY5DYZHHV1dh+rcFxZJNgKlb4=;
        b=XcSSHnQPYBMIkodFGiTui4gm3Bon7dJaXGgQnjgGrHDpYNs28BYX/NhwKxbFOj9zX3
         9WJesh/rWTdKrStojiDxObYhYnp9tl23cuwxDZakNI8HcRwUYlvalaG4r4tMOhIj/eaQ
         yfEjBS42KijD7C8ZikwbkOOxziq/2abM16mOr77PPDS81UdLgHur1bvPXvZL3NqhnGth
         il5BIye5n80rka5/gmGRIqgxd/nbWjYeYf/Z3VvQ/Ih12b0rewJoh8aC6SgyWoIurgkB
         eNCOacoFqLrfLfUfNDcVkKxL2Z04dQf+hmE0q/GOo9MG4G3FmaAYi35aWLF68lRWk9Ao
         3ViA==
X-Gm-Message-State: AOAM533vkb7zusJmeoKaSuRoFMSrtCGqkr6ddGqxp7VLHTde0NHi50z0
        WWRveejRkYIQ1u++ORDsPL+xnpwECX8kM4qT/DTcOQ==
X-Google-Smtp-Source: ABdhPJzPh2FreEu9W/lQvvjgADbqrEMI2cf6ldvFFN45zD3cS7pi8UeqXkjozk3x2P1C388OgWGOLzE9we0HREOJwmM=
X-Received: by 2002:a1f:a802:: with SMTP id r2mr8911868vke.14.1621585598004;
 Fri, 21 May 2021 01:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154654.1791183-1-groug@kaod.org> <20210520154654.1791183-5-groug@kaod.org>
In-Reply-To: <20210520154654.1791183-5-groug@kaod.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 May 2021 10:26:27 +0200
Message-ID: <CAJfpegugQM-ChaGiLyfPkbFr9c=_BiOBQkJTeEz5yN0ujO_O4A@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] virtiofs: Skip submounts in sget_fc()
To:     Greg Kurz <groug@kaod.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 at 17:47, Greg Kurz <groug@kaod.org> wrote:
>
> All submounts share the same virtio-fs device instance as the root
> mount. If the same virtiofs filesystem is mounted again, sget_fc()
> is likely to pick up any of these submounts and reuse it instead of
> the root mount.
>
> On the server side:
>
> # mkdir ${some_dir}
> # mkdir ${some_dir}/mnt1
> # mount -t tmpfs none ${some_dir}/mnt1
> # touch ${some_dir}/mnt1/THIS_IS_MNT1
> # mkdir ${some_dir}/mnt2
> # mount -t tmpfs none ${some_dir}/mnt2
> # touch ${some_dir}/mnt2/THIS_IS_MNT2
>
> On the client side:
>
> # mkdir /mnt/virtiofs1
> # mount -t virtiofs myfs /mnt/virtiofs1
> # ls /mnt/virtiofs1
> mnt1 mnt2
> # grep virtiofs /proc/mounts
> myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
> none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
> none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
>
> And now remount it again:
>
> # mount -t virtiofs myfs /mnt/virtiofs2
> # grep virtiofs /proc/mounts
> myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
> none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
> none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
> myfs /mnt/virtiofs2 virtiofs rw,seclabel,relatime 0 0
> # ls /mnt/virtiofs2
> THIS_IS_MNT2
>
> Submount mnt2 was picked-up instead of the root mount.

Why is this a problem?

Thanks,
Miklos
