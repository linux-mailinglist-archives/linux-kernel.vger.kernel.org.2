Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4D42A056
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhJLIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235543AbhJLIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634028556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZfuMOca3BMyKn1rZ5ck9ra0yqT4Ylul21gEYxqcVNk=;
        b=ZjeG5hBsExaVH97d3qIbj4cYZEHnjsuYWlVmzjSIwSr9VUYHSN1VZ9mB8SCmUpYEOCHA3l
        mhFNxHanqwviRwmnkcbdO3HARZMoyLVAce9D9nUJXOV2VA8ijKJTei3TNiZmr0h1+RtAoA
        Yi9wnhIspA6Mgo1FErY+UYT5H4M4NQk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-D-6USiR9MwqDDqTvXhw2sg-1; Tue, 12 Oct 2021 04:49:15 -0400
X-MC-Unique: D-6USiR9MwqDDqTvXhw2sg-1
Received: by mail-ed1-f69.google.com with SMTP id t28-20020a508d5c000000b003dad7fc5caeso18253485edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PZfuMOca3BMyKn1rZ5ck9ra0yqT4Ylul21gEYxqcVNk=;
        b=xZRdRr9mwtf8qRCaKi3UN8ZxO4jan8sQKnkKNnjwDrzSdg9Bn4SKMNjEtWez0tYLMN
         TdXBIDBwgJSyHOo2hlgDF+ohi/dGWHW35HaDdeUkTLM4Q+XxI8OpaDqw1pmf/P00hBJJ
         zbcen//4b1rF0zsKuvqMW9qbQ9V56qQVIBUuht9AiJOPAAewu9lV5NVLstqxzdft+hJZ
         36W8xy4uVQj+85lUY7lQ2DrA1/Fo9lb8u3EOmobwreLhtokgFon/i8/oSQMQyUEdhetP
         CtHLoIPdf2LCZEqU6HvcEQc0XvqUHL2lPiFbHYZqufWCXsi6IsoG3Wos+qMyOx1LJdPg
         vopA==
X-Gm-Message-State: AOAM533jeYdGEn+jZL+PoTt3/pcW9GY0J208FxNFv8/7Hqs00lxGlO7m
        E29iFjWGWjgjRBGX2IaygYEHQmjapLZMAL9Wzdx1eAOv2rRbfByDstSnkx+z6oGGza97BDfjAWh
        utODJJ5lwRdfwsMHtnuArf5Ft3GgNYnogMCLI3AZq
X-Received: by 2002:a17:906:3486:: with SMTP id g6mr31790747ejb.71.1634028553461;
        Tue, 12 Oct 2021 01:49:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcou8Lgqn0Rq4uLIbUFsO5KlFaR+BNZCSxnz2ONJB3GR7hzH2MPFfyTEhB9bWdVtH5sVUQFiv64h5hS1OOKSY=
X-Received: by 2002:a17:906:3486:: with SMTP id g6mr31790726ejb.71.1634028553265;
 Tue, 12 Oct 2021 01:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211008032231.1143467-1-fengli@smartx.com> <CAPhsuW5+bdQwsyjBP=QDGRbtnF021291D_XrhNtV+v-geVouVg@mail.gmail.com>
 <CALTww28b0HGzSTTNGVzeZdRp0nGMDAyY8sQ+cBsSCuYJ4jMaqw@mail.gmail.com>
 <CAHckoCyuqxM8po4JA4=OacVWhYuo9SWescUVOKRFGwdc=aoN8A@mail.gmail.com>
 <CALTww28CsJdmVOLFeoHC8FgbHDK78h8Lncsf9fFA0RYXEj=R9A@mail.gmail.com>
 <CAHckoCzzVP7npmU4LWedzD-f1QmkH4K0iLk_=8ptSFXrFfRoDw@mail.gmail.com>
 <CAPhsuW4VFTpM94by-iMkTQ=b9Y7FqZ2oqHH+jV-f8BM=YKWyiA@mail.gmail.com> <CAHckoCxRj1qb=yfeQ2o_8n_BSSLD9JXqm8GopUp2qx9NEPxr7w@mail.gmail.com>
In-Reply-To: <CAHckoCxRj1qb=yfeQ2o_8n_BSSLD9JXqm8GopUp2qx9NEPxr7w@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 12 Oct 2021 16:49:01 +0800
Message-ID: <CALTww2_eScuqd4yUtDFhaRUGAK-f8J_L=yOZdTVA9uZ7Tq4bxg@mail.gmail.com>
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

Hi all

How about this patch? Now writemostly flag doesn't be stored in
superblock too. So this patch fix this problem too.
If this patch is ok, I'll send the patch.

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6c0c3d0d905a..9e8a8c5c7758 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2977,6 +2977,7 @@ state_store(struct md_rdev *rdev, const char
*buf, size_t len)
      *  {,-}failfast - set/clear FailFast
      */
     int err =3D -EINVAL;
+    int need_update_sb =3D 0;
     if (cmd_match(buf, "faulty") && rdev->mddev->pers) {
         md_error(rdev->mddev, rdev);
         if (test_bit(Faulty, &rdev->flags))
@@ -2998,20 +2999,19 @@ state_store(struct md_rdev *rdev, const char
*buf, size_t len)

             if (err =3D=3D 0) {
                 md_kick_rdev_from_array(rdev);
-                if (mddev->pers) {
-                    set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-                    md_wakeup_thread(mddev->thread);
-                }
+                need_update_sb =3D 1;
                 md_new_event(mddev);
             }
         }
     } else if (cmd_match(buf, "writemostly")) {
         set_bit(WriteMostly, &rdev->flags);
         mddev_create_serial_pool(rdev->mddev, rdev, false);
+        need_update_sb =3D 1;
         err =3D 0;
     } else if (cmd_match(buf, "-writemostly")) {
         mddev_destroy_serial_pool(rdev->mddev, rdev, false);
         clear_bit(WriteMostly, &rdev->flags);
+        need_update_sb =3D 1;
         err =3D 0;
     } else if (cmd_match(buf, "blocked")) {
         set_bit(Blocked, &rdev->flags);
@@ -3037,9 +3037,11 @@ state_store(struct md_rdev *rdev, const char
*buf, size_t len)
         err =3D 0;
     } else if (cmd_match(buf, "failfast")) {
         set_bit(FailFast, &rdev->flags);
+        need_update_sb =3D 1;
         err =3D 0;
     } else if (cmd_match(buf, "-failfast")) {
         clear_bit(FailFast, &rdev->flags);
+        need_update_sb =3D 1;
         err =3D 0;
     } else if (cmd_match(buf, "-insync") && rdev->raid_disk >=3D 0 &&
            !test_bit(Journal, &rdev->flags)) {
@@ -3120,6 +3122,11 @@ state_store(struct md_rdev *rdev, const char
*buf, size_t len)
     }
     if (!err)
         sysfs_notify_dirent_safe(rdev->sysfs_state);
+    if (need_update_sb)
+        if (mddev->pers) {
+            set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
+            md_wakeup_thread(mddev->thread);
+        }
     return err ? err : len;
 }
 static struct rdev_sysfs_entry rdev_state =3D

On Tue, Oct 12, 2021 at 4:44 PM Li Feng <fengli@smartx.com> wrote:
>
> Song Liu <song@kernel.org> =E4=BA=8E2021=E5=B9=B410=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:17=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Oct 12, 2021 at 1:07 AM Li Feng <fengli@smartx.com> wrote:
> > >
> > > Xiao Ni <xni@redhat.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:58=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Mon, Oct 11, 2021 at 5:42 PM Li Feng <fengli@smartx.com> wrote:
> > > > >
> > > > > Xiao Ni <xni@redhat.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:49=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > Hi all
> > > > > >
> > > > > > Now the per device sysfs interface file state can change failfa=
st. Do
> > > > > > we need a new file for failfast?
> > > > > >
> > > > > > I did a test. The steps are:
> > > > > >
> > > > > > mdadm -CR /dev/md0 -l1 -n2 /dev/sdb /dev/sdc --assume-clean
> > > > > > cd /sys/block/md0/md/dev-sdb
> > > > > > echo failfast > state
> > > > > > cat state
> > > > > > in_sync,failfast
> > > > >
> > > > > This works,  will it be persisted to disk?
> > > > >
> > > >
> > > > mdadm --detail /dev/md0 can show the failfast information. So it
> > > > should be written in superblock.
> > > > But I don't find how md does this. I'm looking at this.
> > > >
> > > Yes, I have tested that it has been persisted, but don't understand w=
ho does it.
> >
> > I think this is not guaranteed to be persistent:
> >
> > [root@eth50-1 ~]# cat /sys/block/md127/md/rd1/state
> > in_sync,failfast
> > [root@eth50-1 ~]# echo -failfast >  /sys/block/md127/md/rd1/state
> > [root@eth50-1 ~]# cat /sys/block/md127/md/rd1/state
> > in_sync
> > [root@eth50-1 ~]# mdadm --stop /dev/md*
> > mdadm: /dev/md does not appear to be an md device
> > mdadm: stopped /dev/md127
> > [root@eth50-1 ~]# mdadm -As
> > mdadm: /dev/md/0_0 has been started with 4 drives.
> > [root@eth50-1 ~]# cat /sys/block/md127/md/rd1/state
> > in_sync,failfast
> >
> > How about we fix state_store to make sure it is always persistent?
> >
> I agree with you.
>
> > Thanks,
> > Song
>

