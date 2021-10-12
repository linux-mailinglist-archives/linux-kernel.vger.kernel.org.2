Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055DE42A02E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhJLIqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbhJLIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:45:59 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBAEC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:43:57 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id t200so9076189vkt.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZgZqaOGPm3fGQ9iYZFcmBjXmsmUelLzgvid1aIpfJQ4=;
        b=PWsCk7uXhaqI3sO4lfo2smARJmvXEd45tQOp3dfvQ/CZUwRO4m7RxijZ2V5Xvr81/w
         IyF+bTDVvDYXvEAAw49QpsWU1LGhmTgaKZXiMoFbTeossBkzm+cjCD53tzUMp6v6wUQX
         wpL93gPZ3Z+Av+fjPGzHXfCIK6lDNEkTZxbGpO2aviLF0vADG2OzmD+e90yjvoosnSKT
         hPMxtqc7FVCu8TH3yDusrKCfJuf+Bd8strSePQFIzGQdgrCuel469nqFAPMVI5XH8fwP
         z8XM7emx/adjqNjIMzk8R7DwcruOpDJvKqRUGZLmSYsGxXskH9nrJu47sX1BZtCALpfz
         5+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZgZqaOGPm3fGQ9iYZFcmBjXmsmUelLzgvid1aIpfJQ4=;
        b=IcuvCj9fQFpYPSblpE2Zyk2alFRrnutsP2N6/+GZL/+GHkX6bSbmJnzKF2o3nJmm0X
         LSmXOZe2XGg2l7KcJKQYZ/t8EiwDUuII4Dge0A50ihTYFqaEikHRizmVqAsSWul+Fugo
         Dak+D6NGgZ7aw5RObswA0M96ubXnEIYJyB1up8e792/HcdEPSQTHFYl6nTxFc4d1hXTg
         iBaGZ5WpQBfXhy1zVFDu90AsIZ231Ys3zI+Si9CayfU2m42ynYqvF6j5HwdvSdUPsC/R
         koKJkQxopu6zMjE2FVOspcC98yfNLzBCZAAwn4FTt+8Dqmz5Tf4MrjHIHKytBY1js+Iy
         kwvg==
X-Gm-Message-State: AOAM5301bQaklPInfkbUrC0qqnOt/kV3VvUg+gmLL40JHwViLrlSH+9j
        CBLOpKwfKCBC6Z28gjsCZ8EFVHp3BNMbSDpIdIZh6+hun3t+Qw==
X-Google-Smtp-Source: ABdhPJz2MWRH30ay4UqAGCweGR1qXBnPa6UC1+/lNVGWcyJvFutNRSSQL58AVsrEME2lXekP2PZFuCbqgB6cZOV3xh0=
X-Received: by 2002:a1f:1ed1:: with SMTP id e200mr25078417vke.7.1634028236636;
 Tue, 12 Oct 2021 01:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211008032231.1143467-1-fengli@smartx.com> <CAPhsuW5+bdQwsyjBP=QDGRbtnF021291D_XrhNtV+v-geVouVg@mail.gmail.com>
 <CALTww28b0HGzSTTNGVzeZdRp0nGMDAyY8sQ+cBsSCuYJ4jMaqw@mail.gmail.com>
 <CAHckoCyuqxM8po4JA4=OacVWhYuo9SWescUVOKRFGwdc=aoN8A@mail.gmail.com>
 <CALTww28CsJdmVOLFeoHC8FgbHDK78h8Lncsf9fFA0RYXEj=R9A@mail.gmail.com>
 <CAHckoCzzVP7npmU4LWedzD-f1QmkH4K0iLk_=8ptSFXrFfRoDw@mail.gmail.com> <CAPhsuW4VFTpM94by-iMkTQ=b9Y7FqZ2oqHH+jV-f8BM=YKWyiA@mail.gmail.com>
In-Reply-To: <CAPhsuW4VFTpM94by-iMkTQ=b9Y7FqZ2oqHH+jV-f8BM=YKWyiA@mail.gmail.com>
From:   Li Feng <fengli@smartx.com>
Date:   Tue, 12 Oct 2021 16:43:45 +0800
Message-ID: <CAHckoCxRj1qb=yfeQ2o_8n_BSSLD9JXqm8GopUp2qx9NEPxr7w@mail.gmail.com>
Subject: Re: [PATCH RESEND] md: allow to set the fail_fast on RAID1/RAID10
To:     Song Liu <song@kernel.org>
Cc:     Xiao Ni <xni@redhat.com>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" 
        <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Liu <song@kernel.org> =E4=BA=8E2021=E5=B9=B410=E6=9C=8812=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 12, 2021 at 1:07 AM Li Feng <fengli@smartx.com> wrote:
> >
> > Xiao Ni <xni@redhat.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:58=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Oct 11, 2021 at 5:42 PM Li Feng <fengli@smartx.com> wrote:
> > > >
> > > > Xiao Ni <xni@redhat.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:49=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > Hi all
> > > > >
> > > > > Now the per device sysfs interface file state can change failfast=
. Do
> > > > > we need a new file for failfast?
> > > > >
> > > > > I did a test. The steps are:
> > > > >
> > > > > mdadm -CR /dev/md0 -l1 -n2 /dev/sdb /dev/sdc --assume-clean
> > > > > cd /sys/block/md0/md/dev-sdb
> > > > > echo failfast > state
> > > > > cat state
> > > > > in_sync,failfast
> > > >
> > > > This works,  will it be persisted to disk?
> > > >
> > >
> > > mdadm --detail /dev/md0 can show the failfast information. So it
> > > should be written in superblock.
> > > But I don't find how md does this. I'm looking at this.
> > >
> > Yes, I have tested that it has been persisted, but don't understand who=
 does it.
>
> I think this is not guaranteed to be persistent:
>
> [root@eth50-1 ~]# cat /sys/block/md127/md/rd1/state
> in_sync,failfast
> [root@eth50-1 ~]# echo -failfast >  /sys/block/md127/md/rd1/state
> [root@eth50-1 ~]# cat /sys/block/md127/md/rd1/state
> in_sync
> [root@eth50-1 ~]# mdadm --stop /dev/md*
> mdadm: /dev/md does not appear to be an md device
> mdadm: stopped /dev/md127
> [root@eth50-1 ~]# mdadm -As
> mdadm: /dev/md/0_0 has been started with 4 drives.
> [root@eth50-1 ~]# cat /sys/block/md127/md/rd1/state
> in_sync,failfast
>
> How about we fix state_store to make sure it is always persistent?
>
I agree with you.

> Thanks,
> Song
