Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32EF3D92AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhG1QAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbhG1QAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:00:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B6C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:00:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so10731694pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yc5UbwPjJQACVbhvjLg+y5j4VZ0+YIpYUrLOrohGgkY=;
        b=qx5DLqsbVm3pDju2VSYfAbQl88h0B1EVxHBtlFut/6ctc/nH5qKeikqQP8qDzv5eLz
         4dXp4+bODSNL0hCZEqkcoIXwwgNai7tOfbtTXvvAJFOhkqKw4/R92jWdwWtXJ9MEEJsN
         ro5LWDnEwbyRH9wKa5r5HNbWgvifvNoGYREpxyTCfDqcz+X9QWsBCb1IwHoUy5UGvqKn
         D2CJREa3Lxf2IUklMIDwvcd8J2lFtg8zk4OMK/DqNxMeWeYh3PgASpIsx6JZRzQy1X5/
         PpueJOCkPwHVbIzp97vF2w551yq7JhJQDq7PAJox8mAqy6DFKelLwFc9oSxgYgQ4xlnG
         MF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yc5UbwPjJQACVbhvjLg+y5j4VZ0+YIpYUrLOrohGgkY=;
        b=qiDsahLFCtqxsEapIlhsbXd6IZCqCPiyP3x0tcNWRti+nyrVBqptYGB8JQutIYnALE
         TF/YWgUrhywbxmWcVsPktBThNz4iPexW9pFR6c3NcUIawxMuwn2YDkXKCNsLwUV5bOki
         QG/WM61yalPZeHoodDjO5tNHPl1HIBm+RXoyxSlc5I0dhwGzaJadhPTUzaMxizmQmJVv
         JYYFSFLzluUUHVTIUg5rPweolpImWDc7ObmD/1TPy3jPtBAydWIhVahjM9YUiK5Tmzqa
         7GtQLsqslwfsGQl+A/n4BbDS6dfjBGYDcoDvqBBdxz7IDveXZSe21+TcsnaBrNHFXDV/
         tA5w==
X-Gm-Message-State: AOAM532PUbLOxGX31I54ya4YfQtjQh5r6tRzLrDxHO0Mo6j4Clceq0Zc
        mmKKfgdHKPpxNnMqleFyUhY4HujgjmsZxAgl/+VAhA==
X-Google-Smtp-Source: ABdhPJz2logvFN0MKIsYvPCI7xECU1r0uANCc3AQ/xrgU3X9/gvm7fwRg8jd0KyK/HMYlIFMJe0A74gaDSUTZUqwKDo=
X-Received: by 2002:a65:6181:: with SMTP id c1mr507765pgv.208.1627488028807;
 Wed, 28 Jul 2021 09:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210727232219.2948-1-phil@philpotter.co.uk> <20210728074605.pp5rs4c65tofnqot@viti.kaiser.cx>
In-Reply-To: <20210728074605.pp5rs4c65tofnqot@viti.kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Wed, 28 Jul 2021 17:00:18 +0100
Message-ID: <CAA=Fs0mH9YAVhr24YeE3jpZrnuDGhOuhj=Sb9Ekkpb-xoC5LYg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] staging: r8188eu: add newer/better RTL8188eu driver
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 at 08:46, Martin Kaiser <martin@kaiser.cx> wrote:
>
> Hi Philipp and all,
>
> Thus wrote Phillip Potter (phil@philpotter.co.uk):
>
> > The driver currently in staging is older and less functional than the
> > version on Larry Finger's GitHub account, based upon v4.1.4_6773.20130222.
> > This series of patches therefore:
>
> [...]
>
> > V4: don't remove old driver now, just mark as deprecated and modify to
> >     allow building alongside the new driver.
>
> Basically, you're suggesting to put aside all the fixes and cleanup
> that was done since the rtl8188eu driver was imported into the kernel
> tree. The TODO file says
>
> - merge Realtek's bugfixes and new features into the driver
>
> Why aren't we going down this route?
>
> Edimax offer a realtek driver linux_v5.7.6.1_36803.20200602 for
> rtl8188eu as a .zip file for download on their website
>
> https://www.edimax.com/edimax/mw/cufiles/files/download/Driver_Utility/EW-7811Un_V2/EW-7811Un_V2_Linux_Driver_1.0.1.2.zip
>
> If we integrate and fix the v4.1.4_6773.20130222 driver, are we running
> the risk that someone else will come along and propose another replacement?
>
> Thanks,
> Martin

Dear Martin,

I see what you are saying for sure - I think we've both sunk a fair
few patches into the existing driver :-)

That said, from what Larry has mentioned, this newer driver would
still be a better bet overall due to the additional work that has
already happened on it out-of-tree. The Realtek driver you reference
probably has no CFG80211 support etc. would be my guess, but I am
going off what others have suggested in terms of proposing this
patchset. I can't honestly say what the risk of this happening again
would be, but minimal I'd imagine.

Regards,
Phil
