Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE151452D13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhKPIrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:47:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:38622 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232161AbhKPIrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:47:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="233891319"
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="233891319"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 00:44:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="506339908"
Received: from mramya-mobl1.gar.corp.intel.com (HELO localhost) ([10.251.219.100])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 00:44:17 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Angus Ainslie <angus@akkea.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     kernel@puri.sm, David Airlie <airlied@linux.ie>,
        Angus Ainslie <angus@akkea.ca>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com
Subject: Re: [PATCH] drm: drm_probe_helper: add modes upto 1920x1080
In-Reply-To: <20211115160135.25451-1-angus@akkea.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211115160135.25451-1-angus@akkea.ca>
Date:   Tue, 16 Nov 2021 10:44:14 +0200
Message-ID: <87czn01odd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: Ville

On Mon, 15 Nov 2021, Angus Ainslie <angus@akkea.ca> wrote:
> Lots of monitors nowdays support more than 1024x768 so if the EDID is
> unknown then add resolutions upto 1920x1080.

IIUC it's supposed to be the fallback that's pretty much guaranteed to
work. What's going to happen if we add 1920x1080 and it fails?


BR,
Jani.

>
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> ---
>  drivers/gpu/drm/drm_probe_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index e7e1ee2aa352..5ad66ae9916e 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -517,7 +517,7 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>  
>  	if (count == 0 && (connector->status == connector_status_connected ||
>  			   connector->status == connector_status_unknown))
> -		count = drm_add_modes_noedid(connector, 1024, 768);
> +		count = drm_add_modes_noedid(connector, 1920, 1080);
>  	count += drm_helper_probe_add_cmdline_mode(connector);
>  	if (count == 0)
>  		goto prune;

-- 
Jani Nikula, Intel Open Source Graphics Center
