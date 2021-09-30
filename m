Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440E541E075
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352956AbhI3SBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352908AbhI3SBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:01:48 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94F9C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:00:05 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id e24so8331290oig.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fw8pwH1OA13DiwW71Gp8zTFcOzlqtHtiksx8vBnSuZo=;
        b=m5+pnYPhp5Mbbl/i9v8Rayru7Xk0LHfsYZ/3ARwECIFS8Pg8nv5paLDPvYkwyh4Ca0
         arVdov2yDLqKrEtQAVe7Byn4CiqcTi2C0JwPArKj6xt/qkc65HNDbv4HSUHo1BqhTjPc
         dJdaY85okFWxMiOoGC5V6/loSkBmKHz8mYi/LACtdatdLYOB1mU5NHnLYXDlYmUbE7wJ
         PLbg0ZkPm+Ysz8O0c2kUx+pvWoWDVe3+WSgEKpw9nHMvoH2AmvHIn8NUt8C1uZf+4KTq
         hxPOTJ0Z0JDOrTp9TBwHkHbKXbwNaxX6R2HQgMghcbkMssONuWMb+Q58XNPQfoEcXHMA
         njIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fw8pwH1OA13DiwW71Gp8zTFcOzlqtHtiksx8vBnSuZo=;
        b=Nv8ydDZNXZQWD8qvW7jOQWxmM167idlga2hr/cTYRItyuIL9KkxhsMA/FGJPddacz7
         64SUE33YOxlujxEH/YXU4e+WgFxKV3sm6ug2QomoHzLVfytTeYugBppzrSSJanZjzbPR
         upCO6kpDyoNGLDmQQjhtcNWzXVuuiV1Yys5EH9xG007454d/tyowh7sViU6yOtRAVc4V
         qJzmz1QxU06MFIfGkoj8O/AsiNRMC3FSU/AucfOioIwMduGh3KSsKZeMqsYf8Fr2RV39
         qs9rMkHx0nHwpySBkDJISpa0UosZheCOQjNweVTKTH0CHCNUYgGx3oyOjJUOFIXpc0Uv
         LD6Q==
X-Gm-Message-State: AOAM531WOfoWrLpAujHobNuP5JSGNe8KI06o7JBrE0fq878G12lIZX63
        E/RlfbrfqqZ/qq7d80gVm+hnRR3p+9W2vqsSSkrf2F2O
X-Google-Smtp-Source: ABdhPJwXt1IhVLGQOfviPEsWczuXrnB2viox7TeVfyjdkXam/lIb60V/M9UNSLtcAmDLi1dT0ZBzUFXTJQRA5PgV35o=
X-Received: by 2002:a05:6808:1141:: with SMTP id u1mr440287oiu.123.1633024805243;
 Thu, 30 Sep 2021 11:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210930162302.2344542-1-nathan@kernel.org> <CADnq5_PBMGdUG8VMUQ2UOSdd9qXbZ7QoyGH2RTgUPnTjdzKqFA@mail.gmail.com>
 <CAKwvOdk56-7UQDs_EAn+WK397mnd5H7_JMrsjROPk5ZFCw2QLw@mail.gmail.com>
In-Reply-To: <CAKwvOdk56-7UQDs_EAn+WK397mnd5H7_JMrsjROPk5ZFCw2QLw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Sep 2021 13:59:54 -0400
Message-ID: <CADnq5_N=x-PFvU2oYtLLSHcos1G_K=2qhSE0+1LS=zuBNov0JQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Return NULL instead of false in dcn201_acquire_idle_pipe_for_layer()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 1:23 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Sep 30, 2021 at 10:10 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > Applied.  Thanks!
> >
> > Alex
> >
> > On Thu, Sep 30, 2021 at 12:23 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Clang warns:
>
> Any chance AMDGPU folks can look into adding clang to the CI roster?

We can look into it.  We may already be doing it for some groups.

Alex

> --
> Thanks,
> ~Nick Desaulniers
