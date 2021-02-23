Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723343222EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 01:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhBWABi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 19:01:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhBWAB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 19:01:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97E0360C41;
        Tue, 23 Feb 2021 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614038446;
        bh=af3kVTgsG+nH3bM3IYnJBqeSQYehgcaCIygkIvqVjeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nV6TYhL/oZNC9ifaFgtV5DjQUEKW4ct/RZXzL5cEAO+OEiYaRVvJB6MnQTc1GgLDg
         ZxZPHOSv1bmmm50hjEKCBKAdJy06dDuQgJws05+gPJ7vhenuXz0IbFL9AHEcQCGmZu
         imEAdGj/OEhQSAKHAz3rHudTUwkOAJGTbcsmgQ3E4mnIeJk4ydl08iGkjwUVUAN1X+
         gpuniD1QjbCS0WDVI9g2unaM1LUFoC9It+wtjRh0GXnNVsd+VoG5YBbI4/JwHcPTrq
         FRtTYoRRzhd2gk02YLalZuf1ZGsh62b0eufN0g4UGVYTpcrawf1WR9HZdvEwjFLc3p
         nD7cOeD11urKg==
Date:   Mon, 22 Feb 2021 17:00:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Simon Ser <contact@emersion.fr>
Cc:     stylon.wang@amd.com, sunpeng.li@amd.com, Bhawanpreet.Lakha@amd.com,
        dri-devel@lists.freedesktop.org, Rodrigo.Siqueira@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        nicholas.kazlauskas@amd.com, airlied@linux.ie,
        aurabindo.pillai@amd.com, Souptick Joarder <jrdr.linux@gmail.com>,
        daniel@ffwll.ch, bas@basnieuwenhuizen.nl,
        alexander.deucher@amd.com, harry.wentland@amd.com,
        christian.koenig@amd.com
Subject: Re: [PATCH] drm/amdgpu/display: initialize the variable 'i'
Message-ID: <20210223000045.GA4304@24bbad8f3778>
References: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
 <32vjVDssCxltB75h5jHin2U3-cvNjmd_HFnRLiKohhbXkTfZea3hw2Knd80SgcHoyIFldMNwqh49t28hMBvta0HeWed1L0q_efLJ8QCgNw8=@emersion.fr>
 <20210222234457.GA36153@24bbad8f3778>
 <yHvp7KbQD2pF5dR6krMc_Zuq9a8GxkYSSiIpjBenuiCjwpFmFxpAOpfzhp0DfHQhH2Z3P81-CGpwmmXp0zjifT93vBXXYd5kJsSucQgXFZI=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yHvp7KbQD2pF5dR6krMc_Zuq9a8GxkYSSiIpjBenuiCjwpFmFxpAOpfzhp0DfHQhH2Z3P81-CGpwmmXp0zjifT93vBXXYd5kJsSucQgXFZI=@emersion.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 11:50:06PM +0000, Simon Ser wrote:
> On Tuesday, February 23rd, 2021 at 12:44 AM, Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > On Mon, Feb 22, 2021 at 11:05:17PM +0000, Simon Ser wrote:
> > > On Monday, February 22nd, 2021 at 8:25 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > >
> > > > >> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9804:38:
> > > > >> warning: variable 'i' is uninitialized when used here
> > > > >> [-Wuninitialized]
> > > >                            timing  = &edid->detailed_timings[i];
> > > >                                                              ^
> > > >    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9714:7:
> > > > note: initialize the variable 'i' to silence this warning
> > > >            int i;
> > > >                 ^
> > > >                  = 0
> > > >    1 warning generated.
> > > >
> > > > Initialize the variable 'i'.
> > >
> > > Hm, I see this variable already initialized in the loop:
> > >
> > >     for (i = 0; i < 4; i++) {
> > >
> > > This is the branch agd5f/drm-next.
> >
> > That is in the
> >
> > 	if (amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
> > 		|| amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_EDP) {
> >
> > branch not the
> >
> > 	} else if (edid && amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> >
> > branch, where i is indeed used uninitialized like clang complains about.
> >
> > I am not at all familiar with the code so I cannot say if this fix is
> > the proper one but it is definitely a legitimate issue.
> 
> I think you have an outdated branch. In my checkout, i is not used in the first
> branch, and is initialized in the second one.
> 
> https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c?h=drm-next#n9700

That branch is the outdated one:

https://git.kernel.org/linus/a897913a819191550ab2fa2784d3c3ada3a096d3

Please see:

https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L9854

It was introduced by commit f9b4f20c4777 ("drm/amd/display: Add Freesync
HDMI support to DM").

Cheers,
Nathan
