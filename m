Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0370C441B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhKANJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:09:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:49947 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230144AbhKANJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:09:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="231271754"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="231271754"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 06:06:42 -0700
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="500032544"
Received: from mvtammin-mobl.ger.corp.intel.com (HELO localhost) ([10.251.214.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 06:06:38 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Perry Yuan <Perry.Yuan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Perry.Yuan@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Xinmei.Huang@amd.com,
        Ray.Huang@amd.com
Subject: Re: [PATCH v2] drm/dp: Fix aux->transfer NULL pointer dereference on drm_dp_dpcd_access
In-Reply-To: <20211101061053.38173-1-Perry.Yuan@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211101061053.38173-1-Perry.Yuan@amd.com>
Date:   Mon, 01 Nov 2021 15:06:36 +0200
Message-ID: <87a6iodnz7.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2021, Perry Yuan <Perry.Yuan@amd.com> wrote:
> Fix below crash by adding a check in the drm_dp_dpcd_access which
> ensures that aux->transfer was actually initialized earlier.

Gut feeling says this is papering over a real usage issue somewhere
else. Why is the aux being used for transfers before ->transfer has been
set? Why should the dp helper be defensive against all kinds of
misprogramming?


BR,
Jani.


>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: 0010 [#1] SMP NOPTI
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> RSP: 0018:ffffa8d64225bab8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000020 RCX: ffffa8d64225bb5e
> RDX: ffff93151d921880 RSI: ffffa8d64225bac8 RDI: ffff931511a1a9d8
> RBP: ffffa8d64225bb10 R08: 0000000000000001 R09: ffffa8d64225ba60
> R10: 0000000000000002 R11: 000000000000000d R12: 0000000000000001
> R13: 0000000000000000 R14: ffffa8d64225bb5e R15: ffff931511a1a9d8
> FS: 00007ff8ea7fa9c0(0000) GS:ffff9317fe6c0000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 000000010d5a4000 CR4: 0000000000750ee0
> PKRU: 55555554
> Call Trace:
> drm_dp_dpcd_access+0x72/0x110 [drm_kms_helper]
> drm_dp_dpcd_read+0xb7/0xf0 [drm_kms_helper]
> drm_dp_start_crc+0x38/0xb0 [drm_kms_helper]
> amdgpu_dm_crtc_set_crc_source+0x1ae/0x3e0 [amdgpu]
> crtc_crc_open+0x174/0x220 [drm]
> full_proxy_open+0x168/0x1f0
> ? open_proxy_open+0x100/0x100
> do_dentry_open+0x156/0x370
> vfs_open+0x2d/0x30
>
> v2: fix some typo
>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 6d0f2c447f3b..76b28396001a 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -260,6 +260,10 @@ static int drm_dp_dpcd_access(struct drm_dp_aux *aux, u8 request,
>  	msg.buffer = buffer;
>  	msg.size = size;
>  
> +	/* No transfer function is set, so not an available DP connector */
> +	if (!aux->transfer)
> +		return -EINVAL;
> +
>  	mutex_lock(&aux->hw_mutex);
>  
>  	/*

-- 
Jani Nikula, Intel Open Source Graphics Center
