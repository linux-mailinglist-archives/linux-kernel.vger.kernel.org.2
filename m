Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC7A459AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 05:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhKWEQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 23:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhKWEQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 23:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637640786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ph1TOkVRVJZ0jQEXGshzxIVlkYeNDfONV+sQAMGUFbw=;
        b=WZeEDPazEZLzUQm5MsUIx3Qbhvl/+RPvyGPbTgYra2tk8mXIVnUvsV5pAEoDS20vtDMIx7
        3qUz+3xREePTeBKzVk0HdPDHW40kNSwfhg5IsHoGusxH1V/w0N2vCr7ApnNfnP2QLBSF3u
        eHSBVCTME3plyncsSNMxZXEp8ps9VEU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-MrHbA7A-N6Go5MSBwYGuXw-1; Mon, 22 Nov 2021 23:13:04 -0500
X-MC-Unique: MrHbA7A-N6Go5MSBwYGuXw-1
Received: by mail-lf1-f69.google.com with SMTP id s18-20020ac25c52000000b004016bab6a12so13559621lfp.21
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 20:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ph1TOkVRVJZ0jQEXGshzxIVlkYeNDfONV+sQAMGUFbw=;
        b=eAL8penrF86eYhMxukAT7BcxozILtzFJ+4qiCh8NVSDblyP3cLWQiMfMYdWc3REbPB
         s1BMSiBf6p1agAkWzgnkG1euboq8ntMFkmFQYjvz5eya6yDLx3gYf2/7HYoxqhMmSOpp
         yD0mx6Q9KhC9GN1CgGCCRW8YdNCVPDlt14xaTkVzsCWty4Yzvj5myUivoHqpsrL7603j
         Aw318fXIjlIvIWP5J7EqDaMSrZuN/spvjHIbXPBRbcsAv/WEYZGOFSWHPK7M/6cqvflX
         uYw6gX9HLBaMt9vcs1Jty0xwKqha1Pi9IfWCyeeZDabsBmrnvIuYWOLiXIvb5i5GeZlV
         JJsg==
X-Gm-Message-State: AOAM530fu4HbyyiIN1Lr+yyOwgmoyvTALJtMgGlROzHQ8GfnUUcRolWV
        DUQn9F9g6s9gc2wVvSnHGwZXnG0JdKBj9/fqq1W+roNcbRObJeLSV42bls9RD9V4eqdY+wkwhWm
        1Np0x6fm9hqT2SKjTocIMw8j97WfvvFRcwrA9Bl8m
X-Received: by 2002:a2e:3012:: with SMTP id w18mr1714473ljw.217.1637640783096;
        Mon, 22 Nov 2021 20:13:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1XKSp5o6YaM93E2NH2xZ/FKDrjFK5qLFTZGKmo0qWX1VnWK9vDWf52/6Mgz7371s3SqvgoDGqTrTY023CcVc=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr1714447ljw.217.1637640782897;
 Mon, 22 Nov 2021 20:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20211122122221.56-1-longpeng2@huawei.com> <PH0PR12MB54811F4CC671312DFB2FACCDDC609@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54811F4CC671312DFB2FACCDDC609@PH0PR12MB5481.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 23 Nov 2021 12:12:49 +0800
Message-ID: <CACGkMEsDmqwWdw51NKftjhcGr6z9ynP8dcqDiaQY=soTXTSBDg@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: avoid putting an uninitialized iova_domain
To:     Parav Pandit <parav@nvidia.com>
Cc:     "Longpeng(Mike)" <longpeng2@huawei.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 11:12 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Longpeng(Mike) <longpeng2@huawei.com>
> > Sent: Monday, November 22, 2021 5:52 PM
> >
> > From: Longpeng <longpeng2@huawei.com>
> >
> > The system will crash if we put an uninitialized iova_domain, this could
> > happen when an error occurs before initializing the iova_domain in
> > vdpasim_create().
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000000 ...
> > RIP: 0010:__cpuhp_state_remove_instance+0x96/0x1c0
> > ...
> > Call Trace:
> >  <TASK>
> >  put_iova_domain+0x29/0x220
> >  vdpasim_free+0xd1/0x120 [vdpa_sim]
> >  vdpa_release_dev+0x21/0x40 [vdpa]
> >  device_release+0x33/0x90
> >  kobject_release+0x63/0x160
> >  vdpasim_create+0x127/0x2a0 [vdpa_sim]
> >  vdpasim_net_dev_add+0x7d/0xfe [vdpa_sim_net]
> >  vdpa_nl_cmd_dev_add_set_doit+0xe1/0x1a0 [vdpa]
> >  genl_family_rcv_msg_doit+0x112/0x140
> >  genl_rcv_msg+0xdf/0x1d0
> >  ...
> >
> > So we must make sure the iova_domain is already initialized before put it.
> >
> > In addition, we may get the following warning in this case:
> > WARNING: ... drivers/iommu/iova.c:344 iova_cache_put+0x58/0x70
> >
> > So we must make sure the iova_cache_put() is invoked only if the
> > iova_cache_get() is already invoked. Let's fix it together.
> >
> > Signed-off-by: Longpeng <longpeng2@huawei.com>
>
> Can you please add the fixes tag here so that older kernels can take this fix?
>

I guess it's 4080fc106750 ("vdpa_sim: use iova module to allocate IOVA
addresses")

Thanks

