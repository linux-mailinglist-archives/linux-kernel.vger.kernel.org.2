Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D604337FA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhEMPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhEMPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:03:26 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C1DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 08:02:15 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id o202-20020a4a2cd30000b02901fcaada0306so5712113ooo.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jiYyfGon+l+dlMJ6kapOd+In1t5dSTiN7MQBF/Q/Es=;
        b=j30501PewlzcvcuQ4+8CqsWaMTS4JQ0lqMxYvK8rfcLbJEYtYIdIB1VD+EOmozA3Lh
         dPQ+IitmoW7fTYLvMf7jNrpt8gHvZRQZG/HuOsP1/aNI3dWJQOJ41+dk5i5m1M/423tK
         AoDRNcKCAPMaS2hIk3PsY+45IFW4k4I27XpU7BTsQmanXVZTxjBA6IX/hMftMhdvhUJH
         hehJIjIRAuVbSGJAc7SbogLAeC7DoW1YVNgHFFZGt79MAaOpZsvz2TJrXrSzPRoV8b0c
         cQR1SxkJhVOJAPhWBUjl74hlcbmhpRi8jlZge1WgV+9B7xHf79Sgv9CQiG+rMfdSoY2K
         XWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jiYyfGon+l+dlMJ6kapOd+In1t5dSTiN7MQBF/Q/Es=;
        b=kxAqlOWTVHU+u1ql5WLb2KvEeR+M3cNgqpiAGWQtqAd41qYenS/u7EUiHdkejPtPQp
         6+l7nC0ooAChSYrUb97ZZfJDcFqIYQ3/667Sm7PAnWBEiqFBR2EpuNSGLmKlLLraPYGq
         hZKKsigLWY7aKrakqB5Q+UYIbPhc2wMIOgd2Cbnco1SZSqQQmIGQP8Nr4zvFkBChrjTN
         oAs7RbmuqQsLSW7njx6TFM+hIS0wldy2FBsmIQg+/+m7TsnQfw/98vADEcoy66NHhlms
         qf+ALQIygFAD3tXz/DzqH/YdWliU0KG7JXwLMD1qcK4nVGXblal7h5Cwr4XKjbH7c2uO
         oUpg==
X-Gm-Message-State: AOAM5315hPluw/HuF7GStNTAI1I83UXEA4BSar0n2zIyDQ/i0WjhW4ey
        g3M/HbfFyafe6Cpm5Kax+0GFA26jx9zxfA9AAtQ=
X-Google-Smtp-Source: ABdhPJyLU0gR/kFQy8ahgNakokKjbP/wNRGj4ycisfi1FD3EebVM6PxVZFr23Qi3Yjm5fku9f9SUlVO0d3fbRkcejw8=
X-Received: by 2002:a4a:d543:: with SMTP id q3mr32537508oos.72.1620918133701;
 Thu, 13 May 2021 08:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210512013058.6827-1-mukul.joshi@amd.com> <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic> <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic> <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
 <YJ04D8a6LaVRMuGH@zn.tnic> <CADnq5_NQonmqtFDpfsWygGzA2kv-W-daDSkxkY2ALf9a1eby9g@mail.gmail.com>
 <YJ0+YbwSpxTrghpo@zn.tnic>
In-Reply-To: <YJ0+YbwSpxTrghpo@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 13 May 2021 11:02:02 -0400
Message-ID: <CADnq5_PibVG4JRwtpX7at-dz6eT=XP8=pdy6a+4kCumdPxooeg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Joshi, Mukul" <Mukul.Joshi@amd.com>, x86-ml <x86@kernel.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 10:57 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, May 13, 2021 at 10:32:45AM -0400, Alex Deucher wrote:
> > Right.  The sys admin can query the bad page count and decide when to
> > retire the card.
>
> Yap, although the driver should actively "tell" the sysadmin when some
> critical counts of retired VRAM pages are reached because I doubt all
> admins would go look at those counts on their own.

I think we print something in the log as well when we hit the
threshold.  I need to double check the code.

>
> Btw, you say "admin" - am I to understand that those are some high end
> GPU cards with ECC memory? If consumer grade stuff has this too, then
> the driver should very much warn on such levels on its own because
> normal users won't know what and where to look.
>

Currently it's only available on workstation and datacenter boards.

> Other than that, the big picture sounds good to me.

Thanks!

Alex

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
