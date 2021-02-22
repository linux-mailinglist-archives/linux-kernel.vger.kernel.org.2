Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AEA3222CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhBVXvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:51:06 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:59775 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBVXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:51:02 -0500
Date:   Mon, 22 Feb 2021 23:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1614037819;
        bh=ph1ySBEQC0LJpRPum3dD4XtE11mtDK6Kdlwf7VEbw5E=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=cc2FYh0f9I8DcHixptL/3YWq/dc+vUJCOLh2GWZ2BXH22GspZN90hOwFl/9dPFMKK
         6nnqDu8qOUg5XbyFoy+E5IGUA/fPrLGhYFnFIrwWPqs6k6jYFXQd5aIEb2l2b3ArnH
         U4iZ0I4cJEgPoPWD/rF1xJeTuAxvkq5KwaicRzqFIuFnDlg8c0+xXp/tf+T4lN/faZ
         mb5/DaE+mvtRNA2PqzuYGUpar5OSfKvIc/foi2JiQ+O03ckn8vE0qFB4xTAKZHJywc
         +ocqGh0J6I+tg28wbF/fzmNQ96BEY+wPmfvl5sSHQOffXNABk5gweZQQH6ovD7+4S0
         xRt//bY/pcZLA==
To:     Nathan Chancellor <nathan@kernel.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nicholas.kazlauskas@amd.com, Rodrigo.Siqueira@amd.com,
        aurabindo.pillai@amd.com, stylon.wang@amd.com,
        bas@basnieuwenhuizen.nl, Bhawanpreet.Lakha@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amdgpu/display: initialize the variable 'i'
Message-ID: <yHvp7KbQD2pF5dR6krMc_Zuq9a8GxkYSSiIpjBenuiCjwpFmFxpAOpfzhp0DfHQhH2Z3P81-CGpwmmXp0zjifT93vBXXYd5kJsSucQgXFZI=@emersion.fr>
In-Reply-To: <20210222234457.GA36153@24bbad8f3778>
References: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com> <32vjVDssCxltB75h5jHin2U3-cvNjmd_HFnRLiKohhbXkTfZea3hw2Knd80SgcHoyIFldMNwqh49t28hMBvta0HeWed1L0q_efLJ8QCgNw8=@emersion.fr> <20210222234457.GA36153@24bbad8f3778>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 23rd, 2021 at 12:44 AM, Nathan Chancellor <nathan@kern=
el.org> wrote:

> On Mon, Feb 22, 2021 at 11:05:17PM +0000, Simon Ser wrote:
> > On Monday, February 22nd, 2021 at 8:25 PM, Souptick Joarder <jrdr.linux=
@gmail.com> wrote:
> >
> > > >> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9804:3=
8:
> > > >> warning: variable 'i' is uninitialized when used here
> > > >> [-Wuninitialized]
> > >                            timing  =3D &edid->detailed_timings[i];
> > >                                                              ^
> > >    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9714:7=
:
> > > note: initialize the variable 'i' to silence this warning
> > >            int i;
> > >                 ^
> > >                  =3D 0
> > >    1 warning generated.
> > >
> > > Initialize the variable 'i'.
> >
> > Hm, I see this variable already initialized in the loop:
> >
> >     for (i =3D 0; i < 4; i++) {
> >
> > This is the branch agd5f/drm-next.
>
> That is in the
>
> =09if (amdgpu_dm_connector->dc_sink->sink_signal =3D=3D SIGNAL_TYPE_DISPL=
AY_PORT
> =09=09|| amdgpu_dm_connector->dc_sink->sink_signal =3D=3D SIGNAL_TYPE_EDP=
) {
>
> branch not the
>
> =09} else if (edid && amdgpu_dm_connector->dc_sink->sink_signal =3D=3D SI=
GNAL_TYPE_HDMI_TYPE_A) {
>
> branch, where i is indeed used uninitialized like clang complains about.
>
> I am not at all familiar with the code so I cannot say if this fix is
> the proper one but it is definitely a legitimate issue.

I think you have an outdated branch. In my checkout, i is not used in the f=
irst
branch, and is initialized in the second one.

https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/amd/display/=
amdgpu_dm/amdgpu_dm.c?h=3Ddrm-next#n9700
