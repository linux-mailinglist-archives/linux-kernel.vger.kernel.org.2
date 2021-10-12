Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85630429E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhJLHAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233378AbhJLHAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634021923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8RijpfQi+prw8bXnwoWv3a6J45QoIwKMNHS02qVkCw=;
        b=KgNE9GMJYRJmjekzIrzTg1CbXspW3stzRTjevR4bAQ/AA6cIYraeQAniftHpD2Q2RzenTA
        0jx57b/mlvvNxwRqDP8GtYFQQ35lc4w282J3DNHj2x3MrJXplvlxuMN39kLTbMA6oMxyHM
        ZLfkzs0EESqRJVjHSbdP/kI9uq2/1ag=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-TrcHSLI2NWqrhI9MUaCFaA-1; Tue, 12 Oct 2021 02:58:42 -0400
X-MC-Unique: TrcHSLI2NWqrhI9MUaCFaA-1
Received: by mail-ed1-f70.google.com with SMTP id p20-20020a50cd94000000b003db23619472so18051668edi.19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 23:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q8RijpfQi+prw8bXnwoWv3a6J45QoIwKMNHS02qVkCw=;
        b=meSZGmTfrUPhStiKBffP2wgbVdZCuZoo7dsFoYm9R0JGtV7P6hkm5ekx8KH8VVm74s
         sOVboW2R+HObDw4E+HDF0Ex1d3miT0RfJeucKJOvEE0oKJSLsOOyJkYXusARKFfzRv5p
         mCVjIHhxQ1DXFTUYSckLXWq/M8x+2tcplxxFYPAatvLmlRHXeHlPq+D6Px2E55YnYCF4
         lY5Xp5ZuIJaDLxGsbqHmOItHU2QcH0YZucvL2CeEfnh/PQMuMkmwTXpxJzcNRSqYQ9Xm
         wYFDK9VXDVcwEncyX9qhrA4VETaXpodIhCom7+qVMTi+iqk3comE7WgxQraX7siNF61L
         8Alg==
X-Gm-Message-State: AOAM531XvGxsehJ0NqAO/NNeA9DIPunralhnRlKFJziav1hEA79Lm9rn
        JRS74qf631WaFkqXe+HJ0F6DpwYXzpGcAsgpbfzyr5FDDOgW3Bwl/EOYafV8kvktVT0LYwT0vDM
        8zW0Hh7PPvPK0TCT8OpMn+NjFZi6IFb27MRrrefcv
X-Received: by 2002:a17:906:6d0a:: with SMTP id m10mr29787749ejr.90.1634021921119;
        Mon, 11 Oct 2021 23:58:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRHeJ989p7dVG/ei6yafdn1mzzyjVVyI8bkiTnv+xsecY3u5UUD0ZFpoZSsrAAywRK1lgyPepPpZKinKOGrh4=
X-Received: by 2002:a17:906:6d0a:: with SMTP id m10mr29787733ejr.90.1634021920886;
 Mon, 11 Oct 2021 23:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211008032231.1143467-1-fengli@smartx.com> <CAPhsuW5+bdQwsyjBP=QDGRbtnF021291D_XrhNtV+v-geVouVg@mail.gmail.com>
 <CALTww28b0HGzSTTNGVzeZdRp0nGMDAyY8sQ+cBsSCuYJ4jMaqw@mail.gmail.com> <CAHckoCyuqxM8po4JA4=OacVWhYuo9SWescUVOKRFGwdc=aoN8A@mail.gmail.com>
In-Reply-To: <CAHckoCyuqxM8po4JA4=OacVWhYuo9SWescUVOKRFGwdc=aoN8A@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 12 Oct 2021 14:58:30 +0800
Message-ID: <CALTww28CsJdmVOLFeoHC8FgbHDK78h8Lncsf9fFA0RYXEj=R9A@mail.gmail.com>
Subject: Re: [PATCH RESEND] md: allow to set the fail_fast on RAID1/RAID10
To:     Li Feng <fengli@smartx.com>
Cc:     Song Liu <song@kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" 
        <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 5:42 PM Li Feng <fengli@smartx.com> wrote:
>
> Xiao Ni <xni@redhat.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8811=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:49=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi all
> >
> > Now the per device sysfs interface file state can change failfast. Do
> > we need a new file for failfast?
> >
> > I did a test. The steps are:
> >
> > mdadm -CR /dev/md0 -l1 -n2 /dev/sdb /dev/sdc --assume-clean
> > cd /sys/block/md0/md/dev-sdb
> > echo failfast > state
> > cat state
> > in_sync,failfast
>
> This works,  will it be persisted to disk?
>

mdadm --detail /dev/md0 can show the failfast information. So it
should be written in superblock.
But I don't find how md does this. I'm looking at this.

Regards
Xiao

