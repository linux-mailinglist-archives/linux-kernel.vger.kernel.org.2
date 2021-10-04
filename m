Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A704217DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhJDTqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:46:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:40111 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233878AbhJDTqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:46:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="212694534"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="212694534"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 12:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="483301456"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga007.fm.intel.com with SMTP; 04 Oct 2021 12:44:51 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 04 Oct 2021 22:44:50 +0300
Date:   Mon, 4 Oct 2021 22:44:50 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, geert@linux-m68k.org,
        oliver.sang@intel.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Jerry Zuo <Jerry.Zuo@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH] drm/edid: Fix crash with zero/invalid EDID
Message-ID: <YVtZstInQxXfPmsZ@intel.com>
References: <20211004092100.1.Ic90a5ebd44c75db963112be167a03cc96f9fb249@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004092100.1.Ic90a5ebd44c75db963112be167a03cc96f9fb249@changeid>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:21:27AM -0700, Douglas Anderson wrote:
> In the commit bac9c2948224 ("drm/edid: Break out reading block 0 of
> the EDID") I broke out reading the base block of the EDID to its own
> function. Unfortunately, when I did that I messed up the handling when
> drm_edid_is_zero() indicated that we had an EDID that was all 0x00 or
> when we went through 4 loops and didn't get a valid EDID. Specifically
> I needed to pass the broken EDID to connector_bad_edid() but now I was
> passing an error-pointer.
> 
> Let's re-jigger things so we can pass the bad EDID in properly.
> 
> Fixes: bac9c2948224 ("drm/edid: Break out reading block 0 of the EDID")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/drm_edid.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 9b19eee0e1b4..9c9463ec5465 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -1911,13 +1911,15 @@ int drm_add_override_edid_modes(struct drm_connector *connector)
>  }
>  EXPORT_SYMBOL(drm_add_override_edid_modes);
>  
> -static struct edid *drm_do_get_edid_base_block(
> +static struct edid *drm_do_get_edid_base_block(struct drm_connector *connector,
>  	int (*get_edid_block)(void *data, u8 *buf, unsigned int block,
>  			      size_t len),
> -	void *data, bool *edid_corrupt, int *null_edid_counter)
> +	void *data)
>  {
> -	int i;
> +	int *null_edid_counter = connector ? &connector->null_edid_counter : NULL;
> +	bool *edid_corrupt = connector ? &connector->edid_corrupt : NULL;
>  	void *edid;
> +	int i;
>  
>  	edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
>  	if (edid == NULL)
> @@ -1941,9 +1943,8 @@ static struct edid *drm_do_get_edid_base_block(
>  	return edid;
>  
>  carp:
> -	kfree(edid);
> -	return ERR_PTR(-EINVAL);
> -
> +	if (connector)
> +		connector_bad_edid(connector, edid, 1);

BTW I believe connector_bad_edid() itself is broken since
commit e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid
corruption test"). Before we've even allocated the memory for the
extension blocks that code now assumes edid[0x7e] is to be 100%
trusted and goes and calculates the checksum on a block based on
that. So that's likely going to be pointing somewhere beyond the base
block into memory we've not even allocated. So anyone who wanted
could craft a bogus EDID and maybe get something interesting to
happen.

Would be good if someone could fix that while at it. Or just revert
the offending commit if there is no simple solution immediately in
sight.

The fact that we're parsing entirely untrustworthy crap in the kernel
always worries me. Either we need super careful review of all relevant
code, and/or we need to think about moving the parser out of the kernel.
I was considering playing around with the usermode helper stuff. IIRC
there is a way to embed the userspace binary into the kernel and just
fire it up when needed. But so far it's been the usual -ENOTIME for
me...

-- 
Ville Syrjälä
Intel
