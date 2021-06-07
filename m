Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6308439E51E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhFGRUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:20:15 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:35751 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFGRUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:20:14 -0400
Received: by mail-oi1-f175.google.com with SMTP id v22so18829071oic.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtFqg3TR/taE0y/EKR7pUF5yxr+poA+jtZYTuPIvfeU=;
        b=UiwljjcSSloI3uGyBgqJOz+hqJuyMgwNynMRAK1DanPqP4KuB6AoDsslE3PDnOhhM5
         IEvI9akDR+vK7Am2aD4pk5XZbUcq/+qzUKMxcuyQPQaaOsLobrsMii9BgFMsgh/jakoo
         5wolJvn0IHCaFGhRZUSgUDFvxKltSFbvS18aP6d/qkncCIPuxppYcfuNzqYxNYBB3m5d
         wLXNTobxjRgZni41zzpE/7OA4ygN+c3UHXuiremmdVsVXW1Z8Tk7u5+HgzIT2YjwiJji
         JQQXlSYiMeGnCRfH2ExbIgXkHjy/+piLVVi4a5MRFP1em605rsOxheuIfwJqFJnsoXNH
         tSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtFqg3TR/taE0y/EKR7pUF5yxr+poA+jtZYTuPIvfeU=;
        b=SIW+yIh9KWaculfaj5f9uaXXkXDgRSutwktuJIIQzbum7ZS5MayrfJYIbC6abLEnEe
         +5tRuSnEf+KYz4hi/PKumXPHlWvOws5WSPPLZb5+INed7DbVVpCZfFyvcSkass1OG5b/
         /c4KX1swfzEA+uVqzTxoPq0ZXRf++zioxmfu8MS7mIwpQzhGvmLFtrsmxGP+863rYtkH
         PwWrWgdOH7y1KKAvpOZuv2tuasAby1nBgEzHre5nt4jYIHc6DA/nWDkswhFQSaeqSRv6
         pi9Oz5NlllgW8e0/P1dbjOGkMsFwPfpzyA1K8xrUkq6u7fYnHfA1X9XTD4IHrtvsz4YI
         Kg9g==
X-Gm-Message-State: AOAM5315DEvG2Ndc77Yro8ngJ8AAKBrE/g8zR3absfI+osVqse39r0aL
        8uNHMCvqDv7hVEf17vS1RkxdWcDiGccj15xOV1E=
X-Google-Smtp-Source: ABdhPJzwkHlxtqTsMiF6NFAkb/Z3ua0k5ZWZ0fLzkk/iXTit2hlNeZTmodS5Bx8mn0idkpNDfkw9O7y6UfTHGGFB9Po=
X-Received: by 2002:a05:6808:999:: with SMTP id a25mr167646oic.123.1623086228330;
 Mon, 07 Jun 2021 10:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <1623061651-33021-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1623061651-33021-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Jun 2021 13:16:57 -0400
Message-ID: <CADnq5_PnyYyzZwAMTb-A=fNM3BN5GmkrEciAT_n2XqqcAQKWrw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix duplicate included dce110_hw_sequencer.h
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jun 7, 2021 at 6:27 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Clean up the following includecheck warning:
>
> ./drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c:
> dce110_hw_sequencer.h is included more than once.
>
> No functional change.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index e731987..04d02ce 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -32,7 +32,6 @@
>  #include "core_status.h"
>  #include "resource.h"
>  #include "dm_helpers.h"
> -#include "dce110_hw_sequencer.h"
>  #include "dce110_timing_generator.h"
>  #include "dce/dce_hwseq.h"
>  #include "gpio_service_interface.h"
> --
> 1.8.3.1
>
