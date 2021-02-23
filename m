Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A2D323065
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhBWSPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:15:11 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:46391 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbhBWSO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:14:56 -0500
Received: by mail-il1-f169.google.com with SMTP id i18so2171004ilq.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 10:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBD19TtNuqKmtZTJ8bFpz+xLfryH6M8evU2W8orJimw=;
        b=AxpqRPgiZpLeJpudauMu58fFjZbDKykbw4VK9oUSdygJSoYAxFwMiZ1DcSuQEnj/e4
         2PqKN0oL1pVnuuLLrlkZLZOqqM0FvWc7LYWM8yap3YlEiRq5S1d9ZoBd23GN6dNNAhCF
         J+tqggI4qM48JrwXq4rKDpfJk6d7CFks5dy+PzTNEZ8g3Xrf6ZqMqRvgzxCcpdLnJg/y
         Vi2gASwWjJjxVfVeN9pzYU1XucMx5Z3aqPQ4gVi//g5472DlOU0XjYdydQsnnxsQUZ4p
         6tD25svBVl4Mnybty7/a4v4ZRi3NgFzqmQUFeIfrSskaI3XQFmCl5uokRFQA2wa1YP89
         Yx7g==
X-Gm-Message-State: AOAM531CWBsjNdgCxNtEG5TwXG3LB9h4povy4vsSfzzGmSEAR+lgLtj7
        Vf0zWoS2ACqlfWqv8OSUZcU7piZRr3X6DhgoQUQ=
X-Google-Smtp-Source: ABdhPJxx/TZSCisENcO5Uxe7yUnXfib+nh/4u/AobThe/PiT92Zy413z/FV3yJKDnruuyr4rRyoAcPmxOiybsL3TF6Q=
X-Received: by 2002:a05:6e02:1848:: with SMTP id b8mr20333140ilv.210.1614104050299;
 Tue, 23 Feb 2021 10:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20210119015415.2511028-1-lyude@redhat.com> <20210119015415.2511028-2-lyude@redhat.com>
 <YDUN+Re/alMVL0Zn@pflmari> <CAKb7UvhFkw23so-a4JKLzpQLhphzjzarOy-9h+FiKP-aAC=4xw@mail.gmail.com>
 <YDUg/9fjsvTkRUqr@pflmari> <CAKb7Uvji_+N+b8HghZckU-uSBWn-=BZwNAiUff2oitbVuNUE2Q@mail.gmail.com>
 <YDUkfjDA4xLJlxE5@pflmari> <YDUr2OGDsxDyC0l2@pflmari>
In-Reply-To: <YDUr2OGDsxDyC0l2@pflmari>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 23 Feb 2021 13:13:59 -0500
Message-ID: <CAKb7UvjmdgS536tNzisomi_oXOGk3Q+anp0AfPvA8OruU_9m5Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/nouveau/kms/nv50-: Report max cursor size to userspace
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        James Jones <jajones@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jeremy Cline <jcline@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:23 AM Alex Riesen
<alexander.riesen@cetitec.com> wrote:
>
> Alex Riesen, Tue, Feb 23, 2021 16:51:26 +0100:
> > Ilia Mirkin, Tue, Feb 23, 2021 16:46:52 +0100:
> > > I'd recommend using xf86-video-nouveau in any case, but some distros
> >
> > I would like try this out. Do you know how to force the xorg server to
> > choose this driver instead of modesetting?
>
> Found that myself (a Device section with Driver set to "nouveau"):
>
>     $ xrandr  --listproviders
>     Providers: number : 1
>     Provider 0: id: 0x68 cap: 0x7, Source Output, Sink Output, Source Offload crtcs: 4 outputs: 5 associated providers: 0 name:nouveau
>
> And yes, the cursor looks good in v5.11 even without reverting the commit.

FWIW it's not immediately apparent to me what grave error modesetting
is committing in setting the cursor. The logic looks perfectly
reasonable. It's not trying to be fancy with rendering the cursor/etc.

The one thing is that it's using drmModeSetCursor2 which sets the
hotspot at the same time. But internally inside nouveau I think it
should work out to the same thing. Perhaps setting the hotspot, or
something in that path, doesn't quite work for 256x256? [Again, no
clue what that might be.]

It might also be worthwhile just testing if the 256x256 cursor works
quite the way one would want. If you're interested, grab libdrm,
there's a test called 'modetest', which has an option to enable a
moving cursor (-c iirc). It's hard-coded to 64x64, so you'll have to
modify it there too (and probably change the pattern from plain gray
to any one of the other ones).

Cheers,

  -ilia
