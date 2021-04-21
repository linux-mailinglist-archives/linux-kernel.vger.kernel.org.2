Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537E236717B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbhDURjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:39:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33880 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbhDURjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:39:14 -0400
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lZGoC-0007IK-98
        for linux-kernel@vger.kernel.org; Wed, 21 Apr 2021 17:38:40 +0000
Received: by mail-lf1-f70.google.com with SMTP id s8-20020a1977080000b02901ae88fbe012so1154652lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9+aIwz9Vql5/6wSQl+X+pueE49imN5o1e/PPElxYzU=;
        b=jXfoVDdfAlj/s86mGJU57Sc6Dmhu+ICN/MO7jUH/YE86vjReKS0CkRsvBJyDJS4i5d
         fYP1HiXkLjxRbvyhnCBNUh4Y/eLE/NI33tJy+h9e/skGE6gxpgVPu0j+JuMmKeSAvE/k
         NrvZn+0pfbPsY2QX5XflpFhzY2xn23GMMZ6jX3YWVLigPzBCNjJSc6kdh6Civ7E0bv72
         3y3OUbG11l9yYdefLa+hCgQOTIIbZhWMmd9QCCoYdr7OWD6ua1/2ir0WGQS1nwzU9W3f
         V3wuVQ1fQfbNwrACxgV06sjKhMh7Vaa49S6ETcjRxmD5bgQd382B+1o7ZqzRdimHf78q
         JoPQ==
X-Gm-Message-State: AOAM5308FRiw+kZNFNxVRyR6LESFwaufLrnwKoCIMvUMcGGl+W2UDTZ6
        QGU8lwxQdHUSSrMRRW4tInjp16KYUgxGqbPTiXNkIIocAs8EmXlg1tFB2RMF9NyHn4EDDJQDTGv
        XuttuuzrJiRVx3uJvxHplVNGElHn8UsBK0eeQTAqEN+QkE0MkvHVufAj/iA==
X-Received: by 2002:a05:6512:3f8c:: with SMTP id x12mr19950139lfa.622.1619026719734;
        Wed, 21 Apr 2021 10:38:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzItHMeXRB2TVHPu5Htg1i1sRwwHWMfKEkn/SOqau90eZrlMpzeKkrk6JIgPMVOa4v50O5FId3GHVMezAV3Sbg=
X-Received: by 2002:a05:6512:3f8c:: with SMTP id x12mr19950124lfa.622.1619026719493;
 Wed, 21 Apr 2021 10:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210416091344.1210803-1-kai.heng.feng@canonical.com>
 <20210419065027.GA19201@lst.de> <CAAd53p4r45fZ4ewCko_Q-mO92omBZkEiPpyyc2SYRXH+6WpEKg@mail.gmail.com>
 <BYAPR12MB3238A5758B18B061204F264EFB479@BYAPR12MB3238.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3238A5758B18B061204F264EFB479@BYAPR12MB3238.namprd12.prod.outlook.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 22 Apr 2021 01:38:27 +0800
Message-ID: <CAAd53p6f14W3RtbhpszzdRp56bh5y3ciezNq2WgsA9FwmREdSw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device supports it
To:     "Liang, Prike" <Prike.Liang@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 4:42 PM Liang, Prike <Prike.Liang@amd.com> wrote:
>
> [AMD Public Use]
>
> According to BIOS guys the _PR3 should be always implemented for NVMe device on the onwards ASIC. This solution seems more simple and looks good to me.

Turns out ASUS laptops don't have _PR3 implement in ACPI, so this
patch doesn't work on them.
For now, please use the patch from AMD instead, thanks!

Kai-Heng

>
> Reviewed-by: Prike Liang <Prike.Liang@amd.com>
>
> Thanks,
> Prike
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Monday, April 19, 2021 2:58 PM
> > To: Christoph Hellwig <hch@lst.de>
> > Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>; Sagi
> > Grimberg <sagi@grimberg.me>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Liang@amd.com>; S-k,
> > Shyam-sundar <Shyam-sundar.S-k@amd.com>; open list:NVM EXPRESS
> > DRIVER <linux-nvme@lists.infradead.org>; open list <linux-
> > kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device
> > supports it
> >
> > On Mon, Apr 19, 2021 at 2:50 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Fri, Apr 16, 2021 at 05:13:44PM +0800, Kai-Heng Feng wrote:
> > > > On AMD platforms that use s2idle, NVMe timeouts on s2idle resume,
> > > > because their SMU FW may cut off NVMe power during sleep.
> > >
> > > We're already have a discussion on a proper quirk for thse broken
> > > platforms on the linux-nvme list, please take part in that discussion.
> >
> > Thanks. I didn't notice v5 was sent the to mailing list.
> > As of now, AMD folks are also reviewing this, and I believe this approach is
> > less quirky.
> >
> > Kai-Heng
