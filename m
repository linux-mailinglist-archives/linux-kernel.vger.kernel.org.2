Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A0037A7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhEKNk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhEKNkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:40:55 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EF3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 06:39:48 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x15so5273703oic.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DiQlUoRS1KcIp4jb80Idacb5jWTO0UHM89k4RPNvhAM=;
        b=V0SPnP29kVRwVzyYu3yn381mPXr37L4GkNlTSpRf9Z1Lg+xnDbQdJV76vtPxr3dW8v
         G8wcNTNdk/tqvS8IWkyzfV/1AMa1opftnowZP2pvmspSIGvp1WMjZIONfBoapA12eCEl
         pif4tQNvizE6BFuH2BaDH4ht+YXXoHhWNA0fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DiQlUoRS1KcIp4jb80Idacb5jWTO0UHM89k4RPNvhAM=;
        b=ZqEK9DfkMNeH8nm8ijSGg160cq7kh5Y3NJCfiB4yD3dI+DxgQifp7nE9e2iaSJ/rKw
         k9f3rvHyXKNYSr9dl47JYAvBzpJWbH1aAV8w6oBayyvbb6az//ZJUSXWjwIqELYS1Jdm
         byzKDPoUT/sole4DophkDEHBw8rQhP2kt6gZYN9gAtNkCFvIbaHkmhxTz20Y+Hb7A2Qd
         LmO9/ua+UOguYFbFVhjh1+Z0bG1ZKgTfPBoAZ7VHKBTIVKQLQhJs+MchdfQKO+xYEwX9
         oQcoTexffLz2LqPm/ejYdmANSwQFmsc0iMYjCOd1AiyXv3uvxKKD0TTngE9GoGIXWHI6
         h/qQ==
X-Gm-Message-State: AOAM532ZuEKMPbj4YsL6StidchVk3Djrv3qS3VpsXlFExjz2PB6EfDYE
        e0HA7ogYgOBnXPHwr4jAFTl//jvXzDqLnmJGtRdQSA==
X-Google-Smtp-Source: ABdhPJypOemzDTmFObHTWqXEMZiMoy0D4neOiUWh21fpySuirlm4zFsGDyTRcXNm9CEqwqwnkS3yp1efP8vxyCLQf5s=
X-Received: by 2002:aca:df87:: with SMTP id w129mr22385363oig.128.1620740387581;
 Tue, 11 May 2021 06:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210508074118.1621729-1-swboyd@chromium.org> <YJlZwYS+oH7W5WjO@phenom.ffwll.local>
 <CAE-0n52S=LFRx93qVyWBpF5PmdCEbWH_+HnN0Do9W45kiJLCbQ@mail.gmail.com>
 <CAKMK7uE_yrXNdEYTf-snNU9dS+=6AKOmUxRuLSHLWBTOtVwpmg@mail.gmail.com>
 <CAE-0n50d8_OtZTpBGaz0uhj6AO823_kwHg9+SJK6ar=e+rGxFA@mail.gmail.com> <CAJZ5v0h42fTKueFxrB6fpc9YBVNyDsCBryAf_geS-=0+OQQqjg@mail.gmail.com>
In-Reply-To: <CAJZ5v0h42fTKueFxrB6fpc9YBVNyDsCBryAf_geS-=0+OQQqjg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 11 May 2021 15:39:36 +0200
Message-ID: <CAKMK7uHXon=k0AxF5fagz1_PW1WONppAZP1cbM72ujYN=pXn+A@mail.gmail.com>
Subject: Re: [PATCH] component: Move host device to end of device lists on binding
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 12:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, May 10, 2021 at 9:08 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> [cut]
>
> >
> > >
> > > > I will try it, but then I wonder about things like system wide
> > > > suspend/resume too. The drm encoder chain would need to reimplement the
> > > > logic for system wide suspend/resume so that any PM ops attached to the
> > > > msm device run in the correct order. Right now the bridge PM ops will
> > > > run, the i2c bus PM ops will run, and then the msm PM ops will run.
> > > > After this change, the msm PM ops will run, the bridge PM ops will run,
> > > > and then the i2c bus PM ops will run. It feels like that could be a
> > > > problem if we're suspending the DSI encoder while the bridge is still
> > > > active.
> > >
> > > Yup suspend/resume has the exact same problem as shutdown.
> >
> > I think suspend/resume has the exact opposite problem. At least I think
> > the correct order is to suspend the bridge, then the encoder, i.e. DSI,
> > like is happening today. It looks like drm_atomic_helper_shutdown()
> > operates from the top down when we want bottom up? I admit I have no
> > idea what is supposed to happen here.
>
> Why would the system-wide suspend ordering be different from the
> shutdown ordering?

At least my point was that both shutdown and suspend/resume have the
same problem, and the righ fix is (I think at least) to add these
hooks to the component.c aggregate ops structure. Hence just adding
new callbacks for shutdown will be an incomplete solution.

I don't feel like changing the global device order is the right
approach, since essentially that's what component was meant to fix.
Except it's incomplete since it only provides a solution for
bind/unbind and not for shutdown or suspend/resume as other global
state changes. I think some drivers "fixed" this by putting stuff like
drm_atomic_helper_shutdown/suspend/resume into early/late hooks, to
make sure that everything is ready with that trick. But that doesn't
compose very well :-/
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
