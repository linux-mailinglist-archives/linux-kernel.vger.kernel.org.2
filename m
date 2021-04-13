Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F635E5B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhDMRz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:55:27 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:46651 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhDMRzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:55:23 -0400
Received: by mail-pg1-f173.google.com with SMTP id t140so12469166pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4PyFE0Z63r4dwfjFWUfn+ZwYI5WhtCq0wza5SYUhT0=;
        b=kFidD4BqxO16i5NDjlMk21z4/+O58HvveY9D/z9HTJtgK5j29TK/u2FQq8biPbYrVC
         n4SQncXF96eXqonDFNOcG8RSZ1Mx/9hASAu1rXmQBB6CrLADOaoI2eBexHQBc4qnPij0
         hkqOoqSua0sAvrdiTzwCxS95gNecLFS3dp/xqp+0cA+ZWRxeEkrTk5PEh34sugAJeHu9
         ZwfOtOb2yWDQ1wJ1yvlPq7IvQpLzrdEP5rJRyYJLs7zaFKo3r7ZZ/9M11ZoSYvswv/sy
         8ml4FEQ4UAvrQ3wK0D7aSv6oNMiBbD5HaPYSwVjnUDraCTXcwUWu7qBUC7TT1EbGwGvV
         adzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4PyFE0Z63r4dwfjFWUfn+ZwYI5WhtCq0wza5SYUhT0=;
        b=uUGN5vyhQjogArqFkH7PhSOoEdW0SEcbruk4et3EkMktv7Lj2yG79A6LbHpDWneVZu
         LBqZY+oQTDYvPmWWwPRy38isGLeXNAMcp5h7yGCF+aitvaSrgXkv+NQTZbRs8z8kwPri
         USsPWfwQJmYocyzGTXQIrHRhpplx3ej+MhWuahkgyi2pqeMFmDtIy9q9tKAPcMZx6SY/
         TJEWsC63GPjLYvBnvYniO4s7WZUcsubItQrkMFQit99YnXE53sg7SXJOqmyy/hpzO1WK
         rVk8VyOTTFd9jaqDqPF0ak5TtqL6lD/TZ87BIq/5A1Ps4l47BKQ97l1l/wzzIhR7h5fY
         /Afw==
X-Gm-Message-State: AOAM532T0Kn21IjSnSVYqo85/SxC+5vHCEqrrvmUo9Cc9x1bfWLFqYvc
        YWwFAPF8W31vzS5FPRqeN9U/srNrfQ3/l44w9w17eA==
X-Google-Smtp-Source: ABdhPJxnIrnRes9OE/FCfsKMv3Tut65YdVv51sZZacX49GiILt4E8sd5eUm7EHV6B623gCj+pFr1rLZMC2J1IN2utb4=
X-Received: by 2002:a63:7708:: with SMTP id s8mr33748780pgc.265.1618336443222;
 Tue, 13 Apr 2021 10:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210412154648.3719153-1-narmstrong@baylibre.com>
 <20210412154648.3719153-4-narmstrong@baylibre.com> <bb9196e3-e2d0-e44b-0cf1-cb469ea2edd7@baylibre.com>
In-Reply-To: <bb9196e3-e2d0-e44b-0cf1-cb469ea2edd7@baylibre.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 13 Apr 2021 19:53:52 +0200
Message-ID: <CAG3jFysHBhj-mj_WAmHNaTDdmzkF2UwTmWc8Xnzb1zdcFFYN7A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add it66121 HDMI bridge driver entry
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        paul@crapouillou.net, Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phong LE <ple@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 at 17:47, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 12/04/2021 17:46, Neil Armstrong wrote:
> > From: Phong LE <ple@baylibre.com>
> >
> > Add Neil Armstrong and myself as maintainers
> >
> > Signed-off-by: Phong LE <ple@baylibre.com>
>
> Obviously:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9ae8444c96b4..ff6450c83049 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9515,6 +9515,14 @@ Q:     http://patchwork.linuxtv.org/project/linux-media/list/
> >  T:   git git://linuxtv.org/anttip/media_tree.git
> >  F:   drivers/media/tuners/it913x*
> >
> > +ITE IT66121 HDMI BRIDGE DRIVER
> > +M:   Phong LE <ple@baylibre.com>
> > +M:   Neil Armstrong <narmstrong@baylibre.com>
> > +S:   Maintained
> > +F:   drivers/gpu/drm/bridge/ite-it66121.c
> > +T:   git git://anongit.freedesktop.org/drm/drm-misc

I'm getting a checkpatch --strict warning here. The two above lines
should switch places.

WARNING: Misordered MAINTAINERS entry - list 'T:' before 'F:'
#27: FILE: MAINTAINERS:9537:
+F:    drivers/gpu/drm/bridge/ite-it66121.c
+T:    git git://anongit.freedesktop.org/drm/drm-misc


With this warning silenced, feel free to add my r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

> > +F:   Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> > +
> >  IVTV VIDEO4LINUX DRIVER
> >  M:   Andy Walls <awalls@md.metrocast.net>
> >  L:   linux-media@vger.kernel.org
> >
>
