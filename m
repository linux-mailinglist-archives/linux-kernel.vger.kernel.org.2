Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C362C4046BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhIIIGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhIIIGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:06:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077E3C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 01:05:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q26so1209492wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RWdrOYla9aR1wZCxqUeWV3FSsYS1iOIetBPvAopBXZ0=;
        b=BOUaWev0noIo82WMc3EqCmoEkbSNKQSxocTJse7loiGLT0UuiQAPL7H9y59HBArfxt
         OytibCSsmov2w/Y4gsZSKTWr69XaeHLcjKDqJAiJwnw20qXwyumrqpxu+nthKiVUc15R
         /Wl0B4TQpmqG9tnqvHSeovSx0mB3MMr73JsZx+W4lPHzVXu78uQezFXUS4Lg7hENdlpa
         fyJ8OLFF+haEugZBsqx2fcpj1aWIn9+qwbWDS8hxuIgkJBks+T5k+aKfcQsAaar/2kM5
         sLqH7OR7lZIClqy0WeQGuavGMW7YoAZFiSfrwghLOlsAwUerFqK0VZP4n7a7Bii0FnY9
         uPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RWdrOYla9aR1wZCxqUeWV3FSsYS1iOIetBPvAopBXZ0=;
        b=lBFBYdacNdOuqbuUmPSg8agpuTcdB3Vio8sEspP6XNkITTzHyUu05XZJ7I4aqWv1Lj
         vmMv/CjR70vD6eQTyFygho15bR/Q8KVr1x0XITsBResS9h5I7Klq61z8R/jo3YwaPVrE
         +gwDwjPrZ6LTFy5ONFfB89q7OO+IGxLtiKQccXTdRTWKZss3vqUIz45RSgl93BDnBXme
         tdaUyh5GLb/Te+WuclPjU1rnerlfMlvRjXFNHxWnscb408eRXlKkhwgNaQZObAWj6D7w
         yP/rIAJtxPaRIs3Qx6aA9iNr9wk2x1jRGJKNcabL2AuLAgpZgyvRLwrGqB7feJOy4XWy
         xywA==
X-Gm-Message-State: AOAM533ms7GYglKr2gXoFgcs10Cp9BjMDbBkD6pvptX/pX74p7uDwItu
        BDgcfwgtwrfHZDwh0Lni9oE=
X-Google-Smtp-Source: ABdhPJzM79Ya2RPNMDzDHt9TIPt64ORsLBpAzUT48i+p0itvvEmFFu1ZL/tuBixOMAqQLLnuEi/8wg==
X-Received: by 2002:adf:fb49:: with SMTP id c9mr170806wrs.44.1631174700659;
        Thu, 09 Sep 2021 01:05:00 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7140:364b:3af8:f004? ([2a02:908:1252:fb60:7140:364b:3af8:f004])
        by smtp.gmail.com with ESMTPSA id d9sm1237820wrb.36.2021.09.09.01.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 01:05:00 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fix stack usage of DML
To:     Harry Wentland <harry.wentland@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     ndesaulniers@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@kernel.org, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, nathan@kernel.org, linux@roeck-us.net,
        llvm@lists.linux.dev
References: <20210909010023.29110-1-harry.wentland@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <76749a45-64e9-c478-cf93-ac7a26b48cd8@gmail.com>
Date:   Thu, 9 Sep 2021 10:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210909010023.29110-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's nice to see at least some of them addressed, feel free to add an 
Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

Am 09.09.21 um 03:00 schrieb Harry Wentland:
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
>    drm/amd/display: Pass display_pipe_params_st as const in DML
>    drm/amd/display: Pass all structs in display_rq_dlg_helpers by pointer
>    drm/amd/display: Fix rest of pass-by-value structs in DML
>    drm/amd/display: Allocate structs needed by dcn_bw_calc_rq_dlg_ttu in
>      pipe_ctx
>
>   .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  55 ++--
>   .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
>   .../dc/dml/dcn20/display_rq_dlg_calc_20.c     | 158 +++++------
>   .../dc/dml/dcn20/display_rq_dlg_calc_20.h     |   4 +-
>   .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   | 156 +++++------
>   .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h   |   4 +-
>   .../dc/dml/dcn21/display_rq_dlg_calc_21.c     | 156 +++++------
>   .../dc/dml/dcn21/display_rq_dlg_calc_21.h     |   4 +-
>   .../dc/dml/dcn30/display_rq_dlg_calc_30.c     | 132 ++++-----
>   .../dc/dml/dcn30/display_rq_dlg_calc_30.h     |   4 +-
>   .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 166 ++++++------
>   .../dc/dml/dcn31/display_rq_dlg_calc_31.h     |   4 +-
>   .../drm/amd/display/dc/dml/display_mode_lib.h |   4 +-
>   .../display/dc/dml/display_rq_dlg_helpers.c   | 256 +++++++++---------
>   .../display/dc/dml/display_rq_dlg_helpers.h   |  20 +-
>   .../display/dc/dml/dml1_display_rq_dlg_calc.c | 246 ++++++++---------
>   .../display/dc/dml/dml1_display_rq_dlg_calc.h |  10 +-
>   .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
>   18 files changed, 695 insertions(+), 689 deletions(-)
>

