Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9023F9A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245232AbhH0NmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhH0NmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:42:00 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BCCC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:41:11 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b200so8495593iof.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRD4HlKjeh59U2jdj/1xZGzYvYP9GrHQzdzoFY2mXsE=;
        b=A3CLO3YLxOrIbWyb60vFVY5nAOD1S0K91vtAH/tBZ4UYIiHTZRqbcQgbAmAKGoFWZG
         /An+oLCueW3IB4z0IrB/QaY7e7UAy6yx/3ssKU2Fizyj8m3ON5iHiQdnPtFOdWIfbppK
         htDep1pS9eTK5c/+T4ej18dgPpkJdWRLS7CDD+AYn/3lTkdeMmkXc/JVCOHk4JbjewSB
         7ODK1H8TgKOJHE43uB6BZMUYcWbNF+mh85ri3uzgabTB6VO8QWQQ0VKiyKnCnzQaPYaG
         V721Nv3zbGyMXlF73M/iHnaT+0Vgd7wPdlX0CnBctqfefPKau+ocjYQUJu/xbdfhj4b2
         OZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRD4HlKjeh59U2jdj/1xZGzYvYP9GrHQzdzoFY2mXsE=;
        b=H75lm9vCDYvPaE1dHfcgMhGxryrYeWPHkcy8fIGkY05l0Ejzqyd49WSk7SmqTqxSG8
         AyRJwn+bcmmc12cZC3CHmyYSZlvKn9i/ckZ4MfigfawmD3xZUnbfN4hJunt7L1DUDC23
         BjCVFCQKbXJcVh+1rkg3uKi0FuSP+ukyJ2AXxmljFqgH4CoWAGnlsmP8jEa9XsRbYM/I
         QAmcCchQobce0+/BiC2Ko4XJv6ra84fEDbbnNhlP+aBetL0a6YEY1y4oOQUOeTMLSo/S
         m00MSd6zQbf/nHKCGsxcoqb+VHYGKeKw2T9dIsqJ+Cl75zyhaKRsOmqxBSSQesjJv/ig
         Yaog==
X-Gm-Message-State: AOAM530cWQO+bANIHYikgGGMPfEDAtzVleEfv46J6s+h/9eAW+gznqif
        EaBky9hh9XG5ob3I9QRvuIhABbJioSZ6tgCh9b57XA==
X-Google-Smtp-Source: ABdhPJzIbvsM9MZ1LrgsCvSCxH3OR626mdzjzjXmbVOemDc4miWf19ECt6QpYYBXweacC3uYNMgDR4fr6rdbIFSi2wY=
X-Received: by 2002:a05:6638:35aa:: with SMTP id v42mr8350640jal.5.1630071670391;
 Fri, 27 Aug 2021 06:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210827082407.101053-1-yangcong5@huaqin.corp-partner.google.com> <20210827082407.101053-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20210827082407.101053-2-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 27 Aug 2021 06:40:58 -0700
Message-ID: <CAD=FV=UaAFY4Q+q8JyYqnjSeun=HHnbUEzFSVj5DtHVBPPAtdw@mail.gmail.com>
Subject: Re: [v3 1/4] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 27, 2021 at 1:24 AM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The auo,b101uan08.3 panel (already supported by this driver) has
> a 3.3V rail that needs to be turned on. For previous users of
> this panel this voltage was directly output by pmic. On a new
> user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
> to turn the 3.3V rail on. Add support in the driver for this.
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

There were no differences between this and the previous version [1]. I
added my Reviewed-by tag on the previous version, so you should have
included it in this new version.

[1] https://lore.kernel.org/r/20210820070113.45191-2-yangcong5@huaqin.corp-partner.google.com

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
