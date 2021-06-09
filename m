Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA23A08D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhFIA6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:58:49 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36705 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbhFIA6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:58:45 -0400
Received: by mail-wm1-f44.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so2666397wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qeiNnEqHnToVwTF+YALaJhts33Y3hAzDOiNFEpUNqM=;
        b=nqsl5TFA6nFViy1WhnYLZii0d/gfdyqbxMgo5ZeCK+zscVoklu4FygICY98Ui//B6f
         nCqThTZMMhYiHD4SThREyZrFCg+F9BfwGkG4DqwOzwpjwwl7ICQYAkZ/P3DlUE32eBtl
         npsM7xAJQBoLFsBLrlmr81kRgV5HvHjICWZSA/fZgQBWkdDx/2nHjZU1GQ/Lj6p2IV98
         FmmigXGK7Z0E94aqQpyP2g921KQ/vi1edhJoiU6MSqBsPr9zsKXC8FFKOo4R32sUVPuB
         WWLLPhyl/pILiWvSG9BUxQf+Jkkb0QIyP35vDEmcfqloSOejvDWhu0tJnTMgBQOcc/sy
         Ovww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qeiNnEqHnToVwTF+YALaJhts33Y3hAzDOiNFEpUNqM=;
        b=g1AJT3DXzj9ZqXqcwwmvhlLKCw+VRmfoWO3NwKCLqO/pW3Loq5/EiVSQZpksOK5/51
         WzbAN0qr57piOwf7OXyQn8aoAKqqRnEIY7bolsJIc6OPIHVSbjaiXOTPn3N5oRfhmHNQ
         xGSjSZJn9ISBbsmI3a3SBFe3Kr3t9h0OAf47ZUQsYrNEqgGwvlISvSVN5S1868X+iSr5
         UXacQpgFbQS8mBIFA89FPudBkldZeZ5HL2ZBqMYFdjcus2ZRNXiGdrML8Uwx1pGYKz0G
         m/ooC2yzVRJJwMMPEJeY8fDgro7FdlCxqq0mklfztEhgbEv2eu4kThBMsFZEnumv2mj1
         jHcQ==
X-Gm-Message-State: AOAM5301ejOr77o+vv/rOdwZbJSkaWkd9Uxa/eGjEM2FU/dRb+9eGruZ
        9ZmgFBBoVxQBwbNfsnTA3o58OsqxqtmC7LeL4jXSRQ==
X-Google-Smtp-Source: ABdhPJwGRvjqPAaMqbRNcEgccpnUGqtyTTgun+Da0x1HGhPQzUmbKr8INifXJjdvTGBCDxpQ3rvZx1RAIbgdMxBGVss=
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr25640495wmi.2.1623200151418;
 Tue, 08 Jun 2021 17:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210608143159.1.I230026301243fbcee23d408c75aa468c1fec58f7@changeid>
 <e599ffb5-da5c-e4bb-a7d6-c2208a48868d@amd.com>
In-Reply-To: <e599ffb5-da5c-e4bb-a7d6-c2208a48868d@amd.com>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Wed, 9 Jun 2021 10:55:38 +1000
Message-ID: <CAATStaPcjYAoMdUVj_G3p_OQuw_faQY0PGiXeo3unPFd=WN2vA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix error code on failure to set brightness
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eryk Brol <eryk.brol@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Thanks for your patch but this code has changed on amd-staging-drm-next.
>
> Can you try with the latest? The new backlight_update_status will always
> return 0 now.

Perfect! This solves my actual issue which is that restoring the
backlight level is failing on my device. Thank you.


-- 
Anand K. Mistry
Software Engineer
Google Australia
