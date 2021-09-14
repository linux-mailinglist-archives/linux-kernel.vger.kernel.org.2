Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A7740B5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhINR0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhINR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:26:07 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6564FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:24:50 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id q14so14932853ils.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGxIKUsb5FP4AsXfc/89dNxHXi2H4NcJUiI1QiagwdY=;
        b=iyrYbI4T8mMOxoTpHdf24U1Ihc4jeVugugDcbUpPPi9+BFYdHzvFYERq2kK2RmDalM
         MVgPdl/vsIs1fpZefdUxu6zAyDFPelsDP9l9Lx/UPNh4U6CWpdEBJMUpbOARU4dpRmTA
         7gl1EFRKcfg0JEn8EhoGza9JVjPp6mOSKYCG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGxIKUsb5FP4AsXfc/89dNxHXi2H4NcJUiI1QiagwdY=;
        b=4XvcTWfwQXlz29fTQHOK+JSEpfp6jjToDveG4LTNSRsxtD3aNYyTGiSrV3DDVkiSdF
         fGhEk/yWjWfl/kbEMjZrMQZUFcCg7Z+ei29nLNz4yUzNjfBc98r0T94PYc20OE4vLzsS
         hFVbkOtlhOWNOO3Kt75zhnF3SyYGXnZewp4uk+ssc4d36kzKC4kfTSarcMt9gLtZpTyJ
         WTo7n7RByj1nHCPo5TYNqaek98ZT1ZWZUSwIGLBjuUmeS/L2EyptUyi8eFsL+4Ke4RpX
         h9qpLgQ5tVeNW5r3GNsc3OCzb8RzDfCoIsXcz7g7nQnq51PG89o+CImp0dJbUtgPYcSG
         A4MA==
X-Gm-Message-State: AOAM532/vPorJqTEddkanDzdKz0vqKtyZfFbmwP7b8uwDLXCLIbN5V06
        DyVr1fRmLZ60L1kqfKApFkbBN6PQTRZZ5A==
X-Google-Smtp-Source: ABdhPJxo5GDPEm6dVQLIkim+q+YOCud6dIOrO61b2c8kmch0auoeTFZJrNIU8Uw1FUYkgO2zXyhgdA==
X-Received: by 2002:a92:bf01:: with SMTP id z1mr12417559ilh.155.1631640289633;
        Tue, 14 Sep 2021 10:24:49 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id c11sm6870605ioh.50.2021.09.14.10.24.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 10:24:48 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id y18so18200525ioc.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:24:48 -0700 (PDT)
X-Received: by 2002:a02:711e:: with SMTP id n30mr15666865jac.3.1631640288500;
 Tue, 14 Sep 2021 10:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210913131113.390368911@linuxfoundation.org> <20210913131118.330293390@linuxfoundation.org>
 <CAD=FV=UhovUSmvbpc3q9=J_NSU0mcvQ3Fv8r4hi1ZNO=cMteuA@mail.gmail.com>
 <YT93qkd8B7jy6AzV@kroah.com> <CAD=FV=WPkVGTUmx2+Egt+ryO02n4cNGjN3S8gkBJP-WW3jPLWw@mail.gmail.com>
 <YUDNXAVHfsrM7sR6@kroah.com>
In-Reply-To: <YUDNXAVHfsrM7sR6@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Sep 2021 10:24:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XA4CVUp0DGs55PGdMirusits8SSmeZG=DoLzu1Km_-xw@mail.gmail.com>
Message-ID: <CAD=FV=XA4CVUp0DGs55PGdMirusits8SSmeZG=DoLzu1Km_-xw@mail.gmail.com>
Subject: Re: [PATCH 5.14 147/334] drm/bridge: ti-sn65dsi86: Dont read EDID
 blob over DDC
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 14, 2021 at 9:27 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 13, 2021 at 09:31:03AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Sep 13, 2021 at 9:09 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 06:57:20AM -0700, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Mon, Sep 13, 2021 at 6:51 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > From: Douglas Anderson <dianders@chromium.org>
> > > > >
> > > > > [ Upstream commit a70e558c151043ce46a5e5999f4310e0b3551f57 ]
> > > > >
> > > > > This is really just a revert of commit 58074b08c04a ("drm/bridge:
> > > > > ti-sn65dsi86: Read EDID blob over DDC"), resolving conflicts.
> > > > >
> > > > > The old code failed to read the EDID properly in a very important
> > > > > case: before the bridge's pre_enable() was called. The way things need
> > > > > to work:
> > > > > 1. Read the EDID.
> > > > > 2. Based on the EDID, decide on video settings and pixel clock.
> > > > > 3. Enable the bridge w/ the desired settings.
> > > > >
> > > > > The way things were working:
> > > > > 1. Try to read the EDID but fail; fall back to hardcoded values.
> > > > > 2. Based on hardcoded values, decide on video settings and pixel clock.
> > > > > 3. Enable the bridge w/ the desired settings.
> > > > > 4. Try again to read the EDID, it works now!
> > > > > 5. Realize that the hardcoded settings weren't quite right.
> > > > > 6. Disable / reenable the bridge w/ the right settings.
> > > > >
> > > > > The reasons for the failures were twofold:
> > > > > a) Since we never ran the bridge chip's pre-enable then we never set
> > > > >    the bit to ignore HPD. This meant the bridge chip didn't even _try_
> > > > >    to go out on the bus and communicate with the panel.
> > > > > b) Even if we fixed things to ignore HPD, the EDID still wouldn't read
> > > > >    if the panel wasn't on.
> > > > >
> > > > > Instead of reverting the code, we could fix it to set the HPD bit and
> > > > > also power on the panel. However, it also works nicely to just let the
> > > > > panel code read the EDID. Now that we've split the driver up we can
> > > > > expose the DDC AUX channel bus to the panel node. The panel can take
> > > > > charge of reading the EDID.
> > > > >
> > > > > NOTE: in order for things to work, anyone that needs to read the EDID
> > > > > will need to instantiate their panel using the new DP AUX bus (AKA by
> > > > > listing their panel under the "aux-bus" node of the bridge chip in the
> > > > > device tree).
> > > > >
> > > > > In the future if we want to use the bridge chip to provide a full
> > > > > external DP port (which won't have a panel) then we will have to
> > > > > conditinally add EDID reading back in.
> > > > >
> > > > > Suggested-by: Andrzej Hajda <a.hajda@samsung.com>
> > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > Link: https://patchwork.freedesktop.org/patch/msgid/20210611101711.v10.9.I9330684c25f65bb318eff57f0616500f83eac3cc@changeid
> > > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > > ---
> > > > >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 22 ----------------------
> > > > >  1 file changed, 22 deletions(-)
> > > >
> > > > I guess it's not a huge deal, but I did respond to Sasha and request
> > > > that this patch be dropped from the stable queue unless the whole big
> > > > pile of patches was being backported. See:
> > > >
> > > > https://lore.kernel.org/lkml/CAD=FV=U2dGjeEzp+K1vnLTj8oPJ-GKBTTKz2XQ1OZ7QF_sTHuw@mail.gmail.com/
> > > >
> > > > I said:
> > > >
> > > > > I would suggest against backporting this one unless you're going to
> > > > > backport the whole pile of DP AUX bus patches, which probably doesn't
> > > > > make sense for stable. Even though the old EDID reading was broken for
> > > > > the first read, it still worked for later reads. ...and the first read
> > > > . didn't crash or anything--it just timed out.
> > >
> > > I see a "bunch" of patches for this driver in this -rc, did Sasha not
> > > get them all?  If not, I can drop this one, but maybe it was needed for
> > > the follow-on patches?
> >
> > It's been a long journey trying to make this bridge work better. I
> > think the easiest way to say it is that if you don't have the parent
> > of ${SUBJECT} patch, AKA:
> >
> > e0bbcc6233f7 drm/bridge: ti-sn65dsi86: Add support for the DP AUX bus
> >
> > ...then you don't have DP AUX bus support and you shouldn't take
> > ${SUBJECT} patch. If you have that patch and it compiles / builds then
> > it means that you have all the proper dependencies. However, there are
> > _a lot_ of dependencies and I wouldn't suggest picking them all to
> > stable unless it's critical for someone.
>
> I tried to drop this one, and it turned out to be a depandancy for
> another patch for this driver.  And that was another dependancy.  So
> I've now dropped all of these from the queue.

Ugh. :(


> Here are the commits I dropped.  If you think any should be added back,
> please let us know:
>
> 05a7f4a8dff1 ("devlink: Break parameter notification sequence to be before/after unload/load driver")

I don't understand what the "devlink" patch had to do with
ti-sn65dsi86. I'll assume you didn't intend to have it in your list.


> e183bf31cf0d ("drm/bridge: ti-sn65dsi86: Add some 100 us delays")
> c7782443a889 ("drm/bridge: ti-sn65dsi86: Avoid creating multiple connectors")
> a70e558c1510 ("drm/bridge: ti-sn65dsi86: Don't read EDID blob over DDC")
> acb06210b096 ("drm/bridge: ti-sn65dsi86: Fix power off sequence")
> 4c1b3d94bf63 ("drm/bridge: ti-sn65dsi86: Improve probe errors with dev_err_probe()")
> 4e5763f03e10 ("drm/bridge: ti-sn65dsi86: Wrap panel with panel-bridge")

I'd say it's OK to drop these. If someone demonstrates a need for them
on stable channel then I can help with backporting, but otherwise I
can't see that it's worth it. Basically:

1. I think ${SUBJECT} patch without full DP AUX support for people
could cause a real regression if anyone is using this bridge chip on
5.14 stable.

2. I think picking back full DP AUX support is too heavy for a
stable-channel backport without a demonstrated need.

3. Of the above patches, only one fixes a problem that was observed on
real hardware ("Fix power off sequence"). That was only seen on a
panel that _requires_ the full DP AUX support in order to work. Other
ones are fixes based on code inspection, cleanups, or fixes for other
patches in the series there.

-Doug
