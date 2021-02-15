Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83731C244
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBOTM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhBOTMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:12:14 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB788C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:11:33 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id q4so6958859otm.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vyYLUpmU6IFRJn6DkBKZeMcUTefwAqDTD3LpFwE2YRQ=;
        b=rDBXPPfdjkQEcUimIMOZ9aaFzfzO8+xnlCYgYQ3JYTiqLSTBLZL/k8vns9Ay9aM1pT
         W61lEwJNeibCKdPJpXJXd97lDPSZ3ET1aHvUkyTZQTSQqB7RcY/SJ7F1tyAoCgsuPfnd
         nlyeJjlW+UW4LXEDMG80mek+H5aMYRUMqa9fOmIkx7Xu7yANlTT0vpErmyKgrA3/8Odb
         ZKCpW3sT5FlFtaVBvmMtODwiUZPyvJDFD38DmfDqqnF8ckhoWP3oH/TJ9Ket6VLOLmIh
         DZtFOUY+e3dx5XxRby1NlZ1nlyTqH4gHKTh0if/F8d+QY3u3xneaOlP9N5KGL/9WIkcJ
         2uLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vyYLUpmU6IFRJn6DkBKZeMcUTefwAqDTD3LpFwE2YRQ=;
        b=ihkW6elqIyZxB9Klw8kyMZBcjP6bmwu4AKU4efLmg2ECIA+1MJM+oleQ6PP9ERnckm
         3a7OJMcF+1XKzpMMR2HeB6NmdnuWcuO89umE4BFhPpV36FxCq8QChDct3Us4irEnLPpd
         YTTVuxixy9NwhjA+R0iGlc2s5VCSSF0+tsGeeEBiJZaocvI+f+egNOXo+37fyP375HMm
         4erl5aNpmwu2kB3r1YAmj/oyCwjsofY/BX4IbJns5KlyZV3esYYP4X3+aN7qvtKjaVHz
         21XNgV20y2ccPiAfUas2PuSFH+sJ6md6xlPH/y3xbDO936Rm+TtDs94qZJ/mMOSBqkW+
         zkAA==
X-Gm-Message-State: AOAM533HAiYonn/QAArQ5ir3s7q42dUILp2/xAsZNJK0Eni3+0YU347P
        P+xq6FvhjcddCIiHVEnIunzCWe+rdePGI2GrkMI=
X-Google-Smtp-Source: ABdhPJx/Vn6fcl5sqAzH0f80Fk2jbYVMI6anacnhUcIiN4wTSQDpSzu7jDeQYQ/knjwSk88tz0gSAcjzdwbccBFSLMc=
X-Received: by 2002:a9d:12f2:: with SMTP id g105mr13136151otg.132.1613416293415;
 Mon, 15 Feb 2021 11:11:33 -0800 (PST)
MIME-Version: 1.0
References: <1613384489-3102-1-git-send-email-chen45464546@163.com> <e045d7ad-c9a5-e956-7efc-b0b1a7db1247@amd.com>
In-Reply-To: <e045d7ad-c9a5-e956-7efc-b0b1a7db1247@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Feb 2021 14:11:22 -0500
Message-ID: <CADnq5_M7g1=i9Dqrks2Z1tZfV=+HMwfnfaFCyMyAc9tu4kBQ5g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Remove unused function pointer typedef radeon_packet3_check_t
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Chen Lin <chen45464546@163.com>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Chen Lin <chen.lin5@zte.com.cn>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Feb 15, 2021 at 5:43 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> Am 15.02.21 um 11:21 schrieb Chen Lin:
> > From: Chen Lin <chen.lin5@zte.com.cn>
> >
> > Remove the 'radeon_packet3_check_t' typedef as it is not used.
> >
> > Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/radeon/radeon.h |    3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/r=
adeon.h
> > index 5f3adba..a1c38b5 100644
> > --- a/drivers/gpu/drm/radeon/radeon.h
> > +++ b/drivers/gpu/drm/radeon/radeon.h
> > @@ -1111,9 +1111,6 @@ struct radeon_cs_packet {
> >   typedef int (*radeon_packet0_check_t)(struct radeon_cs_parser *p,
> >                                     struct radeon_cs_packet *pkt,
> >                                     unsigned idx, unsigned reg);
> > -typedef int (*radeon_packet3_check_t)(struct radeon_cs_parser *p,
> > -                                   struct radeon_cs_packet *pkt);
> > -
> >
> >   /*
> >    * AGP
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
