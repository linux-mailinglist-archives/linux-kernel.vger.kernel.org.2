Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649F533A40F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 11:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhCNKBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 06:01:51 -0400
Received: from ozlabs.org ([203.11.71.1]:35421 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhCNKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 06:01:20 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Dyw7264Z4z9sWH; Sun, 14 Mar 2021 21:01:18 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, geert@linux-m68k.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        linuxppc-dev@lists.ozlabs.org, alexdeucher@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
References: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Fix missing declaration of [en/dis]able_kernel_vsx()
Message-Id: <161571587339.138988.8288160163932312489.b4-ty@ellerman.id.au>
Date:   Sun, 14 Mar 2021 21:01:18 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 08:39:39 +0000 (UTC), Christophe Leroy wrote:
> Add stub instances of enable_kernel_vsx() and disable_kernel_vsx()
> when CONFIG_VSX is not set, to avoid following build failure.
> 
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o
> In file included from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
>                  from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
>                  from drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:27:
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: In function 'dcn_bw_apply_registry_override':
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
>    64 |   enable_kernel_vsx(); \
>       |   ^~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:640:2: note: in expansion of macro 'DC_FP_START'
>   640 |  DC_FP_START();
>       |  ^~~~~~~~~~~
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:75:3: error: implicit declaration of function 'disable_kernel_vsx'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
>    75 |   disable_kernel_vsx(); \
>       |   ^~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:676:2: note: in expansion of macro 'DC_FP_END'
>   676 |  DC_FP_END();
>       |  ^~~~~~~~~
> cc1: some warnings being treated as errors
> make[5]: *** [drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o] Error 1

Applied to powerpc/fixes.

[1/1] powerpc: Fix missing declaration of [en/dis]able_kernel_vsx()
      https://git.kernel.org/powerpc/c/bd73758803c2eedc037c2268b65a19542a832594

cheers
