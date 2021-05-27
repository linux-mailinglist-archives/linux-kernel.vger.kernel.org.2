Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC3393907
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhE0XQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbhE0XQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:16:06 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DC7C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:14:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h21so1500198qtu.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUv/H2tSnyEpa0je+9CNljGuyS/P4gW1vHKFaYDtrQ4=;
        b=ChVZOb7exsfcVgpIA48kpnMbJAqreH3Kr6NAAbL2WgkKUno/5lrDjOfss9Eox06/W7
         LM87HKJfFVcDtuZwpowGUsyjjZhnTpZEDp44jB8tdAJt25wDjckkAG8bZnG0fZs9HpaA
         BSTdfbWDFTdH+8lb8BDAXE8xF1696WkGaCu90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUv/H2tSnyEpa0je+9CNljGuyS/P4gW1vHKFaYDtrQ4=;
        b=tLVzabg5MM3t1InlcCksB4qiaUQIM8RKGyiUGg0QBIoqVgU82Z1S1hioP2gOev31H4
         n6Z3XqUa/rgbCI6JUgx5XG9gx24Px+FACu+JXcaWAcSpNQ4ZriQjX2+uhlHy+gIK5tUa
         TFuRVYqlvX+1MM5SFBlWXEOTUtQSaf8t9q6tBmid3dEZBB7EzdFX4KgTgFx/qjiGMjKS
         08Be/KRiUhem4yfBjEnBkeVNXZ7aB50bnwbesC3KQDrWocgTWKvSog5cpD0GPXTZsmIB
         s4bvKSc4vj+FUm/Z0dlbbmbKPx5BlXzFjXGO4AY8MYEq1CqgfVFxAbPgn8GKfqs6r2ss
         30Mw==
X-Gm-Message-State: AOAM531efgX++VUV6g48nfnyQPc9vMvmmFzlVTTZGMYK0ijkzc1pmMoR
        +umovY/cxPt65GSg5yjHvBypjgMZDqsORg==
X-Google-Smtp-Source: ABdhPJziBpTl001wNvcE91bGBr7gDpa8FuJNdsbl9IyEEGROzItve7iULbDclhQ5N8dJaABjV5sZ8A==
X-Received: by 2002:ac8:7e96:: with SMTP id w22mr928527qtj.52.1622157270507;
        Thu, 27 May 2021 16:14:30 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id m15sm2244612qtn.47.2021.05.27.16.14.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 16:14:29 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id r8so2968339ybb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:14:29 -0700 (PDT)
X-Received: by 2002:a25:b801:: with SMTP id v1mr9231563ybj.32.1622157269138;
 Thu, 27 May 2021 16:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <1622092076-5100-1-git-send-email-mkrishn@codeaurora.org>
In-Reply-To: <1622092076-5100-1-git-send-email-mkrishn@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 27 May 2021 16:14:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQzM=cEsEYbR4QwaovT377dn4vLxqcK7xrLMutZPVDeQ@mail.gmail.com>
Message-ID: <CAD=FV=UQzM=cEsEYbR4QwaovT377dn4vLxqcK7xrLMutZPVDeQ@mail.gmail.com>
Subject: Re: [v1] drm/msm/disp/dpu1: avoid perf update in frame done event
To:     Krishna Manikandan <mkrishn@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 26, 2021 at 10:08 PM Krishna Manikandan
<mkrishn@codeaurora.org> wrote:
>
> Crtc perf update from frame event work can result in
> wrong bandwidth and clock update from dpu if the work
> is scheduled after the swap state has happened.
>
> Avoid such issues by moving perf update to complete
> commit once the frame is accepted by the hardware.
>
> Fixes: a29c8c024165 ("drm/msm/disp/dpu1: fix display underruns during modeset")
> Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

I don't know much about this code or any of the theory behind it, but
I can confirm that this fixes the hang I was seeing with the previous
patch. On sc7180-trogdor-lazor:

Tested-by: Douglas Anderson <dianders@chromium.org>
