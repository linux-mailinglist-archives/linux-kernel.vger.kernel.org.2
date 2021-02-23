Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA61322DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhBWPj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:39:29 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhBWPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:39:26 -0500
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5gAG-1lCxBL1zPW-007Dru; Tue, 23 Feb 2021 16:36:33 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 92CFB1E01E7;
        Tue, 23 Feb 2021 15:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id blSB3nUsz-cE; Tue, 23 Feb 2021 16:36:32 +0100 (CET)
Received: from pflmari.corp.cetitec.com (2-usr-pf-main.vpn.it.cetitec.com [10.8.5.2])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 3F9B51E01E6;
        Tue, 23 Feb 2021 16:36:32 +0100 (CET)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Tue, 23 Feb 2021 16:36:31 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Lyude Paul <lyude@redhat.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        James Jones <jajones@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jeremy Cline <jcline@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH 2/3] drm/nouveau/kms/nv50-: Report max cursor size to
 userspace
Message-ID: <YDUg/9fjsvTkRUqr@pflmari>
References: <20210119015415.2511028-1-lyude@redhat.com>
 <20210119015415.2511028-2-lyude@redhat.com>
 <YDUN+Re/alMVL0Zn@pflmari>
 <CAKb7UvhFkw23so-a4JKLzpQLhphzjzarOy-9h+FiKP-aAC=4xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb7UvhFkw23so-a4JKLzpQLhphzjzarOy-9h+FiKP-aAC=4xw@mail.gmail.com>
X-Provags-ID: V03:K1:lLfiHh+wAU5dx6w2wtMoChBxn+RUn1NPTqMejn0E5YxvkGIR5C7
 T/ocA7y4+SV4umv5AYaWXbtoiI04JxTxRQyXnS5A5TN+Ey+EqY1H5nL19RGjrJyFGdRBynt
 bKPDnBpiqfV282AW5wOnWm26A0+NwhDq/puB793Ygpd0zuN+qZgQxfnFLwTF5ddKAFMP8w1
 apOtnKnNM1j+zfAPQW+Bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TI+fHRxjWZw=:3KUVxUdSpFHuJrngopUJQq
 teuXNswinl9LVsVPNf/dUhmae3mPNlRGMQpFbjXcJFUdj56S1BTwxTCnL9AI3mRK0EHy/tUIN
 RgnS6a8pEj9krmkW+Ya52Cb7dTP5DaxYabD38D0ipROFAssle2XyIAqxrwV/M3YKeYNlMV4XC
 3WbuX09GZfG9gWkP9Wf/v7zbr9nyR8Bp9etamFQmfcMUoXkfEIsJFqbmk5h6bIQBRiofhkzqh
 oLEK7/7ZcEtcumhy3fQpLuj/VLXghT8IZb16P7Xw+edAS79vD2112hfGq/JiuvIH0Jt7EOrIF
 3KiSTTs5kbczF8OIx1B3wlg1lQLlZaSsDfzBMMDtbIdEhdF+NAfILCvbt2Z3B4S/WzzkgBBPf
 JzZZZU7ZtfaXZGg8SjU5VJxkjEtyAWMo5fsakhJ8u09XrrvplVb67sMCFlH0GsoVs0ya5sfYU
 yPbB8yhkFw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilia Mirkin, Tue, Feb 23, 2021 15:56:21 +0100:
> On Tue, Feb 23, 2021 at 9:26 AM Alex Riesen <alexander.riesen@cetitec.com> wrote:
> > Lyude Paul, Tue, Jan 19, 2021 02:54:13 +0100:
> > > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > > index c6367035970e..5f4f09a601d4 100644
> > > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > > @@ -2663,6 +2663,14 @@ nv50_display_create(struct drm_device *dev)
> > >       else
> > >               nouveau_display(dev)->format_modifiers = disp50xx_modifiers;
> > >
> > > +     if (disp->disp->object.oclass >= GK104_DISP) {
> > > +             dev->mode_config.cursor_width = 256;
> > > +             dev->mode_config.cursor_height = 256;
> > > +     } else {
> > > +             dev->mode_config.cursor_width = 64;
> > > +             dev->mode_config.cursor_height = 64;
> > > +     }
> > > +
> > >       /* create crtc objects to represent the hw heads */
> > >       if (disp->disp->object.oclass >= GV100_DISP)
> > >               crtcs = nvif_rd32(&device->object, 0x610060) & 0xff;
> >
> > This change broke X cursor in my setup, and reverting the commit restores it.
> >
> > Dell Precision M4800, issue ~2014 with GK106GLM [Quadro K2100M] (rev a1).
> > libdrm 2.4.91-1 (Debian 10.8 stable).
> > There are no errors or warnings in Xorg logs nor in the kernel log.
> 
> Could you confirm which ddx is driving the nvidia hw? You can find
> this out by running "xrandr --listproviders", or also in the xorg log.

xrandr(1) does not seem to list much:

$ xrandr --listproviders
Providers: number : 1
Provider 0: id: 0x48 cap: 0xf, Source Output, Sink Output, Source Offload, Sink Offload crtcs: 4 outputs: 5 associated providers: 0 name:modesetting

I failed to find a DDX in Xorg.0.log. Both Xorg.0.log and dmesg can be seen here:

    https://gist.github.com/ar-cetitec/68c27551d9a59b89dc73bffe0456bbef


