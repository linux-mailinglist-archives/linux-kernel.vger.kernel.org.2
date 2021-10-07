Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE29424D9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbhJGHCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbhJGHCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:02:18 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5D4C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 00:00:24 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id w13so5712209vsa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 00:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KPvY9m8xF7OhMRrQhNbNUN45tpWYIkMldtqvzSBBP4Q=;
        b=REIqf8NfQ1eKMpt6Uf2AM4qcDo68FgmR/POVotERZS0U2XCypUiwT89kbwcYYaTCEj
         emvfkcnX+sY2WvZr+Ivm4po4OoFW2wid/mIBR7Rr2QunsXOHEe71Mi/nuaoJEWm+AG19
         1tdijotabn3rz7HSb0wHuRNO343Y+4tUxpp9iA+vR44XiUNA5ShrcoRkMtBWbg1s6elE
         YWwU0dvN+k+bjrY9oBAfp/M4/cWWbbMl4Bp0Vd/Dxosle3S5gi+Kyt/AepIkcL2bXA8Y
         sOpPJPEb90+yI1IJKcT8z/c47tud19Bwvt/zw+75sREDHFlkLDnaP4bNHtUrR5XC6X+T
         PNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=KPvY9m8xF7OhMRrQhNbNUN45tpWYIkMldtqvzSBBP4Q=;
        b=N4Cw0jIbZCSDdJwir40dTb3ZeAnGNp/vYSb3MU49XuhmXTJvPRAc+isJMlKCtiZRzi
         11EZn7u0xgPWzs3TKexRCJAy37JVWBbxXfIpkpiO9YfqxIqe5kXMcp+mqrMe0TkkoorA
         x3CQj+Be000Y+iJ5fvaY3rwiA2T3PR5rMfCLJei6++VLRaWELRiyveTXZ7LcVJLGl4y8
         BvgrDWk/Ymn6WSqQ58S0VZAyVFLZKseoLse9gY87IhpH/FjXKuKH2hjqApBCZOFgmDQu
         IYqve0hjFzbA/kNJ2q3/vuWTEOa/FIaJHOVVmoVWFiFbxerzRQTBCaCUa9wgp2mPfgSM
         qlBA==
X-Gm-Message-State: AOAM533Ayi3qS+5fcHcq3WjsTZxQrNaPpm6HTx5eVpBrRf23NehBivc5
        kuSupz7UzKKoA1zS2ZyMhcf/wCEbxGI2e7cousEykyX7KGbKUg==
X-Google-Smtp-Source: ABdhPJxhTIeTM2YsBQjs/Hxb8tjpMKMRA+oM7JCom2mWp29uuhG00YcV/ZEg5rWysJ0bwM2edQ4GNk9QbT2krnMKZFI=
X-Received: by 2002:a67:d28f:: with SMTP id z15mr2434728vsi.44.1633590024062;
 Thu, 07 Oct 2021 00:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210913032003.2836583-1-fengli@smartx.com> <CAHckoCyDULok_QLLh5Nmbx4qLCxKL43TgtFgCSAwuaPpRy1BFw@mail.gmail.com>
 <CAHckoCwOgpH8E9UgkRkyZitPb6X5Jp-PVKoN6QFHJMt_4h+V6g@mail.gmail.com>
In-Reply-To: <CAHckoCwOgpH8E9UgkRkyZitPb6X5Jp-PVKoN6QFHJMt_4h+V6g@mail.gmail.com>
From:   Li Feng <fengli@smartx.com>
Date:   Thu, 7 Oct 2021 15:00:11 +0800
Message-ID: <CAHckoCwk1i7_vV=oweLTNYkCjMi4ReyXed2NOvZ10z2J32xGBg@mail.gmail.com>
Subject: Re: [PATCH] md: allow to set the fail_fast on RAID1/RAID10
To:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue ping...

Thanks,
Feng Li

Li Feng <fengli@smartx.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8827=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:24=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Song,
>
> What about this feature?
>
> Thanks,
> Feng Li
>
> Li Feng <fengli@smartx.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:08=E5=86=99=E9=81=93=EF=BC=9A
> >
> > ping ...
> >
> > Thanks,
> > Feng Li
> >
> > Li Feng <fengli@smartx.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:22=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > When the running RAID1/RAID10 need to be set with the fail_fast flag,
> > > we have to remove each device from RAID and re-add it again with the
> > > --fail_fast flag.
> > >
> > > Export the fail_fast flag to the userspace to support the read and
> > > write.
> > >
> > > Signed-off-by: Li Feng <fengli@smartx.com>
> > > ---
> > >  drivers/md/md.c | 30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >
> > > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > > index ae8fe54ea358..ce63972a4555 100644
> > > --- a/drivers/md/md.c
> > > +++ b/drivers/md/md.c
> > > @@ -3583,6 +3583,35 @@ ppl_size_store(struct md_rdev *rdev, const cha=
r *buf, size_t len)
> > >  static struct rdev_sysfs_entry rdev_ppl_size =3D
> > >  __ATTR(ppl_size, S_IRUGO|S_IWUSR, ppl_size_show, ppl_size_store);
> > >
> > > +static ssize_t
> > > +fail_fast_show(struct md_rdev *rdev, char *page)
> > > +{
> > > +       return sprintf(page, "%d\n", test_bit(FailFast, &rdev->flags)=
);
> > > +}
> > > +
> > > +static ssize_t
> > > +fail_fast_store(struct md_rdev *rdev, const char *buf, size_t len)
> > > +{
> > > +       int ret;
> > > +       bool bit;
> > > +
> > > +       ret =3D kstrtobool(buf, &bit);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       if (test_bit(FailFast, &rdev->flags) && !bit) {
> > > +               clear_bit(FailFast, &rdev->flags);
> > > +               md_update_sb(rdev->mddev, 1);
> > > +       } else if (!test_bit(FailFast, &rdev->flags) && bit) {
> > > +               set_bit(FailFast, &rdev->flags);
> > > +               md_update_sb(rdev->mddev, 1);
> > > +       }
> > > +       return len;
> > > +}
> > > +
> > > +static struct rdev_sysfs_entry rdev_fail_fast =3D
> > > +__ATTR(fail_fast, 0644, fail_fast_show, fail_fast_store);
> > > +
> > >  static struct attribute *rdev_default_attrs[] =3D {
> > >         &rdev_state.attr,
> > >         &rdev_errors.attr,
> > > @@ -3595,6 +3624,7 @@ static struct attribute *rdev_default_attrs[] =
=3D {
> > >         &rdev_unack_bad_blocks.attr,
> > >         &rdev_ppl_sector.attr,
> > >         &rdev_ppl_size.attr,
> > > +       &rdev_fail_fast.attr,
> > >         NULL,
> > >  };
> > >  static ssize_t
> > > --
> > > 2.31.1
> > >
