Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017913ABAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhFQRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhFQRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:39:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C62C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:36:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l9so3963898wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=hRboyT3Px4Bh5KPhImfvUXYzcpIAxMeOVL/V1Z4UHPE=;
        b=RR+u6A/06lfdqDqYmXZVMQjZG2N60Diui/M/YZ2oB28+Wa74KYcN/p1pfKLaaIg3S0
         +E64VBEumEsYQsXjI26hKD1Kv9XL9B5fe4flODe3AZ9sxyuZOTGQ0Z8hFxDr77yEcqnU
         Z7y9+7J5h170T/OeO0cgC5cSsrimM4jZghHLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=hRboyT3Px4Bh5KPhImfvUXYzcpIAxMeOVL/V1Z4UHPE=;
        b=OmwdGXQxn6mZMO+8m+41p9ndElCzfXntTo3NMiY7W5cN5x2fy3i1vLtwfP/Hn0ldFn
         XA59RI/OSif5SXt6zGzzUAhqalg7RgRLr3jIA1qGHgsvVOT0frP3pk77yK4u+m6eU4sY
         Ukct0g4ZTM72tbbWNUjibmscCfacXmExvh4ryauwB5KMf6NbM70O7aXLehNbcwL2Qomg
         i5SyfnG7TlGnw0htc7T8DjiW+IJ431CLo70QLI3oXicaq/mI2Tag3735x2kCp7dnk3sI
         TVOjiclME9XF/Uht1HqWbQYVzejoa8cih9J1Oo9CH2hwE9zmsBHrHnkZ+eZYwEOQSlGW
         okpg==
X-Gm-Message-State: AOAM530yutVDV4BfmCdSiHFGzbQlZVdMp/UlbwJ3EJRSWJK2gsnC1eey
        0Hn8tG2MxzHwgDxPbxEHVtqj6g==
X-Google-Smtp-Source: ABdhPJymg8rF8PgFQgt+R9gf2l9QwPwixcZwWeo5KN3MgGywFLFVuPNg0334YonJgaX8o67kjenwdg==
X-Received: by 2002:a05:600c:2103:: with SMTP id u3mr6673005wml.0.1623951415925;
        Thu, 17 Jun 2021 10:36:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o20sm8356179wms.3.2021.06.17.10.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 10:36:54 -0700 (PDT)
Date:   Thu, 17 Jun 2021 19:36:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        CQ Tang <cq.tang@intel.com>,
        Zbigniew =?utf-8?Q?Kempczy=C5=84ski?= 
        <zbigniew.kempczynski@intel.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Remove duplicate include of intel_region_lmem.h
Message-ID: <YMuINKQ/ScxdkCSx@phenom.ffwll.local>
Mail-Followup-To: Wan Jiabing <wanjiabing@vivo.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        CQ Tang <cq.tang@intel.com>,
        Zbigniew =?utf-8?Q?Kempczy=C5=84ski?= <zbigniew.kempczynski@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210615113522.6867-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615113522.6867-1-wanjiabing@vivo.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:35:20PM +0800, Wan Jiabing wrote:
> Fix the following checkinclude.pl warning:
> drivers/gpu/drm/i915/gt/intel_region_lmem.c
> 8	#include "intel_region_lmem.h"
>      12	#include "intel_region_lmem.h"
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Applied to drm-intel-gt-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/i915/gt/intel_region_lmem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> index f7366b054f8e..119eeec98837 100644
> --- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> +++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> @@ -9,7 +9,6 @@
>  #include "intel_region_ttm.h"
>  #include "gem/i915_gem_lmem.h"
>  #include "gem/i915_gem_region.h"
> -#include "intel_region_lmem.h"
>  
>  static int init_fake_lmem_bar(struct intel_memory_region *mem)
>  {
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
