Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9BC339027
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhCLOhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCLOhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:37:42 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E9DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:37:42 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id n16so46145572lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GNaWAC3DABEUbVGxWGplqiDw9dv4NcAFZkElxGgXLyY=;
        b=Doao8t2c/aKsTmuZTBLh5f5ZSWI1SZppbw7XI1vdCzqbnmJasNh77UUWwwdSd5C585
         VtfaV5oqpBcKAav/s3mHQ5mxVYc8TZ7zU+rxAQqVbRgeKDUnGi0UhQk/yLFlzAPf0/nz
         SGi81siMWgVQ0Ys9SE0dOvP18HhjnL5DEfuYV8A7+fCnqnGTwSqRh5UlD9lAHN0mQY2U
         syD7Ngg5onbk7VtLALYTcR1/N3Zw8a9iU/iCwiTTBw4IUplY0tJJdathTbhD57W53q98
         NTCe0Z1bLpI5vaPSUTF+IcjMQE48/7Y5nfoYdhrE8VJ2rwBeH3ZjSdX5W8/bCpM2zq/s
         2RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GNaWAC3DABEUbVGxWGplqiDw9dv4NcAFZkElxGgXLyY=;
        b=BzUvdP+hRTetp9jYeZOAkqMEFDnNsywu6ZAti5BfrTesBQEc3Ptquh6qkH6WfU96/l
         sCjPSiLoBFRJNayPG8PSZGKXNIiGDIr0/mILmBmwTiLVhCzCv3zvepySJcrvyWp8H/p3
         L04SHKFXwUBDA7ZEkGpydgLM6W44ozsoUWPYAOhNE3s3eVVrj6fCeisXPoK2DQOTvDKM
         w3YJWAQ/2hkVIpfa6mifQ5ALzFbbfd4V0OvjgXZrAET9lAEX8VwhRqcqU5GeGTlrke73
         ZJ5PZbILO4yBkHYg20WEhLRwHfj+kUaVxpJ3Zd4zFaRSolz1kUJ9heJxF+pE3I/2Yj2w
         uvmw==
X-Gm-Message-State: AOAM530ObFVJUrZ3CBhwSBVKx8CWIekTyFZqtkrpcpf5WbvIv1+MVsLU
        9Y9aZYo/QtxxQY3/VXACSRJotiTK19IzKbdPL1U=
X-Google-Smtp-Source: ABdhPJwwl7ZeHIO1/PaLqP5HtlHq/CufvSpEF/oWMuumWKtGzcrJj/qXjjjP/1uJ814d33mZnLHXGUtO+3M7zsogiuI=
X-Received: by 2002:a19:ec1a:: with SMTP id b26mr5257227lfa.610.1615559860904;
 Fri, 12 Mar 2021 06:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20210312122531.2717093-1-daeho43@gmail.com> <YEtg8U7whCVV2tQt@kroah.com>
 <CACOAw_zhZ0OgT-KCBmD_H6_U=CZCNY44D-ojH2AZah2cbAvdAQ@mail.gmail.com> <YEt00vJ6oVfoRjSJ@kroah.com>
In-Reply-To: <YEt00vJ6oVfoRjSJ@kroah.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 12 Mar 2021 23:37:29 +0900
Message-ID: <CACOAw_yjyy+58B=RawAaQO98NQB43roZOv4sq5313sFHN1myXQ@mail.gmail.com>
Subject: Re: [PATCH v4] f2fs: add sysfs nodes to get runtime compression stat
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you can see, if we're doing like the below.

sbi->compr_written_block +=3D blocks;

Let's assume the initial value as 0.

<thread A>                                             <thread B>
sbi->compr_written_block =3D 0;

sbi->compr_written_block =3D 0;
+blocks(3);
                                                               + blocks(2);
sbi->compr_written_block =3D 3;

sbi->compr_written_block =3D 2;

Finally, we end up with 2, not 5.

As more threads are participating it, we might miss more counting.

2021=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11:04, =
Greg KH <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Mar 12, 2021 at 10:56:13PM +0900, Daeho Jeong wrote:
> > Thanks for suggesting me sysfs_emit().
> >
> > For atomic values, actually, those are needed for writer part, not read=
er.
> >
> > +#define add_compr_block_stat(inode, blocks)                           =
 \
> > +       do {                                                           =
 \
> > +               struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);         =
   \
> > +               int diff =3D F2FS_I(inode)->i_cluster_size - blocks;   =
   \
> > +               atomic64_add(blocks, &sbi->compr_written_block);       =
 \
> > +               atomic64_add(diff, &sbi->compr_saved_block);           =
 \
> > +       } while (0)
> >
> > I needed a protection here, because they might be updated in the race c=
ondition.
>
> Why?  What are you trying to protect from "racing" here?
>
> thanks,
>
> greg k-h
