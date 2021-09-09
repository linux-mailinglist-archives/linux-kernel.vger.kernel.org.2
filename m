Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637F0405F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhIIVyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhIIVyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:54:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79D636113A;
        Thu,  9 Sep 2021 21:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631224414;
        bh=iO9c6ro8/Jqgx0B8ZTzRynOkRkRDZVnUUSu1jdMn8yU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7pUigz78SFsgfYfhXLsKjS9oYRduzOlauh2Mozjksd9Y/dWeGcztVCHwE91g8vIn
         0cMVrS4/dcNEoTjuH4PRrzEFYqq9xQDmnuxfeTyO2pWyj0et8rHoFoxIs5JfIpPY3D
         /gF0mI28RiqpudZjkW7fie8bpdaGwqoHAzGOPgqvMzWlWdVQBKhBn7DO4UhOOldSAt
         AV0Tep6rsxsC59vojPNSqufb4ebOtnzPVNejZHARF9aQNk7TeqbGBKWc+hCqQF4LW/
         neojFkGB5/xZUMb9GrsCTxdk54tL6REzRo4yu12CUxHS2UN27ZfiVM3E14WlDgt1fZ
         y+TEPSo++wD+w==
Date:   Thu, 9 Sep 2021 14:53:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, ndesaulniers@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@kernel.org, sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, linux@roeck-us.net,
        llvm@lists.linux.dev
Subject: Re: [PATCH 0/4] Fix stack usage of DML
Message-ID: <YTqCWyZ7mXDaJ5HQ@Ryzen-9-3900X.localdomain>
References: <20210909010023.29110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909010023.29110-1-harry.wentland@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 09:00:19PM -0400, Harry Wentland wrote:
> With the '-Werror' enablement patch the amdgpu build was failing
> on clang builds because a bunch of functions were blowing past
> the 1024 byte stack frame default. Due to this we also noticed
> that a lot of functions were passing large structs by value
> instead of by pointer.
> 
> This series attempts to fix this.
> 
> There is still one remaining function that blows the 1024 limit by 40 bytes:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:3397:6:
>  
> error: stack frame size of 1064 bytes in function 
> 'dml21_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than=]
> 
> This will be a slightly more challenging fix but I'll see if we can get it
> below 1024 by breaking it into smaller functions.
> 
> With this series I can build amdgpu with CC=clang and a stack frame limit of 
> 1064.
> 
> This series boots on a Radeon RX 5500 XT.
> 
> Harry Wentland (4):
>   drm/amd/display: Pass display_pipe_params_st as const in DML
>   drm/amd/display: Pass all structs in display_rq_dlg_helpers by pointer
>   drm/amd/display: Fix rest of pass-by-value structs in DML
>   drm/amd/display: Allocate structs needed by dcn_bw_calc_rq_dlg_ttu in
>     pipe_ctx

This series resolves some warnings that were reported on our issue
tracker for 32-bit x86. I do see some other warnings in amdgpu with
clang in various configurations but this is a great start. Thank you for
taking a look at them. For the series:

Build-tested-by: Nathan Chancellor <nathan@kernel.org>

>  .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  55 ++--
>  .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
>  .../dc/dml/dcn20/display_rq_dlg_calc_20.c     | 158 +++++------
>  .../dc/dml/dcn20/display_rq_dlg_calc_20.h     |   4 +-
>  .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   | 156 +++++------
>  .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h   |   4 +-
>  .../dc/dml/dcn21/display_rq_dlg_calc_21.c     | 156 +++++------
>  .../dc/dml/dcn21/display_rq_dlg_calc_21.h     |   4 +-
>  .../dc/dml/dcn30/display_rq_dlg_calc_30.c     | 132 ++++-----
>  .../dc/dml/dcn30/display_rq_dlg_calc_30.h     |   4 +-
>  .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 166 ++++++------
>  .../dc/dml/dcn31/display_rq_dlg_calc_31.h     |   4 +-
>  .../drm/amd/display/dc/dml/display_mode_lib.h |   4 +-
>  .../display/dc/dml/display_rq_dlg_helpers.c   | 256 +++++++++---------
>  .../display/dc/dml/display_rq_dlg_helpers.h   |  20 +-
>  .../display/dc/dml/dml1_display_rq_dlg_calc.c | 246 ++++++++---------
>  .../display/dc/dml/dml1_display_rq_dlg_calc.h |  10 +-
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
>  18 files changed, 695 insertions(+), 689 deletions(-)
> 
> -- 
> 2.33.0
