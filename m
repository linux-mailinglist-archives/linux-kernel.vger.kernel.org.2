Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C8A44B530
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245214AbhKIWPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbhKIWPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:15:07 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A6EC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:12:20 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso963923ote.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=q4dY+M8nyiFAt4remZo3SHhwNRe5f+ykJVrEzZX13ZY=;
        b=dUVV+iZ7gYosXBMozkc7vKB1RNOH5oYuxH+4ETASHmsxotjE4SMaeLcPuNuZo3YgLS
         VKqrYcvpOjHVanfYHo2JDTh9TG9fBjUwC/5YUeev8lYij4oN6Dvhmr9g993TWSjfRQXA
         y/Ob41ctB8Ez3blzsLaMRml0A4mz13rP97ljM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=q4dY+M8nyiFAt4remZo3SHhwNRe5f+ykJVrEzZX13ZY=;
        b=L9jU/y4IBvA8kfKdbk3orymrkojNCXQvGeCGzlxnhCrTFpxKCushJ6CrQSOAfzToCr
         u1qW/+fM958vhEe5gIg3r/dSkVgmk8ls08jWEaQRtIz/Vut/L1v0YvBRRaMyazBBBYKV
         FaqYJknB2MjJWhdruBlauUK0WHov4wF+SXS+8cbOm1wQn90sYaBOZyzikKS/ytIomySw
         OcPyPrfFfYKPEh8mtyhVDs9h47xvMjPRXLC3kg5dPUmUqvZvjUiz6XzP85LmzisiOS0s
         TkBUm0We09kcg/LdbuyuFCNLuv40wHaSOpuHxxqRSDHhXSXvwA6eg7iLT5/qk/R11CvB
         E/7Q==
X-Gm-Message-State: AOAM533E9gDRzLzIrzqdHq6KnUvibFYHOU3rV05Lo0X1CFEEPbjpnH+i
        79GUEsStQPjHu8p1eB9NBZnuZ4RyqET84Bllrlak8g==
X-Google-Smtp-Source: ABdhPJzCxZIvzxfRWv/IW1ZG0J6NJo3QJ4ZuZGIuMdYHfvlxdSbDBBsE6NHiPmYbpRrVGi/S+/NGsMIcLCSrzc29ITI=
X-Received: by 2002:a9d:2f42:: with SMTP id h60mr8342701otb.159.1636495940269;
 Tue, 09 Nov 2021 14:12:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Nov 2021 22:12:19 +0000
MIME-Version: 1.0
In-Reply-To: <1636451248-18889-1-git-send-email-quic_mkrishn@quicinc.com>
References: <1636451248-18889-1-git-send-email-quic_mkrishn@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 9 Nov 2021 22:12:19 +0000
Message-ID: <CAE-0n50a5LWpi1JoY=BpwPokpuzYC2c3RXv86Ob_azmdCOkgyw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm: use compatible lists to find mdp node
To:     Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_kalyant@quicinc.com, robdclark@gmail.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krishna Manikandan (2021-11-09 01:47:28)
> In the current implementation, substring comparison
> using device node name is used to find mdp node
> during driver probe. Use compatible string list instead
> of node name to get mdp node from the parent mdss node.
>
> Signed-off-by: Krishna Manikandan <quic_mkrishn@quicinc.com>
>
> Changes in v2:
>   - Use compatible lists instead of duplicate string
>     check (Stephen Boyd)
>
> Changes in v3:
>   - Use match tables to find the mdp node (Stephen Boyd)
> ---

With the export symbol dropped

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
