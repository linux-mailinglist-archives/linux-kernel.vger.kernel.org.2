Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7690A3D0030
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhGTQq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 12:46:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:23531 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231910AbhGTQmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 12:42:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211286204"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="211286204"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 10:19:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="462117412"
Received: from tjathaud-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.255.230.66])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 10:19:27 -0700
Date:   Tue, 20 Jul 2021 10:19:27 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915/xelpd: Fix unsigned compared to less than
 zero error
Message-ID: <20210720171927.joohdb6lykm7j64t@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20210720155726.73628-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210720155726.73628-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 04:57:26PM +0100, Colin King wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>The subtraction of fw->size - offset is operating on two unsigned
>integers and the result is unsigned and hence the less than zero
>comparison will always to be false. Fix this by casting fw->size
>from a size_t to a ssize_t to ensure the result can be signed to
>allow a less than zero result.
>
>Addresses-Coverity: ("Unsigned compared against 0")
>Fixes: 3d5928a168a9 ("drm/i915/xelpd: Pipe A DMC plugging")
>Signed-off-by: Colin Ian King <colin.king@canonical.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>---
> drivers/gpu/drm/i915/display/intel_dmc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
>index f8789d4543bf..dde1f243d375 100644
>--- a/drivers/gpu/drm/i915/display/intel_dmc.c
>+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
>@@ -645,7 +645,7 @@ static void parse_dmc_fw(struct drm_i915_private *dev_priv,
> 			continue;
>
> 		offset = readcount + dmc->dmc_info[id].dmc_offset * 4;
>-		if (fw->size - offset < 0) {
>+		if ((ssize_t)fw->size - offset < 0) {
> 			drm_err(&dev_priv->drm, "Reading beyond the fw_size\n");
> 			continue;
> 		}
>-- 
>2.31.1
>
