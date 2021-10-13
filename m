Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2727B42B9CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhJMIAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238713AbhJMIAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634111890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uwSRG5VpgF9GMHGYBZADyWxlcRVpODekeZlTKT4bouc=;
        b=Ypy5RVkYi8g8mEbcNWwH2h+OWVcr+PzUwwZ5rtygWlhiiDOJzqkfc0qhdYqkDjRokeZ99b
        l/TIzOuE0zFIeakMAttLgvwYxIT22VnmugJ5oThHmaE807xFaIyLtuY+8ksLZ8NKQIp7Th
        he48lnswcaIJ/mz7eEqbV8uks+VIM4k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-A6063dyIPX6Tm5sPQaiubA-1; Wed, 13 Oct 2021 03:58:09 -0400
X-MC-Unique: A6063dyIPX6Tm5sPQaiubA-1
Received: by mail-ed1-f72.google.com with SMTP id i7-20020a50d747000000b003db0225d219so1553378edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwSRG5VpgF9GMHGYBZADyWxlcRVpODekeZlTKT4bouc=;
        b=KOSNxGn/K8DuQuHqXG8g8e+ADGclZ0jAsB8KiXXd33ZLaaBeBzm9GJqtUqmrPX+v1w
         sanzeMyIU2COVbMEeE0+XB2BwQEysDb3hQ1uOTLP8R4FWTgjNZAAetsymOmAfNbPwOzX
         26VqHBoaSzuCcuX5YRlwlfpA4ZppdKPbIWp2+AVXug8oF/yKN6xAhZtRlUVoISjEvZ/8
         NzZ2ajU1iCheyGnnYfUpzQMOnXNcsIL9HI6Flp3SH8MJQ4qXAoerBaDEVN3mAaWQxMDG
         vPy/cWIl+InMkLbnU2pzuJDOSdkkw9L+r7+YZE2xt3haKFP41bNjV0FnKyotI9SFgH+D
         p8Lw==
X-Gm-Message-State: AOAM530lIE0B6qbL6TXUr2vOT0rmS1Byhb+8DZ4AqecoTNGjEK7Lnhmm
        6X0td1PNiV5iIYYNx4ttOUKBdoQDokAET0a37ge7uQGyllQDSHo9BweqpRrAi+0faHGnzoHZMie
        MfCYS6Zd6cSrLkPSSzxQRWrot7sPlte0xEA/MNofz
X-Received: by 2002:a17:906:6d0a:: with SMTP id m10mr37614245ejr.90.1634111888516;
        Wed, 13 Oct 2021 00:58:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiR77ZWt17w0FdzUumhatfva+RqZ5nCNAG7etUI8DT4C/RC/+Tasmj+lgu/Ql9RQxad4oOgH9u1PWtUmX6RII=
X-Received: by 2002:a17:906:6d0a:: with SMTP id m10mr37614226ejr.90.1634111888338;
 Wed, 13 Oct 2021 00:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211008032231.1143467-1-fengli@smartx.com> <CAPhsuW5+bdQwsyjBP=QDGRbtnF021291D_XrhNtV+v-geVouVg@mail.gmail.com>
 <CALTww28b0HGzSTTNGVzeZdRp0nGMDAyY8sQ+cBsSCuYJ4jMaqw@mail.gmail.com>
 <CAHckoCyuqxM8po4JA4=OacVWhYuo9SWescUVOKRFGwdc=aoN8A@mail.gmail.com>
 <CALTww28CsJdmVOLFeoHC8FgbHDK78h8Lncsf9fFA0RYXEj=R9A@mail.gmail.com>
 <CAHckoCzzVP7npmU4LWedzD-f1QmkH4K0iLk_=8ptSFXrFfRoDw@mail.gmail.com>
 <CAPhsuW4VFTpM94by-iMkTQ=b9Y7FqZ2oqHH+jV-f8BM=YKWyiA@mail.gmail.com>
 <CAHckoCxRj1qb=yfeQ2o_8n_BSSLD9JXqm8GopUp2qx9NEPxr7w@mail.gmail.com>
 <CALTww2_eScuqd4yUtDFhaRUGAK-f8J_L=yOZdTVA9uZ7Tq4bxg@mail.gmail.com> <CAHckoCys6_SG56jzuK0OfFwKb6BtBsUhpp6A70hOKFSeVTWU-Q@mail.gmail.com>
In-Reply-To: <CAHckoCys6_SG56jzuK0OfFwKb6BtBsUhpp6A70hOKFSeVTWU-Q@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 13 Oct 2021 15:57:57 +0800
Message-ID: <CALTww29m_RQHbZY6owX2y1_rmOeCEL9rSWg4=shnnitA1RpWQg@mail.gmail.com>
Subject: Re: [PATCH RESEND] md: allow to set the fail_fast on RAID1/RAID10
To:     Li Feng <fengli@smartx.com>
Cc:     Song Liu <song@kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" 
        <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 5:14 PM Li Feng <fengli@smartx.com> wrote:
> >          sysfs_notify_dirent_safe(rdev->sysfs_state);
> > +    if (need_update_sb)
> > +        if (mddev->pers) {
> > +            set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
> > +            md_wakeup_thread(mddev->thread);
> > +        }
> When will mddev->pers is NULL?

The process of creating a raid device is:
1. md_ioctl->md_add_new_disk
2. md_ioctl->do_md_run->md_run->(pers->run)->(mddev->pers = pers)
In md_add_new_disk it creates the per device sysfs files. It can
read/write these
files before setting mddev->pers.

> If it is NULL, this change will not on disk.

I did a test. You are right. Someone can change the per device state
before ADD_NEW_DISK
and RUN_ARRAY ioctl. Please note, the mdadm --create command doesn't
return until RUN_ARRAY
ioctl finishes. Even though the are small, we can try to set MD_SB_CHANGE_DEVS.

Best regards
Xiao

