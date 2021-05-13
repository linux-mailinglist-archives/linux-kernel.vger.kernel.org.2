Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2000237F9B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhEMOeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEMOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:34:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4998CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:32:57 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u16so25511974oiu.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEuGTZXx01IWdu5muG47EcBsb9Sbqb79hygStbbAehs=;
        b=KPnuGGuE+Lpm1YyJQWCY19i3aU56Cw/eDYdeXlMBeIa6WJKgJBkc2P+t2my7QZ6+ey
         gtnaz/9jiqv0XBrb7ang/9nDFY4EYjBK0fZEKNVneCfzUgs36sO4IcoTWL+Rp6CzlxUB
         UJbtAmFjzJuVy34blDU7SqUt5gl5lWiQL1jJwDk946yq9waKTHh2CTA+D1hZIJQHmPX9
         Ym04jzn/EKOSHjTu8QYfB/+p5T6a9Ql64jvu8P1Bms9M7Cnrwan324k0fdpYDWwg61Eh
         D8cDm21gTmH4I9txbSKBaMqRAcVC1q13Xk6PypJkM1S6BarMqS7SPveX1oxNsi3hUUMC
         bAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEuGTZXx01IWdu5muG47EcBsb9Sbqb79hygStbbAehs=;
        b=sOtz1WmrQStIDBtxCt7z/CgK9wwp2fV8b5YqsaiZdCRBhZVNYYzjATjaJRVWXep0Rr
         XP+N0oAZpAShKYm098nSX849tABWZjVk4c0nGWUS7tyNuDpdiB48s+1VY0R3hd9XilSX
         vryB3MaLrTDKn1Z4NF56rnSBwUyduzIzXjWPcgAeOu0+jTYXjVL48rGXNHMxX68uG6lh
         TpcBVuQK5BJNERzCTc4kgiXOcUKCkaGpY7W0rTKON/aoZANoxVpqOz2vGfrV78jtmaRr
         oxrjEAJHXcmonnHv0Bk7ns+u+YToKd8S/tZTjgB67dKYJlFLrpxJK/aF3MIWgzQ7bEhB
         YWNg==
X-Gm-Message-State: AOAM5312Vh20/dYag/Z1qo+M1qZ1fYvQP/eoIoNrbqqTZEqGYmy64GFW
        DSb+H9omwXxMGerKEtZXvFBxaNcp0sJZfeDI+RQ=
X-Google-Smtp-Source: ABdhPJzU1//9leZjuMF7o12hQw9Wcnj0phspDotWiYdLUlVGeVMkWdmQwYRDa7eXWzHluTRABN7IjfOMTKW35K7Pjxw=
X-Received: by 2002:a05:6808:68a:: with SMTP id k10mr30053815oig.120.1620916376680;
 Thu, 13 May 2021 07:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210512013058.6827-1-mukul.joshi@amd.com> <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic> <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic> <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
 <YJ04D8a6LaVRMuGH@zn.tnic>
In-Reply-To: <YJ04D8a6LaVRMuGH@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 13 May 2021 10:32:45 -0400
Message-ID: <CADnq5_NQonmqtFDpfsWygGzA2kv-W-daDSkxkY2ALf9a1eby9g@mail.gmail.com>
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

On Thu, May 13, 2021 at 10:30 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, May 13, 2021 at 10:17:47AM -0400, Alex Deucher wrote:
> > The bad pages are stored in an EEPROM on the board and the next time
> > the driver loads it reads the EEPROM so that it can reserve the bad
> > pages at init time so they don't get used again.
>
> And that works automagically on the next boot? Because that sounds like
> the right thing to do.

Yes, or driver reload, suspend/resume, etc.

>
> So practically, what happens to a GPU in such a case where the VRAM
> starts going bad? It might get exhausted eventually and the driver will
> say something along the lines of:
>
>   "VRAM bad pages: 80%, consider replacing the GPU. It is operating
>   currently with degrated performance."
>
> or so?

Right.  The sys admin can query the bad page count and decide when to
retire the card.

>
> Yap, from a RAS perspective, that makes good sense as you're prolonging
> the life of the component while still remains operational as good as it
> can and the only user interaction you need is she/he replacing it.
>
> Sounds good.

Yes.  That's the idea.

Alex


>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
