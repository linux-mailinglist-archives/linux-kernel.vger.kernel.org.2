Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2DE3D2224
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhGVJzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhGVJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:55:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F95C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:35:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dt7so7624807ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=GrVJiLCQ2td0LvFK6G+f6bTrOT7qBQ9CowikA35mI6k=;
        b=MPLRAuRMQscjJ1bRSPG4VJjStt0rZUgJLQkjV8Ee74n4JK+gKsZ7E7GbremKpAbXEa
         5RSfjjBngX0otVhG9sMSkQLeikaSoPGMoGGqC4NPQ/xZwSIJGc3C3qKQAjXJzoqHtrnc
         PPUUoOevWpVg4MQ3t0pqVrvjBRHgXApPIqqX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=GrVJiLCQ2td0LvFK6G+f6bTrOT7qBQ9CowikA35mI6k=;
        b=L0sDw16bO4u0/p5ApZWR/I9u57gYYlnn21rmDwij30v7KmOfxVSjtIg4fNzkq5UgvO
         /go5uqbkJ6I+SsT1tjJgUsihf3IZwXakqhc+qFzlH7zAKfgdNP/3sS9xyEQSe2VpKyR9
         6g9Alepk6lX2X6AK6N/nHd4PxaghGa9CAuFc7h+/+C1WyolOfLcXiE1Y0U5tJv4ZeI80
         1dgeZIKNZ2VOkESgB73ANo2Ov3qwdeluMjaoPavJLI1GlQvkz3KJerC2nJM+j1NeWMpu
         XZT9F6MIKUR9DKe1ZsEwURNyBS/dfYjoTb5vuxQVYsSv1WhqAzhu8BjRI8PdzWRd+B3F
         02hw==
X-Gm-Message-State: AOAM531/yD0sJlfUVgMOFJR689ROktJT6Uzmb615rn7uf0xDN05NIfRU
        ZfVenMaRo9YCrG2azLmTPXX7dsslMpladw==
X-Google-Smtp-Source: ABdhPJzNq6lAT9fVXCqbmiOVhh6CzSJjtq8+tM+DSHEpE5WiLhtvjojRagf8CYVO6eOi+rS6ouALzA==
X-Received: by 2002:a17:906:990f:: with SMTP id zl15mr43047702ejb.34.1626950156329;
        Thu, 22 Jul 2021 03:35:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i6sm9257113ejr.68.2021.07.22.03.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 03:35:55 -0700 (PDT)
Date:   Thu, 22 Jul 2021 12:35:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/3] drm: clarify lifetime/locking for drm_master's lease
 fields
Message-ID: <YPlKCc7Sep71xjBC@phenom.ffwll.local>
Mail-Followup-To: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210722092929.244629-1-desmondcheongzx@gmail.com>
 <20210722092929.244629-3-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722092929.244629-3-desmondcheongzx@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 05:29:28PM +0800, Desmond Cheong Zhi Xi wrote:
> In particular, we make it clear that &drm_device.mode_config.idr_mutex
> protects the lease idr and list structures for drm_master. The lessor
> field itself doesn't need to be protected as it doesn't change after
> it's set in drm_lease_create.
> 
> Additionally, we add descriptions for the lifetime of lessors and
> leases to make it easier to reason about them.
> 
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
>  include/drm/drm_auth.h | 62 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 51 insertions(+), 11 deletions(-)
> 
> diff --git a/include/drm/drm_auth.h b/include/drm/drm_auth.h
> index f99d3417f304..c978c85464fa 100644
> --- a/include/drm/drm_auth.h
> +++ b/include/drm/drm_auth.h
> @@ -58,12 +58,6 @@ struct drm_lock_data {
>   * @refcount: Refcount for this master object.
>   * @dev: Link back to the DRM device
>   * @driver_priv: Pointer to driver-private information.
> - * @lessor: Lease holder
> - * @lessee_id: id for lessees. Owners always have id 0
> - * @lessee_list: other lessees of the same master
> - * @lessees: drm_masters leasing from this one
> - * @leases: Objects leased to this drm_master.
> - * @lessee_idr: All lessees under this owner (only used where lessor == NULL)
>   *
>   * Note that master structures are only relevant for the legacy/primary device
>   * nodes, hence there can only be one per device, not one per drm_minor.
> @@ -88,17 +82,63 @@ struct drm_master {
>  	struct idr magic_map;
>  	void *driver_priv;
>  
> -	/* Tree of display resource leases, each of which is a drm_master struct
> -	 * All of these get activated simultaneously, so drm_device master points
> -	 * at the top of the tree (for which lessor is NULL). Protected by
> -	 * &drm_device.mode_config.idr_mutex.
> +	/**
> +	 * @lessor:
> +	 *
> +	 * Lease holder. The lessor does not change once it's set in

Lessor is the lease grantor, lessee is the one receiving the lease. Maybe
clarify this with

"Lease grantor, only set if this struct drm_master represents a lessee
holding a lease of objects from @lessor. Full owners of the device have
this set to NULL."

> +	 * drm_lease_create(). Each lessee holds a reference to its lessor that

I also figured it'd be a good idea to link to the drm_lease docs here to
explain the concepts, but alas we don't have those :-( Hence at least
define what we mean with lessor, lessee, lease and owner.

> +	 * it releases upon being destroyed in drm_lease_destroy().
> +	 *
> +	 * Display resource leases form a tree of &struct drm_master. All of

For now we've limited the tree to a depth of 1, you can't create another
lease if yourself are a lease. I guess another reason to update the
drm_lease.c docs.

So maybe add "Currently the lease tree depth is limited to 1."

> +	 * these get activated simultaneously, so &drm_device.master
> +	 * points at the top of the tree (for which lessor is NULL).
>  	 */
> -
>  	struct drm_master *lessor;
> +
> +	/**
> +	 * @lessee_id:
> +	 *
> +	 * ID for lessees. Owners always have ID 0. Protected by

Maybe clarify to "Owners (i.e. @lessor is NULL) ..."

> +	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
> +	 */
>  	int	lessee_id;
> +
> +	/**
> +	 * @lessee_list:
> +	 *
> +	 * List of lessees of the same master. Protected by

We try to distinguis between list entries and the list, even though it's
the same struct. So maybe

"List entry of lessees of @lessor, where they are linked to @lessee. Not
use for owners."

> +	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.

> +	 */
>  	struct list_head lessee_list;
> +
> +	/**
> +	 * @lessees:
> +	 *
> +	 * List of drm_masters leasing from this one. Protected by
> +	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
> +	 *
> +	 * This master cannot be destroyed unless this list is empty as lessors
> +	 * are referenced by all their lessees.

Maybe add "this list is empty of no leases have been granted."

> +	 */
>  	struct list_head lessees;
> +
> +	/**
> +	 * @leases:
> +	 *
> +	 * Objects leased to this drm_master. Protected by
> +	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
> +	 *
> +	 * Objects are leased all together in drm_lease_create(), and are
> +	 * removed all together when the lease is revoked.
> +	 */
>  	struct idr leases;
> +
> +	/**
> +	 * @lessee_idr:
> +	 *
> +	 * All lessees under this owner (only used where lessor is NULL).

@lessor so it's highlighted correctly

> +	 * Protected by &drm_device.mode_config's &drm_mode_config.idr_mutex.
> +	 */
>  	struct idr lessee_idr;
>  	/* private: */

With the nits addressed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks for updating the docs!
-Daniel

>  #if IS_ENABLED(CONFIG_DRM_LEGACY)
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
