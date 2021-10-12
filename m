Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667E4429F62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhJLIJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhJLIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:09:35 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8965C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:07:34 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id t200so9042606vkt.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b2FjW88iV7WH8M52qDc4ZYBbTRY828MiXLZ98UxnmbA=;
        b=xNjJ4i/g+iOuOz4grm6y/fgSVU+k588ykvt5Jak8x9dxQ+V2J8nSXIPAkIyI6EvXjz
         0HN1vyWq3MPhsN0EWXVXCvT754z6EqADHaNHIHzu9pnzkxRDwPEkkKiZnFi9JogTbRpG
         wkiV3QyEGmDyHKXcUPqLukTyS5YWJC0jQsGAPIQKLKvtxO9K2ddlhXX52cfrzHCE94q1
         YtfrLIRg7JJnOguBmwHl3x/nCVUursEeLWD50E9XKfKFqabvqef/XbD92jW9TGYabJSz
         Py6OmAWMYV1kqtI+JNayCTExKKOiUtkFLpXDry3x9ztQUYjV7OaE5x6244cGiEibZp8d
         rjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b2FjW88iV7WH8M52qDc4ZYBbTRY828MiXLZ98UxnmbA=;
        b=gs0nKv0rd6Jetq7lxqi8kDLTeofHH5URajVDDx5dXdw1yAZP4XBKgi0b6n8DtAG+8q
         c/PMfkIRWQzuTUmSKv2qmfnZuYQtk99r1EeR7K/cNIqz4/++4Lsw+11ieuTkSCyVTDAj
         bjMiSV/8aWTH8ZkIjA/Uwu9MgbtkPzc43xPvbszJkr61u2B1/f2U9egseVwHLbWAOwxl
         rnSupkR5WtbGkECzSEuC+CkAX/uHfGMlXy9bRStNH2x9ZX1XrBdVQknkFG+209IPyBgE
         H7qvLm2+8QtxyZS2y/i83fGTAJ+UMn92sKwrTvoU8X4QkAxgm1Zos9LN+cd1ncW/hhuU
         h8zQ==
X-Gm-Message-State: AOAM533DHwX6AEkRqj+GEBuE8POzMZ76YD4/7KYRQk36RPuxjYR/SDvg
        v5Nia1FdRKP1TRFXdsxlrRVKiAAdFeKgVgD5cbUBcLGYWaPD7w==
X-Google-Smtp-Source: ABdhPJw+N8OD0BSrstSsRCN2Qv7yKT2BHtyoxMXlqpH3guFm53TQiNEblhFAdL9xzXLyFAYjrxqOjpJ5nqlvSz32LSg=
X-Received: by 2002:a05:6122:90d:: with SMTP id j13mr13052333vka.25.1634026053766;
 Tue, 12 Oct 2021 01:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211008032231.1143467-1-fengli@smartx.com> <CAPhsuW5+bdQwsyjBP=QDGRbtnF021291D_XrhNtV+v-geVouVg@mail.gmail.com>
 <CALTww28b0HGzSTTNGVzeZdRp0nGMDAyY8sQ+cBsSCuYJ4jMaqw@mail.gmail.com>
 <CAHckoCyuqxM8po4JA4=OacVWhYuo9SWescUVOKRFGwdc=aoN8A@mail.gmail.com> <CALTww28CsJdmVOLFeoHC8FgbHDK78h8Lncsf9fFA0RYXEj=R9A@mail.gmail.com>
In-Reply-To: <CALTww28CsJdmVOLFeoHC8FgbHDK78h8Lncsf9fFA0RYXEj=R9A@mail.gmail.com>
From:   Li Feng <fengli@smartx.com>
Date:   Tue, 12 Oct 2021 16:07:22 +0800
Message-ID: <CAHckoCzzVP7npmU4LWedzD-f1QmkH4K0iLk_=8ptSFXrFfRoDw@mail.gmail.com>
Subject: Re: [PATCH RESEND] md: allow to set the fail_fast on RAID1/RAID10
To:     Xiao Ni <xni@redhat.com>
Cc:     Song Liu <song@kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" 
        <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiao Ni <xni@redhat.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8812=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Oct 11, 2021 at 5:42 PM Li Feng <fengli@smartx.com> wrote:
> >
> > Xiao Ni <xni@redhat.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8811=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:49=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi all
> > >
> > > Now the per device sysfs interface file state can change failfast. Do
> > > we need a new file for failfast?
> > >
> > > I did a test. The steps are:
> > >
> > > mdadm -CR /dev/md0 -l1 -n2 /dev/sdb /dev/sdc --assume-clean
> > > cd /sys/block/md0/md/dev-sdb
> > > echo failfast > state
> > > cat state
> > > in_sync,failfast
> >
> > This works,  will it be persisted to disk?
> >
>
> mdadm --detail /dev/md0 can show the failfast information. So it
> should be written in superblock.
> But I don't find how md does this. I'm looking at this.
>
Yes, I have tested that it has been persisted, but don't understand who doe=
s it.

> Regards
> Xiao
>
