Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2332228A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBVXGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:06:24 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:31487 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhBVXGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:06:17 -0500
Date:   Mon, 22 Feb 2021 23:05:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1614035130;
        bh=mD7inEEpBWky59qWI7tHe8UlQANiZKAGuft09L0bkr8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=O9pobkWKoTsS0sHKYQpi2lbk/t0vLnzpL32ZQ4kiZks0MFXd57WL/chx9c/LaTFDT
         oEX5EY/hFrTNZ8iA9ydQhRINGJcOD8mTG68GEvosLRNtLJp8suww8rdRM92hVVuN2f
         9N2NO29jPBlGfXV6pl3nc1eNndNyH32XKDyunutj9ac9o5wux+CI1Zl0oR4REpiS9c
         w3mqDtkIjbmxThnqQ/FWpo7Dgtc5RVXRCM3DNNBGBg79Lx6m+/ZfJBpwzxNV4N5qFk
         icmI6jbA72yGfdLJHq4i5kLPiHfUwSV6m4vsCzAO8HP+MCn6RslWFNt+EkjnPnOaBI
         hwxjy+d7JjlQA==
To:     Souptick Joarder <jrdr.linux@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
        Rodrigo.Siqueira@amd.com, aurabindo.pillai@amd.com,
        stylon.wang@amd.com, bas@basnieuwenhuizen.nl,
        Bhawanpreet.Lakha@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amdgpu/display: initialize the variable 'i'
Message-ID: <32vjVDssCxltB75h5jHin2U3-cvNjmd_HFnRLiKohhbXkTfZea3hw2Knd80SgcHoyIFldMNwqh49t28hMBvta0HeWed1L0q_efLJ8QCgNw8=@emersion.fr>
In-Reply-To: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
References: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
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

On Monday, February 22nd, 2021 at 8:25 PM, Souptick Joarder <jrdr.linux@gma=
il.com> wrote:

> >> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9804:38:
> >> warning: variable 'i' is uninitialized when used here
> >> [-Wuninitialized]
>                            timing  =3D &edid->detailed_timings[i];
>                                                              ^
>    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9714:7:
> note: initialize the variable 'i' to silence this warning
>            int i;
>                 ^
>                  =3D 0
>    1 warning generated.
>
> Initialize the variable 'i'.

Hm, I see this variable already initialized in the loop:

    for (i =3D 0; i < 4; i++) {

This is the branch agd5f/drm-next.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a22a53d..e96d3d9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9717,7 +9717,7 @@ static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_co=
nnector *aconnector,
>  void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>  =09=09=09=09=09struct edid *edid)
>  {
> -=09int i;
> +=09int i =3D 0;
>  =09struct detailed_timing *timing;
>  =09struct detailed_non_pixel *data;
>  =09struct detailed_data_monitor_range *range;
> --
> 1.9.1
