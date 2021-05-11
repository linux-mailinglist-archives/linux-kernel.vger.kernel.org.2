Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E3A37AF25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhEKTOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEKTOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:14:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A4AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 12:13:07 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l61-20020a0c84430000b02901a9a7e363edso16302792qva.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 12:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p5OF8uCnVHGhsJH/LB13/zRAsll4eW+Rnf3hqCAjaGs=;
        b=QGCnwNOfvwAHBlH2u/xTMVmWyzEi17mtrBYFHlBxWo/hJvrQ3gT69fp+5BHv7DhTwW
         oMT15L7Cb+z2UKDXuhYZOfBOb9sDRo+WHINPY/Az8vtSPUemEpnxW5Iymj8rQbQd8Ccd
         KhBTHIoKB4QVmEdDbq4YgrYJaWl2OZLSD0zy+yNfnmrBBMVZF71F+RDKK6LY/u17qQFX
         xGy7dXAf5+onoDSAH1Q+v+BY8tGoqM/F1RLWmJBrljss13uGAiVUxb3Fhn4pFpD9zS2c
         /W4ty0mfwt48QFOap46V50vwZqfFSrfF3H5tzlNdEZGtUGIdWzEbmq/x2ElnXj0yn4L0
         lZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p5OF8uCnVHGhsJH/LB13/zRAsll4eW+Rnf3hqCAjaGs=;
        b=YZVSn5yvayZyr2sHcfCEQ74mBdlslRJ0MCMjECkFfUIB2de442kRwzuSfjEyIohZpy
         fXhOU3n84VvDljny6/ejheG0x0rWF0ORfDl/wSQLZEjnoNVFIT7/ZltX7LuwD3fxbEcB
         36sjapqE9B1W5rVFudNn7Xh66YqGUCkQ9ibUjdG8xX80MAFmPEDiEhKHv6ijI61vlqCQ
         hfBh2kEeTdK+JDcKJerdGUQlVazgdy0zz4ngY9Hp5GGuHzSW6wICyfafoqw4AHrXj2eJ
         5xxX4Ld5wTOacyZJk9Pm6lztyU/Vd2sYilfLmBZLK003OqtaGKuCYuC4m9oeww9C6ccA
         uOWA==
X-Gm-Message-State: AOAM532brZhpNiYKw/PNTGMX7JYMVRJ5mVWpnR2hFq55tS8y6DR1/8u8
        M5r4qWkIJw90MLnROikzECXuQ1wWZ61Uf3o=
X-Google-Smtp-Source: ABdhPJwg7uMX+NWke5KhkxiXSzGh9CILFYm94jMx+Qr+MSyD42OBNjsGV3LXlQqaLV6aPqHqshLXb7ZyOmgItXQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:24c0:6742:b823:eafe])
 (user=saravanak job=sendgmr) by 2002:a0c:df08:: with SMTP id
 g8mr31455206qvl.12.1620760386837; Tue, 11 May 2021 12:13:06 -0700 (PDT)
Date:   Tue, 11 May 2021 12:12:58 -0700
In-Reply-To: <CAE-0n53AcL807G3WLp7phQUNN6umuwUikiz_5bNfcHdRbThu=Q@mail.gmail.com>
Message-Id: <20210511191259.1139635-1-saravanak@google.com>
Mime-Version: 1.0
References: <CAE-0n53AcL807G3WLp7phQUNN6umuwUikiz_5bNfcHdRbThu=Q@mail.gmail.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: Re: [PATCH] component: Move host device to end of device lists on binding
From:   Saravana Kannan <saravanak@google.com>
To:     swboyd@chromium.org
Cc:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, rmk+kernel@arm.linux.org.uk,
        robdclark@gmail.com, Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd <swboyd@chromium.org>:
> Quoting Daniel Vetter (2021-05-11 06:39:36)
> > On Tue, May 11, 2021 at 12:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, May 10, 2021 at 9:08 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > [cut]
> > >
> > > >
> > > > >
> > > > > > I will try it, but then I wonder about things like system wide
> > > > > > suspend/resume too. The drm encoder chain would need to reimplement the
> > > > > > logic for system wide suspend/resume so that any PM ops attached to the
> > > > > > msm device run in the correct order. Right now the bridge PM ops will
> > > > > > run, the i2c bus PM ops will run, and then the msm PM ops will run.
> > > > > > After this change, the msm PM ops will run, the bridge PM ops will run,
> > > > > > and then the i2c bus PM ops will run. It feels like that could be a
> > > > > > problem if we're suspending the DSI encoder while the bridge is still
> > > > > > active.
> > > > >
> > > > > Yup suspend/resume has the exact same problem as shutdown.
> > > >
> > > > I think suspend/resume has the exact opposite problem. At least I think
> > > > the correct order is to suspend the bridge, then the encoder, i.e. DSI,
> > > > like is happening today. It looks like drm_atomic_helper_shutdown()
> > > > operates from the top down when we want bottom up? I admit I have no
> > > > idea what is supposed to happen here.
> > >
> > > Why would the system-wide suspend ordering be different from the
> > > shutdown ordering?
> >
> > At least my point was that both shutdown and suspend/resume have the
> > same problem, and the righ fix is (I think at least) to add these
> > hooks to the component.c aggregate ops structure. Hence just adding
> > new callbacks for shutdown will be an incomplete solution.
> 
> To add proper hooks to component.c we'll need to make the aggregate
> device into a 'struct device' and make a bus for them that essentially
> adds the aggregate device to the bus once all the components are
> registered. The bind/unbind can be ported to probe/remove, and then the
> aggregate driver can get PM ops that run before the component devices
> run their PM ops.
> 
> Let me go try it out and see if I can make it minimally invasive so that
> the migration path is simple.

Yes, please! This is the right solution. We should put all these aggregate
devices in some "aggregate" bus (needs a better name) and NOT a drm bus because
AFAICT components are not specific to the drm framework.

You can also create device links (without the STATELESS flag, and a bunch of
other flags) from the aggregate device to all the component devices and this
will automatically fix all the ordering issues too.

I'd be happy to help with this if you want and happy to review this too. Please
Cc me when you send out this series.

-Saravana

> 
> >
> > I don't feel like changing the global device order is the right
> > approach, since essentially that's what component was meant to fix.
> > Except it's incomplete since it only provides a solution for
> > bind/unbind and not for shutdown or suspend/resume as other global
> > state changes. I think some drivers "fixed" this by putting stuff like
> > drm_atomic_helper_shutdown/suspend/resume into early/late hooks, to
> > make sure that everything is ready with that trick. But that doesn't
> > compose very well :-/
> 
> Yeah it looks like msm is using prepare/complete for this so that it can
> jump in early and suspend the display pipeline before the components
> suspend themselves. The shutdown path only has one callback so we can't
> play the same games.
