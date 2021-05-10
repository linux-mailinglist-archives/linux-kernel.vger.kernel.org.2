Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F4E3794AA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhEJQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhEJQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:56:15 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6826C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:55:10 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u16so16391647oiu.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=sVOf3rnQQoCxErFwACuycQahXXh0Mo2aHzmf0ZUSPko=;
        b=HQy+UmcK03DuKLfDIAryB3qD1Mil6T0UDB98z17huWfwRWDjMSI+T3c85L9CGSPeay
         DU+Evt3AJhioziDQCNcCJSrpcKj5BsrsNIscNv7h4V1kko81oWGTehQmGxZDnyW4CUe5
         yw9wsqE9adjtg4qamSlq2FebUWGdDllpv8PeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=sVOf3rnQQoCxErFwACuycQahXXh0Mo2aHzmf0ZUSPko=;
        b=pdcPxelp6dQjQAhYYWYEsJlyF7ORIzgarqS/hmRz8srpudC3kZrb7h0OOXeIcStzEn
         7cZGLUnpgC/RLhbbaO9vLC3CUrDAX7Ze4i7NhBggFIdrT1rUWNuhWBXyU70q7RlBerJu
         aJTk7o9s/fvBs37LhGDU2Di9Ilq7hmp5fg+j2R1BnJAyDM9rHiWLrjiQ6C+45Us7+8Z4
         mryVFNPd3pzg9VhlmLF91Gg7KrHf+OHfcWbk/gHWgg9Adqik+o86V76RjVmvCxGEM4NY
         xMsCCrzm4rf8RUoh8+yeFQLs2+jeyQNBbulE6DSEyRKcF1uNEH+q3+Gh9SMg8qzz58H5
         HMZA==
X-Gm-Message-State: AOAM532R+bRAEbXy3oCWDmR3ORwVN9aBffzRpOwjY1i3R+yDh7by8c4d
        qSuQ+oIs8YxR6J3VJsob3DaYCbiqo9CeX9aWs/0dAA==
X-Google-Smtp-Source: ABdhPJz5RLoBLot1CVzxTjJkBJp56d5KozQuBoFhRpWF7SSXLzx/nTWQb1uAogO6gMhleLVVnQnOjunOH/YyigS6+KU=
X-Received: by 2002:aca:211a:: with SMTP id 26mr18395539oiz.19.1620665710136;
 Mon, 10 May 2021 09:55:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 May 2021 09:55:09 -0700
MIME-Version: 1.0
In-Reply-To: <20210510063805.3262-2-thunder.leizhen@huawei.com>
References: <20210510063805.3262-1-thunder.leizhen@huawei.com> <20210510063805.3262-2-thunder.leizhen@huawei.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 10 May 2021 09:55:09 -0700
Message-ID: <CAE-0n52a4hAsg0bq-1PeL=gK3uFQ0mkvWngdfA_NqdhgWg6tuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/msm/dpu: Fix error return code in dpu_mdss_init()
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhen Lei (2021-05-09 23:38:05)
> The error code returned by platform_get_irq() is stored in 'irq', it's
> forgotten to be copied to 'ret' before being returned. As a result, the
> value 0 of 'ret' is returned incorrectly.
>
> After the above fix is completed, initializing the local variable 'ret'
> to 0 is no longer needed, remove it.
>
> In addition, when dpu_mdss_init() is successfully returned, the value of
> 'ret' is always 0. Therefore, replace "return ret" with "return 0" to make
> the code clearer.
>
> Fixes: 070e64dc1bbc ("drm/msm/dpu: Convert to a chained irq chip")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
