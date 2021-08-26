Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F23F82C9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 08:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhHZGzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 02:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhHZGzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 02:55:41 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02336C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:54:55 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso609411ooq.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=KhqwvKpX2QUupbDYfTBjhyLe2hfemZiewWwZY0rgk0w=;
        b=IKoyYNbSttHPGi5+7FMcORxQLLUgr+nGS4hi/HbbDCxYtSfz6/Do8eIOqxPKT1CBLS
         57YpI2ic79FSuSudLRG1MGqTg9lN/wHHgdsb7G3o8qCDJNHn0aaoK0/clk6xpbJYou/v
         EX5Iw3aDq7mm5yF87RCn/NMkWrW0Hr+1g683k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=KhqwvKpX2QUupbDYfTBjhyLe2hfemZiewWwZY0rgk0w=;
        b=Ta5gxzS27jEhSfVXrvB38N8eNsTVpSvB164M6WC614m11Cx49duqX10EpqVORQ/Byw
         3lBT0ZttYBLYosXrEhB8iuZMYmQIiNnKY/B1obdJVluy9p8Nt8DrGGrThHJcDo14UikJ
         76ZAvTnk4qwNUnqxHpuC/eQDxaCd+WnTdE/c+B6vZnSQamIxVpQV7x2JcXCXJYNSIK5V
         dXvBfmNY5snmybBndf2S17XonTvjJdfVXM3HkXZvRZx/wzB1kFMfnb/82gL6NzD8tQtS
         pL6ZMi5AO4wFndtN0FUwnJMbZXkA24vNRyj4MEQP6HMbGpJkKnsmLAIISV49smLmgKrM
         Yh2Q==
X-Gm-Message-State: AOAM533Du2qLU+MDzsUrrnlJUv5q0qudKpZ7PkxKeggavSK/w4XGQKFf
        /iE1HMLBtXCZxkpA90+y9F7mndJmrE5rKqRYkS+Ggw==
X-Google-Smtp-Source: ABdhPJxXVSZ0AeDf4bM/tncwC3s9EqVDnIEfhIMOL7c4INLIqsTWlLNWu96+47aZUOf/3EzE4j0uBVgY5Q0OkeJXviA=
X-Received: by 2002:a4a:a841:: with SMTP id p1mr1813277oom.92.1629960894339;
 Wed, 25 Aug 2021 23:54:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Aug 2021 06:54:53 +0000
MIME-Version: 1.0
In-Reply-To: <20210825234233.1721068-2-bjorn.andersson@linaro.org>
References: <20210825234233.1721068-1-bjorn.andersson@linaro.org> <20210825234233.1721068-2-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 26 Aug 2021 06:54:53 +0000
Message-ID: <CAE-0n53M-bk-525Jh5owT54fQu-E+cHM-6m-qLo3APYLDLuueA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] drm/msm/dp: Remove global g_dp_display variable
To:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-08-25 16:42:29)
> As the Qualcomm DisplayPort driver only supports a single instance of
> the driver the commonly used struct dp_display is kept in a global
> variable. As we introduce additional instances this obviously doesn't
> work.
>
> Replace this with a combination of existing references to adjacent
> objects and drvdata.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
