Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F75363C02
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 08:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhDSG6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 02:58:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48562 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbhDSG6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 02:58:39 -0400
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lYNr5-0003FS-FR
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 06:57:59 +0000
Received: by mail-lj1-f199.google.com with SMTP id n1-20020a2e90410000b02900bddb911a15so5845149ljg.16
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 23:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NED6jjF9FTGvqZjiOiGlzkrUtxsIiQuMqxjuwK5DjQ8=;
        b=M5uqWnqLhEftK4hj0vqiFG59nFM9s8iv/tZ6Nt9fAjF3BvU9elxe+qtLFmDEd54+Tz
         XLiLcSk/lsWLJrWfQwawWlR2HcYv6X1ZEcbocQk/m+CbT4DFRJ07q7zW6HqgRYanueDd
         wPDN57gQseG7QptH4qk9eTrhFA3MQke/c4muz7nLh58iK82Gn5EB0iVe6Kryl5kXGXY6
         fFPBF7CpUT5p6UxDkNsV9ZelZdkjM5x8ejsA5cjueXByHOJ9jzaH2Xf/gWbZtunWwHTv
         hxUCG4f8CV7fS9qsooIUanwWKQGkOWWyk9ZG4+TGYqooucDrc+RwdTaKeyb+ZGqSxKz8
         abig==
X-Gm-Message-State: AOAM530iRo7imtgEJTuFRK57dkUK3eLhZDCKTFU7VTQ5tVXSyyjVHvFU
        RFI0oegUcuRje5qrZ6Fi3yXZkxkVt44xPSztoF8aoDQJLVaqBiJn5/9AMmCaVnxwYWP8UnfjXih
        WCJnPQDVAIiLvnAvy9fWLboBjhMImmUhAs7bF8xomZCsZDJE/cAeqiI+M0w==
X-Received: by 2002:a2e:97c6:: with SMTP id m6mr6276932ljj.403.1618815478908;
        Sun, 18 Apr 2021 23:57:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymqqDsD4BR0a12QO0hOs762glaPCScP1aUjakoJbCxpHe65YTQsfDj47rcBPva+aKEpAhhlP3dFqKpvkuEwk0=
X-Received: by 2002:a2e:97c6:: with SMTP id m6mr6276920ljj.403.1618815478670;
 Sun, 18 Apr 2021 23:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210416091344.1210803-1-kai.heng.feng@canonical.com> <20210419065027.GA19201@lst.de>
In-Reply-To: <20210419065027.GA19201@lst.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 19 Apr 2021 14:57:46 +0800
Message-ID: <CAAd53p4r45fZ4ewCko_Q-mO92omBZkEiPpyyc2SYRXH+6WpEKg@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device supports it
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alex Deucher <alexander.deucher@amd.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 2:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Apr 16, 2021 at 05:13:44PM +0800, Kai-Heng Feng wrote:
> > On AMD platforms that use s2idle, NVMe timeouts on s2idle resume,
> > because their SMU FW may cut off NVMe power during sleep.
>
> We're already have a discussion on a proper quirk for thse broken
> platforms on the linux-nvme list, please take part in that discussion.

Thanks. I didn't notice v5 was sent the to mailing list.
As of now, AMD folks are also reviewing this, and I believe this
approach is less quirky.

Kai-Heng
