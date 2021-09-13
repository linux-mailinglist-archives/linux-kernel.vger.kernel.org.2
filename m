Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E80409B51
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbhIMR5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239619AbhIMR5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:57:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1F0360E97;
        Mon, 13 Sep 2021 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631555750;
        bh=9hCsDfa152YCgrx2lvwHetmU1uS6j7bALqOO6SjfsBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCzjSSdCZH9GmfVIx8YGg35ecGbRj3kGBdijAGtlqO4WEMWosxchtOBbWUhJmwpON
         K7EzWyw9tObM0NefsDXNfHs2mxJK2wX64M/hPyNxVCNGVD8smZG58IyQyJmn4x96qd
         ByzHGLy7UtvE/gMluPvdMqS+E/mz0lyOIoDq7manEo0IFLzJH8q+/QxjdwWOHI/yVY
         KQDTwQcTLPORF+OaSc8OIczMKQSu+C3xASC24gWQ8Uq8UzAFsplvWgiLYlS2MtP9SJ
         6srSvyePYxQ9pn8Uewqrr/utN6RCvCZmopoWSVSTDMWODkEIAvnTSVdPGn0VVD3m8n
         gePHJqb3mmCFw==
Date:   Mon, 13 Sep 2021 10:55:36 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Jason Ekstrand <jason@jlekstrand.net>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        llvm@lists.linux.dev
Subject: Re: [PATCH 0/3] drm/i915: Enable -Wsometimes-uninitialized
Message-ID: <YT+QmKyKCdotTcqA@archlinux-ax161>
References: <20210824225427.2065517-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824225427.2065517-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 03:54:24PM -0700, Nathan Chancellor wrote:
> Commit 46e2068081e9 ("drm/i915: Disable some extra clang warnings")
> disabled -Wsometimes-uninitialized as noisy but there have been a few
> fixes to clang that make the false positive rate fairly low so it should
> be enabled to help catch obvious mistakes. The first two patches fix
> revent instances of this warning then enables it for i915 like the rest
> of the tree.
> 
> Cheers,
> Nathan
> 
> Nathan Chancellor (3):
>   drm/i915/selftests: Do not use import_obj uninitialized
>   drm/i915/selftests: Always initialize err in
>     igt_dmabuf_import_same_driver_lmem()
>   drm/i915: Enable -Wsometimes-uninitialized
> 
>  drivers/gpu/drm/i915/Makefile                        | 1 -
>  drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c | 7 ++++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> 
> base-commit: fb43ebc83e069625cfeeb2490efc3ffa0013bfa4
> -- 
> 2.33.0
> 
> 

Ping, could this be picked up for an -rc as these are very clearly bugs?

Cheers,
Nathan
