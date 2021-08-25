Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D613F7267
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbhHYJ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:57:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:19636 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234372AbhHYJ50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:57:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="217495633"
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="217495633"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 02:56:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="426393046"
Received: from pjthomps-mobl1.ger.corp.intel.com (HELO [10.249.254.76]) ([10.249.254.76])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 02:56:37 -0700
Subject: Re: [PATCH 1/3] drm/i915/selftests: Do not use import_obj
 uninitialized
To:     Nathan Chancellor <nathan@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Jason Ekstrand <jason@jlekstrand.net>,
        Matthew Auld <matthew.auld@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        llvm@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>
References: <20210824225427.2065517-1-nathan@kernel.org>
 <20210824225427.2065517-2-nathan@kernel.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
Message-ID: <ef38255f-fe4a-3ba5-e828-bac4d9957cdb@linux.intel.com>
Date:   Wed, 25 Aug 2021 11:56:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824225427.2065517-2-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/25/21 12:54 AM, Nathan Chancellor wrote:
> Clang warns a couple of times:
>
> drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:63:6: warning:
> variable 'import_obj' is used uninitialized whenever 'if' condition is
> true [-Wsometimes-uninitialized]
>          if (import != &obj->base) {
>              ^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:80:22: note:
> uninitialized use occurs here
>          i915_gem_object_put(import_obj);
>                              ^~~~~~~~~~
> drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:63:2: note: remove
> the 'if' if its condition is always false
>          if (import != &obj->base) {
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:38:46: note:
> initialize the variable 'import_obj' to silence this warning
>          struct drm_i915_gem_object *obj, *import_obj;
>                                                      ^
>                                                       = NULL
>
> Shuffle the import_obj initialization above these if statements so that
> it is not used uninitialized.
>
> Fixes: d7b2cb380b3a ("drm/i915/gem: Correct the locking and pin pattern for dma-buf (v8)")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Patch looks good to me.

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>


