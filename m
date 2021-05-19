Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24431389318
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355004AbhESP6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355003AbhESP6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:58:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D7C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=GCiO5jtPmcXxtuD2cYz4lG/3Yt3JBlECnMVfp0AvOxQ=; b=RAptUpFt5PkVRnPKRgjbxl9670
        5WPlJcxK0CFHlUd7Z+x2UZeVDeCeXQxPUyJj+WPPAFZkU5UAv+8NrGBdwPcft52DICFAmwXACMFNs
        ZLzimhPgjudhWjPWLzf+0N+D6YsKw8lFG9Js43cvA3Osh97QRPOt8hzV6E6Gqu0F8K9QE0IO759Kf
        AdNJHdPPtDmLA/mOyIhXzqWVrPlZaLFc+eewZ87vS5NRb2Vhr0UifYAjKULtIjLVu4Pkr4Yh1o2cl
        oogv7P4f1wVw2aRewWVZ1H3aAPehsezMVcJXH/dpGBLIXcrkSpjc8ZZzFNwVpabKx17STrUzJy98j
        KKJTJ7hg==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljOYk-00Fbf9-Fy; Wed, 19 May 2021 15:56:34 +0000
Subject: Re: [PATCH 1/3] gpu: drm: replace occurrences of invalid character
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Airlie <airlied@linux.ie>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <e606930c73029f16673849c57acac061dd923866.1621412009.git.mchehab+huawei@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f0589aff-a776-0715-e421-0d9a8cf2cc25@infradead.org>
Date:   Wed, 19 May 2021 08:56:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <e606930c73029f16673849c57acac061dd923866.1621412009.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 1:15 AM, Mauro Carvalho Chehab wrote:
> There are some places at drm that ended receiving a
> REPLACEMENT CHARACTER U+fffd ('�'), probably because of
> some bad charset conversion.
> 
> Fix them by using what it seems	to be the proper
> character.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/gpu/drm/amd/include/atombios.h       | 10 +++++-----
>  drivers/gpu/drm/i915/gt/intel_gpu_commands.h |  2 +-
>  drivers/gpu/drm/i915/i915_gpu_error.h        |  2 +-
>  drivers/gpu/drm/r128/r128_drv.h              |  2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 

-- 
~Randy

