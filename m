Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15B94390C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhJYIED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:04:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:44469 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhJYIEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:04:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="210373631"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="210373631"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 01:01:17 -0700
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="446531190"
Received: from dscaswel-mobl2.ger.corp.intel.com (HELO [10.213.242.254]) ([10.213.242.254])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 01:01:14 -0700
Subject: Re: [PATCH] drm/i915/selftests: Fix inconsistent IS_ERR and PTR_ERR
To:     Kai Song <songkai01@inspur.com>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, jason@jlekstrand.net,
        thomas.hellstrom@linux.intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211022120655.22173-1-songkai01@inspur.com>
From:   Matthew Auld <matthew.auld@intel.com>
Message-ID: <f0f66cb7-ce70-b968-2fa2-64c39a87e98c@intel.com>
Date:   Mon, 25 Oct 2021 09:01:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211022120655.22173-1-songkai01@inspur.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2021 13:06, Kai Song wrote:
> Fix inconsistent IS_ERR and PTR_ERR in i915_gem_dmabuf.c
> 
> Signed-off-by: Kai Song <songkai01@inspur.com>

Pushed to drm-intel-gt-next. Thanks.

> ---
>   drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
> index 4a6bb64c3a35..3cc74b0fed06 100644
> --- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
> @@ -102,7 +102,7 @@ static int igt_dmabuf_import_same_driver_lmem(void *arg)
>   	obj = __i915_gem_object_create_user(i915, PAGE_SIZE, &lmem, 1);
>   	if (IS_ERR(obj)) {
>   		pr_err("__i915_gem_object_create_user failed with err=%ld\n",
> -		       PTR_ERR(dmabuf));
> +		       PTR_ERR(obj));
>   		err = PTR_ERR(obj);
>   		goto out_ret;
>   	}
> @@ -158,7 +158,7 @@ static int igt_dmabuf_import_same_driver(struct drm_i915_private *i915,
>   					    regions, num_regions);
>   	if (IS_ERR(obj)) {
>   		pr_err("__i915_gem_object_create_user failed with err=%ld\n",
> -		       PTR_ERR(dmabuf));
> +		       PTR_ERR(obj));
>   		err = PTR_ERR(obj);
>   		goto out_ret;
>   	}
> 
