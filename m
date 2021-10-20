Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C233C435183
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJTRnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhJTRnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:43:19 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44C3C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:41:04 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id x1so25637364iof.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09x1oRFaTKDmQrhlhOb9jy+N6hL8DwJNbTkF0zphjoE=;
        b=mnQOVOqgdt1WuKAT8iYksqfZizblzHqHQ0ZpeyU/Tr7i35LtYOojJ16b518ll9ZQop
         mSXIV/ojivDGtUBOWZKJAjqQpyiuL6uYQv8P1dwI4WVCWO4wf9sJhg+9F4yd4Opbq1HD
         yzO3c7Ha5/V2RuTtNP0UfuMMt6qwM6HdXnzJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09x1oRFaTKDmQrhlhOb9jy+N6hL8DwJNbTkF0zphjoE=;
        b=5zCnZpF6cI1namp1xq6s3/HsDIvDTVQiK31ev8uKA4de0knPK+aUnPasmDCApukM0I
         Ec7es4+dMcxjxbjsGpJSq9v15tk/gvRruhD+OMQRZ5a50URRorXF8lfFMHzMw+TKKseZ
         WSVfz13v5MhyRQsoXFgzgL7ZuiBdTi6/Lxr/66+TGK6Ej5qLEDaZQ54vqMzyQNh9v0F4
         8zQHlaSnIDuucQ056w81fhaX3hiL2aehQj4qLMRwBUoI+yNJtzsmz5qbMNC8ajDfwymm
         vTd9ukyBuM7B6d6eHVt+lzOw1tc1LKWo9O3I4WaqSlcX0ytDEcCR8TqQOo/bO7qId3u0
         YnoQ==
X-Gm-Message-State: AOAM532A6brIDxIDJ87a1b0POM2gnQ5gn+3C+X4IHiiPiBPtfyaZUMMJ
        DDymPuC6vwiGb7pM82hjnNFYuWuAw1lWHA==
X-Google-Smtp-Source: ABdhPJxHkZxKk4280fJacTHzWhx/A2sESkg8+hxPVMQC3o9MtwuKuXaICqYI5qpTY21JRNJDAuQMdw==
X-Received: by 2002:a6b:148d:: with SMTP id 135mr460384iou.174.1634751663866;
        Wed, 20 Oct 2021 10:41:03 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id v17sm1351382ilh.67.2021.10.20.10.41.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 10:41:03 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id r134so25649672iod.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:41:03 -0700 (PDT)
X-Received: by 2002:a05:6638:2510:: with SMTP id v16mr514672jat.68.1634751662770;
 Wed, 20 Oct 2021 10:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <1634732051-31282-1-git-send-email-quic_sbillaka@quicinc.com> <1634732051-31282-3-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1634732051-31282-3-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Oct 2021 10:40:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U9==zFpYtiU1S=n+Ygy5Qa4xfA6GFMpHJUtkpjpNfcyw@mail.gmail.com>
Message-ID: <CAD=FV=U9==zFpYtiU1S=n+Ygy5Qa4xfA6GFMpHJUtkpjpNfcyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Add SC7280 compatible string
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sankeerth Billakanti <sbillaka@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 20, 2021 at 5:14 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> From: Sankeerth Billakanti <sbillaka@codeaurora.org>
>
> The Qualcomm SC7280 platform supports an eDP controller, add
> compatible string for it to dp-controller.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)

I think you ignored some of the feedback that was given on v1. Perhaps
you could go back and re-read that feedback? See the replies to:

https://lore.kernel.org/r/1628726882-27841-3-git-send-email-sbillaka@codeaurora.org/

For one, ${SUBJECT} needs updating. It's probably as simple as adding
the "msm/dp" tag, like:

dt-bindings: msm/dp: Add SC7280 compatible string

For another, Stephen requested that you add "sc7280-dp" too.
