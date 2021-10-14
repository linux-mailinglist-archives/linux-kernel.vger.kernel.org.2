Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3850042D1F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 07:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhJNFod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 01:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229672AbhJNFo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 01:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634190143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VY03GubPFVDdkvSR8SdXXqCAVaPVrTzhj7NluBAU388=;
        b=PzA0Cuas91a7mf9izDA4td3OIfZMYr7glmocc8jlOvPWiJH+mDFOySbwJKJ1G360yRDbBU
        d1plIHLyPwFZFCsaJYNVDT6SEWAxB3Vqjxo+J1Na/bKH/W08G3pPUqmMXb2Y/ZiqswIItY
        prsemgC7gEAvCeHvodTH8bsiVEubgbY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-jAilxBzgNX2iEZSVbD2NCw-1; Thu, 14 Oct 2021 01:42:21 -0400
X-MC-Unique: jAilxBzgNX2iEZSVbD2NCw-1
Received: by mail-wr1-f72.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso3687880wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 22:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VY03GubPFVDdkvSR8SdXXqCAVaPVrTzhj7NluBAU388=;
        b=EcKj9662elw/e5qmK3Nv7394+CRkDlQHbkDluBdo0rAc7o6YIqdLCDiRm4+WHqzIWI
         XOd0djHasVu/N75+k814DdVKfRhY/VhzEvlcADbub8fBEepBtREaoZGEPXpX/cJ7KNz7
         XWm7UnmsBsWNHfVpHFFbvc3YQV5XPB4BDcEkqSgzN/FJ67PR1hYeRPqcEIgcRKDXLpcS
         zHVBOzSoTt8CayzsouvjmwOIVHjSbquRo9zwTq7lhPGd8BKx39Uc7G9xegOy54OTpgVa
         huKfJ170HTZ7KvukRzoaJzFf8t+28n/BMIcuHx/Thyc6zePzxg0LE08d06i9RTUiHNVK
         S9Ng==
X-Gm-Message-State: AOAM5323fUWkS15vrPYb3nEOUudMqbdgmIYW8JpYbtdNco74CHR0OreI
        bI00B4u8AuBe+LUdmc7rwV/DrYUt9np8bHrJREMC2iqbNDvNck3yQFW9xWty1UpMji/YU90SK6E
        zPoCqZ3JqcPCHTu2CBjByHGOeW3Hfd0FEcSdNijDi
X-Received: by 2002:adf:a29c:: with SMTP id s28mr4104547wra.116.1634190140691;
        Wed, 13 Oct 2021 22:42:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQovMuuTmLhj35z2utXaPHJV063AsII3FyccF8wXMMb7viJYHRoQqfSWAqErXYbz1US8DF/BzbxkOaXmWnGMg=
X-Received: by 2002:adf:a29c:: with SMTP id s28mr4104529wra.116.1634190140520;
 Wed, 13 Oct 2021 22:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211012131836.4e17a031@canb.auug.org.au> <202110141102364478237@zte.com.cn>
In-Reply-To: <202110141102364478237@zte.com.cn>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 14 Oct 2021 07:42:09 +0200
Message-ID: <CACO55tsyrnta4z=K_vARsQTTD1t4o8sHA4Svr=Z+sDnvv0jHCQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To:     Luo penghao <luo.penghao@zte.com.cn>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 5:02 AM <luo.penghao@zte.com.cn> wrote:
>
> Hi,
>
> I review the code.
>
> It seems I forget to delete the definition of the variable "inst",I'm sry for that.: (
>
> I'll submit another patch soon.
>

I already wrote the patch and pushed it:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=381ba6a6baf104b572379c6b2deab884555104d4

>
> > Hi all,
> >
> > After merging the drm-misc tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c: In function 'gp100_vmm_fault_cancel':
> > drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c:491:6: error: unused variable 'inst' [-Werror=unused-variable]
> >   491 |  u32 inst, aper;
> >       |      ^~~~
> > cc1: all warnings being treated as errors
> >
> > Caused by commit
> >
> >   404046cf4805 ("drm/nouveau/mmu/gp100-: drop unneeded assignment in the if condition.")
> >
> > I have used the drm-misc tree from next-20211011 for today.
> >
> > --
> > Cheers,
> > Stephen Rothwell

