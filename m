Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4E53730A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhEDTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhEDTUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:20:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEADC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:19:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n25so11757707edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PaY5BeyThU9Oqa5E0rN+QI4l8GyOFDg1PpkL7EPVYXE=;
        b=JFA/8XYwritP46yCAgT/nmYSkwKesLyBCdX4oAhNdOXQ69Td23Fk3CP35RxxITPhih
         rhnzsp0ZNAkMJisc2i599n6V7f5dW4Kl2ROcORZwx3HXkqViXtbZsk5/62rIXOB2qGtU
         WFJakaMAyaCefWlwkcmjYuG1DvfqbC8AFWdIYSwHj3lJMZ91dJH3WSYoBVkApqLP/Vp+
         2G/STcG2STau8pGFolQVSW6jasMrNh/4m4zce/IAosTmfR+oig36/rYiHxC4ZNATMCqk
         f1ZqeCLxCUTkLXFQwiAIVX2NYXYXokNBBUM2PCyVZ0zmK1f3sKvM9T3Y+SgzewZyB/CA
         TvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PaY5BeyThU9Oqa5E0rN+QI4l8GyOFDg1PpkL7EPVYXE=;
        b=LdK8hybAwNraO/Ypvg7il1AWC2H5UnP9HTDPiDeQba4kPivX3EC7N0ZmgtTzlADmzR
         Uj3Jyc6CeaQSasWNX89AQwjln/Rbi68jhlvmvVKk70zFDibZLMKZdsiw2ZFRHG+NNuMK
         8eD6di5WtmKXiskYg09d4lYvnzsM2h7Jx9LwJPNCjwL0wMgAeFJ8MexFyCQyF/iMRf9u
         mRx4uMqKje+9sOXUL2MyzAnuVqm6cWDk/4DpTpntk85mMpmsztvFT7wv5/02IFj+nCh0
         iJtoxLQNDy3rWpJTy8NBcPH39w2U5oG6wC560oEbTD56p7eLQ0q2qI3d3u4Q02HBMLiX
         NiqQ==
X-Gm-Message-State: AOAM533yLq4wsBDktvsrud+I26E2Nb49AM8R/7Kgs1CKTi/Xd3egd2IC
        w8cLYVNk3vWpHlABZZ56bD+v3HGuLLBxwofyDzI=
X-Google-Smtp-Source: ABdhPJxQhIHBDaE08YeU5xNR99TW13NYeX6EKKCoEJUJq4Tl1oPY59Rx1+gNQB6ZpTtMRCDoE9w7os89CzDYdM3ulQ4=
X-Received: by 2002:aa7:cd50:: with SMTP id v16mr28953451edw.175.1620155991412;
 Tue, 04 May 2021 12:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <e4r4g4R-yjH.A.CJE.0pVkgB@appolonius> <20210504183009.GV6564@kitsune.suse.cz>
 <CABkfQAHfjfBFqnVPzg1w5JFOErr=AsLpQgwzwpUJ2Uc_-cmD_w@mail.gmail.com> <20210504190452.GW6564@kitsune.suse.cz>
In-Reply-To: <20210504190452.GW6564@kitsune.suse.cz>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 4 May 2021 21:19:36 +0200
Message-ID: <CABkfQAFpTYFgiA-h+5DBiky3CMtdj71n5+usGGtrTHsYB1xruA@mail.gmail.com>
Subject: Re: ERROR: modpost: "drm_display_mode_to_videomode"
 [drivers/gpu/drm/bridge/lontium-lt8912b.ko] undefined!
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok thanks,

I will investigate this.

Le mar. 4 mai 2021 =C3=A0 21:04, Michal Such=C3=A1nek <msuchanek@suse.de> a=
 =C3=A9crit :
>
> Hello,
>
> I have only one from ppc64, the other architectures don't have the
> problem or fail earlier.
>
> Thanks
>
> Michal
>
> On Tue, May 04, 2021 at 08:45:01PM +0200, Adrien Grassein wrote:
> > Hello,
> >
> > I think this is self-evident but could you please send the config to co=
nfirm?
> >
> > Thanks,
> >
> > Le mar. 4 mai 2021 =C3=A0 20:30, Michal Such=C3=A1nek <msuchanek@suse.d=
e> a =C3=A9crit :
> > >
> > > Hello,
> > >
> > > I get errors about missing symbol in the lontium-lt8912b module.
> > >
> > > Is the problem self-evident or do you need the config as well?
> > >
> > > I don't need the driver for anything, it was just auto-enabled becaus=
e
> > > it's new and the change has not been reviewed.
> > >
> > > Thanks
> > >
> > > Michal
> > > >
> > > > Last output:
> > > >   WRAP    arch/powerpc/boot/zImage.maple
> > > >   WRAP    arch/powerpc/boot/zImage.pseries
> > > > make[2]: *** Deleting file 'modules-only.symvers'
> > > >   MODPOST modules-only.symvers
> > > > ERROR: modpost: "drm_display_mode_to_videomode" [drivers/gpu/drm/br=
idge/lontium-lt8912b.ko] undefined!
> > > > make[2]: *** [../scripts/Makefile.modpost:150: modules-only.symvers=
] Error 1
> > > > make[1]: *** [/home/abuild/rpmbuild/BUILD/kernel-vanilla-5.12.0.136=
70.g5e321ded302d/linux-5.12-13670-g5e321ded302d/Makefile:1770: modules] Err=
or 2
> > > > make: *** [../Makefile:215: __sub-make] Error 2
> > > > error: Bad exit status from /var/tmp/rpm-tmp.q1oSIp (%build)
