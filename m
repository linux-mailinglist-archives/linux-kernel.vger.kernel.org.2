Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365F231DB44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhBQOOy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Feb 2021 09:14:54 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:56928 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232371AbhBQOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:14:52 -0500
X-Greylist: delayed 1027 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Feb 2021 09:14:51 EST
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.69.177;
Received: from localhost (unverified [78.156.69.177]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23891380-1500050 
        for multiple; Wed, 17 Feb 2021 13:56:50 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210216212953.24458-1-nathan@kernel.org>
References: <20210216212953.24458-1-nathan@kernel.org>
Subject: Re: [PATCH] drm/i915: Enable -Wuninitialized
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Wed, 17 Feb 2021 13:56:49 +0000
Message-ID: <161357020959.15107.941362709800379680@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2021-02-16 21:29:54)
> -Wunintialized was disabled in commit c5627461490e ("drm/i915: Disable
> -Wuninitialized") because there were two warnings that were false
> positives. The first was due to DECLARE_WAIT_QUEUE_HEAD_ONSTACK, which
> was fixed in LLVM 9.0.0. The second was in busywait_stop, which was
> fixed in LLVM 10.0.0 (issue 415). The kernel's minimum version for LLVM
> is 10.0.1 so this warning can be safely enabled, where it has already
> caught a couple bugs.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/220
> Link: https://github.com/ClangBuiltLinux/linux/issues/415
> Link: https://github.com/ClangBuiltLinux/linux/issues/499
> Link: https://github.com/llvm/llvm-project/commit/2e040398f8d691cc378c1abb098824ff49f3f28f
> Link: https://github.com/llvm/llvm-project/commit/c667cdc850c2aa821ffeedbc08c24bc985c59edd
> Fixes: c5627461490e ("drm/i915: Disable -Wuninitialized")
> References: 2ea4a7ba9bf6 ("drm/i915/gt: Avoid uninitialized use of rpcurupei in frequency_show")
> References: 2034c2129bc4 ("drm/i915/display: Ensure that ret is always initialized in icl_combo_phy_verify_state")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

make CC=clang-11 now compiles cleanly for me as well,
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
