Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDBF32D153
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbhCDK7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbhCDK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:59:42 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0189C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 02:59:01 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id e7so42495311lft.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 02:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vj7crQv0RBsiX1DUBa7jbsdhS16ZuGDUR9megRQZGoM=;
        b=w2oE41WXVFCbvUlqrjhtMX4NdYb/PFCtelM1C2k7uR2Udy/zt8bsV0rHcfy+kIcU2G
         lB43OWqmPv8KG9C/LljFhZ/C5RMEkY5VRlmp0fwLSwkVdN5B/hMs/KMaKuKMIKjWWpQi
         OF3FwBZ+0gxJf7V96KnH7t5iKJ21mtWYrNwJK6v0cgg85MpcLcjH2rURuZdP9NxameRf
         QrktBeg7pGgG9zXwGwWF4T87imCTpca+Zqn2DEneBXwPCfONiEiNQL+jkdvpTonIjQPF
         IieTtVeBdUK+5VLNLLqFiYgFq/99KXtnFlOUNSv1O0mEBztHtGyREGI1uTbvQgecgP6i
         AzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vj7crQv0RBsiX1DUBa7jbsdhS16ZuGDUR9megRQZGoM=;
        b=Cj5evq5WNdw0zuahT78TbbNLg2dVYHUQGY3cTTWkKXCut0C6iKaAxF/hGtiI1cvn51
         79reaYpsc4qiYqCPas0yUaGRTqAscdiJMxDxMReOXcz+bdEN6GVEeAtXqdyBRso6TLDV
         Crr1PHkzBvMF7X0gtqrMylcdnuPbE6VVB+m988u9TwHWog8INVeqVyno+kgEEcz7hqay
         dC7dqiRLx9PM0Ai3gy0uVbAytRrzGcXxz/tz5lG7ZL5va/7YoDih45ZaiKCWH/sZ2IO7
         Wixgca4S9weV6aa4CCFLUL7rlab2OBmRhhQ0uBeixZD/pt7Lct8bknmTjrjHfll3ICtG
         0rZQ==
X-Gm-Message-State: AOAM532hzegmKHBqupLisl2iWpCvVWjaLw7MAPnarNTF5xeOq0XrDcWZ
        WZpZ7A8fYw782WmDBiyFbdRtrB6kZlnw1gjBmBS42A==
X-Google-Smtp-Source: ABdhPJyWqGiUuxPFvOFcxzQxzI3A6i2dpoPZD0hl0hSbpORcm/OPWK5ClqUWDBuKcL9Nqu78hAv989j0+dqYxoh+9JU=
X-Received: by 2002:ac2:46db:: with SMTP id p27mr1953927lfo.396.1614855540297;
 Thu, 04 Mar 2021 02:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20210224070827.408771-1-sumit.garg@linaro.org> <CAD=FV=XQAWoAQ1kkyJ1QzhJgueCj0Lui1m5cxgPQXzThxm1SGw@mail.gmail.com>
In-Reply-To: <CAD=FV=XQAWoAQ1kkyJ1QzhJgueCj0Lui1m5cxgPQXzThxm1SGw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 4 Mar 2021 16:28:49 +0530
Message-ID: <CAFA6WYPBka8B7WSD_v_UAHgRzDnK3V-OY91-M6SNKi=PpuK4Og@mail.gmail.com>
Subject: Re: [PATCH v5] kdb: Simplify kdb commands registration
To:     Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Tue, 2 Mar 2021 at 00:10, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Feb 23, 2021 at 11:08 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Simplify kdb commands registration via using linked list instead of
> > static array for commands storage.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Changes in v5:
> > - Introduce new method: kdb_register_table() to register static kdb
> >   main and breakpoint command tables instead of using statically
> >   allocated commands.
> >
> > Changes in v4:
> > - Fix kdb commands memory allocation issue prior to slab being available
> >   with an array of statically allocated commands. Now it works fine with
> >   kgdbwait.
> > - Fix a misc checkpatch warning.
> > - I have dropped Doug's review tag as I think this version includes a
> >   major fix that should be reviewed again.
> >
> > Changes in v3:
> > - Remove redundant "if" check.
> > - Pick up review tag from Doug.
> >
> > Changes in v2:
> > - Remove redundant NULL check for "cmd_name".
> > - Incorporate misc. comment.
> >
> >  kernel/debug/kdb/kdb_bp.c      |  81 ++++--
> >  kernel/debug/kdb/kdb_main.c    | 472 ++++++++++++++++++++-------------
> >  kernel/debug/kdb/kdb_private.h |   3 +
> >  3 files changed, 343 insertions(+), 213 deletions(-)
>
> This looks good to me, thanks!
>
> Random notes:
>
> * We no longer check for "duplicate" commands for any of these
> statically allocated ones, but I guess that's fine.

Yeah, I think that check is redundant for static ones.

>
> * Presumably nothing outside of kdb/kgdb itself needs the ability to
> allocate commands statically.  The only user I see now is ftrace and
> it looks like it runs late enough that it should be fine.

Agree.

>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>

Thanks,
-Sumit

>
> -Doug
