Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5A40B867
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhINTy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhINTyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:54:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3760161108;
        Tue, 14 Sep 2021 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631649218;
        bh=th9TFOXsR06Xg/2ttcv1rjgy5eK+72XXt8aYRu+bByo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5M0TLTr0U8YWN17ZphgSgOsr2LkfGc/XojytM3rF1QIuC2MWJk+hTrgoPUij63Tf
         ZbK1iGOjiaztEHrnL5vad2ePLBAKUcN1kbiRKDdllueg705sx3t9CQPF/dksuWcCpF
         zlj9V/fW3WAvq5nZxn6+YWn1IPxkJ4ru23CZmt8YAU/PZ03YdtlWMiMmoghpuNkSeh
         S4NZsiBS+u+8Wx1VRDVaVJMazZM2ZRgiyu6L77M8++T3suP5qVHK3rnjA5DQCkChLN
         18yNPa2S3CWiv3K22BWh1xIG6nTmWleS/yUu/XLKdD/bCeditfV4GkDlflsqU1n3KB
         /VfLJbmib9UcA==
Date:   Tue, 14 Sep 2021 12:53:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        llvm@lists.linux.dev
Subject: Re: [PATCH 0/3] drm/i915: Enable -Wsometimes-uninitialized
Message-ID: <YUD9u88IGvdZ7MqW@archlinux-ax161>
References: <20210824225427.2065517-1-nathan@kernel.org>
 <YT+QmKyKCdotTcqA@archlinux-ax161>
 <87wnnj13t5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnnj13t5.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:10:14PM +0300, Jani Nikula wrote:
> On Mon, 13 Sep 2021, Nathan Chancellor <nathan@kernel.org> wrote:
> > On Tue, Aug 24, 2021 at 03:54:24PM -0700, Nathan Chancellor wrote:
> >> Commit 46e2068081e9 ("drm/i915: Disable some extra clang warnings")
> >> disabled -Wsometimes-uninitialized as noisy but there have been a few
> >> fixes to clang that make the false positive rate fairly low so it should
> >> be enabled to help catch obvious mistakes. The first two patches fix
> >> revent instances of this warning then enables it for i915 like the rest
> >> of the tree.
> >> 
> >> Cheers,
> >> Nathan
> >> 
> >> Nathan Chancellor (3):
> >>   drm/i915/selftests: Do not use import_obj uninitialized
> >>   drm/i915/selftests: Always initialize err in
> >>     igt_dmabuf_import_same_driver_lmem()
> >>   drm/i915: Enable -Wsometimes-uninitialized
> >> 
> >>  drivers/gpu/drm/i915/Makefile                        | 1 -
> >>  drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c | 7 ++++---
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> >> 
> >> 
> >> base-commit: fb43ebc83e069625cfeeb2490efc3ffa0013bfa4
> >> -- 
> >> 2.33.0
> >> 
> >> 
> >
> > Ping, could this be picked up for an -rc as these are very clearly bugs?
> 
> Thanks for the patches and review. Pushed to drm-intel-gt-next and
> cherry-picked to drm-intel-fixes, header to -rc2.

Thanks a lot!

Cheers,
Nathan
