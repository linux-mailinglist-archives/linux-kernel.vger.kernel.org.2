Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FBE378D71
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347484AbhEJMpt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 May 2021 08:45:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:7182 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238305AbhEJLRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:17:21 -0400
IronPort-SDR: 0zN4AI+9+dm6QeGdeyG7W/Pvh1EEzs2Qrv1mpYqwt0n+5b3zHuz1qtYWvKdfWSJFpz0LK9dexj
 dt6krpAbylmA==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="197184662"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="197184662"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 04:16:16 -0700
IronPort-SDR: 6f7483hNhBYZ6quW3AIAvXtqyjGE63Mhhqh6TMeYQme1IdnqDs+NRHcY9ZfhmJJcCXLHx3iMr+
 r0uzfvmVKEPg==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="436099598"
Received: from solender-mobl.ger.corp.intel.com (HELO localhost) ([10.252.48.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 04:16:10 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        "James \(Qian\) Wang" <james.qian.wang@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 44/53] docs: gpu: avoid using UTF-8 chars
In-Reply-To: <36bc1118467da645a57515743c9f6c1cd86abe8c.1620641727.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1620641727.git.mchehab+huawei@kernel.org> <36bc1118467da645a57515743c9f6c1cd86abe8c.1620641727.git.mchehab+huawei@kernel.org>
Date:   Mon, 10 May 2021 14:16:08 +0300
Message-ID: <87sg2uvnyf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> While UTF-8 characters can be used at the Linux documentation,
> the best is to use them only when ASCII doesn't offer a good replacement.
> So, replace the occurences of the following UTF-8 characters:
>
> 	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Jani Nikula <jani.nikula@intel.com>


> ---
>  Documentation/gpu/i915.rst       | 2 +-
>  Documentation/gpu/komeda-kms.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> index 486c720f3890..2cbf54460b48 100644
> --- a/Documentation/gpu/i915.rst
> +++ b/Documentation/gpu/i915.rst
> @@ -361,7 +361,7 @@ Locking Guidelines
>  	  real bad.
>  
>  #. Do not nest different lru/memory manager locks within each other.
> -   Take them in turn to update memory allocations, relying on the object’s
> +   Take them in turn to update memory allocations, relying on the object's
>     dma_resv ww_mutex to serialize against other operations.
>  
>  #. The suggestion for lru/memory managers locks is that they are small
> diff --git a/Documentation/gpu/komeda-kms.rst b/Documentation/gpu/komeda-kms.rst
> index eb693c857e2d..c2067678e92c 100644
> --- a/Documentation/gpu/komeda-kms.rst
> +++ b/Documentation/gpu/komeda-kms.rst
> @@ -324,7 +324,7 @@ the control-abilites of device.
>  
>  We have &komeda_dev, &komeda_pipeline, &komeda_component. Now fill devices with
>  pipelines. Since komeda is not for D71 only but also intended for later products,
> -of course we’d better share as much as possible between different products. To
> +of course we'd better share as much as possible between different products. To
>  achieve this, split the komeda device into two layers: CORE and CHIP.
>  
>  -   CORE: for common features and capabilities handling.

-- 
Jani Nikula, Intel Open Source Graphics Center
