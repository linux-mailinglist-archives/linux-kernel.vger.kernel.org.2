Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD86C3F726D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbhHYJ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:58:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:26549 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236997AbhHYJ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:58:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="197062944"
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="197062944"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 02:57:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="426393181"
Received: from pjthomps-mobl1.ger.corp.intel.com (HELO [10.249.254.76]) ([10.249.254.76])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 02:57:26 -0700
Subject: Re: [PATCH 2/3] drm/i915/selftests: Always initialize err in
 igt_dmabuf_import_same_driver_lmem()
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
 <20210824225427.2065517-3-nathan@kernel.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
Message-ID: <354f7760-7b43-8e3f-414b-1556dabbcdb3@linux.intel.com>
Date:   Wed, 25 Aug 2021 11:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824225427.2065517-3-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/25/21 12:54 AM, Nathan Chancellor wrote:
> Clang warns:
>
> drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:127:13: warning:
> variable 'err' is used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>          } else if (PTR_ERR(import) != -EOPNOTSUPP) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:138:9: note:
> uninitialized use occurs here
>          return err;
>                 ^~~
> drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:127:9: note: remove
> the 'if' if its condition is always true
>          } else if (PTR_ERR(import) != -EOPNOTSUPP) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:95:9: note:
> initialize the variable 'err' to silence this warning
>          int err;
>                 ^
>                  = 0
>
> The test is expected to pass if i915_gem_prime_import() returns
> -EOPNOTSUPP so initialize err to zero in this case.
>
> Fixes: cdb35d1ed6d2 ("drm/i915/gem: Migrate to system at dma-buf attach time (v7)")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>


