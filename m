Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693383F9B16
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhH0OrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhH0OrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:47:00 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB548C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 07:46:11 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id x5so7255710ill.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzOUQOR04WNA4/YVeKBqMlLPAY17QH2nosfTS9IvUQM=;
        b=tZDh69nDdVY5p7wRtH8bR1I7nA5Lti7qTlnAa+w2NJMyRCyNUDyujRpwCrdFBwcM9c
         wOkBjm2SZoBOXeA75VW9eEXPBO6RHPJvykSOIAfv1w3a+ad7jPs7uYOiNSuusNIlumh6
         nSsyDYW3SbZjy88g9okTipYz0IjSQXXJpb/+3Iyz0KTpIxP3RIK7YtTn/G5e2UkTckvB
         qey7hclft0SQShoNbO3yj8qYz8OJrSDRy8XJpTwREgJbKNKOWpsPbrc1br7t5+2SRnix
         bjTxpNKKuDAp8QH8C+hV3mWtFPjPa32fe/lhHP8ffNAOiGfPv6FaFus9FhAcWPK/Qh83
         QsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzOUQOR04WNA4/YVeKBqMlLPAY17QH2nosfTS9IvUQM=;
        b=JVRUKZaLd4aIrMmeqPgTxwVRCO/Sppccz82326/vfMOfjrZfnjWXP9o72xQOBVMJaM
         L41mHwdbwVstOi7bgd1VFwhD1X2mSw+wuMsKSW4cY6gnAnEt5wf7h8lR7ph2Cid0ZgqK
         kuIPB55DiTvn+JXjI61Rwi50dgmvGoisQTSbV429Sa3o+ATK185+Hbi+5VLo9n4xYTHP
         hWP6U8GILvoDjFpud/QYX9D4ZHVWXSlYXvvqLh3MFG4AYwRXj6ESGjNS+wm5kQPWJk2N
         A5r/OS2nHAlgVUkXfsj5TtwrUWYbsZoG12/ftUSn9cntyEEoZDLrAskEIaSelBpk0eAl
         2NUg==
X-Gm-Message-State: AOAM531B/wdqNOh98eSHTtLYtJp4AUP7DK4kApL2bgv2sVJNHNxhF0W3
        N/H516swbUSruwbMS8YQFG10mI/sJP7FDrMyFM8e+g==
X-Google-Smtp-Source: ABdhPJx90jiXR/+Kuna9VvwisR0DddZo5lVJ7fj2PG+cx5IfLN0T4GMa1sjlVy8FyIiIF7WR0UGBSnO1/nHgexAlrhc=
X-Received: by 2002:a92:a008:: with SMTP id e8mr6603471ili.187.1630075571040;
 Fri, 27 Aug 2021 07:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210827082407.101053-1-yangcong5@huaqin.corp-partner.google.com> <20210827082407.101053-5-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20210827082407.101053-5-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 27 Aug 2021 07:45:58 -0700
Message-ID: <CAD=FV=URvNk1rBpRaRKTjGS+0u8PePd7reY9ix6cT272_MZcjA@mail.gmail.com>
Subject: Re: [v3 4/4] dt-bindngs: display: panel: Add BOE and INX panel bindings
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
> Add documentation for boe tv110c9m-ll3, inx hj110iz-01a panel.
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml   | 4 ++++
>  1 file changed, 4 insertions(+)

Lumping these new panels in like this seems to be what Sam was
suggesting [1] and it seems fine to me. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/YSPAseE6WD8dDRuz@ravnborg.org/

Note: please make sure to carry forward Reviewed-by tags to the v4
version of this patch series unless something substantially changes
about a patch.
