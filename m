Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BB2372FE3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhEDSqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhEDSqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:46:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30604C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 11:45:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r9so14768023ejj.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NbVhIMCFX3/Rv7gGknfj4DjPNAhT1jyy7BEtshdUxfA=;
        b=N9xM6Bk1NBWAseAORN2s9DOxf3Fq6twnoX2y0i6lWMiboT+uq/8PdPaiKnhl0Vl9Sk
         BOeApmAA7nJfhiJMo8k7D77ZkdUnR81QgSQVjNa3TR5ffOgBU61jFDcecRAK6ORGbWp8
         rfbiP/iCfecgUqpWL4Gc4VnX5EFaMjXCXNQnJF3k3BAp/XPROMErnWZHB0rrsIaJ0K2u
         ipH20rUur4aT8ovXovGD6o2MJxmMQCgxNlHsHP9S+rA8trXw9KEC84ERv3xSDLbG7vD4
         4eYgya1RPsGS6BNNgPJwE+73D4JfZzmTThUwywFTF2YN/IgGP2Q5cAw4PGb52yc+nvNx
         41og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NbVhIMCFX3/Rv7gGknfj4DjPNAhT1jyy7BEtshdUxfA=;
        b=gRvTDbl6Okc2zDlLROLT1y1ClIs+m7EZ5X3U73W+igxRIldh+JT8KhATmHkY8O/ELo
         sbHvmSYrRFmmRlqIByISRDcEvFY6BvCNW0ssTPdTPrTzC3ZzlXHhvbZS98x6/A8VJN7M
         se4aqN/Xz76A3k8F0ud7umPE8lS2Vo0lJdESKmW6LM8SDL/2/PJ/xz3RlVmT2RxUb6Mc
         2+BGK21U8ymORULzfroOVAXTln38HNEMzKuOByaRyCKaEhvgGBPcfHMiNQ9PfjrgErm7
         0WgtE6wbAjFZuM1rMWKsy0olmrGUQ6cBGY9oeqBWUXl+fFcnR1RKqUd0zjqyj6rnVyqG
         1Qvg==
X-Gm-Message-State: AOAM531AddfEtMdlMW2cBEHN1Qv33AaaXDSfjDKXoQu86Lgspq58yrs8
        8Xwo5jjc4Jp5Hwnk1g0mJ3F5pnVWmlKnveOT2gg=
X-Google-Smtp-Source: ABdhPJyL1F/F0cIowY5BgY+sCzN06aktYN1M8TCokPWxDC48r3XBpQiezqj52lg6w+qZ3JYBwRDcZork07pte8DJZoo=
X-Received: by 2002:a17:906:ae0a:: with SMTP id le10mr23592854ejb.86.1620153912945;
 Tue, 04 May 2021 11:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <e4r4g4R-yjH.A.CJE.0pVkgB@appolonius> <20210504183009.GV6564@kitsune.suse.cz>
In-Reply-To: <20210504183009.GV6564@kitsune.suse.cz>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 4 May 2021 20:45:01 +0200
Message-ID: <CABkfQAHfjfBFqnVPzg1w5JFOErr=AsLpQgwzwpUJ2Uc_-cmD_w@mail.gmail.com>
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

Hello,

I think this is self-evident but could you please send the config to confir=
m?

Thanks,

Le mar. 4 mai 2021 =C3=A0 20:30, Michal Such=C3=A1nek <msuchanek@suse.de> a=
 =C3=A9crit :
>
> Hello,
>
> I get errors about missing symbol in the lontium-lt8912b module.
>
> Is the problem self-evident or do you need the config as well?
>
> I don't need the driver for anything, it was just auto-enabled because
> it's new and the change has not been reviewed.
>
> Thanks
>
> Michal
> >
> > Last output:
> >   WRAP    arch/powerpc/boot/zImage.maple
> >   WRAP    arch/powerpc/boot/zImage.pseries
> > make[2]: *** Deleting file 'modules-only.symvers'
> >   MODPOST modules-only.symvers
> > ERROR: modpost: "drm_display_mode_to_videomode" [drivers/gpu/drm/bridge=
/lontium-lt8912b.ko] undefined!
> > make[2]: *** [../scripts/Makefile.modpost:150: modules-only.symvers] Er=
ror 1
> > make[1]: *** [/home/abuild/rpmbuild/BUILD/kernel-vanilla-5.12.0.13670.g=
5e321ded302d/linux-5.12-13670-g5e321ded302d/Makefile:1770: modules] Error 2
> > make: *** [../Makefile:215: __sub-make] Error 2
> > error: Bad exit status from /var/tmp/rpm-tmp.q1oSIp (%build)
