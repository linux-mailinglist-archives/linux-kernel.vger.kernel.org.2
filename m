Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780C13222BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhBVXpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231419AbhBVXpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:45:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 367AB64DA5;
        Mon, 22 Feb 2021 23:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614037499;
        bh=XFGxZWOiGtpFOFbxDLAcp9qcmWnZcBnW8fvwf4JwOUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AI2KKYoJMwsJst0ReZUzZzHJvM48mdR1eVEerDmFbIOQCx+Vo6tjOLhfZm7NvM5LQ
         wsjSN9gL29VPZ/SF5w5Sf80Ju31iF4opqVp82iRk0yE5lcdra2LeHGoQR0z7EkyKmo
         OxuDkq5+M1KIpouzLub8Aw2cCOloNG4onrTbhJ+0x5HnZOSxmovGpitjAVMLc3MmIq
         d9fcw0QkR5uom7qqUP1rEvV8JSYOXt6jBGGPDt39/oMRihD7c1XN2ocACIKm6Gbyyu
         g66hqnC778VmU6V24/M20sicvRno8QM3kXwtH0gkxC/Erwe0nie4mQ77JAd52k0nl3
         eSL/UHHUoL3cw==
Date:   Mon, 22 Feb 2021 16:44:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Simon Ser <contact@emersion.fr>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nicholas.kazlauskas@amd.com, Rodrigo.Siqueira@amd.com,
        aurabindo.pillai@amd.com, stylon.wang@amd.com,
        bas@basnieuwenhuizen.nl, Bhawanpreet.Lakha@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu/display: initialize the variable 'i'
Message-ID: <20210222234457.GA36153@24bbad8f3778>
References: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
 <32vjVDssCxltB75h5jHin2U3-cvNjmd_HFnRLiKohhbXkTfZea3hw2Knd80SgcHoyIFldMNwqh49t28hMBvta0HeWed1L0q_efLJ8QCgNw8=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32vjVDssCxltB75h5jHin2U3-cvNjmd_HFnRLiKohhbXkTfZea3hw2Knd80SgcHoyIFldMNwqh49t28hMBvta0HeWed1L0q_efLJ8QCgNw8=@emersion.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 11:05:17PM +0000, Simon Ser wrote:
> On Monday, February 22nd, 2021 at 8:25 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> 
> > >> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9804:38:
> > >> warning: variable 'i' is uninitialized when used here
> > >> [-Wuninitialized]
> >                            timing  = &edid->detailed_timings[i];
> >                                                              ^
> >    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9714:7:
> > note: initialize the variable 'i' to silence this warning
> >            int i;
> >                 ^
> >                  = 0
> >    1 warning generated.
> >
> > Initialize the variable 'i'.
> 
> Hm, I see this variable already initialized in the loop:
> 
>     for (i = 0; i < 4; i++) {
> 
> This is the branch agd5f/drm-next.

That is in the

	if (amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
		|| amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_EDP) {

branch not the

	} else if (edid && amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {

branch, where i is indeed used uninitialized like clang complains about.

I am not at all familiar with the code so I cannot say if this fix is
the proper one but it is definitely a legitimate issue.

Cheers,
Nathan

> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index a22a53d..e96d3d9 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -9717,7 +9717,7 @@ static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> >  void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
> >  					struct edid *edid)
> >  {
> > -	int i;
> > +	int i = 0;
> >  	struct detailed_timing *timing;
> >  	struct detailed_non_pixel *data;
> >  	struct detailed_data_monitor_range *range;
> > --
> > 1.9.1
