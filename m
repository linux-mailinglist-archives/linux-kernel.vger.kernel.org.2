Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B983C9335
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhGNVm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhGNVmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:42:25 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D07C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:39:32 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id n187-20020a4a40c40000b029025e72bdf5d6so1011614ooa.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=7yU/lXVPq8v5DxUavviakd+XqTwyKh5GL+eckjJwhhU=;
        b=Huzsn41/m5wNJTthgcAkHFWvNusXC97KqI0iRCAyi4I1V8yYIvTOhj+iZO052RBDgY
         /jxRFEZK8vH/CEYJ5CnaKLfuPND5/1DeDeNXoS5qhh5axGrqcLRDIAgCJvKCy8aLX8g1
         uCSMpbZnly1BXgEIB0LWc1Jh/Ao6j+lmqofVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=7yU/lXVPq8v5DxUavviakd+XqTwyKh5GL+eckjJwhhU=;
        b=nbqRoWWgpalotwVMZ1kihcWYQkjgQITk2gyEMXOKfOu/aFj3qS4LrZh5ewTUwADBqV
         YbW+FsoOn6OypXBHlYsVS+IP1NWe8Uzd0VaZG3zOC34VTChYC9agcwZE2qGjCp9n81L1
         lBBYGERBTNP81wj49J6g/3sX24SV9pwd7BJajBcBcCmP4h2EFM6DyIr9Suj7HVXz180+
         tt/kEmJhiHlQsE112mlTT43HNG4DScDFbKqU1PWTMQ2Jfjh7sI2yjXP/pYLVFTpVilZD
         qL+B/6QmIBSs75zO4b/lQurQQTWyFTFgdoQPeO5AEjpHySSYV3pxae3nVaXX5cXQ5075
         YcGQ==
X-Gm-Message-State: AOAM530JovNHxPlnFf1UeeVPovA02St1EUtnIy/31dF7IfCsZDORSn8a
        YGLY6E1QElOv/rEsTTo5LuNqHVJpgxKPOgT/NmPe0g==
X-Google-Smtp-Source: ABdhPJwE2R3+k8+ce7HwbkPywG7nnMFEF4vtMpBltJIbIWP52CkUWZLrAOaoBO6XdJi33DjezNuNWFNaiYMAd18hPNU=
X-Received: by 2002:a4a:e206:: with SMTP id b6mr17846oot.16.1626298771497;
 Wed, 14 Jul 2021 14:39:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Jul 2021 23:39:31 +0200
MIME-Version: 1.0
In-Reply-To: <20210709024834.29680-1-jrdr.linux@gmail.com>
References: <20210709024834.29680-1-jrdr.linux@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 14 Jul 2021 23:39:30 +0200
Message-ID: <CAE-0n51cqCz4JD75n4ZZV2LDxbB6b0QwJ-La2hU8mnPcckNmSg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Remove unused variable
To:     Souptick Joarder <jrdr.linux@gmail.com>, abhinavk@codeaurora.org,
        airlied@linux.ie, chandanu@codeaurora.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, khsieh@codeaurora.org,
        robdclark@gmail.com, sean@poorly.run, tanmay@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Souptick Joarder (2021-07-08 19:48:34)
> Kernel test roobot throws below warning ->
>
> drivers/gpu/drm/msm/dp/dp_display.c:1017:21:
> warning: variable 'drm' set but not used [-Wunused-but-set-variable]
>
> Removed unused variable drm.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
