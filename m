Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB4F454909
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbhKQOoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236521AbhKQOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:44:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8960C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:41:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b13so2371421plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FENSdBV0SaFPzDm6ckFQMVqmxl4V70yKaIqoETl6sE0=;
        b=f/pyFvV0vA2GCGB8Z63Qh23tGDpqhPosUxoivdHO63LD2gQjgkDE4WxqzUgg/xjU2T
         zCeZwrymSe1rS3cpN8qc6WSuF/+M2qux/XtqX0A+Enj+LrWnFur2wQI5IzGVcB3xsGJT
         51OdCnXTv+Pp0OeMCCMGEAy50g353bZQrSBaXzi++LjFJjK5sIvfme7Jo7U6P3LIjUCm
         etYEjhdRo4NLPzUZmwPzT/hRHtgGgxhA1ftHsrY14jMp4NdcQFtu7R3ZfTlAWdUE7ADp
         r079vem5gJZBAr7DtQSTMRdfG522T65Lbu57hoRb9/hGCqxrTEKL9naQS0D1RI05v91Z
         Hgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FENSdBV0SaFPzDm6ckFQMVqmxl4V70yKaIqoETl6sE0=;
        b=eQJr4vIdc72yhdxxHYKhueGiE3I7Q384y5t6xGo+wKLaMVz48/58eNYrtAXl9dBEjb
         XLemQXKR/JIMQNlaMIlUhku9oOyfltjMnBWGMwhMbYTvBE8A4r388UsnBq3dxl5+pmBl
         lDv7LeLMGLVp21eI30Cxt6HKR61H1xhdfUnuAXoqLE9h6icPLvhP+WKa84RbphR0wKrY
         4jWLLNXvwdfayfc9z5EHEExyM6keZDTrxvccOnUKaiD2GxtQXaLrj1QyWZM3XvhFieAd
         ELJTDdJeh/5PhFC4ZeAEgwnl4e/gVudXmrX/bHgJcxlBTuVow9AoKKo72m25tXhksKFm
         kEeA==
X-Gm-Message-State: AOAM532jSwU39CXgM8Q4uF0QtbcC1ViuASNMdhWRPohVMvOfVVE0NH2f
        CHs9itraXwIiEA7zLr4LNNPxPTCaw6A8OHfxpy4=
X-Google-Smtp-Source: ABdhPJwBWbOTIeE/xNglN2St/fEM2ufDbLuVAev+HyD8MI0m1CHkcdnPBzl2yEjiTH3t9sTZat1zxg==
X-Received: by 2002:a17:902:8645:b0:142:8c0d:3f4a with SMTP id y5-20020a170902864500b001428c0d3f4amr55291209plt.3.1637160082264;
        Wed, 17 Nov 2021 06:41:22 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([66.23.193.242])
        by smtp.gmail.com with ESMTPSA id gv23sm5554558pjb.17.2021.11.17.06.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:41:21 -0800 (PST)
Date:   Wed, 17 Nov 2021 22:41:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     German Gomez <german.gomez@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FYI][PATCH 1/1] perf tools: Set COMPAT_NEED_REALLOCARRAY for
 CONFIG_AUXTRACE=1
Message-ID: <20211117144110.GC4771@leoy-ThinkPad-X240s>
References: <YZT63mIc7iY01er3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZT63mIc7iY01er3@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 09:51:42AM -0300, Arnaldo Carvalho de Melo wrote:
> As it is being used in tools/perf/arch/arm64/util/arm-spe.c and the
> COMPAT_NEED_REALLOCARRAY was only being set when CORESIGHT=1 is set.

Thanks for the patch, Arnaldo.

This patch looks good to me.  But I cannot reproduce the build failure,
if without CORESIGHT=1 I still don't see the build failure.

I think we should apply below code as well, if COMPAT_NEED_REALLOCARRAY
is enabled for AUXTRACE, it will be applied for cs-etm as well.  For
this reason, we can remove the redundant definition for CORESIGHT.

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 07e65a061fd3..2dbf086d1155 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -477,9 +477,6 @@ ifdef CORESIGHT
   $(call feature_check,libopencsd)
   ifeq ($(feature-libopencsd), 1)
     CFLAGS += -DHAVE_CSTRACE_SUPPORT $(LIBOPENCSD_CFLAGS)
-    ifeq ($(feature-reallocarray), 0)
-      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
-    endif
     LDFLAGS += $(LIBOPENCSD_LDFLAGS)
     EXTLIBS += $(OPENCSDLIBS)
     $(call detected,CONFIG_LIBOPENCSD)

Thanks,
Leo

> Fixes: 56c31cdff7c2a640 ("perf arm-spe: Implement find_snapshot callback")
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: German Gomez <german.gomez@arm.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Makefile.config | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 07e65a061fd3a13b..afd144725a0bf766 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1010,6 +1010,9 @@ ifndef NO_AUXTRACE
>    ifndef NO_AUXTRACE
>      $(call detected,CONFIG_AUXTRACE)
>      CFLAGS += -DHAVE_AUXTRACE_SUPPORT
> +    ifeq ($(feature-reallocarray), 0)
> +      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
> +    endif
>    endif
>  endif
>  
> -- 
> 2.31.1
> 
