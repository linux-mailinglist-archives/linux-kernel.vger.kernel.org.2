Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EF93FA404
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 08:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhH1Gaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 02:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhH1Gai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 02:30:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D62C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:29:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mq3so6148094pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kl4oyWPglVRUj2XZDB55NaYF6bwSVxszOpVOFsdxEz8=;
        b=YBbcqVWb/Pb5iJPeInUfgC8ehc+vcyde91b3ruRdnSMIuwbS6t4MTsI6OeyoC++B2b
         gL0fiz87+MBXxxPd9yZuhgbEhYLBHTMobH/HQQhrPJoLObWa/RuLW2tJ4lDX/T3PUPje
         KxF8DAcCfg8XLGnOjxNjfi/D1VXJBEHJ99FVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kl4oyWPglVRUj2XZDB55NaYF6bwSVxszOpVOFsdxEz8=;
        b=liMc0jlMh5PD9op0aFhoubV3+fap2gUzyV/w1/B9j322lUnkEqrjuZLiOaBv61SwFa
         7M7INbEsx/wCZBIwMnuZipuwhZofdh0c2+TrGPtFUs0I2ymQgqyaWFWdV/m08v4lMXuV
         ATNILn2k4Lp9+Ym1zI1MLtgSjx9l1ONh/ppMjehs0xBQxB6MU+t6TiFHxNk1GrFhD2y5
         xAEHThhqadrMsdVa8tMn7U23IArBlJ3hcajNo86yWwGoAXoVvWp60N5RqpWyWA1ofuLo
         ujImHmnfoFEVgGOzNT+FVM5f7FvuFb7RF7JyM5jGelYYBdRZGY/Jn4moLSC9Lj03svMl
         f87w==
X-Gm-Message-State: AOAM531EpPzFpe7tKhl718+L4SndvKNjqCwWyjKHteldTzUD0JofiP9E
        3h9WcQZSrl1bppsZEhSPTdbjcg==
X-Google-Smtp-Source: ABdhPJxx0/QeZcIdxX3mPlRM/oa4o6+SmgT0s/ayJFtgGXtkDG8GbEKCyH+E7UDLWeLKFZo6BxzlTQ==
X-Received: by 2002:a17:902:6b8a:b029:12d:3f99:9e5e with SMTP id p10-20020a1709026b8ab029012d3f999e5emr12265690plk.66.1630132187761;
        Fri, 27 Aug 2021 23:29:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20sm8379175pfn.173.2021.08.27.23.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 23:29:47 -0700 (PDT)
Date:   Fri, 27 Aug 2021 23:29:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, shuah@kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "selftests: Remove KSFT_TAP_LEVEL"
Message-ID: <202108272326.3E57729532@keescook>
References: <20210827225812.3247919-1-rmoar@google.com>
 <20210827225812.3247919-3-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827225812.3247919-3-rmoar@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:58:12PM +0000, Rae Moar wrote:
> This reverts commit f41c322f17ec4aa809222dc352439d80862c175b:
> https://lore.kernel.org/linux-kselftest/20190424231236.aWGsEs-_2b6p3DpN3b_4U1xGERmHSv45uBzgjf6RIRk@z/
> 
> This patch removes nested TAP headers in kselftets TAP results and is part
> of a series to alter the format of kselftest TAP results to improve
> compatibility with proposed KTAP specification
> (https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/).

That would have been nice to have been CCed on. :)

-Kees

> 
> Signed-off-by: Rae Moar <rmoar@google.com>
> Change-Id: I24e74cacfc49a90a068eb30ee1448c097de5297d
> ---
>  tools/testing/selftests/Makefile            | 6 ++++++
>  tools/testing/selftests/kselftest/runner.sh | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index fb010a35d61a..3bbfb83e2252 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -122,6 +122,12 @@ else
>  	endif
>  endif
>  
> +# KSFT_TAP_LEVEL is used from KSFT framework to prevent nested TAP header
> +# printing from tests. Applicable to run_tests case where run_tests adds
> +# TAP header prior running tests and when a test program invokes another
> +# with system() call. Export it here to cover override RUN_TESTS defines.
> +export KSFT_TAP_LEVEL=`echo 1`
> +
>  # Prepare for headers install
>  top_srcdir ?= ../../..
>  include $(top_srcdir)/scripts/subarch.include
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 9b04aeb26d3a..40ce901cb38d 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -2,6 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # Runs a set of tests in a given subdirectory.
> +export KSFT_TAP_LEVEL=1
>  export skip_rc=4
>  export timeout_rc=124
>  export logfile=/dev/stdout
> -- 
> 2.33.0.259.gc128427fd7-goog
> 

-- 
Kees Cook
